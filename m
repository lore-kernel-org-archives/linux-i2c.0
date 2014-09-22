From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: axxia: Add I2C driver for AXM55xx
Date: Mon, 22 Sep 2014 15:16:40 +0200
Message-ID: <20140922131640.GU3755@pengutronix.de>
References: <1408967482-17723-1-git-send-email-anders.berg@avagotech.com>
 <20140920121242.GA3833@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140920121242.GA3833@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Sep 20, 2014 at 02:12:43PM +0200, Wolfram Sang wrote:
> Hi,
>=20
> thanks for the submission.
>=20
> On Mon, Aug 25, 2014 at 01:51:22PM +0200, Anders Berg wrote:
> > Add I2C bus driver for the controller found in the LSI Axxia family=
 SoCs. The
> > driver implements 10-bit addressing and SMBus transfer modes via em=
ulation
> > (including SMBus block data read).
> >=20
> > Signed-off-by: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>
>=20
> Looks pretty good already. Still, some comments:
>=20
> > +config I2C_AXXIA
> > +	tristate "Axxia I2C controller"
> > +	depends on ARCH_AXXIA
> > +	help
> > +	  Say yes if you want to support the I2C bus on Axxia platforms.
> > +
> > +	  If you don't know, say Y.
>=20
> I'd say skip this sentence and consider 'default y' if it is really
> needed on this platform.
Still better:

	depends on ARCH_AXXIA || COMPILE_TEST
	default ARCH_AXXIA

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
