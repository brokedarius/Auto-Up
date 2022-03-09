# Auto-Up
Automate uploading across trackers.

The aim of this collection of scripts is to help uploaders post stuff faster and avoid repetitive tasks. I tried to automate as much of the work as possible while keeping control where required such as categories, tags, presentations but only in the areas that must require intervention. All the rest is fully automated. This is mostly for those that which to upload more than 10 torrents at once.

These scripts allows you to 'Cross-Upload', meaning uploading one file, one presentation, 2 torrents with separate hashcodes on 2 trackers at once. 

The semi-auto versions are more of an offspring that came later on when I figured some people would like something similar for smaller workflows.

Feel free to leave any suggestions/feedback that could potentially improve on this.

Requirements
============ 

-Chromedriver 96

-Selenium webdriver 3.14

-Chrome 96 (Portable version highly recommended)

You can either use a portable version, a separate profile or the one you already got if that's the case, just point the script to your local profile and make sure in any case you are logged in to the site. 

-Powershell 5 (If you have windows, it should be installed just make sure you have execution policy set to unrestricted or else you won't be able to run any .ps1 scripts in your machine.)

-Py3createtorrent  (You can also modify the script and skip this if you prefer to generate torrents on your own.)

-Python 3 (Added to path)

(Technically you could remove the need for python by using another CLI based torrent generator than py3createtorrent.)

-Transmission or any torrent client that can auto-add torrents from a specific folder without opening a file dialog (Qbittorrent or Tixati seem to work as well), I just like the simplicity of transmission for the process.

-Optional: Command line screen generator like MTZ or EZthumb. (You can skip this part if you prefer to generate screens on your own, else add a line for screen generation right after the first ForEach loop.)

Best practice would be to generate the screens prior to running the script in order to be able to write quality presentation.

Remember folks, the pause/break key on your keyboard was made to pause scripts if you ever need to :)

DEFAULT DIRECTORIES 
===================

The script exes work out of the box if the following directories are created. Just place them where you want to keep them and create shortcuts you will place in your shell:sendto folder. To navigate there just type shell:sendto in your file explorer.

Feel free to edit any of this and recompile with WINPS2-EXE to suit your likings, I just tried to cover most use cases and have it work out of the box.

You can change those as much as you want, the $ENV:USERNAME variable is there so it works out of the box on any setup, just represents your current username on windows.

\Desktop\Uploads\Covers\
\Desktop\Uploads\Presentations\
\Desktop\Uploads\Screens\
\Desktop\Uploads\Torrents\

Default ChromeDriver-Selenium directory

C:\ChromeDriver-Selenium\Chromedriver.exe 
C:\ChromeDriver-Selenium\Webdriver.dll
C:\ChromeDriver-Selenium\Webdriver.xml

Default Google Chrome binaries directory 

(High chances the script works just as well with a portable chromium of the same version, newer version of the browsers should work as well but they were not tested.)

C:\GoogleChrome\App\Chrome-bin\chrome.exe

You user profile directory, if you want to use your local version then point to a profile set up there.

C:\GoogleChrome\Data\profile\Default 

Py3CreateTorrent default user config path

C:\Users\$ENV:USERNAME\.py3createtorrent.cfg

The default suffixes for the files are _s.jpg for the screens, _c.jpg for the presentation covers and _i.txt for the presentation text files, you are free to change that to any desired format as well.

Rest of the explaining is done in script for more convenience.

Here is an example of how an upload folder should look with default settings when it comes to suffixes. (For folder based torrents you can set the covers/screens to be processed outside as well by changing values accordingly.)

\Cover_c.jpg (could also be _c.jpg or .gif or .anything-supported)
\Movie.mkv
\Screen_s.jpg

For individual files, here how it should look

Movie.mkv
/Desktop/Uploads/Presentations/Movie_i.txt
/Desktop/Uploads/Screens/Movie_s.txt
/Desktop/Uploads/Covers/Movie_c.txt

The script supports individual files, megapacks, image sets, even isos upload just as well. Just make sure to put the screens and covers in their respective folders for those.

The only exception where things differ slightly is for ISO uploads as individual files as those tend to have multiple screens, when you upload them just name the screens s1.jpg, s2.jpg, s3.jpg, so on and so forth. If you upload them as folders, never mind this.

The script can technically support Adult Games as well though I have not tried and don't know much about those.

If you want to do a test run before actually uploading you can comment out the last lines after #FINALIZE UPLOAD in the script.


HEADFUL MODE INFO
=================

In headful mode, once it starts you can minimize the browser and let it run, when it's done and a message will appear on the Powershell console.

HEADLESS MODE INFO
==================

You have to log yourself in the first time, I will post the login script on the respective trackers to make it easy. I will try to add more verbose and progress bars in the future.

SEMI AUTO MODE INFO
===================

The semi-auto mode will pick up the screens and covers from their respective directories but you will ask for your input for the remaining process. Categories, tags and titles will be filled in the console. In case you made mistakes you will be able to cancel the process at the presentation step.

The script supports all kinds of output templates, in this mode you will see a gui box appear with the bbcode links already inside waiting for you. Just type your presentation. Reason I am using that is because typing such text in a console is less convenient.

Supports undo/redo. 

In semi-auto mode you will be able to decide if you approve a dupe or not with a yes or no dialog.

FULL AUTO MODE INFO
===================

Be sure to put all your text files in the presentation folder, you can change or remove the default _i suffix if you don't want to use it. 

In full-auto mode there is a batch text helper to generate templates after the torrent names you can simply use with a right click as well. They will contain prefilled templates, just add your categories, taglist and type your text presentation. You can change it and recompile it as well. That workflow is the fastest and allow the use of auto-complete in your text editor. 

Category for EMP is always on line 1

Category for PB is always on line 2

This will always be the case even in the individual scripts in an effort to avoid future edits of your presentation in case you wish to stop using the cross upload script and move to the individual ones, you will have nothing to touch. Keeps things clear as PB and EMP categories differ I wanted this to be as precise as possible.

Tags are on line 4, write them as one big line of text.

Anything after line 5 will be part of the presentation.

If you need bbcode closing tags after you screenshots, feel free to edit the closing tags line in the script to suit your needs.

In case of errors for missing files or bbcode errors, the current torrent is skipped in full auto mode.

In this mode, torrent titles will be based off the directory names and the script have some pre-filled replacement string you can use. You can change that as well and add your own characters for auto-replacement.

Full-Auto mode is made to automatically skip dupes no matter by how many % but I want ideally to have it auto-pass the torrents that are less than 50%. I have to check some things. 

In full auto-mode all dupes will be logged in the dupes folder in a text file named after the torrent and containing all the information pertaining to that specific dupe.

PY3CREATE TORRENT CONFIG FILE
=============================

Your passkeys will be stored there for more convenience, if you ever need to change those you can just update that specific files, it wallows you to create shortcut names for your trackers.

Here is an example how you need to have it setup for the script to work. Just copy this into the .py3createtorrent.cfg file you will have to create in your user directory.

{
    "tracker_abbreviations": {
        "mytrackergroup": [
            "http://XXXX.XXXX.XX:XXXX/XXXX/announce",
            "http://XXXX.XXXX.XX:XXXX/XXXX/announce"
        ],
        "EMP": "http://XXXX.XXXX.XX:XXXX/XXXX/announce",
        "PB": "http://XXXX.XXXX.XX:XXXX/XXXX/announce"
    },
      "advertise": false
}








 
 
