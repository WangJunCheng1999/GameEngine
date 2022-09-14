workspace "GameEngine"	-- �����������
	architeture "x64"	-- ƽ̨

	configurations{		-- ����ģʽ
		"Debug",	
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "GameEngine"
	location "GameEngine"	-- project�ļ������λ��
	kind "SharedLib"		-- Project����Ϊdll
	language "C++"

	targetdir("bin/" ..outputdir.. "/%{prj.name}")		-- �ļ����Ŀ¼
	objdir("bin-int/" ..outputdir.. "/%{prj.name}")		-- �м��ļ����Ŀ¼

	files{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs{						-- ���������ͷ�ļ�
		"%{prj.name}/vendor/spdlog/include"
	}

	filter "system:windows"				-- ����ϵͳ����һЩ�������
		cppdialect "C++17"
		staticruntime "On"
		systemversion "10.0.19041.0"

		defines{						-- �궨��
			"GE_PLATFORM_WINDOWS",
			"GE_BUILD_DLL"
		}

		postbuildcommand{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" ..outputdir.. "/Sandbox")
		}

	filter "configurations:Release"
		defines "GE_RELEASE"
		optimize "On"

	filter "configurations:Debug"
		defines "GE_DEBUG"
		symbols "On"

	filter "configurations:Dist"
		defines "GE_DIST"
		optimize "On"
	
	-- �����Ҫ֧���������filter,����Ҫ���������������������
	--filter {"system:window","configurations:Release"}
		--buildoptions "/MT"

project "Sandbox"
	location "Sandbox"		-- project�ļ������λ��
	kind "ConsoleApp"		-- Project����Ϊdll
	language "C++"

	targetdir("bin/" ..outputdir.. "/%{prj.name}")		-- �ļ����Ŀ¼
	objdir("bin-int/" ..outputdir.. "/%{prj.name}")		-- �м��ļ����Ŀ¼
	
	includedirs{						-- ���������ͷ�ļ�
		"%{prj.name}/vendor/spdlog/include",
		"GameEngine/src"
	}

	-- ����Sandbox��GameEngine
	links{
		"GameEngine"
	}

	filter "system:windows"				-- ����ϵͳ����һЩ�������
		cppdialect "C++17"
		staticruntime "On"
		systemversion "10.0.19041.0"

		defines{						-- �궨��
			"GE_PLATFORM_WINDOWS"
		}

	filter "configurations:Release"
		defines "GE_RELEASE"
		optimize "On"

	filter "configurations:Debug"
		defines "GE_DEBUG"
		symbols "On"

	filter "configurations:Dist"
		defines "GE_DIST"
		optimize "On"