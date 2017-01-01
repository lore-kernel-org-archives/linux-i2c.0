From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 0/4] Coordinate pmic i2c bus and i915 punit accesses
Date: Sun,  1 Jan 2017 21:13:59 +0100
Message-ID: <20170101201403.12132-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932229AbdAAUOH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 1 Jan 2017 15:14:07 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>

Hi,

So one user is reporting problems with my patches to get the
i2c pmic bus (cherrytrail punit semaphore support) + axp288 fuel_gauge /
charger drivers working in combination with i915:

https://bugzilla.kernel.org/show_bug.cgi?id=155241#c37

"My device is a laptop with no USB charging or OTG. So, I'd tried only SDIO _ADR patch, i2c and axp288_fuel_gauge patches. Everything works well for upto 3 mins after boot, then the device freezes. I hadn't tried any drm patches BTW. Here's the log:

[drm:fw_domains_get [i915]] *ERROR* render: timed out waiting for forcewake ack request.
[drm:fw_domains_get [i915]] *MEDIA* render: timed out waiting for forcewake ack request.
[drm:fw_domains_get [i915]] *ERROR* render: timed out waiting for forcewake ack request.
[drm:fw_domains_get [i915]] *MEDIA* render: timed out waiting for forcewake ack request.
clocksource: timekeeping watchdog on CPU0: Marking clocksource 'tsc' as unstable because the skew is too large:
clocksource:                       'refined-jiffies' wd_now: 10002ee30 wd_last: 10002edb8 mask: ffffffff
clocksource:                       'tsc' cs_now: 16ac2c7744a cs_last: 16a8d9bd8f2 mask: ffffffffffffffff
clocksource: Switched to clocksource refined-jiffies
usb 1-2: reset high-speed USB device number 2 using xhci_hcd
i2c_designware 808622C1:06: punit semaphore timed out, resetting
i2c_designware 808622C1:06: PUNIT SEM: 2
i2c_designware 808622C1:06: couldn't acquire bus ownership
axp288_fuel_gauge axp288_fuel_gauge: axp288 reg read err:-110
axp288_fuel_gauge axp288_fuel_gauge: PWR STAT read failed:-110
usb 1-2: reset high-speed USB device number 2 using xhci_hcd
usb 1-2: reset high-speed USB device number 2 using xhci_hcd
usb 1-2: reset high-speed USB device number 2 using xhci_hcd
i2c_designware 808622C1:06: punit semaphore timed out, resetting
i2c_designware 808622C1:06: PUNIT SEM: 0
i2c_designware 808622C1:06: couldn't acquire bus ownership
axp288_fuel_gauge axp288_fuel_gauge: IIO channel read error: fffffffb, 0
power_supply axp288_fuel_gauge: driver failed to report `voltage_now' property: -5
***SYSTEM FREEZE***

If I blacklist axp288_fuel_gauge, then there were no errors."

This sounds a lot like things go wrong when the i915 driver asks some
changes from the punit while i2c-designware-baytrail is holding the
pmic i2c bus semaphore, just like changing C-states while holding
the semaphore seems to lock up the punit,

So this patch-set is an attempt at fixing that. I'm still waiting for the
reporter to report back if it actually fixes things, in the mean time
any input on this issue (or the proposed fix) is welcome.

Note the i2c-designware-baytrail patch applies on top of v5 of my
i2c-designware series, which I will send out directly after this.

Regards,

Hans
