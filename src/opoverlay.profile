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
#    If speed is more important to you than window animations you can choose for a lower value for faster windows animations
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
#    This will block some annoying Google Play Store and Services Wakelocks to improved battery life thanks to @MeggaMortY
DisableGooglePlayWakelocks = 1


#--< OVERLAYROM.MENU.MAIN - ROMTWEAKS >--< Skip Android Setup Wizard >
#    This will skip the Android Setup Wizard on the first boot after a clean install. Then you can deside yourself what to setup
SkipAndroidSetupWizard = 0


#--< OVERLAYROM.MENU.MAIN - ROMTWEAKS >--< Modded Apps Detaching >
#    This will detach the modded YouTube vanced. 
#    Default setting (0) is simply disable updates for the app but YouTube will always be listed in the Playstore for available updates
#    If you want to completely hide Youtube set it to 1 but this will disable the Playstore DailyHygiene Service. No self- or app auto-updates anymore.
ModdedAppsDetaching = 0


#--< OVERLAYROM.MENU.MAIN - BUSYBOX >--< BusyBox by osm0sis >
#    Recommended, but you might want to use another Busybox variant
BusyBoxbyosm0sis = 0


#--< OVERLAYROM.MENU.MAIN - SDCARDFIX >--< Fix SDcard permissions >
#    Fix ownership & permissions of files and folders on the sdcard to what they would be if Android OS had put them there itself
FixSDcardpermissions = 0





#--< OVERLAYROM.MENU.OPTIONS.MENU - LAUNCHERSELECTION >--< OnePlus Launcher >
#    BEWARE! If you uncheck this Launcher make sure you you have an alternative Launcher below or you will end up in a Black Screen!
OnePlusLauncher = 1

#--< OVERLAYROM.MENU.OPTIONS.MENU - LAUNCHERSELECTION >--< Nova Launcher >
#    It is one of the most Smoothest and highly customizable launcher.
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
#    ViPER4AndroidFX thanks to Ahrion, Zackptg5, ViPER520, ZhuHang
Viper4Android = 1

#--< OVERLAYROM.MENU.OPTIONS.MENU - SOUNDMODS >--< DolbyAtmos >
#    Legacy Version of Dolby Atmos thanks to guitardedhero, Ahrion and Zackptg5
DolbyAtmos = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - SOUNDMODS >--< Viper Profile Collection >
#    Profile collection for Viper4Arise thanks to @A.R.I.S.E. Team
ViperProfileCollection = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - SOUNDMODS >--< Stereo Speaker Mod >
#    Adds the earpiece as an additional speaker. Earpiece audio might not be as clear as main speaker
StereoSpeakerMod = 0



##### !!!!! -> Xposed do NOT work on PIE - for OREO only <- !!!!!

#--< OVERLAYROM.MENU.OPTIONS.MENU - XPOSEDFRAMEWORK >--< Xposed - Systemless by topjohnwu >
#    Xposed BETA by @rovo89 as Systemless Module by @topjohnwu - BEWARE!! One Android Restart required & Xposed trips SafetyNet.
Xposedbyrovo89sysless = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - XPOSEDFRAMEWORK >--< Uninstall Xposed Systemless >
#    This will uninstall the Xposed Systemless Module by @topjohnwu and the Xposed Installer App.
XposedUninstall = 0





#--< OVERLAYROM.MENU.OPTIONS.MENU - EMOJIS >--< Oneplus Stock Emojis >
#    Keep all System Apps and Services
OneplusStockEmojis = 1

#--< OVERLAYROM.MENU.OPTIONS.MENU - EMOJIS >--< Android O Emojis >
#    thanks to XDA Recognized Contributor linuxct
AndroidOEmojis = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - EMOJIS >--< iOS Emojis >
#    iOS 12.1 Emojis thanks to @RickyBush
iOSEmojis = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - EMOJIS >--< Emoji One >
#    another Emoji variation 
EmojiOne = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - EMOJIS >--< Samsung Emojis >
#    Samsung devices use their own glossy emojis
SamsungEmojis = 0





