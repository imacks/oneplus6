prop.version=12
############################################################################
#            
# opoverlay.profile
#
# Configuration file for customizing the ROM
# 
# Magisk overlay ROM for OnePlus6 devices
# Authored by iMacks
#
#############################################################################
#
# This file is used to save all individual selections made.
#     
# This file must be stored in the /sdcard/ folder
# If the installer cannot find this file in the path above, 
# it will use the one in the root folder of the overlayrom.zip.
#
# For editing this file on Windows OS you MUST use Notepad++ for this.
#
#############################################################################
#
# ----- How to Guide ------
# 
# For each option you will find a line looking like this:
# Fastest-NoAnimations = 1
#
# Allowed values are:
#   1 = yes, I want this
#   0 = don't apply option - do nothing  
#
#############################################################################

#--< OVERLAYROM.MENU.MAIN - ROMTWEAKS >--< Windows Animation Scales >
#    If speed is more important, choose a lower value for faster windows animations
WindowsAnimationScales = 1

	#--< OVERLAYROM.MENU.ANIMATION.SCALES - WINDOWSANIMATIONSPEEDS >--< Fastest - No Animations >
	#    Value = 0
	Fastest-NoAnimations = 0

	#--< OVERLAYROM.MENU.ANIMATION.SCALES - WINDOWSANIMATIONSPEEDS >--< Very Fast Animations >
	#    Value = 0.25
	VeryFastAnimations = 0

	#--< OVERLAYROM.MENU.ANIMATION.SCALES - WINDOWSANIMATIONSPEEDS >--< Fast Animations >
	#    Value = 0.50
	FastAnimations = 1

	#--< OVERLAYROM.MENU.ANIMATION.SCALES - WINDOWSANIMATIONSPEEDS >--< Android Standard  >
	#    Value = 1
	AndroidStandard = 0


#--< OVERLAYROM.MENU.MAIN - ROMTWEAKS >--< Disable Google Play Wakelocks >
#    This will block some annoying Google Play Store and Services Wakelocks to improved battery life
DisableGooglePlayWakelocks = 1


#--< OVERLAYROM.MENU.MAIN - ROMTWEAKS >--< Skip Android Setup Wizard >
#    This will skip the Android Setup Wizard on first boot after a clean install.
SkipAndroidSetupWizard = 0


#--< OVERLAYROM.MENU.MAIN - ROMTWEAKS >--< Modded Apps Detaching >
#    This will detach the modded YouTube vanced. 
#    Default setting (0) is simply disable updates for the app but YouTube will always be listed in the Playstore for available updates
#    If you want to completely hide Youtube set it to 1 but this will disable the Playstore DailyHygiene Service. No self or app auto-updates anymore.
ModdedAppsDetaching = 0


#--< OVERLAYROM.MENU.MAIN - BUSYBOX >--< BusyBox by osm0sis >
#    Recommended, but you might want to use another Busybox variant
BusyBoxbyosm0sis = 0


#--< OVERLAYROM.MENU.MAIN - SDCARDFIX >--< Fix SDcard permissions >
#    Fix ownership and permissions of files and folders on the SD card to what they would be if Android OS had put them there itself.
FixSDcardpermissions = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - LAUNCHERSELECTION >--< OnePlus Launcher >
#    WARNING! If you uncheck this launcher, make sure you you have an alternative launcher below. Otherwise, you will boot to a blank screen!
OnePlusLauncher = 1

#--< OVERLAYROM.MENU.OPTIONS.MENU - LAUNCHERSELECTION >--< Nova Launcher >
#    One of the smoothest and customizable launcher.
NovaLauncher = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - LAUNCHERSELECTION >--< Action Launcher >
#    Action Launcher brings all the features of Pixel Launcher and Android Oreo to your device
ActionLauncher = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - LAUNCHERSELECTION >--< Pixel Laucher >
#    This used to be the original Nexus Launcher. Google Now is in a swipable panel on the homescreen and more.
PixelLaucher = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - LAUNCHERSELECTION >--< Lawnchair Laucher >
#    This is a Launcher based on the Pixel Lancher but provides you with much more functionallity
LawnchairLaucher = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - SOUNDMODS >--< ViPER4AndroidFX >
#    This is the original ViPER4AndroidFX
Viper4Android = 1

#--< OVERLAYROM.MENU.OPTIONS.MENU - SOUNDMODS >--< DolbyAtmos >
#    Legacy Version of Dolby Atmos
DolbyAtmos = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - SOUNDMODS >--< Viper Profile Collection >
#    Profile collection for Viper4Arise
ViperProfileCollection = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - SOUNDMODS >--< Stereo Speaker Mod >
#    Adds the earpiece as an additional speaker. Earpiece audio might not be as clear as main speaker.
StereoSpeakerMod = 0


