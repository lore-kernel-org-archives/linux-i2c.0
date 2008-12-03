From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH][resend] iMX/MXC support for I2C
Date: Wed, 3 Dec 2008 15:19:42 +0000
Message-ID: <20081203151942.GH2556@sirena.org.uk>
References: <gh3f1h$fto$1@ger.gmane.org> <Pine.LNX.4.64.0812030917440.4717@axis700.grange> <gh5vf4$e02$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <gh5vf4$e02$1@ger.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 03, 2008 at 02:52:56PM +0200, Darius wrote:
> Guennadi Liakhovetski wrote:

> >>+	/* write slave address */
> >>+	writeb(msgs->addr, i2c_imx->base + IMX_I2C_I2DR);

> >This is wrong! You have to double the address before writing to the 
> >register.

> strange! there are I2c board data in my MXLADS code:

...

> slave addresses are exactly 0x42 and 0x90 (from datasheets).
> my driver works with these devices with address not doubled.
> I saw this in other I2C drivers, but If I double address in my driver, it 
> works wrong.

Many datasheets quote the I2C address in wire format (ie, after the
doubling, including the read/write bit as LSB) that the hardware is
looking for here.  The Linux I2C framework doesn't do this, it doesn't
include the read/write bit in the address.

> >Making clkfreq a module parameter you force the same frequency on all i2c 
> >busses. On my i.MX31 system 2 busses are internal and one goes to a 
> >connector, to which a camera is connected. This third bus can only handle 
> >a lower frequency, which, however, doesn't mean we also have to throttle 
> >the other two busses. Can we put this into platform data?

> We can do that, but now there is possibility to change bitrate when 
> re-loading module.
> What is better?

Platform data is better but you could also include a default for use
when no platform data is specified and then have a module parameter to
override that.
