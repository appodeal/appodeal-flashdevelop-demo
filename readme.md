# Appodeal API plugin. Flash develop integration.

1. Download Appodeal ane plugin.
2. Unzip the archive with plugin, put ane files to lib folder of your project.
3. Put contents of the assets folder to bin folder of your rpoject (without assets folder)
4. In Flash Develop select *.ane files, right click and choose "Add To Library".
5. Add the following extensions to the descriptor:
   ```
   <extensionID>com.appodeal.aneplugin</extensionID>
   <extensionID>com.appodeal.playservicesane</extensionID>
   <extensionID>com.appodeal.supportane</extensionID>
   ```
6. Open bat/Packager.bat file with text editor, find the following line (or similar):
   ```
   call adt -package -target %TYPE%%TARGET% %OPTIONS% %SIGNING_OPTIONS% "%OUTPUT%" "%APP_XML%" %FILE_OR_DIR%
   ```
   And add "-extdir lib/" parameter.
7. Open bat/RunApp.bat file with text editor, find the following line:
   ```
   adl -screensize %SCREEN_SIZE% "%APP_XML%" "%APP_DIR%"
   ```
   And add the same parameter: "-extdir lib/"