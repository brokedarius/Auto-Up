#Feel free to use the batch text file helper script to generate .txt files with BBCode templates for all your torrents with a single right click.

#STARTING CHROME DRIVER WITH USER PROFILE, set directories accordingly.

$WorkingPath = 'C:\ChromeDriver-Selenium';

If (($Env:Path -Split ';') -Notcontains $WorkingPath) {
    $Env:Path += ";$WorkingPath"

};

Add-Type -Path "$($WorkingPath)\WebDriver.dll";

$ChromePath = "C:\Google Chrome\App\Chrome-bin\chrome.exe"

$ChromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions;

$ChromeOptions.BinaryLocation = $ChromePath  

$ChromeOptions.AddArguments(@(
    "--user-data-dir=C:\Google Chrome\Data\profile\Default"
));

#Activate the 3 options below to run in headless mode, set screen resolution accordingly, headless mode is using a separate profile so be sure to log yourself the first time.

#Headful mode is the same but has the extra browser window running as well. You can minimize it or move it to another desktop, it does not steal focus. Helpful for visual people or testing.

#$ChromeOptions.AddArguments(@(
#    "headless"
#));

#$ChromeOptions.AddArguments(@(
#"--window-size=2560,1440"
#));


#$ChromeOptions.AddArguments(@(
#'--disable-gpu'
#));

#Log level is set at 3 to avoid useless warnings displayed on the command line by default over the output, with this only errors will be shown.

$ChromeOptions.AddArguments(@(
"log-level=3"
));

$ChromeDriver = New-Object OpenQA.Selenium.Chrome.ChromeDriver($ChromeOptions);

"Starting chrome driver..."; 