#--< OVERLAYROM.MENU.OPTIONS.MENU - SUBSTRATUM >--< Substratum Theme Engine >
#    Substratum is a theme engine. You can download different theme modules which helps you to theme apps, taskbar items etc.
SubstratumThemeEngine = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - SUBSTRATUM >--< Ozone Module >
#    Provides you with different actionbar + accent combinations, QS backgrounds etc.
OzoneModule = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - SUBSTRATUM >--< K-Klock Module >
#    Provides plenty of options to modify the taskbar clock like center it or apply colors etc.
K-KlockModule = 0





#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< AdAway >
#    AdAway doesn't directly block ads but it limits unwanted ads by blocking servers that distribute those ads to websites
AdAway = 1

#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Always On Display >
#    This adds an Always On Option Settings>Display>Ambient display. BEWARE! This will add some battery drain when enabled
AlwaysOnDisplay = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Navigation Gestures >
#    Get iPhone X style gesture control thanks to @MishaalRahman and @Zacharee1
NavigationGestures = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< YouTube Vanced mod Black >
#    This is a modded version of the original YouTube app that enables background / screen-off playback & removes ads
YouTubeiYTBPmodWhite = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< YouTube Vanced mod Dark >
#    This is a dark themed modded version of the original YouTube app that enables background / screen-off playback & removes ads
YouTubeiYTBPmodDark = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Google Dialer - OOS Dialer remains >
#    Google Dialer experience but several features are not working when combined with OOS Dialer. But native call recording works
GoogleDialer1 = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Google Dialer - OOS Dialer removed >
#    improves your calling experience and gain control over calls with features like spam protection, caller ID and call blocking
GoogleDialer2 = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Google Camera >
#    Modded version with HDR+ and Slowmotion working
GoogleCamera = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Google Gmail for Exchange >
#    This will extend Gmail so you can connect to an Exchange Account
GoogleGmailforExchange = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Screen Timeout Tile >
#    QuickTiles is a Screen timeout tile which lets you toggle between 15, 30 seconds, 1 , 2 , 5 , 10, 30 minutes screen on time
Caffeine = 1


#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< MoreLocal >
#    Morelocal can help you to enable your local language in HydrogenOS.
#    Don't work for Android itself, but all user apps switch to the selected language.
MoreLocale = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Digital WellBeing >
#    Get a daily view of your digital habits
#    How frequently you use different apps, How many notifications you receive, or how often you check your phone
DigitalWellBeing = 1

#--< OVERLAYROM.MENU.OPTIONS.MENU - MISCELLANEOUSOPTIONS >--< Ice Box Speedup System Plugin >
#    Speed up Ice Box's freezing and defrosting.
IceBoxSpeedup = 0





#--< OVERLAYROM.MENU.OPTIONS.MENU - BOOTANIMATIONS >--< Oxygen Stock Bootanimation >
#    
OxygenStockBootanimation = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - BOOTANIMATIONS >--< Bootanimation in ROM folder >
#    Install a bootanimation.zip which you prior copied to rom folder on your internal sdcard.
BootAnimationInOverlayFolder = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - BOOTANIMATIONS >--< Google Pixel 1 Bootanimation >
#    thanks to XDA Senior Member niwia
GooglePixel1Bootanimation = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - BOOTANIMATIONS >--< Google Pixel 2 Bootanimation >
#    
GooglePixel2Bootanimation = 0

#--< OVERLAYROM.MENU.OPTIONS.MENU - BOOTANIMATIONS >--< WatchDogs Bootanimation >
#    thanks to @Robdyx
WatchDogsBootanimation = 1







# ------ Debloating Section ------------
#        0 = no debloating / don't touch
#        1 = debloat 


