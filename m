From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 08/24] leds: fix dangling pointers
Date: Tue, 30 Mar 2010 14:36:12 +0200
Message-ID: <20100330123612.GH29472@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de> <1269094385-16114-9-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EemXnrF2ob+xzFeB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1269094385-16114-9-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Riku Voipio <riku.voipio-X3B1VOXEql0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--EemXnrF2ob+xzFeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 20, 2010 at 03:12:49PM +0100, Wolfram Sang wrote:
> Fix I2C-drivers which missed setting clientdata to NULL before freeing the
> structure it points to. Also fix drivers which do this _after_ the struct=
ure
> was freed already.
>=20
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>
> Cc: Riku Voipio <riku.voipio-X3B1VOXEql0@public.gmane.org>

please drop this this patch. We reached an agreement that a) setting the
clientdata-pointer to NULL should be done in the i2c-core [1] and b) how to=
 do
it. Based on that, I will do the modification of the i2c-core for 2.6.34 (a=
s it
fixes the dangling pointers) and then create one single patch removing the =
then
superflous calls to i2c_set_clientdata for 2.6.35 (as it is a cleanup). If =
you
already applied the above patch to your branch, you don't have to revert; we
will fix it for you in the next round.

Sorry for the detour!

Kind regards,

   Wolfram

[1] http://thread.gmane.org/gmane.linux.drivers.i2c/5674/focus=3D5729

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--EemXnrF2ob+xzFeB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkux8DwACgkQD27XaX1/VRtGVwCfZkkftdDEO97j7QecceDftlaL
4h4AnjBYnZQvW4F5FQnXcPDNQGmN5A8+
=AvUU
-----END PGP SIGNATURE-----

--EemXnrF2ob+xzFeB--