ForEach ($Item in $Args) {

    If (Test-Path -LiteralPath $Item -PathType Leaf) {

         $Name = [System.IO.Path]::GetFileNameWithoutExtension($Item);

         #SCREENSHOTS UPLOADING (if you need other formats or suffixes, just add lines or change values in this next part)   

         $Screens = GCI -LiteralPath "C:\Users\$Env:USERNAME\Desktop\Uploads\Screens\" -Filter $Name`_s* | Select-Object -ExpandProperty FullName;

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         $ChromeDriver.Navigate().GoToURL('https://fapping.empornium.sx/');

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         Start-Sleep -S 2;

         ForEach ($File in $Screens) { 

         $ChromeDriver.FindElementByXpath("/html/body/div[1]/div[2]/form/div[4]/div[2]/div[1]/div[2]/div/input[2]").SendKeys("$File"); 

         };

         If ($Screens.Count -gt 1) {

             #Back and forth, necessary for SendKeys() to work on fapping with multi-file uploads
         
             $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

             $ChromeDriver.Navigate().Back();

             $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

             $ChromeDriver.Navigate().Forward();

         } Else {};

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         $ChromeDriver.FindElementById("upload-button").Click();
                 
         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400); 

         "Uploading screenshot(s)...";  

         If ($Screens.Count -gt 1) { 

             $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

             $ChromeDriver.FindElementByXPath("/html/body/div[1]/div[2]/div[1]/select/option[2]").Click()

             $BBCode = $ChromeDriver.FindElementByXpath("/html/body/div[1]/div[2]/div[1]/textarea[2]").getattribute('value');
         
         } Else {

             $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);    

             $BBCode = $ChromeDriver.FindElementByXpath("/html/body/div[1]/div[2]/div/div[2]/div[1]/div[1]/input").getattribute('value'); 

         };  

         "Grabbing screenshot(s) link(s)...";
         
         #COVER UPLOADING (if you need other formats or need to change suffixes, just add lines or change values in this next part)

         $Cover = GCI -LiteralPath "C:\Users\$Env:USERNAME\Desktop\Uploads\Covers\" -Filter $Name`_c.* | Select-Object -Expandproperty Fullname;

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         $ChromeDriver.Navigate().GoToURL('https://fapping.empornium.sx');

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         $ChromeDriver.FindElementByXpath("/html/body/div[1]/div[2]/form/div[4]/div[2]/div[1]/div[2]/div/input[2]").SendKeys("$Cover"); 

         "Sending cover...";

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);
     
         $ChromeDriver.FindElementById("upload-button").Click();
     
         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         "Uploading torrent cover...";
     
         $Direct = $ChromeDriver.FindElementByXpath("/html/body/div[1]/div[2]/div/div[2]/div[1]/div[2]/input").GetAttribute("Value");

         "Grabbing cover link(s)..."; 

         } Else {

         $Name = [System.IO.Path]::GetFileNameWithoutExtension($Item);

         #SCREENSHOTS UPLOADING (if you need other formats or suffixes, just add lines or change values in this next part)   

         $Screens = GCI -LiteralPath $Item -Filter *_s.* -Recurse | Select-Object -Expandproperty Fullname | Select -First 40;

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         $ChromeDriver.Navigate().GoToURL('https://fapping.empornium.sx/');

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         Start-Sleep -S 2;

         ForEach ($File in $Screens) { 

         $ChromeDriver.FindElementByXpath("/html/body/div[1]/div[2]/form/div[4]/div[2]/div[1]/div[2]/div/input[2]").SendKeys("$File"); 

         };

         If ($Screens.Count -gt 1) {

             #Back and forth, necessary for SendKeys() to work on fapping with multi-file uploads
         
             $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

             $ChromeDriver.Navigate().Back();

             $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

             $ChromeDriver.Navigate().Forward();

         } Else {};

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         $ChromeDriver.FindElementById("upload-button").Click();
                 
         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400); 

         "Uploading screenshot(s)...";  

         If ($Screens.Count -gt 1) { 

             $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

             $ChromeDriver.FindElementByXPath("/html/body/div[1]/div[2]/div[1]/select/option[2]").Click()

             $BBCode = $ChromeDriver.FindElementByXpath("/html/body/div[1]/div[2]/div[1]/textarea[2]").getattribute('value');
         
         } Else {

             $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);    

             $BBCode = $ChromeDriver.FindElementByXpath("/html/body/div[1]/div[2]/div/div[2]/div[1]/div[1]/input").getattribute('value'); 

         }; 

         "Grabbing screenshot(s) link(s)...";

         #COVER UPLOADING (if you need other formats or suffixes, just add lines or change values in this next part)  

         $Cover = GCI -literalpath $Item -Filter folder.jpg -Recurse | Select-Object -expandproperty fullname;

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         $ChromeDriver.Navigate().GoToURL('https://fapping.empornium.sx');

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400); 

         $ChromeDriver.FindElementByXpath("/html/body/div[1]/div[2]/form/div[4]/div[2]/div[1]/div[2]/div/input[2]").SendKeys("$Cover");

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);
     
         $ChromeDriver.FindElementById("upload-button").Click();
     
         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         "Uploading Torrent Cover...";
     
         $Direct = $ChromeDriver.FindElementByXpath("/html/body/div[1]/div[2]/div/div[2]/div[1]/div[2]/input").GetAttribute("Value");

         "Grabbing Cover Link...";

     }      

     #TORRENT CREATION (You can modify the script to skip this and create torrents on your own as well, set by default to private, verbose mode and piece size 8MB)

     #Use the config file located in 'C:\Users\$Env:USERNAME\.py3createtorrent.cfg' by default to set your announce URLs and their 'shortcut name'.

     #If you need to reset your passkey just update the .py3createtorrent.cfg, no need to edit the script.     

     py3createtorrent -v --private -p 8192 -c "Auto-Up, Automate uploading across trackers" -s EMP -t EMP -o "C:\Users\$Env:USERNAME\Desktop\UPLOADS\TORRENTS\$Name-EMP.torrent" "$Item";

     py3createtorrent -v --private -p 8192 -c "Auto-Up, Automate uploading across trackers" -s PB -t PB -o "C:\Users\$Env:USERNAME\Desktop\UPLOADS\TORRENTS\$Name-PB.torrent" "$Item";

     "Creating torrent(s)...";
 
     #This next line isn't mandatory, just special character replacement for direct links you can take it out if you never use it

     $Direct -Replace ("¦", "%C2%A6");

     ##START OF UPLOAD SEQUENCE EMP##

     "Start of upload sequence for EMP...";

     $ChromeDriver.Navigate().GoToURL('https://www.empornium.is/upload.php');

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

     $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[6]/td[2]/input").SendKeys("$Direct");

     #CATEGORY-EMP (Must be on line 1 of your text file, don't make typos)

     $CategoryEMP = GCI -LiteralPath "C:\Users\$Env:USERNAME\Desktop\Uploads\Presentations\$Name`_i.txt" | Get-content -TotalCount 1;

     $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[2]/td[2]/select").SendKeys("$CategoryEMP");

     "Sending Category..."; 

     #This next line isn't mandatory, just special character replacement, else the torrent will be named after the file without the extension or the folder by default.

     $Title = $Name.Replace('_¦@GROUP¦','').Replace("_"," ");

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

     $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[3]/td[2]/input").SendKeys("$Title");

     "Sending title..."; 

     #TAGS (Tags must be on line 4 of your text file, do not add line returns)

     $Tags = GCI -LiteralPath "C:\Users\$Env:USERNAME\Desktop\Uploads\Presentations\$Name`_i.txt" | Get-content | Select -First 4 | Select -Last 1;

     $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[5]/td[2]/div/textarea").SendKeys($Tags);

     "Sending taglist..."; 

     #PRESENTATION (Make sure there are no BBCode errors or else the torrent will be skipped)

     $Presentation = GCI -LiteralPath "C:\Users\$Env:USERNAME\Desktop\Uploads\Presentations\$Name`_i.txt" | Get-content | Select -Skip 5;

     ForEach ($Line in $Presentation) {

         $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[7]/td[2]/textarea").SendKeys("$Line`n"); 

     };

     $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[7]/td[2]/textarea").SendKeys("$BBCode");

     #Closing tags for your bbcode (those you want after the screens)

     $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[7]/td[2]/textarea").SendKeys("[/align][/td][/tr][/table][/bg]");

     "Sending presentation...";

     #ANONYMOUS UPLOAD

     $ChromeDriver.FindElementByXpath('/html/body/div[3]/div[2]/div/form/table/tbody/tr[8]/td[2]/input[2]').Click(); 

     #TORRENT FILE

     $TorrentEMP = "C:\Users\$Env:USERNAME\Desktop\UPLOADS\TORRENTS\$Name-EMP.torrent";

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

     $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[1]/td[2]/input[2]").SendKeys($TorrentEMP);

     "Sending torrent file..."; 

     #DUPE CHECK (for now dupes will be skipped no matter the %)

     "Dupe detection...";

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);
     
     $ChromeDriver.FindElementByXpath('/html/body/div[3]/div[2]/div/form/table/tbody/tr[1]/td[2]/span/input').Click();

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400); 

     if ($DupeCheck = $ChromeDriver.FindElementByXpath('/html/body/div[3]/div[2]/div/form/div[2]').Text) {

         Add-Content -LiteralPath "C:\Users\$Env:USERNAME\Desktop\Uploads\Dupes\$Title-EMP.txt" "----EMPORNIUM----`n$DupeCheck`n----DATE----";

         Add-Content -LiteralPath "C:\Users\$Env:USERNAME\Desktop\Uploads\Dupes\$Title-EMP.txt" -Value (get-date -Format yyyy-MM-dd@hh.mm.ss);

         Add-Content -LiteralPath "C:\Users\$Env:USERNAME\Desktop\Uploads\Dupes\$Title-EMP.txt" "----------------";

         "A dupe has been logged.";

         "----EMPORNIUM----`n$DupeCheck`n----DATE----";

         Get-Date -Format yyyy-MM-dd@hh.mm.ss; 

         "-----------------";

     } else { 

     "No dupes detected, continuing...";

     #FINALIZE UPLOAD

     #$ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

     #$ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[9]/td/input[2]").Click();

     # "Uploading torrent...";

     }

     Start-Sleep -S 2;

     ##START OF UPLOAD SEQUENCE PB##

     "Start of upload sequence PB...";

     $ChromeDriver.Navigate().GoToURL('https://pornbay.org/upload.php');

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

     $ChromeDriver.FindElementByXpath("/html/body/div[2]/div[3]/div/form/table/tbody/tr[5]/td[2]/input").SendKeys("$Direct");

     "Sending cover...";

     #CATEGORY-PB (Must be on line 2 of your text file, don't make typos else it will be skipped)

     $CategoryPB = GCI -LiteralPath "C:\Users\$Env:USERNAME\Desktop\Uploads\Presentations\$Name`_i.txt" | Get-content | Select -First 2 | Select -Last 1;

     $ChromeDriver.FindElementByXpath("/html/body/div[2]/div[3]/div/form/table/tbody/tr[2]/td[2]/select").SendKeys("$CategoryPB");

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

     $ChromeDriver.FindElementByXpath("/html/body/div[2]/div[3]/div/form/table/tbody/tr[3]/td[2]/input").SendKeys("$Title");

     "Sending category...";

     #TAGS (Tags must be on line 4 of your text file, do not add line returns)

     $ChromeDriver.FindElementByXpath("/html/body/div[2]/div[3]/div/form/table/tbody/tr[4]/td[2]/textarea").SendKeys($Tags);

     "Sending taglist...";

     #PRESENTATION (Make sure there are no BBCode errors or else the torrent will be skipped)

     ForEach ($Line in $Presentation) {

         $ChromeDriver.FindElementByXpath("/html/body/div[2]/div[3]/div/form/table/tbody/tr[6]/td[2]/textarea").SendKeys("$Line`n") 

     };

     $ChromeDriver.FindElementByXpath("/html/body/div[2]/div[3]/div/form/table/tbody/tr[6]/td[2]/textarea").SendKeys("$BBCode");

     #Closing tags for your bbcode (those you want usually after the screens)

     $ChromeDriver.FindElementByXpath("/html/body/div[2]/div[3]/div/form/table/tbody/tr[6]/td[2]/textarea").SendKeys("[/align][/td][/tr][/table][/bg]");

     "Sending presentation...";

     #TORRENT FILE

     $TorrentPB = "C:\Users\$Env:USERNAME\Desktop\UPLOADS\TORRENTS\$Name-PB.torrent";

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

     $ChromeDriver.FindElementByXpath("/html/body/div[2]/div[3]/div/form/table/tbody/tr[1]/td[2]/input[2]").SendKeys($TorrentPB);

     "Sending torrent file...";

     #ANONYMOUS UPLOAD

     $ChromeDriver.FindElementByXpath('/html/body/div[2]/div[3]/div/form/table/tbody/tr[7]/td[2]/input[2]').Click();                        

     #DUPE CHECK (dupes will be logged no matter the % for now)

     "Dupe detection...";

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);
     
     $ChromeDriver.FindElementByXpath('/html/body/div[2]/div[3]/div/form/table/tbody/tr[1]/td[2]/span/input').Click();

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400); 

     if ($DupeCheck = $ChromeDriver.FindElementByXpath('/html/body/div[2]/div[3]/div/form/div[2]').text) {

         Add-Content -LiteralPath "C:\Users\$Env:USERNAME\Desktop\Uploads\Dupes\$Title-PB.txt" "----PORNBAY----`n$DupeCheck`n----DATE----";

         Add-Content -LiteralPath "C:\Users\$Env:USERNAME\Desktop\Uploads\Dupes\$Title-PB.txt" -Value (get-date -Format yyyy-MM-dd@hh.mm.ss);

         Add-Content -LiteralPath "C:\Users\$Env:USERNAME\Desktop\Uploads\Dupes\$Title-PB.txt" "----------------";

         "A dupe has been logged.";

         "----PORNBAY----`n$DupeCheck`n----DATE----";

         Get-Date -Format yyyy-MM-dd@hh.mm.ss;  

         "-----------------";

     } else { 

     "No dupes detected, continuing...";

     #FINALIZE UPLOAD

     #$ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

     #$ChromeDriver.FindElementByXpath("/html/body/div[2]/div[3]/div/form/table/tbody/tr[8]/td/input[2]").Click();

     # "Uploading torrent...";

     }

     Start-Sleep -S 2;       

}


Read-Host "Press any key to exit Auto-Up";

$ChromeDriver.Close();

$ChromeDriver.Quit();

exit




 