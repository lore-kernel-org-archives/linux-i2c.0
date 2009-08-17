From: Robert Schwebel <r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: "I2C_RDWR" ioctl returning EINVAL on Freescale mxc
Date: Mon, 17 Aug 2009 23:21:27 +0200
Message-ID: <20090817212127.GB31727@pengutronix.de>
References: <528f13590908141409g4b2556e5m10aec0dc15429457@mail.gmail.com> <20090817065313.GJ31727@pengutronix.de> <528f13590908170751u4dcf6d8ftb865103b888225e0@mail.gmail.com> <20090817150159.GT31727@pengutronix.de> <528f13590908171404q2aa4f9aaub98a191c91bd2448@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <528f13590908171404q2aa4f9aaub98a191c91bd2448-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Robert Schwebel <r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 17, 2009 at 04:04:00PM -0500, alfred steele wrote:
> > Could you try the latest mxc-master from here:
> > http://git.pengutronix.de/?p=imx/linux-2.6.git
>
> I do not see any mx31/mxc specific i2c bus driver in the snapshot. Can
> you point where its is?

drivers/i2c/busses/i2c-imx.{c,ko}

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