##### !!!!! -> Xposed do NOT work on PIE - for OREO only <- !!!!!

#--< OVERLAYROM.MENU.OPTIONS.MENU - XPOSEDFRAMEWORK >--< Xposed - Systemless by topjohnwu >
#    Xposed BETA as Systemless Module. WARNING! One Android restart required and Xposed cannot be hidden from SafetyNet.
Xposedbyrovo89sysless = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - XPOSEDFRAMEWORK >--< Uninstall Xposed Systemless >
#    This will uninstall the Xposed Systemless Module and the Xposed Installer App.
XposedUninstall = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - EMOJIS >--< Oneplus Stock Emojis >
#    OnePlus stock emojis.
OneplusStockEmojis = 1

#--< OVERLAYROM.MENU.OPTIONS.MENU - EMOJIS >--< Android O Emojis >
#    Stock Android O emojis.
AndroidOEmojis = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - EMOJIS >--< iOS Emojis >
#    iOS 12.1 emojis
iOSEmojis = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - EMOJIS >--< Emoji One >
#    Another Emoji variation 
EmojiOne = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - EMOJIS >--< Samsung Emojis >
#    Samsung devices use their own glossy emojis
SamsungEmojis = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - SUBSTRATUM >--< Substratum Theme Engine >
#    Substratum is a theme engine. You can download different theme modules which helps you to theme apps, taskbar items etc.
SubstratumThemeEngine = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - SUBSTRATUM >--< Ozone Module >
#    Provides you with different actionbar and accent combinations, QS backgrounds etc.
OzoneModule = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - SUBSTRATUM >--< K-Klock Module >
#    Provides plenty of options to modify the taskbar clock like center it or apply colors etc.
K-KlockModule = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< AdAway >
#    AdAway doesn't directly block ads but it limits unwanted ads by blocking servers that distribute those ads to websites.
AdAway = 1


#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Always On Display >
#    This adds an Always On Option in Settings. WARNING! This will impact battery life.
AlwaysOnDisplay = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Navigation Gestures >
#    Get iPhone X style gesture control
NavigationGestures = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< YouTube Vanced mod Black >
#    This is a modded version of the original YouTube app that enables background / screen-off playback and removes ads.
YouTubeiYTBPmodWhite = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< YouTube Vanced mod Dark >
#    This is a dark themed modded version of the original YouTube app that enables background / screen-off playback and removes ads.
YouTubeiYTBPmodDark = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Google Dialer - OOS Dialer remains >
#    Google Dialer experience but several features are not working when combined with OOS Dialer. But native call recording works.
GoogleDialer1 = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Google Dialer - OOS Dialer removed >
#    Improves your calling experience and gain control over calls with features like spam protection, caller ID and call blocking.
GoogleDialer2 = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Google Camera >
#    Modded version with HDR+ and slow motion
GoogleCamera = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Google Gmail for Exchange >
#    This will extend Gmail so you can connect to an Exchange account
GoogleGmailforExchange = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Screen Timeout Tile >
#    QuickTiles is a Screen timeout tile which lets you toggle between 15, 30 seconds, 1 , 2 , 5 , 10, 30 minutes screen on time.
Caffeine = 1


#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< MoreLocal >
#    Enable more local languages in HydrogenOS.
#    Doesn't work for Android itself, but all user apps switch to the selected language.
MoreLocale = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Digital WellBeing >
#    Get a daily view of your digital habits, such as how frequently you use different apps, notification count, and how often you check your phone.
DigitalWellBeing = 1


#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Ice Box Speedup System Plugin >
#    Speed up Ice Box's freezing and defrosting.
IceBoxSpeedup = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - BOOTANIMATIONS >--< Oxygen Stock Bootanimation >
#    The stock OxygenOS boot animation.
OxygenStockBootanimation = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - BOOTANIMATIONS >--< Bootanimation in ROM folder >
#    Install a bootanimation.zip which you must have already copied to the rom folder on your internal sdcard.
BootAnimationInOverlayFolder = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - BOOTANIMATIONS >--< Google Pixel 1 Bootanimation >
#    Google Pixel phone boot animation.
GooglePixel1Bootanimation = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - BOOTANIMATIONS >--< Google Pixel 2 Bootanimation >
#    Google Pixel 2 phone boot animation.
GooglePixel2Bootanimation = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - BOOTANIMATIONS >--< WatchDogs Bootanimation >
#    The awesome WatchDogs animation by Robdyx
WatchDogsBootanimation = 1


# ------ Debloating Section ------------
#        0 = no debloating / don't touch
#        1 = debloat 

