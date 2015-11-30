From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/9] i2c: brcmstb: add missing parenthesis
Date: Mon, 30 Nov 2015 16:36:04 +0100
Message-ID: <20151130153604.GN1513@katana>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
 <1445395021-4204-4-git-send-email-jaedon.shin@gmail.com>
 <5628425C.5080104@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dPW7zu3hTOhZvCDO"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33419 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754061AbbK3PgJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 10:36:09 -0500
Content-Disposition: inline
In-Reply-To: <5628425C.5080104@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jaedon Shin <jaedon.shin@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org


--dPW7zu3hTOhZvCDO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2015 at 06:56:44PM -0700, Florian Fainelli wrote:
> Le 20/10/2015 19:36, Jaedon Shin a =C3=A9crit :
> > Add the necessary parenthesis for NOACK condition.
> >=20
> > Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>=20
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

I wouldn't call them necessary?

>=20
> > ---
> >  drivers/i2c/busses/i2c-brcmstb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-=
brcmstb.c
> > index 6b8bbf99880d..2d7d155029dc 100644
> > --- a/drivers/i2c/busses/i2c-brcmstb.c
> > +++ b/drivers/i2c/busses/i2c-brcmstb.c
> > @@ -305,7 +305,7 @@ static int brcmstb_send_i2c_cmd(struct brcmstb_i2c_=
dev *dev,
> >  	}
> > =20
> >  	if ((CMD_RD || CMD_WR) &&
> > -	    bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK) {
> > +	    (bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK)) {
> >  		rc =3D -EREMOTEIO;
> >  		dev_dbg(dev->device, "controller received NOACK intr for %s\n",
> >  			cmd_string[cmd]);
> >=20
>=20
>=20
> --=20
> Florian

--dPW7zu3hTOhZvCDO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXGzkAAoJEBQN5MwUoCm2BRQP/3Jp7MtRO1DcmUk+TOVQ49y3
kvJgqGzocRCKPZzKr3a2MRRqvsRxODIjOWbM7tptNGMZVDbqBquhZB5tHfQFp7Ux
95MjyBV6pU0jMIWnR14LwKknrUXjBN7YPrr9hbUmjKm7QAxI8LZLc5cAdE+fqza6
uZ9qybujqnTO2eFlnXquFXPG3cnbZDx1zY9PkWmjF7sbEr7GdtcQSiq/S3tC+hJD
XuQIMI47sp0sdBE+BefiCLPp8cF8ly67fmQ7yHtBh2D5gLE8m7MPAT9u/wKStKYX
COCKmsyiW8jlbI5qksUq9+k8Xm3XNYaaFjXgqRWI/TSPuIC9DdSj2ZebI2AN/LCg
t9n2QqwZcPU15hpxsm8FITtkSlhY3w3ldtGwL0GfS12HfsG0iKRFW6faYUJ2jLkM
pQgAkD0bFcOEQN2y+O6cGw19AqU8kHjl66OpkIM+UNDBwVJxB7XHtlWJPq/7v5wO
pfILsiO1rm59aX05Kh3FJyDkMixv3tBGJogfIYOLcHNRDfih9qBX2U6dtAchEhlN
W4ZoDiHQdKKL6xGQch7nq2ap0WFXj693dCF0gCcXJYp4kzmoqaAesoG9el6Q2a1M
nNwlO6osnPgwmdmkD1uCRDjPxSXOJu20hzlPRpms7Wstafu5H4rJAoCtL9NI8brU
qnWOoBDAihktR/EOXG7V
=4IwD
-----END PGP SIGNATURE-----

--dPW7zu3hTOhZvCDO--
