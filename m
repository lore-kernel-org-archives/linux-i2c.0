From: Benjamin Tissoires <btissoir@redhat.com>
Subject: Re: [PATCH v2 00/16] intel-lpss: support non-ACPI platforms
Date: Mon, 11 Jan 2016 17:47:52 +0100
Message-ID: <20160111164752.GA19287@mail.corp.redhat.com>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1855560.2DW9QAnCKL@vostro.rjw.lan>
 <568D3EA5.7040207@redhat.com>
 <6535017.eZvpZdlbGL@vostro.rjw.lan>
 <568FECF8.8070507@redhat.com>
 <56900C67.7050700@redhat.com>
 <5693D945.1050409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5693D945.1050409@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On Jan 11 2016 or thereabouts, Laura Abbott wrote:
> On 01/08/2016 11:22 AM, Hans de Goede wrote:
> >Hi,
> >
> >On 08-01-16 18:08, Laura Abbott wrote:
> >>On 01/07/2016 04:03 PM, Rafael J. Wysocki wrote:
> >>>On Wednesday, January 06, 2016 08:19:49 AM Laura Abbott wrote:
> >>>>On 01/05/2016 03:59 PM, Rafael J. Wysocki wrote:
> >>>>>On Tuesday, January 05, 2016 09:57:35 AM Laura Abbott wrote:
> >>>>>>On 12/06/2015 05:44 PM, Rafael J. Wysocki wrote:
> >>>>>>>On Monday, November 30, 2015 05:11:28 PM Andy Shevchenko wrote:
> >>>>>>>>This series includes few logical sets that bring a support of non-ACPI
> >>>>>>>>platforms for Intel Skylake.
> >>>>>>>>
> >>>>>>>>First part is a refactoring of built-in device properties support:
> >>>>>>>>- keep single value inside the structure
> >>>>>>>>- provide helper macros to define built-in properties
> >>>>>>>>- fall back to secondary fwnode if primary has no asked property
> >>>>>>>>
> >>>>>>>>Second is a propagating built-in device properties in platform core.
> >>>>>>>>
> >>>>>>>>Third one is modifications to MFD code and intel-lpss.c driver in particular
> >>>>>>>>to define and pass built-in properties to the individual drivers.
> >>>>>>>>
> >>>>>>>>And last part is a fix for I2C bug found on Lenovo Yoga hardware and a first
> >>>>>>>>converted user.
> >>>>>>>>
> >>>>>>>>Built-in device properties is an alternative to platform data. It provides a
> >>>>>>>>unified API that drivers can use to cover all cases at once: DT, ACPI, and
> >>>>>>>>built-in properties.
> >>>>>>>>
> >>>>>>>>With this series applied a platform data can be considered obsolete. Moreover,
> >>>>>>>>built-in device properties allow to adjust the existing configuration, for
> >>>>>>>>example, in cases when ACPI values are wrong on some platforms.
> >>>>>>>>
> >>>>>>>>The series has been tested on available hardware and doesn't break current
> >>>>>>>>behaviour. But we ask people who have the affected hardware to apply the series
> >>>>>>>>on your side and check with Lenovo hardware.
> >>>>>>>>
> >>>>>>>>Changelog v2:
> >>>>>>>>- fix isuues found by kbuild bot (kbuild)
> >>>>>>>>- append a patch to propagate device properties in polatform code (Arnd)
> >>>>>>>>- update few existing and add couple of new patches due to above
> >>>>>>>>- check with kmemleak
> >>>>>>>>
> >>>>>>>>Andy Shevchenko (9):
> >>>>>>>>     device property: always check for fwnode type
> >>>>>>>>     device property: rename helper functions
> >>>>>>>>     device property: refactor built-in properties support
> >>>>>>>>     device property: keep single value inplace
> >>>>>>>>     device property: improve readability of macros
> >>>>>>>>     device property: return -EINVAL when property isn't found in ACPI
> >>>>>>>>     device property: Fallback to secondary fwnode if primary misses the
> >>>>>>>>       property
> >>>>>>>>     mfd: core: propagate device properties to sub devices drivers
> >>>>>>>>     mfd: intel-lpss: Pass HSUART configuration via properties
> >>>>>>>>
> >>>>>>>>Heikki Krogerus (1):
> >>>>>>>>     device property: helper macros for property entry creation
> >>>>>>>>
> >>>>>>>>Mika Westerberg (6):
> >>>>>>>>     device property: Take a copy of the property set
> >>>>>>>>     driver core: platform: Add support for built-in device properties
> >>>>>>>>     driver core: Do not overwrite secondary fwnode with NULL if it is set
> >>>>>>>>     mfd: intel-lpss: Add support for passing device properties
> >>>>>>>>     mfd: intel-lpss: Pass SDA hold time to I2C host controller driver
> >>>>>>>>     i2c: designware: Convert to use unified device property API
> >>>>>>>
> >>>>>>>I'm going to queue up this series for v4.5.
> >>>>>>>
> >>>>>>>If there are any problems with it or objections from anyone, please let me know.
> >>>>>>>
> >>>>>>
> >>>>>>
> >>>>>>Raising an old thread, I pulled this series into Fedora rawhide and
> >>>>>>while it worked for Lenovo Yoga we received a report that it caused
> >>>>>>a regression on the Dell Inspiron 7559 (see
> >>>>>>https://bugzilla.redhat.com/show_bug.cgi?id=1275718#c27) . I haven't
> >>>>>>asked the reporter about bisecting to see which patch broke it.
> >>>>>>Were there any known follow up patches?
> >>>>>
> >>>>>There were a few.
> >>>>>
> >>>>>All of them are in my linux-next branch if you can try this one.
> >>>>>
> >>>>>Alternatively, I can expose a branch with these to you to test.
> >>>>>
> >>>>
> >>>>I picked up all the patches from the device-properties merge but the
> >>>>problem still shows up. Are there others I should pick up? Hardware
> >>>>details about the touchpad are at https://bugzilla.redhat.com/show_bug.cgi?id=1275718#c34
> >>>
> >>>Well, in that case can you please ask the reporter to bisect?
> >>>
> >>>Rafael
> >>>
> >>
> >>I'll see if I can help the reporter bisect although it looks like Hans
> >>has an idea about what might be failing.
> >
> >Nope, sorry if I left the impression that I have an idea where things are failing.
> >
> >Benjamin Tissoires latest reply in this thread (or was it in bugzilla ?) however
> >seems to point in the right direction, as with this patch-set the i2c controller
> >on the laptop in question starts working (as intended by this patch-set) and then
> >i2c-hid tries to talk to the touchpad, but fails too. However it gets far enough
> >for the touchpad to drop of the ps/2 bus.
> >
> >So what seems to be happening is that this is a dual protocol / bus (ps2 / i2c)
> >touchpad (not that uncommon actually) and now that we've the i2c bus working due
> >to this patchset, we start talking i2c to the touchpad, kicking it from ps2 mode
> >to i2c mode, but our i2c driver then fails to work properly with the touchpad
> >leaving it non functional.
> >
> >Regards,
> >
> >Hans
> 
> Thanks for clarifying. I'm going to see if I can help the reporter bisect.
> It may take a few days.
> 

Hi,

as Hans said, I am pretty sure that the regression is in fact a
different bug in hid-multitouch or in i2c-hid which will not be shown in
the bisect. Before those patches, we were not able to make his
i2c controller working, and the magic within his touchpad made it work
through ps/2. Starting from this commit, the i2c controller now works,
which switches the touchpad in the i2c (enhanced) mode.
It is unfortunate that his touchpad doesn't work over i2c, but a bisect
should not give any information more than this patch series switches his
touchpad from ps/2 to i2c.

To sum up, I'll handle the i2c not working bug when he opened the new
bug, and there should be no need for a bisect (unless there are other
issues besides his touchpad not working).

Cheers,
Benjamin