#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< Extreme Debloating >
#    This will debloat all removable apps without further confirmation.
ExtremeDebloating = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< OnePlus Analytics Disabler Light >
#    This will disable the OPDeviceManager which was rumored to send personal device information to OnePlus
OnePlusAnalyticsDisablerLight = 1

#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< OnePlus Analytics Disabler Full >
#    Might mess up useful stuff. Disables more stuff which is rumored to send analytics or potentially open a backdoor.
#    Attention! This option will break secret codes menus like *#800# or *#801# etc. 
OnePlusAnalyticsDisablerFull = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< HydrogenOS Bloatware >
#    This will remove bloatware on Hydrogen OS. You need to ENABLE each sub item you want to remove.
HydrogenDebloating = 1

	#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< HydrogenOS Vendor Apps >
	#    This will remove vendor apps such as QQBrowser bundled with Hydrogen OS.
	HydrogenVendorApps = 1

	#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< HydrogenOS OnePlus Accounts >
	#    This will remove OnePlus accounts on Hydrogen OS.
	HydrogenOPAccount = 1

	#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< HydrogenOS OnePlus Sync Center >
	#    This will remove OnePlus sync center on Hydrogen OS.
	HydrogenOPSyncCenter = 1

	#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< HydrogenOS OnePlus Wallet >
	#    This will remove OnePlus wallet on Hydrogen OS.
	HydrogenOPWallet = 1

	#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< HydrogenOS OnePlus Forum >
	#    This will remove OnePlus forum on Hydrogen OS.
	HydrogenOnePlusBBS = 1

	#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< HydrogenOS OnePlus Photos >
	#    This will remove OnePlus photos app on Hydrogen OS.
	HydrogenPhotos = 1

	#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< HydrogenOS OnePlus Market >
	#    This will remove OnePlus market app on Hydrogen OS.
	HydrogenMarket = 1

	#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< HydrogenOS OnePlus FindMyPhone >
	#    This will remove OnePlus FindMyPhone app on Hydrogen OS.
	HydrogenFindMyPhone = 1

	#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< HydrogenOS OnePlus Easter Egg >
	#    This will remove OnePlus easter egg on Hydrogen OS.
	HydrogenEasterEgg = 1

	#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< HydrogenOS OnePlus Icons >
	#    This will remove OnePlus icons on Hydrogen OS.
	HydrogenIcons = 1

	#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< HydrogenOS OnePlus Card >
	#    This will remove OnePlus card app on Hydrogen OS.
	HydrogenCard = 1

	#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< HydrogenOS OnePlus Calculator >
	#    This will remove OnePlus calculator on Hydrogen OS.
	HydrogenCalculator = 1


#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - GOOGLEFRAMEWORKLEVEL >--< GApps Pico level >
#    This will remove the GApps framework down to the GApps Pico level, which is the absolute minimum to run the framework
GAppsPicolevel = 0

#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - GOOGLEFRAMEWORKLEVEL >--< Total GApps removal >
#    WARNING! This will completely remove the Google Framework. No GApps such as Youtube, Chrome etc.
TotalGAppsremoval = 1


