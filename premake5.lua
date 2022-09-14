workspace "GameEngine"	-- 解决方案名称
	architeture "x64"	-- 平台

	configurations{		-- 运行模式
		"Debug",	
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "GameEngine"
	location "GameEngine"	-- project文件夹相对位置
	kind "SharedLib"		-- Project类型为dll
	language "C++"

	targetdir("bin/" ..outputdir.. "/%{prj.name}")		-- 文件输出目录
	objdir("bin-int/" ..outputdir.. "/%{prj.name}")		-- 中间文件输出目录

	files{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
	}

	includedirs{						-- 额外包含的头文件
		"%{prj.name}/vendor/spdlog/include"
	}

	filter "system:windows"				-- 根据系统设置一些相关属性
		cppdialect "C++17"
		staticruntime "On"
		systemversion "10.0.19041.0"

		defines{						-- 宏定义
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
	
	-- 如果需要支持且命令的filter,就需要用下面这个花括号阔起来
	--filter {"system:window","configurations:Release"}
		--buildoptions "/MT"

project "Sandbox"
	location "Sandbox"		-- project文件夹相对位置
	kind "ConsoleApp"		-- Project类型为dll
	language "C++"

	targetdir("bin/" ..outputdir.. "/%{prj.name}")		-- 文件输出目录
	objdir("bin-int/" ..outputdir.. "/%{prj.name}")		-- 中间文件输出目录
	
	includedirs{						-- 额外包含的头文件
		"%{prj.name}/vendor/spdlog/include",
		"GameEngine/src"
	}

	-- 链接Sandbox和GameEngine
	links{
		"GameEngine"
	}

	filter "system:windows"				-- 根据系统设置一些相关属性
		cppdialect "C++17"
		staticruntime "On"
		systemversion "10.0.19041.0"

		defines{						-- 宏定义
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