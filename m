From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: question about drivers/i2c/busses/i2c-davinci.c
Date: Thu, 24 Jan 2013 13:36:15 +0100
Message-ID: <20130124123615.GG12933@pengutronix.de>
References: <alpine.DEB.2.02.1301062057260.2029@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1301062057260.2029-bi+AKbBUZKagILUCTcTcHdKyNwTtLsGr@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 06, 2013 at 09:00:59PM +0100, Julia Lawall wrote:
> The function davinci_i2c_remove in drivers/i2c/busses/i2c-davinci.c
> contains the following code:
>=20
>         put_device(&pdev->dev);
>=20
>         clk_disable_unprepare(dev->clk);
>         clk_put(dev->clk);
>         dev->clk =3D NULL;
>=20
>         davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, 0);
> 	free_irq(dev->irq, dev);
>=20
> Is there any danger in putting free_irq(dev->irq, dev); after
> put_device(&pdev->dev);, because the interrupt handler
> i2c_davinci_isr can eg refer to dev->dev.

Not having a clock doesn't sound exactly thrilling either when servicing
an interrupt. I've seen something like this in the remove path of
another driver today as well. I assume a lot of drivers might have such
issues. It is also one of the subtle issues with devm_request_irq. The
remove path can already render the ISR unusable/oopsable but devm will
free the interrupt only after remove has finished. Interrupts need to be
properly masked out before.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlEBKr8ACgkQD27XaX1/VRth+QCgxvSuaCWBWBWEzWAOXdyZXI8d
VkIAn0YlJWCOCQvrVJThR/16q0+A6B8z
=yvUF
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
