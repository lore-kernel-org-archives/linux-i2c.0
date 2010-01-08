From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: status of i2c-cpm and ds2482
Date: Fri, 8 Jan 2010 18:54:10 +0100
Message-ID: <20100108185410.5f916ef3@hyperion.delvare>
References: <20100108020253.GJ3388@radix50.net>
	<4B471647.8050806@scram.de>
	<20100108121723.GD4004@radix50.net>
	<20100108135222.49d7b834@hyperion.delvare>
	<20100108140111.GF4004@radix50.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100108140111.GF4004-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baurzhan Ismagulov <ibr-Y2X99Y6vBNTR7s880joybQ@public.gmane.org>
Cc: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 8 Jan 2010 15:01:11 +0100, Baurzhan Ismagulov wrote:
> On Fri, Jan 08, 2010 at 01:52:22PM +0100, Jean Delvare wrote:
> > For an overview of how an I2C device can be declared, see:
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/i2c/instantiating-devices
> 
> As I wrote yesterday, I did try Method 4. However,
> /sys/bus/i2c/devices/i2c-0 doesn't exist.

/sys/bus/i2c/devices/i2c-* is new in kernel 2.6.32. For older kernels,
look in /sys/class/i2c-adapter. That being said, method 4 is new in
kernel 2.6.31 anyway, so it isn't what you want.

> There is also ds2482_detect in ds2482.c of 2.6.27.25 (Method 3); still
> cannot see /sys/devices/w1_bus_master1.

As I recall, this isn't a real detect function, because the list of
addresses to probe by default is empty. For the detect function to be
called, you must provide extra module parameters (e.g. probe or force).

> What is the problem there? Should I update some infrastructure files
> from 2.6 git? For now, I can't use newer kernels since they either hang
> or run very slowly ("time id" taking real 32s) on my board.

You don't have to update anything, other than your dts file. Until your
dts file lists the ds2482 device, you must load the ds2482 driver with
the right parameter.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
