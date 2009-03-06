From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Fri, 06 Mar 2009 18:09:38 +0000
Message-ID: <49B166E2.5060909@cam.ac.uk>
References: <20090225212119.67402391@hyperion.delvare>	<1235606248-13004-1-git-send-email-daniel@caiaq.de>	<20090226094857.50d0710d@hyperion.delvare>	<20090306160042.GA17800@buzzloop.caiaq.de> <20090306182432.338b0244@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090306182432.338b0244-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> Hi Daniel,
> 
> On Fri, 6 Mar 2009 17:00:42 +0100, Daniel Mack wrote:
>> On Thu, Feb 26, 2009 at 09:48:57AM +0100, Jean Delvare wrote:
>>> On Thu, 26 Feb 2009 00:57:28 +0100, Daniel Mack wrote:
>>>> This patch adds a driver for Intersil's ISL29003 ambient light sensor
>>>> device plus some documentation. Inspired by tsl2550.c, a driver for a
>>>> similar device.
>>>>
>>>> Signed-off-by: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
>>>> ---
>>>> Moved the driver to drivers/hwmon
>>>>
>>>>  Documentation/hwmon/isl29003 |   62 +++++
>>>>  drivers/hwmon/Kconfig        |   10 +
>>>>  drivers/hwmon/Makefile       |    1 +
>>>>  drivers/hwmon/isl29003.c     |  517 ++++++++++++++++++++++++++++++++++++++++++
>>>>  4 files changed, 590 insertions(+), 0 deletions(-)
>>>>  create mode 100644 Documentation/hwmon/isl29003
>>>>  create mode 100644 drivers/hwmon/isl29003.c
>>> Still no luck, sorry. Light sensors have nothing to do with hardware
>>> monitoring.
>> Sorry to annoy you again with that topic, but I'm a little stuck here.
>> The 'industrial I/O' thread I was pointed to seems to be orphaned and I
>> didn't get much response on the LKML about alternatives either.
> 
> Sorry for the long silence, I have been pretty busy these last days,
> and was also hopping for a comment from Jonathan. The industrial I/O
> subsystem isn't orphaned, I am fairly certain it will be merged some
> day, but it could take some time.
Sorry, I missed this thread entirely until just now.

Jean is indeed correct that things have gotten a little delayed.  The
principal problem has been lack of interested users / testers / driver
developers.
Basically not enough people had relevant hardware.  Things are improving
so hopefully we can make some progress on this soon.  In the meantime
I've mostly just been fixing bugs my local users have been submitting
rather than doing any major new development.

I have a similar light sensor driver which I'll admit I've not widely
distributed at yet (it's in one of my git trees, imote2-linux, but under
the soon to disappear i2c-chips oops) This one has been out of mainline
for a while. It's for the tsl2561.

> 
>> As hwmon still appears the best existing place for such a driver to live
>> in, could we just take it and move it somewhere else as soon somebody
>> comes along with some better idea? I'd just like to avoid it being lost,
>> and every other approach does not feel very productive currently.
> 
> I agree that it doesn't make sense to wait for the industrial I/O
> subsystem to be merged. But I also do not want to put in drivers/hwmon
> drivers which do not really belong there. So I'd either go the way you
> proposed already (drivers/sensors for non-hwmon sensor drivers) or
> simply put your driver in drivers/misc if this is only meant as a
> temporary home until the industrial I/O subsystem is merged.
Jean's suggestion of drivers/misc may make sense in the short term or
I'm happy to do the minor bit of porting needed to merge this (and my tsl
driver) into the industrial i/o tree (held on kernel.org) to ensure it
doesn't disappear into the ether!

---
Jonathan Cameron
