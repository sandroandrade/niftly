# Niftly
Niftly is a RSS Reader built with Qt/QML and QML Material.

# How to build Niftly

1. Ensure you have a proper Qt development environment for Android
2. Clone qml-material repository (git clone https://github.com/papyros/qml-material.git)
3. Build and install qml-material using Qt for Android
   * cd to qml-material directory
   * Run 'mkdir build'
   * cd to build directory
   * Run 'cmake -DCMAKE_PREFIX_PATH=<path-to-your-qt-for-android-installation>/5.5/android_armv7/:/usr/ -DCMAKE_INSTALL_PREFIX=<path-to-your-qt-for-android-installation>/5.5/android_armv7/ -DCMAKE_BUILD_TYPE=Release ../'
   * cd to material directory
   * Run 'make install'
4. Open Niftly project in QtCreator
5. Build it with the Android Kit

If you also want to run it in your desktop, clear everything in build directory and run cmake as:
cmake -DCMAKE_INSTALL_PREFIX=/usr/ -DCMAKE_BUILD_TYPE=Release ../
then cd to material directory and run 'sudo make install'. Build it with the Desktop kit.

Voilá ! Niftly is nifty, isn't it? ;)