#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< Individual Debloat Selection >
#    Enabling this will allow you to remove selective apps and services. You need to ENABLE each sub item you want to remove.
IndividualDebloatSelection = 1	

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Google Chrome >
		#    If you remove Google Chrome, many apps will FC or blank screen. To fix that, you need to install the latest version of WebView separately.
		GoogleChrome = 0
		
		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< AndroidPay >
		#    Android Pay
		AndroidPay = 1
		
		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< GooglePay >
		#    Google Pay
		GooglePay = 1
				
		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Google ARCore >
		#    ARCore
		ARCore = 1		

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< CalendarGoogle >
		#    Google Calendar
		CalendarGoogle = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Drive >
		#    Google Drive
		Drive = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Gboard - Google Keyboard >
		#    Make sure you have any keyboard installed. Otherwise you will end up with NO keyboard available
		Gboard-GoogleKeyboard = 0

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Gmail2 >
		#    Gmail app
		Gmail2 = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Hangouts >
		#    Google Hangouts chat app
		Hangouts = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< LiveWallpapersPicker >
		#    Live wallpapers picker
		LiveWallpapersPicker = 0

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Maps >
		#    Google maps
		Maps = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Music2 >
		#    Google Music
		Music2 = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< OPDialer+Contacts >
		#    Make sure you have an alternativ dialer in place. Otherwise you can't do or take any calls
		OPDialer+Contacts = 0

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< OnePlus Switch >
		#    OnePlus phone data migration app.
		OnePlusSwitch = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< OPFilemanager >
		#    OnePlus file manager
		OPFilemanager = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< OPForum >
		#    OnePlus forum
		OPForum = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< OPMusic >
		#    OnePlus music app
		OPMusic = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< OPPush >
		#    OnePlus push service
		OPPush = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< OP Icons >
		#    OnePlus stock icons.
		OPIcons = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Photos >
		#    OnePlus photos
		Photos = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< SoundRecorder >
		#    OnePlus sound recorder
		SoundRecorder = 0

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< SwiftKey >
		#    SwiftKey IME
		SwiftKey = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< talkback >
		#    talkback service.
		talkback = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Velvet - Google App >
		#    Required for Google Assist, OK Google, Pixel Launcher…
		Velvet-GoogleApp = 0

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Videos >
		#    Videos app.
		Videos = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Weather >
		#    OnePlus weather app.
		Weather = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< YouTube >
		#    YouTube app.
		YouTube = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< BasicDreams >
		#    
		BasicDreams = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< BookmarkProvider >
		#    
		BookmarkProvider = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< BTtestmode >
		#    
		BTtestmode = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< bugreport >
		#    
		bugreport = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< DMAgent >
		#    
		DMAgent = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< Duo >
		#    
		Duo = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< EasterEgg >
		#    
		EasterEgg = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< EngSpecialTest >
		#    
		EngSpecialTest = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< fmfactorytest >
		#    
		fmfactorytest = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< LogKitSdService >
		#    
		LogKitSdService = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< NFCTestMode >
		#    
		NFCTestMode = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< OemAutoTestServer >
		#    
		OemAutoTestServer = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< OPNotes >
		#    
		OPNotes = 1		

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< NVBackupUI >
		#    
		NVBackupUI = 1		

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< Card >
		#    
		card = 1	

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< OpenWnn >
		#    
		OpenWnn = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< PartnerBookmarksProvider >
		#    
		PartnerBookmarksProvider = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< SecureSampleAuthService >
		#    
		SecureSampleAuthService = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< SensorTestTool >
		#    
		SensorTestTool = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< Stk >
		#    
		Stk = 0

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< usb_drivers.iso >
		#    
		usb_drivers.iso = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< WifiLogger_app >
		#    
		WifiLogger_app = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< WifiRfTestApk >
		#    
		WifiRfTestApk = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< tts >
		#    
		tts = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< PicoTts >
		#    
		PicoTts = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< GoogleTTS >
		#    
		GoogleTTS = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - EXTREMEDEBLOATING-SYSTEMSERVICES >--< VrCore >
		#    
		VrCore = 1


#--< OVERLAYROM.MENU.MAIN - ROMBUILD.PROPTWEAKS >--< All build.prop Tweaks >
#    Several build.prop tweaks to improve overall performance, smoothness and battery
Allbuild.propTweaks = 0

#--< OVERLAYROM.MENU.MAIN - ROMBUILD.PROPTWEAKS >--< Individual Tweaks Selections >
#    Selectively enable build.prop tweaks. You need to ENABLE each item that you want.
IndividualTweaksSelections = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Root support for Tasker >
	#    
	RootsupportforTasker = 0

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< 2.4GHz WiFi channel bonding >
	#    
	2.4GHzWiFichannelbonding = 0

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Better call voice quality >
	#    
	Bettercallvoicequality = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Better net speeds >
	#    
	Betternetspeeds = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< 3G signal and speed tweaks >
	#    
	3Gsignalandspeedtweaks = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< More RAM  >
	#    
	MoreRAM = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Memory Tweaks >
	#    
	MemoryTweaks = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Better memory management >
	#    
	Bettermemorymanagement = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Increase general Performances >
	#    
	IncreasegeneralPerformances = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Smoother scrolling >
	#    
	Smootherscrolling = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Smoother video streaming >
	#    
	Smoothervideostreaming = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Improves audio + video rec quality >
	#    
	Improvesaudio = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< AGPS mods >
	#    
	AGPSmods = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Faster boot >
	#    
	Fasterboot = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Disable logs + error reporting >
	#    
	Disablelogs = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Magisk Hide support >
	#    
	MagiskHidesupport = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Phone rings immediately >
	#    
	Phoneringsimmediately = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< More volume steps in call >
	#    
	Morevolumestepsincall = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Decrease screen off-on time during call >
	#    
	Decreasescreenoff = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Enables 270 Degree Rotation >
	#    
	Enables270DegreeRotation = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< No wakeup by hitting volume rocker  >
	#    
	Nowakeupbyhittingvolumerocker = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Better Flashlight intensity >
	#    
	BetterFlashlightintensity = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Disable persistant USB Notifications >
	#    
	DisablepersistantUSB = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< MMS APN retry timer set to 2 seconds >
	#    
	MMSAPNretrytimersetto2sec = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Misc System Tweaks >
	#    
	MiscSystemTweaks = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Kernel Tweaks >
	#    
	KernelTweaks = 1
