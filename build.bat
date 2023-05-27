set "toolchain=%~dp0%1.cmake"
set "toolchain=%toolchain:\=/%"
set "clang_executable=%~dp0boringssl\util\bot\llvm-build\bin\clang-cl.exe"
set "clang_executable=%clang_executable:\=/%"
call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" %1
cd boringssl
mkdir build
cmake "-DCMAKE_TOOLCHAIN_FILE=%toolchain%" -DBUILD_SHARED_LIBS=1 -DCMAKE_BUILD_TYPE=Release -GNinja -DCMAKE_LINKER=link.exe "-DCMAKE_ASM_NASM_COMPILER=C:/Program Files/NASM/nasm.exe" "-DCMAKE_CXX_COMPILER=%clang_executable%" "-DCMAKE_C_COMPILER=%clang_executable%" "-DCMAKE_MAKE_PROGRAM=ninja.exe" "-DPERL_EXECUTABLE=C:/Strawberry/perl/bin/perl.exe" -B build
ninja -C build
cd build
7z a build.zip crypto\crypto.dll crypto\crypto.dll.manifest crypto\crypto.lib ssl\ssl.dll ssl\ssl.dll.manifest ssl\ssl.lib
