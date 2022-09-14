del /f /s .\Sandbox\Sandbox.vcxproj
del /f /s .\Sandbox\Sandbox.vcxproj.user
del /f /s .\GameEngine\GameEngine
del /f /s .\GameEngine\GameEngine.vcxproj
del /f /s .\GameEngine.sln

call vendor\bin\premake\premake5.exe vs2022
PAUSE