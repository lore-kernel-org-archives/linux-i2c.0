From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-gpio: fix some of gpio sleep issues
Date: Wed, 22 Apr 2015 11:05:02 +0200
Message-ID: <20150422090502.GD23758@pengutronix.de>
References: <1426593869-8724-1-git-send-email-ben.dooks@codethink.co.uk>
 <20150327154609.GD27238@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150327154609.GD27238@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 27, 2015 at 04:46:09PM +0100, Wolfram Sang wrote:
> On Tue, Mar 17, 2015 at 12:04:29PM +0000, Ben Dooks wrote:
> > The i2c-gpio driver can be used in systems where the GPIO itself is
> > provided by a GPIO driver that may be sleeping (for example, SPI or
> > USB). In this case, it is preferable to use the _cansleep() variant=
s
> > of the GPIO code.
> >=20
> > We can only fix this up for the case where the i2c-gpio implementat=
ion
> > provides open-drain outputs as there are no gpio_direction_xxx_cans=
leep()
> > provided.
> >=20
> > This removes the issues on the customer system with the console con=
stantly
> > showing the following warning:
> >=20
> > WARNING: CPU: 0 PID: 1 at drivers/gpio/gpiolib.c:2389 gpiod_set_raw=
_value
>=20
> ??? It will silence a warning but will totally break the timing in ca=
se
> sleeping is needed? I'd think the warning is very suitable.
I don't understand this objection. What do you mean by "timing"? A
sleeping gpio is probably slower, but this shouldn't affect correctness
of the protocol implementation, should it?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
