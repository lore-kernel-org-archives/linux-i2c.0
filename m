From: Baurzhan Ismagulov <ibr-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Subject: Re: status of i2c-cpm and ds2482
Date: Fri, 8 Jan 2010 15:01:11 +0100
Message-ID: <20100108140111.GF4004@radix50.net>
References: <20100108020253.GJ3388@radix50.net> <4B471647.8050806@scram.de> <20100108121723.GD4004@radix50.net> <20100108135222.49d7b834@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100108135222.49d7b834-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Jean,

On Fri, Jan 08, 2010 at 01:52:22PM +0100, Jean Delvare wrote:
> You probably want to take a look at these 2 patches of mine which were
> applied to the ds2482 driver:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=61c91f7ded640bb2b340cc89d9ca3a3ca0229c74
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=0314b020c49c1d6cd182d2b89775bfa6686660db

Yes, I studied them yesterday in detail :) . The docs in i2c are also
useful to get the big picture, thank you. That said, I'm currently stuck
how to make the infrastructure probe ds2482.


> Before 2.6.27, the ds2482 driver was a so-called "legacy i2c driver"
> probing buses randomly in search of supported chips. Since 2.6.27 is is
> a so-called "new-style i2c driver" which only attaches to the devices
> when told to. So what you observe is the expected behavior. It is much
> safer that way.

Yes, this is clear from your docs.


> For an overview of how an I2C device can be declared, see:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/i2c/instantiating-devices

As I wrote yesterday, I did try Method 4. However,
/sys/bus/i2c/devices/i2c-0 doesn't exist.

There is also ds2482_detect in ds2482.c of 2.6.27.25 (Method 3); still
cannot see /sys/devices/w1_bus_master1.

What is the problem there? Should I update some infrastructure files
from 2.6 git? For now, I can't use newer kernels since they either hang
or run very slowly ("time id" taking real 32s) on my board.


> One method not described in this document is listing the device in a
> dts. It should probably be added, unfortunately I don't know enough
> about this myself to do it. Any volunteer?

I would gladly contribute that as soon as I learn how to do that :) .


Thanks in advance,
Baurzhan.
