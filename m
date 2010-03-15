From: Robert Schwebel <r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: i2c driver for mxc platform
Date: Mon, 15 Mar 2010 20:37:57 +0100
Message-ID: <20100315193757.GC2723@pengutronix.de>
References: <528f13591003151100q29984964n99828cccad075d41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <528f13591003151100q29984964n99828cccad075d41-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alfred steele <alfred.jaquez-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sascha Hauer <sha-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 15, 2010 at 01:00:42PM -0500, alfred steele wrote:
> Looks like there is some discrepancy with the mxc i2c driver.
>
> In this portion of the mxc_i2c_stop()  routine, the MSTA bit is
> cleared(1to 0) to generate a stop condition but there is no  state
> check whatsoever before for the IBB bit (bus busy bit is set or not)
>
> while (retry-- && ((sr & MXC_I2SR_IBB))) {
>         udelay(3);
>         sr = readw(dev->membase + MXC_I2SR);
>
> I am not sure what SCL frequency has been tested with  for the
> "udelay(3)". Is that a sufficient wait on busses set to run on the
> traditional slow rate(bit rate upto 100 kbps?
>
> I am curious.

Setting Wolfram and Sascha to Cc: ...

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
