From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/7] coordinate cht i2c-pmic and i915-punit accesses
Date: Sun,  8 Jan 2017 14:44:20 +0100
Message-ID: <20170108134427.8392-1-hdegoede@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752266AbdAHNod (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 8 Jan 2017 08:44:33 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

Hi All,

Here is a non RFC version of my previous RFC series for coordinating
cht i2c-pmic and i915-punit accesses. New in this non RFC version is
that forcewake accesses are coodinated now too.

The problem:
============

This series fixes an issue where the following messages are shown in dmesg:
[drm:fw_domains_get [i915]] *ERROR* render: timed out waiting for forcewake ack request.
[drm:fw_domains_get [i915]] *MEDIA* render: timed out waiting for forcewake ack request.
i2c_designware 808622C1:06: punit semaphore timed out, resetting
i2c_designware 808622C1:06: PUNIT SEM: 2
i2c_designware 808622C1:06: couldn't acquire bus ownership

Usually followed by a gfx or system freeze, this is happening both on my
cherrytrail tablet as well as being seen by an user commenting on:
https://bugzilla.kernel.org/show_bug.cgi?id=155241

This problem is triggered by my patch series to fix the punit i2c bus
semaphore code in drivers/i2c/busses/designware-baytrail.c :

https://patchwork.ozlabs.org/patch/710067/
https://patchwork.ozlabs.org/patch/710068/
https://patchwork.ozlabs.org/patch/710069/
https://patchwork.ozlabs.org/patch/710070/
https://patchwork.ozlabs.org/patch/710071/
https://patchwork.ozlabs.org/patch/710072/

Which actually allows i2c access to pmic-s wich need bus-access arbritration
for the first time on cherrytrail, combined with patches from me to actually
make the axp288_fuel_gauge driver load, which leads to regular pmic i2c
accesses (when userspace checks the battery level).

The fix / workaround
====================

Testing has shown that just taking the punit i2c bus semaphore on
i2c accesses to a shared pmic i2c bus is not enough to avoid problem,
e.g. besides this series to coordinate i915 access, we also need:
https://patchwork.ozlabs.org/patch/710070/

This series introduces 2 mechanisms to coordinate direct pmic accesses
vs punit requests which lead to pmic accesses. The first mechanism is
a simple mutex, which works well for the direct punit accesses the i915
code does. However testing has shown this is not enough, we also need
to avoid doing a forcewake when a driver is directly accessing the pmic
i2c bus, otherwise we get the timeout errors quoted above, the fact
that after the forcewake errors the designware-baytrail.c code also
fails to acquire the lock, suggests that doing forcewakes during the
access window causes the i2c bus to get stuck (or the punit to get
confused).

The deal with the forcewake issue a notifier is introduced which allows
drivers to get notified before any pmic i2c transfer begins (and after
it ends). This is used in the i915 driver to do a
forcewake_get(FORCEWAKE_ALL) before the access begins avoiding needing to
it while the access is in progress.

Testing has shown that this avoids the problem for both me and the user,
where as before it could be reproduced at will.

The implementation of the fix
=============================

I've decided to put the mutex and the notifier in the iosf_mbi code,
as that is somewhat of a common middle ground between the i915 driver and
the designware-baytrail.c code, with the latter already depending on the
iosf_mbi code. I'm open for moving them if someone has a suggestion for a
better place to put them.

If iosf_mbi support is not enabled then all the functions used will become
static inline NOPs and nothing changes on the i915 side.

If the code is enabled and runs on a system which does not need pmic i2c
bus arbritration, then the mutex lock / unlock calls added to the i915 code
will still be made, but there won't be any contention, so other then the
overhead of the lock / unlock there will not be any delays. These calls are
not made in any hot paths.

The biggest downside IMHO is that taking FORCEWAKE_ALL before each bus
access will cause extra GPU wakeups, and thus powerdrain. I plan to make
the impact of this minimal by modifying any drivers (axp288 code, with
which I'm quite familiar by now) to limit their i2c accesses to a bare
minimum. Specifically I plan to e.g. cache the battery level and wait
at least 15 seconds (max 4 times a minute) before getting a fresh reading
even if userspace asks for it more often, combined with some mechanism
to only do 1 access-begin and 1 access-end notification for i2c accesses
in quick succession.

Alternatives
============

It would be tempting to say that this is not worth the trouble and we
should just disallow direct i2c accesses to the pmic bus. Unfortunately
that will cause some major issues on affected devices:
-No battery monitoring
-No "AC" plugged in monitoring
-If booted with a normal USB-A -> micro-USB cable, or no cable, plugged
 in and then the user replaces the cable with an otg USB-host cable /
 adapter, the id-pin shorting will enable a 5v boost convertor, but we
 need to disable the pmic's USB-Vbus path otherwise it will start drawing
 current from the boost convertor, leading to aprox 300mA of extra
 battery drain, this is done by the axp288_charger driver, which needs
 direct i2c access to the pmic bus

Way forward
===========

I realize the workaround this patch-set adds is not the prettiest code
ever seen, but I see no otherway to get things like battery monitoring
and proper OTG support working on affected devices without breaking
drm/i915 support. So I would like to see this merged in some form, I'm
happy to make any kind of requested changes; and/or to try alternative
fixes.

Regards,

Hans
