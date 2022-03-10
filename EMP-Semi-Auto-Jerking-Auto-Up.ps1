#STARTING CHROME DRIVER WITH USER PROFILE

$WorkingPath = 'C:\ChromeDriver-Selenium';

If (($Env:Path -Split ';') -Notcontains $WorkingPath) {
    $Env:Path += ";$WorkingPath"

};

Add-Type -Path "$($WorkingPath)\WebDriver.dll";

$ChromePath = "C:\Google Chrome\App\Chrome-bin\chrome.exe";

$ChromeOptions = New-Object OpenQA.Selenium.Chrome.ChromeOptions;

$ChromeOptions.BinaryLocation = $ChromePath;  

$ChromeOptions.AddArguments(@(
    "--user-data-dir=C:\Google Chrome\Data\profile\Default"
));

#Activate the 3 options below to run in headless mode, set screen resolution accordingly, headless mode is using a separate profile so be sure to log yourself the first time.

#Headful mode is the same but has the extra browser window running as well. You can minimize it or move it to another desktop, it does not steal focus. Helpful for visual people or testing.

#$ChromeOptions.AddArguments(@(
#    "headless"
#));

#$ChromeOptions.AddArguments(@(
#"--window-size=1920,1080"
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

         $ChromeDriver.Navigate().GoToURL('https://jerking.empornium.ph');

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         Start-Sleep -S 2;

         ForEach ($File in $Screens) {

         $ChromeDriver.FindElementByXpath("/html/body/div[4]/div[1]/div/input[1]").SendKeys("$File");

         Start-Sleep -S 0.6;

         }; 

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         $ChromeDriver.FindElementByXpath("/html/body/div[4]/div[1]/div/div[2]/div[1]").Click();
                 
         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);  

         "Uploading screenshot(s)...";  

         $ChromeDriver.FindElementByXpath("/html/body/div[4]/div[1]/div/div[6]/div/div[1]/select").Click();

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         $BBCode = $ChromeDriver.FindElementByXpath("/html/body/div[4]/div[1]/div/div[6]/div/div[2]/div[2]/textarea").getattribute('value');

         "Grabbing screenshot(s) link(s)...";
         
         #COVER UPLOADING (if you need other formats or need to change suffixes, just add lines or change values in this next part)

         $Cover = GCI -LiteralPath "C:\Users\$Env:USERNAME\Desktop\Uploads\Covers\" -Filter $Name`_c.* | Select-Object -Expandproperty Fullname;

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         $ChromeDriver.Navigate().GoToURL('https://jerking.empornium.ph');

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         Start-Sleep -S 2;

         $ChromeDriver.FindElementByXpath("/html/body/div[4]/div[1]/div/input[1]").SendKeys("$Cover"); 

         "Sending cover...";

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);
     
         $ChromeDriver.FindElementByXpath("/html/body/div[4]/div[1]/div/div[2]/div[1]").Click();
     
         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         Start-Sleep -S 2;

         "Uploading torrent cover...";

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);
     
         $Direct = $ChromeDriver.FindElementByXpath("/html/body/div[4]/div[1]/div/div[6]/div/div[2]/div[1]/textarea").getattribute('value');

         "Grabbing cover link(s)..."; 

         } Else {

         $Name = [System.IO.Path]::GetFileNameWithoutExtension($Item);

         #SCREENSHOTS UPLOADING (if you need other formats or suffixes, just add lines or change values in this next part)   

         $Screens = GCI -LiteralPath $Item -Filter *_s.* -Recurse | Select-Object -Expandproperty Fullname | Select -First 40;

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         $ChromeDriver.Navigate().GoToURL('https://jerking.empornium.ph');

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         Start-Sleep -S 2;

         ForEach ($File in $Screens) { 

         $ChromeDriver.FindElementByXpath("/html/body/div[4]/div[1]/div/input[1]").SendKeys("$File");

         Start-Sleep -S 0.6; 

         };

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         $ChromeDriver.FindElementByXpath("/html/body/div[4]/div[1]/div/div[2]/div[1]").Click();
                 
         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);  

         "Uploading screenshot(s)..."; 

         $ChromeDriver.FindElementByXpath("/html/body/div[4]/div[1]/div/div[6]/div/div[1]/select").Click();

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         Start-Sleep -S 2;  

         $BBCode = $ChromeDriver.FindElementByXpath("/html/body/div[4]/div[1]/div/div[6]/div/div[2]/div[2]/textarea").getattribute('value');
         
         "Grabbing screenshot(s) link(s)...";

         #COVER UPLOADING (if you need other formats or suffixes, just add lines or change values in this next part)  

         $Cover = GCI -literalpath $Item -Filter $Name`_c.* -Recurse | Select-Object -expandproperty fullname;

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         $ChromeDriver.Navigate().GoToURL('https://jerking.empornium.ph');

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         Start-Sleep -S 2;  

         $ChromeDriver.FindElementByXpath("/html/body/div[4]/div[1]/div/input[1]").SendKeys("$File");

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);
     
         $ChromeDriver.FindElementByXpath("/html/body/div[4]/div[1]/div/div[2]/div[1]").Click();
     
         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         Start-Sleep -S 2;  

         "Uploading Torrent Cover...";
     
         $Direct = $ChromeDriver.FindElementByXpath("/html/body/div[4]/div[1]/div/div[6]/div/div[2]/div[1]/textarea").getattribute('value');

         "Grabbing Cover Link...";

     };     

     #TORRENT CREATION (You can modify the script to skip this and create torrents on your own as well, set by default to private, verbose mode and piece size 8MB)

     #Use the config file located in 'C:\Users\$Env:USERNAME\.py3createtorrent.cfg' by default to set your announce URLs and their 'shortcut name'.

     #If you need to reset your passkey just update the .py3createtorrent.cfg, no need to edit the script.     

     py3createtorrent -v --private -p 8192 -c "Auto-Up, Automate uploading across trackers" -s EMP -t EMP -o "C:\Users\$Env:USERNAME\Desktop\UPLOADS\TORRENTS\$Name-EMP.torrent" "$Item";

     "Creating torrent(s)...";
 
     #This next line isn't mandatory, just special character replacement for direct links you can take it out if you never use it

     $Direct -Replace ("¦", "%C2%A6");

     ##START OF UPLOAD SEQUENCE EMP##

     "Start of upload sequence for EMP...";

     $ChromeDriver.Navigate().GoToURL('https://www.empornium.is/upload.php');

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

     $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[6]/td[2]/input").SendKeys("$Direct");

     #CATEGORY

     $CategoryEMP = Read-Host "Enter your torrent category for EMP";

     $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[2]/td[2]/select").SendKeys("$CategoryEMP");

     "Sending Category..."; 

     #TITLE

     $Title = Read-Host "Enter your torrent title";

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

     $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[3]/td[2]/input").SendKeys("$Title");

     "Sending title..."; 

     #TAGS

     $Tags = Read-Host "Enter your taglist (Minimum 8)"

     $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[5]/td[2]/div/textarea").SendKeys($Tags);

     "Sending taglist..."; 

     #PRESENTATION

     ### Creating the form with the Windows forms namespace

     Add-Type -AssemblyName System.Windows.Forms;
    
     Add-Type -AssemblyName System.Drawing;
    
     $Form = New-Object System.Windows.Forms.Form;
    
     $Form.Text = 'Enter the BBCode presentation'; ### Text to be displayed in the title
    
     $Form.Size = New-Object System.Drawing.Size(640,540); ### Size of the window
    
     $Form.StartPosition = 'CenterScreen';  ### Optional - specifies where the window should start
    
     $Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow;  ### Optional - prevents resize of the window
    
     $Form.Topmost = $True;  ### Optional - Opens on top of other windows

     ### Adding an OK button to the text box window
    
     $OKButton = New-Object System.Windows.Forms.Button;
    
     $OKButton.Location = New-Object System.Drawing.Point(400,460); ### Location of where the button will be
    
     $OKButton.Size = New-Object System.Drawing.Size(76,24); ### Size of the button
    
     $OKButton.Text = 'OK'; ### Text inside the button
    
     $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK;
    
     $Form.AcceptButton = $OKButton;
    
     $Form.Controls.Add($OKButton);

     ### Adding a Cancel button to the text box window
    
     $CancelButton = New-Object System.Windows.Forms.Button;
    
     $CancelButton.Location = New-Object System.Drawing.Point(120,460); ### Location of where the button will be
    
     $CancelButton.Size = New-Object System.Drawing.Size(76,24); ### Size of the button
    
     $CancelButton.Text = 'Cancel'; ### Text inside the button
    
     $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel;
    
     $Form.CancelButton = $CancelButton;
    
     $Form.Controls.Add($CancelButton);

     ### Putting a label above the text box
    
     $Label = New-Object System.Windows.Forms.Label;
    
     $Label.Location = New-Object System.Drawing.Point(10,10); ### Location of where the label will be
    
     $Label.AutoSize = $True
    
     $Font = New-Object System.Drawing.Font("Arial",12,[System.Drawing.FontStyle]::Bold); ### Formatting text for the label
    
     $Label.Font = $Font;
    
     $Label.Text = $Input_Type; ### Text of label, defined by the parameter that was used when the function is called
    
     $Label.ForeColor = 'Red'; ### Color of the label text
    
     $Form.Controls.Add($Label);

     ### Inserting the text box that will accept input
    
     $TextBox = New-Object System.Windows.Forms.TextBox;
    
     $TextBox.Location = New-Object System.Drawing.Point(10,40); ### Location of the text box
    
     $TextBox.Size = New-Object System.Drawing.Size(600,380); ### Size of the text box
    
     $TextBox.Multiline = $True; ### Allows multiple lines of data
    
     $TextBox.AcceptsReturn = $True; ### By hitting enter it creates a new line
    
     $TextBox.ScrollBars = "Vertical"; ### Allows for a vertical scroll bar if the list of text is too big for the window

     $Textbox.Text = $BBCode
    
     $Form.Controls.Add($TextBox);

     $Form.Add_Shown({$TextBox.Select()}); ### Activates the form and sets the focus on it
    
     $Result = $Form.ShowDialog();### Displays the form 

     ### If the OK button is selected do the following
     If ($Result -eq [System.Windows.Forms.DialogResult]::OK) {

         ForEach ($Line in $Textbox.Text) {

             $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[7]/td[2]/textarea").SendKeys("$Line`n"); 

         };
    
     };

    ### If the cancel button is selected do the following
    If ($Result -eq [System.Windows.Forms.DialogResult]::Cancel) {
        
        Write-Host "User Canceled" -BackgroundColor Red -ForegroundColor White;
        
        Write-Host "Press any key to exit...";
        
        $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown");
        
        Exit
    }

     $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[7]/td[2]/textarea").SendKeys("$BBCode");

     "Sending presentation..."; 

     #TORRENT FILE

     $TorrentEMP = "C:\Users\$Env:USERNAME\Desktop\UPLOADS\TORRENTS\$Name-EMP.torrent";

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

     $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[1]/td[2]/input[2]").SendKeys($TorrentEMP);

     "Sending torrent file..."; 

     #DUPE CHECK

     "Dupe detection...";

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);
     
     $ChromeDriver.FindElementByXpath('/html/body/div[3]/div[2]/div/form/table/tbody/tr[1]/td[2]/span/input').Click();

     $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400); 

     If ($DupeCheck = $ChromeDriver.FindElementByXpath('/html/body/div[3]/div[2]/div/form/div[2]').Text) {

         "----EMPORNIUM----`n$DupeCheck`n----DATE----";

         Get-Date -Format yyyy-MM-dd@hh.mm.ss;  

         "-----------------";

         $Answer = Read-Host "(Yes or No) Do you want to upload this dupe, are you sure?";

         While ("Yes","No" -NotContains $Answer)

         {
             $Answer = Read-Host "(Yes or No) Do you want to upload this dupe, are you sure?";
         };

         If ($Answer -Contains "Yes") { 

             Write-Host "Fair Enough";

             $ChromeDriver.FindElementByXpath('/html/body/div[2]/div[2]/div/form/div[3]/div/input').Click();

             #$ChromeDriver.FindElementByXpath('/html/body/div[3]/div[2]/div/form/table/tbody/tr[9]/td/input[2]').Click();


         } Else {

             "Torrent $Title was not uploaded"; 

         };

         } Else { 

         "No dupes detected, continuing...";

         #FINALIZE UPLOAD

         $ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

         $ChromeDriver.FindElementByXpath("/html/body/div[3]/div[2]/div/form/table/tbody/tr[9]/td/input[2]").Click();

         "Uploading torrent...";

     }

     Start-Sleep -S 2;   

}


Read-Host "Press any key to exit Auto-Up";

$ChromeDriver.Close();

$ChromeDriver.Quit();

exit




 
