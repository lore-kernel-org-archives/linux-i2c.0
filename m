From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: Re: [PATCH 1/2] Create eeprom_dev hardware class for EEPROM devices
Date: Wed, 22 Jan 2014 11:32:24 -0800
Message-ID: <52E01CC8.4020709@amacapital.net>
References: <1390412855-2927-1-git-send-email-curt@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390412855-2927-1-git-send-email-curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Curt Brune <curt-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 01/22/2014 09:47 AM, Curt Brune wrote:
> Create a new hardware class under /sys/class/eeprom_dev
> 
> EEPROM drivers can register their devices with the eeprom_dev class
> during instantiation.
> 
> The registered devices show up as:
> 
>   /sys/class/eeprom_dev/eeprom0
>   /sys/class/eeprom_dev/eeprom1
>   ...
>   /sys/class/eeprom_dev/eeprom[N]
> 
> Each member of the eeprom class exports a sysfs file called "label",
> containing the label property from the corresponding device tree node.
> 
> Example:
> 
>   /sys/class/eeprom_dev/eeprom0/label
> 
> If the device tree node property "label" does not exist the value
> "unknown" is used.
> 
> Userspace can use the label to identify what the EEPROM is for.

I will be using the at24 driver (most likely -- the SPD protocol is so
simple that it may be easier to use the raw SMBUS API) to talk to
NV-DIMMs.  For this purpose, I really need to know that a given EEPROM
is the EEPROM attached to a particular DIMM.  I wrote some code (search
for "DIMM bus", in limbo) that kind of solves this problem, but it's not
pretty.

In general, I suspect this will have the issue that EDID, SPD, etc.
eeprom devices will get all confused.

Ideally there would be a way to express the logical topology.  In the
case of NV-DIMMs there's a DIMM.  That DIMM exposes some memory (which
isn't really part of the driver model), some temperature sensors, an
SPD, and some other stuff.  The DIMM as a whole lives in a DIMM slot.

Unfortunately, the kernel has no real awareness of what's going on.  The
arch code just sees it as memory (without really associating it with a
DIMM) and the EDAC driver and things like dmidecode do their own thing.

The same issue shows up when sensors-detect offers to scan all the i2c
busses on the ports on my graphics card for things like motherboard
voltage sensors.

Unfortunately, I don't think that using a device tree label really helps
here, especially because none of the machines I care about use (or are
likely to ever use) device trees.


--Andy
