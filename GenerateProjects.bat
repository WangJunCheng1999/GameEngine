del /f /s .\Sandbox\Sandbox.vcxproj
del /f /s .\Sandbox\Sandbox.vcxproj.user
del /f /s .\GameEngine\GameEngine
del /f /s .\GameEngine\GameEngine.vcxproj

call vendor\bin\premake\premake5.exe vs2017
PAUSE