From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Wed, 20 May 2009 08:28:20 +0200
Message-ID: <20090520082820.42c6a0ee@hyperion.delvare>
References: <49ED6AD3.2060808@gmx.de>
	<49ED6F03.5050107@grandegger.com>
	<49ED9132.9050806@gmx.de>
	<20090421095112.GB3100@pengutronix.de>
	<49EDC487.8010201@gmx.de>
	<20090424085256.GA26169@pengutronix.de>
	<49F19A11.3090700@gmx.de>
	<9e4733910904240838k5f425d7m849cd6b7fad19f27@mail.gmail.com>
	<20090427121758.7965c48a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090427121758.7965c48a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 27 Apr 2009 12:17:58 +0200, Jean Delvare wrote:
> On Fri, 24 Apr 2009 11:38:04 -0400, Jon Smirl wrote:
> > Jean, is it still possible to instantiate i2c devices from the module
> > command line?
> 
> It is still possible if the driver implements the .detect() callback
> (even without any address being probed by default) and uses one of the
> I2C_CLIENT_INSMOD* macros. However, these macros are planned for
> removal. Their replacement is the sysfs entries I have been discussing
> with Michael in the past few weeks and for which he sent a patch for me
> to review. This is still on my todo list, but I am very busy these
> days :(

For the record, it finally happened. I posted a patch doing this on
the linux-i2c list on May 4th, which can be temporarily seen at:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-sysfs-interface-to-instantiate-devices.patch

It will be merged in 2.6.31. Potential users are invited to give it a
try and comment by then. Hopefully we can then deprecate the ugly
I2C_CLIENT_INSMOD* macros, and get rid of them 2 kernels later.

Thanks,
-- 
Jean Delvare
