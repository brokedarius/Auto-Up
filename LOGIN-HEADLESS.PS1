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

$ChromeOptions.AddArguments(@(
    "headless"
));

#Set the screen resolution to match yours.

$ChromeOptions.AddArguments(@(
"--window-size=2560,1440"
));


$ChromeOptions.AddArguments(@(
'--disable-gpu'
));

#Log level is set at 3 to avoid useless warnings displayed on the command line by default over the output, with this only errors will be shown.

$ChromeOptions.AddArguments(@(
"log-level=3"
));

$ChromeDriver = New-Object OpenQA.Selenium.Chrome.ChromeDriver($ChromeOptions);

"Starting chrome driver..."; 

$ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

$ChromeDriver.Navigate().GoToURL('http://empornium.sx/login');

#Username

$ChromeDriver.FindElementByXpath('//*[@id="username"]/input').SendKeys('USER');

#Pass

$ChromeDriver.FindElementByXpath('//*[@id="password"]/input').SendKeys('PASS');

#Stay Logged In 

$ChromeDriver.FindElementByXpath('/html/body/div[2]/div[2]/div[2]/form/div[3]/div/label[2]/input').Sendkeys('1');

#login Button 

$ChromeDriver.Manage().Timeouts().ImplicitWait = [TimeSpan]::FromSeconds(400);

$ChromeDriver.FindElementByXpath('/html/body/div[2]/div[2]/div[2]/form/div[3]/div/p/input').Click();

#Enter 2FA code (Remove if you don't have 2FA)

$ChromeDriver.FindElementByXpath('/html/body/div[2]/div[2]/div[2]/form/input[2]').Sendkeys('2FA CODE');

#Click to login after 2fa

$ChromeDriver.FindElementByXpath('/html/body/div[2]/div[2]/div[2]/form/div[1]/input').Click();

#If this command fails, you are not logged in.

$ChromeDriver.Navigate().GoToURL('http://empornium.sx/torrents.php');

Read-Host "Press Enter To Exit"

Exit