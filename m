From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: i2c_transfer & dma
Date: Thu, 25 Sep 2014 16:05:05 +0200
Message-ID: <20140925140505.GA1316@katana>
References: <201409232138.33067.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201409232138.33067.PeterHuewe-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter =?utf-8?B?SMO8d2U=?= <PeterHuewe-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> So the question is - does the user of i2c_transfer have to provide a dma-=
able=20
> buffer, or is the bus driver (like the robotfuzz one) expected to convert=
=20
> incoming buffer into a dma-able buffer?

As of now, this is an open question, sadly. I have a tendency to leave
it to the drivers (maybe with helper functions from the core), because
I2C and DMA is so uncommon. I need to work on I2C & DMA next month
anyhow, so I hope to dive into that topic, too. No promises, though. If
you want to look into it already, please go ahead. The issue was raised
here, too: http://patchwork.ozlabs.org/patch/220137/


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUJCERAAoJEBQN5MwUoCm2/aUQAKTKYeahFvwPg65Ar4bGoL8/
YRaRcy7MLHdk4W2YO+HBeseypQUeZ9qmkMlTEYvpdlzVR2G/WW4lYP7Z3jWjh68k
z2DDv6/YMZO7N3bwjYdW4gV4tHa2+Xx/UpNR0Y1okLaqZA5VA+wCFZVNCiXO3MXq
E/OtL0tpByFJRv/IbrMDnsc1En2PoxbhQbOrKoKwJbAG1D0Yh+iSvae/XwVkJIe1
BH1wuTZT8tZQ3W8UnTcZO9qf30HXlXukOMpbuSlU5XY0tnGWeT58/UaGELx/szFf
8wZ0IuXWrKVOfsFXJGiA+3+0o7J7f8bbzZDArmDPTZmRDJI39DNerzfR4HOWg59K
4cHEKBg7Q/iw+a1o1EdmNQWAL0ZGH/53j1YWCtEEgYfmb+NRCH/2XAa2OVvUrY7I
nY7zEHhBp9nPU5bbJiO2Ws0ZL7cF+SIHYW5HjDqjQ0CFs1SNTB10ezNvM70qdJHw
glEQ3J2em4vCsUHnkjS5gLFFe8XtxbXQTikKjR7zModGVCF8fCcOAjudWPnLoMJJ
GlsG1JFQm7p278wQLEZ1kO/2K80oBmTSKBWon3WXSXStl5KD02sgC9K/H/DIa1VB
lZYoTv8UPz7vPrMWJ1JUXuO28V3fe0gEImvAISG+ksjaE7Lm4OIMx8IcO88+4wq4
Oez4jmBUhuh1UDZzpbVY
=NcLk
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
