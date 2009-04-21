From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Tue, 21 Apr 2009 13:26:02 +0200
Message-ID: <49EDAD4A.4070200@grandegger.com>
References: <49ED6AD3.2060808@gmx.de>	<49ED6F03.5050107@grandegger.com>	<49ED9132.9050806@gmx.de>	<49EDA185.7040206@grandegger.com> <20090421130134.1e82a078@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090421130134.1e82a078-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Sang, Wolfram" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-discuss <devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> On Tue, 21 Apr 2009 12:35:49 +0200, Wolfgang Grandegger wrote:
>> Michael Lawnick wrote:
>>> Wolfgang Grandegger said the following:
>>>> Do we really need that? Probing is dangerous and not necessary. Does it
>>>> not work with a proper DTS entry? But maybe I have missed something?
>>> Our current and our next system consists of two flavors of the same
>>> board with different devices. To minimize maintenance and testing we use
>>> a reduced kernel and load the needed modules at runtime. Furthermore we
>>> will have to handle hot-plugged I2C-devices. Whether this strategy is
>>> best could be discussed in another thread but is rather OT in this
>>> mailing list. Nevertheless loading modules at runtime is legal and
>>> generally supported by LINUX.
>>>
>>> Defining all possible (I2C-)devices in DTS would give a mess. E.g. on
>>> one board there will be ~30 temperature sensors, on the other none.
>> The legacy device probing has it's limitations and I doubt that it will
>> be able to find 30 DTT devices properly. E.g. the legacy probing
>> algorithm is not able to distinguish between a LM75 and DS75. Let's
>> first try to find out why it does not work as expected with the DTS entry.
>>
>>> As every DTS entry will force a sysFs subdirectory there would be a
>>> bunch of functionless directories - rather ugly.
>> Hopefully not. They will be created when the probing was successful, I
>> assume.
> 
> No, device creation is unconditional. It is assumed that the DTS file
> author knew what he/she was doing.
> 
> There was a discussion about adding a flag to state the "may not be
> present" nature of devices, which would result in a probe before
> instantiating the device (on success), but it wasn't implemented yet. I
> have no objection is this mechanism is deemed useful.

Ah, I see. If the software can reliably find out if a device exists it
should probe for it. It would be useful to limit the amount of required
DTS files for the hardware variants. Often the RTC or other I2C devices
are optional. I added the Deviceterr-disccuss ML to the CC to reach the
the device-tree gurus.

Wolfgang.
