From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: i2c-mxs: Problems with PIO mode on iMX28
Date: Fri, 28 Jun 2013 11:13:33 +0200
Message-ID: <20130628091332.GA2948@katana>
References: <19340213.PSZe5UysTs@linux-1fbo.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19340213.PSZe5UysTs-BVXpyJtzy6LO1Ldfs0Uenw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


CCing Marek Vasut and Pengutronix...

On Thu, Jun 27, 2013 at 07:39:45PM +0200, Torsten Fleischer wrote:
> Hi,
>=20
> on my board there is a temperature sensor TCN75A (compatible to LM75)=20
> connected to the iMX283.
> In the user space the temperature is periodically polled by reading the f=
ile=20
> /sys/bus/i2c/devices/0-0048/temp1_input.
> When triggering this file the LM75 driver consecutively reads 3 registers=
 from=20
> the sensor and outputs the current temperature read from register 0.
>=20
> With linux 3.9.7 I sometimes get a communication timeout when reading the=
=20
> sensor.
>=20
> Since several patches have been added to the driver, I tried linux 3.10-r=
c7.=20
> With this version no timeout will be reported, but sometimes the value=20
> returned seems to be wrong. Normally I get a value of round about 30000. =
But=20
> sometimes it takes some seconds to read the temperature and the returned =
value=20
> is 75000. This value is not the current temperature but the temperature=
=20
> hysteresis that is the content of register 2 of the sensor.=20
>=20
> After some investigation I found that the i2c-mxs driver sometimes times =
out=20
> while waiting for the MXS_I2C_DEBUG0_DMAREQ bit when writing data (the=20
> I2C_M_RD flag is not set).
> Unfortunately this error is never reported to the I2C core and thus to th=
e=20
> LM75 driver. So the LM75 driver assumes that it has received the correct=
=20
> values.
>=20
> This problem seems to be only in the PIO mode. After changing the driver =
so=20
> that the DMA is always used it works as expected.
>=20
> Best regards,
> Torsten Fleischer
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRzVO8AAoJEBQN5MwUoCm2hzEP/RxRvAjrfEKsBr7emTgG6sNw
8VtDDO1NaOVfv/QlIaCD69kDEWaoYFTMD6IS8EqkYDOFUBlFlme2z8kBK5FZQD+o
BVOCpwD3GMecXd6Yd53yY8XaRHw4yumIEMrVhSezWBAeLzU+o8QeMxFrlR22Yb5t
/hpdobmv5OsbJYnv1xkWm30+Lxw/YRjR3E3OmSE/n6X74qfomnUM1njyHqHv+o/D
kRODBcMJ6ev+jCSKzaeWu7D8ECKbJvNKuc574LRTcVjG/MTfYlN11jN3OWQAhsn6
DOG0HPmBCxoMeeEXxLf1DKI1EjTvZvVgSyVkS0xniVmwT0GKE/4NTD6PT6OXa/UJ
KBQTrsuD0YW/qUxY6p4C59BI+iQSJ76vH1wVeWX23jiAvyte0Xdx/3b1+15ne9x/
ISn5JC3f3Gk4zQ+Oki0dkcZ0DiiDPewHUgkuRByXRdoaQ8c+A3AnR+0fqhIrXrj6
NLvVD5XIA8lufxMZKAVAxHhzNqT5wxwpwP5pBxIYDRitotn3r1EynCfiEsdNH1ge
1+G7nGqIHKlA8vRfZaQPyn3Z9J7uMvMMkO09DKnIC+0c2Qjm9GENZHXBurY/tuQy
mg6INXLmenNRcQCr0+qSLBRYnzc/QAHU5gRBAcKKXQO+VhLtbMWiHL5DarNiKE4M
fqr6lcTLXpe1ZMdyWqg+
=k74w
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
