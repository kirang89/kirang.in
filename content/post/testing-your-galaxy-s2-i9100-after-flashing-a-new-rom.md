---
title: "Testing your Galaxy S2 i9100 after flashing a new ROM"
date: 2014-02-23T19:22:00+05:30
author: "Kiran Gangadharan"
categories: ["android"]
tags: ["android", "cyanogenmod", "samsung galaxy s2"]
slug: testing-your-galaxy-s2-i9100-after-flashing-a-new-rom
---

After a bit of boredom and a morbid desire to play with KitKat ROM's for
my Galaxy S2, here I was, pulling through the day without realising how
much time I poured into getting the latest Cyanogenmod 11 nightly
working on my phone. It took patience, some restarts, some flashings,
some more restarts, and a plethora of network bandwith wastefulness, to
finally get my phone setup with everything that I needed.<!--more-->

So in such kind of a situation, it is important to first test your phone
with the new OS before going ahead and restoring/downloading all your
apps. In this post, I've mentioned a few apps and tweaks that you can
use to measure out the performance and battery life of your newly
flashed device. I would recommend  to have these apps stored offline in
your SD card perhaps, so that you can test out everything without
needing to connect to the internet.

**Essential Apps**

-   [Better Battery
    Stats](https://play.google.com/store/apps/details?id=com.asksven.betterbatterystats&hl=en)
-   [CPU
    Spy](https://play.google.com/store/apps/details?id=com.bvalosek.cpuspy&hl=en)
-   [Root
    Explorer](https://play.google.com/store/apps/details?id=com.speedsoftware.rootexplorer&hl=en)
-   [RootAppDelete](https://play.google.com/store/apps/details?id=zsj.android.uninstall&hl=en)
-   [Titanium
    Backup](https://play.google.com/store/apps/details?id=com.keramidas.TitaniumBackup&hl=en)
-   [SetCPU](https://play.google.com/store/apps/details?id=com.mhuang.overclocking&hl=en)

*Once you have the apps installed, monitor your phone for a while to
check if there are any abnormal apps hogging your CPU or Battery. *

Once the device seems to be doing well, you can now try and tweak to get
more out of your device. Start with the following:

1.  First open *Settings \> About Phone* and tap the Build number field
    approx 7 times until you get the notification about the developer
    settings being activated. Now when you head back to Settings, you
    should see both *Developer options* and *Performance* under System.
2.  Open *Performance \> Processor,* set CPU governor to ONDEMAND and
    check the Set on Boot option.
3.  Open *Performance \> I/O Scheduler* and set it to CFQ or Noop and
    once again check the Boot option.
4.  Open *Performance \> Memory Management* and check the purging assets
    option.
5.  Under Developer Options, set the Window and Transition animation and
    Animator duration scale to `0.5x`.

The above should give you a little more performance and juice. For
adding the icing to the cake, do the following tweak as well: Using the
Root Explorer, head to the android home directory (**/) **and look for a
file called `build.prop`. Select the file and choose to open it in a
text editor. Now, append the following settings to it:

```
ro.telephony.call_ring.delay=0 
pm.sleep_mode=1 
persist.sys.purgeable_assets=1 
ro.media.enc.jpeg.quality=100 
wifi.supplicant_scan_interval=180
ro.lge.proximity.delay=25
mot.proximity.delay=25
debug.sf.nobootanimation=1
windowsmgr.max_events_per_sec=300
ro.max.fling_velocity=12000
ro.min.fling_velocity=8000
dalvik.vm.startheapsize=8M
video.accelerate.hw=1
```

If you're interested to know about these options and what they do,
simply google *"build.prop tweaks galaxy s2"* and you should be able to
find all of these settings and more, with their explanations.

Well, that's all I did, and my phone seems to be pretty smooth with
decent battery life. Now to take a break and enjoy the KitKat ;)
