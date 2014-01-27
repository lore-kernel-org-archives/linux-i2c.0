From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: rename Blackfin TWI I2C driver to i2c-adi-twi.c
Date: Mon, 27 Jan 2014 10:28:38 +0100
Message-ID: <20140127092838.GA2633@katana>
References: <1390720607-447-1-git-send-email-sonic.adi@gmail.com>
 <20140126102859.GA2579@katana>
 <CAJxxZ0PW+QHZqgo+7HCTt_s-Vbp=R4xX8a967qT84VnfZt3MAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJxxZ0PW+QHZqgo+7HCTt_s-Vbp=R4xX8a967qT84VnfZt3MAg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > You describe what you do, yet the commit message should describe WHY the
> > change is needed. This applies for the other patches as well.
>=20
> OK, I will add WHY in 2nd version. The ADI TWI peripheral is not
> binding to the Blackfin processor only. It is better to use a more
> generic name for this driver.

Oh, this is the only reason? Then NACK. Names always change, even
company names. Trying to keep that up-to-date only creates lots of
changes for no technical gain. It is quite common that drivers keep the
name of their first incarnation.

Thanks,

   Wolfram


--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS5ibGAAoJEBQN5MwUoCm2sw0P/jTyfOCAdGlgVfUGOxdcWCwj
VlI6b2PFKdY4UkOA8LRBee+3DSuHekI5LxMlgonCHjqVOgVVnU22Z35F3oGWajZ9
9xOT8S4RThltvI9pY0T8lh1b/U4vR99vHMJxZljkTjUX6Xg9/6CiT7+hd5KMkoPz
UJIukRZ2C8o/jk9bIquELzGE7kLdQrIF0G6NEOMnQkscs0MiGkmsO6Ypk6lmj7Cg
yttJdc3f091nmwnZh55RwDFCNkv1xm3CyOwq0tphwtFwR0LQRE9jnGvG02Cuh1wp
Yo+r4M8EYS57/u3PnJVQn++80KqefRzkUFaY4YlPMId/IfxUz1OwFSNdTdE5mUlu
fPXAoMgeVE6s1OKw5wcdDpWOKsjiMJIMvXl6f5mk04Qzc9SkCkrK4tE4bDikBnq5
Y8rmSNEPC+3HFBpWjRnGjFT+KCUOdVn1AGOVnMDyWn41y0bygC4IDU4GCtsliDqE
Sh6vHkP3MI9n5EwLBExkn4hQoXsQedxiv+5On0PARIWUBpUQ/Xch1Dv+rNhOwjw2
iw+oXKtQTYSm5aLWD1QAVWvKMp+xNIwXmtbkRx+y8wWx7beMeteu6NXMPSolJxjV
sOkXLxSPztAFLR4/xvKZ0u0/On9vw+j12aZxokp30wo+vPqbMFLh5OqIQmyERH5i
0W4Ox8FYumdFZcNhjvHK
=crSZ
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
