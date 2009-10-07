From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: New home for DS1682 driver
Date: Wed, 07 Oct 2009 13:12:39 +0100
Message-ID: <4ACC85B7.2010300@cam.ac.uk>
References: <20091007115017.6941faa7@hyperion.delvare> <20091007095610.GF3177@pengutronix.de> <20091007120734.31a41f33@hyperion.delvare> <20091007102557.GG3177@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091007102557.GG3177-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang wrote:
> On Wed, Oct 07, 2009 at 12:07:34PM +0200, Jean Delvare wrote:
>> On Wed, 7 Oct 2009 11:56:10 +0200, Wolfram Sang wrote:
>>> On Wed, Oct 07, 2009 at 11:50:17AM +0200, Jean Delvare wrote:
>>>> Hi Grant,
>>>>
>>>> Driver ds1682 needs a new home, as drivers/i2c/chips will be gone soon.
>>>> Do you have a preference for where it should go?
>>>>
>>>> As the device includes an EEPROM, the driver could go in
>>>> drivers/misc/eeprom, but OTOH the EEPROM in question is so small that
>>>> this can hardly be considered the main feature of the driver. So maybe
>>>> just drivers/misc?
>>> I would much prefer drivers/misc.
>> OK, fine with me. Will you send a patch?
> 
> Will do if you want one. My idea was to wait for IIO becoming mainline and then
> take care of both.
> 
>> For tsl2550, the plan is indeed to wait for iio to become mainline. Or
>> the alternative ALS subsystem. I hope we won't have to wait too long.
> 
> Good you mentioned ALS; I forgot about it. I am afraid it will still take a
> while for IIO, but moving drivers twice is also ugly :(
> 
ALS is the right place for this one. I've offered to do the port but haven't had
a chance as yet.

These light sensors are two slow to really require most of IIO. When you can get
all data from a chip by polling at a couple hz life becomes somewhat easy!
Also moving the tsl2561 out of iio and into ALS asap. 

Though I'm guessing ALS won't merge until next merge window opens. To my mind
it's clean enough to merge now as a new 'driver' but I'm guessing as a subsystem
this might not get past Linus. I'm not bothered about ditching the iio based
tsl2561 immediately (as far as I know I'm the only user other than on boards
for which I roll out the images anwyay - please yell if not!),
but moving the tsl2550 will probably involve a few userspace api changes
(to conform to what als expects), not to mention a change in location in sysfs.

I've no idea how heavily used this driver is, so what do people reckon we do about
about deprecating and removing the old driver? (the usual 2 kernel release or
can we speed it up to finally get rid of that chips directory!)

Also I fear you are right about IIO. It's now in staging which is getting some eyes
on the code which is very helpful, but there are a couple of big changes that will probably
be needed before moving out of there.  

Thanks,

Jonathan
