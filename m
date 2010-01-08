From: Baurzhan Ismagulov <ibr-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Subject: Re: status of i2c-cpm and ds2482
Date: Fri, 8 Jan 2010 13:17:23 +0100
Message-ID: <20100108121723.GD4004@radix50.net>
References: <20100108020253.GJ3388@radix50.net> <4B471647.8050806@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B471647.8050806-NIgtFMG+Po8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Jochen,

On Fri, Jan 08, 2010 at 12:25:59PM +0100, Jochen Friedrich wrote:
>> There are boot messages about both. Creating /dev/i2c-0 and reading =
from
>> it result in appropriate debug messages. However,
>> /sys/devices/w1_bus_master1 is not created; the path described in
>> http://marc.info/?l=3Dlinux-i2c&m=3D125365009130579&w=3D2 does not e=
xist. What
>> is the fastest way to get the application running on 2.6.27.25?
>
> What does your dts look like? Is the ds2482 present in the dts?

Oh, that's an interesting point. No, it isn't present, only i2c. How di=
d
it work in 2.6.25.7? I'd also appreciate pointers about that, if there
are any.

Currently I'm trying to understand why the new i2c infrastructure
doesn't call ds2482_probe, which creates the w1_bus_master1 directory.
Other ideas also welcome.

Gru=DF,
Baurzhan.
