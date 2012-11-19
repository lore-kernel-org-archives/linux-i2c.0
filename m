From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: mxs: Do not disable the I2C SMBus quick mode
Date: Mon, 19 Nov 2012 19:13:20 +0100
Message-ID: <201211191913.20938.marex@denx.de>
References: <1353216308-7338-1-git-send-email-marex@denx.de> <201211191619.59877.marex@denx.de> <CANqk_c92YYzCKjT7ehfXpmGhJC8p0BDSNoW3vC71J9q89=XUaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANqk_c92YYzCKjT7ehfXpmGhJC8p0BDSNoW3vC71J9q89=XUaQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Tim Michals,

[...]

> > ~ # /i2cdetect.static -r 0 20 30
> > WARNING! This program can confuse your I2C bus, cause data loss and
> > worse! I will probe file /dev/i2c-0 using read byte commands.
> > I will probe address range 0x14-0x1e.
> > Continue? [Y/n]
> > 
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 
> > 00:
> > 10:             -- -- -- -- -- -- -- -- -- -- --
> > 20:
> > 30:
> > 40:
> > 50:
> > 60:
> > 70:
> > 
> > Best regards,
> > Marek Vasut
> 
> I'm using a imx233, I don't know what would be different or cause this
> issue.

The register layout differs. You might want to check if all the register 
programing is correct. Make sure the placement of various bits is correct. Also 
see how the DMA operates with the transfer length on MX23 and MX28 ... there are 
quite a few differences and I didn't test the driver on MX23 like that. I recall 
someone testing it on a different MX23 board but only by some "standard" usage.