#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< Extreme Debloating >
#    This will process the complete debloat list without any further menu or confirmation
ExtremeDebloating = 0


#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< OnePlus Analytics Disabler Light >
#    This will disable the OPDeviceManager which was rumored to send personal device information to OnePlus
OnePlusAnalyticsDisablerLight = 1
 
#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< OnePlus Analytics Disabler Full >
#    Might mess up usefull stuff. Disables more stuff which is rumored to send analytics or potentially open a backdoor.
#    Attention! This option will break secret codes menus like *#800# or *#801# etc. 
OnePlusAnalyticsDisablerFull = 0
 
#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< Hydrogen OS Bloatware >
#    This will completely remove all bloatware on Hydrogen OS.
HydrogenDebloating = 1


#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - GOOGLEFRAMEWORKLEVEL >--< GApps Pico level >
#    This will debloat the GApps Framework down to the GApps Pico level which is the absolut minimum to run the framework
GAppsPicolevel = 0

#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - GOOGLEFRAMEWORKLEVEL >--< Total GApps removal >
#    BEWARE!! This will completely remove the Google Framework. No GApps like Youtube, Chrome etc will work anymore
TotalGAppsremoval = 1



	
#--< OVERLAYROM.MENU.OPTIONS.MENU - DEBLOATING >--< Individual Debloat Selection >
#    This will provide you with an addition menu where you can select each app, service etc. you want to debloat.
IndividualDebloatSelection = 1	

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Google Chrome >
		#    If you debloat Google Chrome, you might experience FCs and Black screens until you update Webview to latest version!
		GoogleChrome = 0
		
		
		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< AndroidPay >
		#    
		AndroidPay = 1
		
		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< GooglePay >
		#    
		GooglePay = 1
				
		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Google ARCore >
		#    
		ARCore = 1		

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< CalendarGoogle >
		#    
		CalendarGoogle = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Drive >
		#    
		Drive = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Gboard - Google Keyboard >
		#    Make sure you have any keyboard installed. Otherwise you will end up with NO keyboard available
		Gboard-GoogleKeyboard = 0

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Gmail2 >
		#    
		Gmail2 = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Hangouts >
		#    
		Hangouts = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< LiveWallpapersPicker >
		#    
		LiveWallpapersPicker = 0

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Maps >
		#    
		Maps = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Music2 >
		#    
		Music2 = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< OPDialer+Contacts >
		#    Make sure you have an alternativ dialer in place. Otherwise you can't do or take any calls
		OPDialer+Contacts = 0

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< OnePlus Switch >
		#    
		OnePlusSwitch = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< OPFilemanager >
		#    
		OPFilemanager = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< OPForum >
		#    
		OPForum = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< OPMusic >
		#    
		OPMusic = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< OPPush >
		#    
		OPPush = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< OP Icons >
		#    
		OPIcons = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Photos >
		#    
		Photos = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< SoundRecorder >
		#    
		SoundRecorder = 0

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< SwiftKey >
		#    
		SwiftKey = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< talkback >
		#    
		talkback = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Velvet - Google App >
		#    Required for Google Assist, OK Google, Pixel Launcher…
		Velvet-GoogleApp = 0

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Videos >
		#    
		Videos = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< Weather >
		#    
		Weather = 1

		#--< OVERLAYROM.MENU.DEBLOAT.OPTIONS - LIGHTDEBLOATING-USERAPPS >--< YouTube >
		#    
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
#    This will provide you with an addition menu where you can select each build.prop tweak individual
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

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< MMS APN retry timer set to 2 sec >
	#    
	MMSAPNretrytimersetto2sec = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Misc System Tweaks >
	#    
	MiscSystemTweaks = 1

	#--< OVERLAYROM.MENU.BUILD.PROP - BUILD.PROPTWEAKSELECTIONS >--< Kernel Tweaks >
	#    
	KernelTweaks = 1


