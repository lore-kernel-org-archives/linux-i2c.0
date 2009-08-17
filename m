From: Robert Schwebel <r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: "I2C_RDWR" ioctl returning EINVAL on Freescale mxc
Date: Mon, 17 Aug 2009 17:01:59 +0200
Message-ID: <20090817150159.GT31727@pengutronix.de>
References: <528f13590908141409g4b2556e5m10aec0dc15429457@mail.gmail.com> <20090817065313.GJ31727@pengutronix.de> <528f13590908170751u4dcf6d8ftb865103b888225e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <528f13590908170751u4dcf6d8ftb865103b888225e0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Alfred,

On Mon, Aug 17, 2009 at 09:51:11AM -0500, alfred steele wrote:
> > - which kernel version is that
> > - which i.MX derivate are you using?
>
> 2.6.24 , I am using mx31.

I assume you are using Freescale's patches ontop of 2.6.24.

Could you try the latest mxc-master from here:
http://git.pengutronix.de/?p=imx/linux-2.6.git

The i2c driver has seen a lot of modification recently.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
