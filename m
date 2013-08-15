From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: davinci: remove useless mach/hardware include
Date: Thu, 15 Aug 2013 14:31:37 +0200
Message-ID: <20130815123137.GC17155@katana>
References: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
 <1374712099-32095-2-git-send-email-santosh.shilimkar@ti.com>
 <51F0F283.5080900@ti.com>
 <51F191AD.9020108@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51F191AD.9020108-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2013 at 04:59:25PM -0400, Santosh Shilimkar wrote:
> On Thursday 25 July 2013 05:40 AM, Sekhar Nori wrote:
> > On Thursday 25 July 2013 05:58 AM, Santosh Shilimkar wrote:
> >> This driver no longer uses definitions from mach/hardware.h.
> >> On the other hand, including this header breaks this driver
> >> on non-davinci platforms which don't have such a header.
> >>
> >> Fix it.
> >>
> >> Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> >> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> >>
> >> Signed-off-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> >=20
> > Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> >=20
> > One minor nit:
> >=20
> >> ---
> >>  drivers/i2c/busses/i2c-davinci.c |    1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c=
-davinci.c
> >> index fa55605..ddaa2a3 100644
> >> --- a/drivers/i2c/busses/i2c-davinci.c
> >> +++ b/drivers/i2c/busses/i2c-davinci.c
> >> @@ -41,7 +41,6 @@
> >>  #include <linux/of_i2c.h>
> >>  #include <linux/of_device.h>
> >> =20
> >=20
> > You can now remove this empty line too.
> >=20
> Yes. Updated patch below with your ack added.
>=20
> Regards,
> Santosh
>=20
> From d7ae1c488ebae19028f33abff76c4d684271a7fb Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> Date: Tue, 23 Jul 2013 15:40:46 -0400
> Subject: [PATCH 1/2] i2c: davinci: remove useless mach/hardware include
>=20
> This driver no longer uses definitions from mach/hardware.h.
> On the other hand, including this header breaks this driver
> on non-davinci platforms which don't have such a header.
>=20
> Fix it.

Applied to for-next, thanks! Please send a proper V2 in a seperate
message next time.

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDMopAAoJEBQN5MwUoCm2efYP/1xfUHLuKrZizeT7mnroEK0q
qT2Uw1HchxNkv4sAWF2s3LcEonxDctYzE+u9H6tuWpmfMH03p8M0MTsGV3ElCsWo
ugqmVcOI3zPgImapSIt285px4MLCwcb+jvqbhUYx4hdBoYdJU5IFTnhyXcy6McZn
3X6YiPPxsXZd+0lMf0zMxgr4+AzEP3hCUQF4AGqXoZN6q2a82XfkeidGhsiS+iUi
9PC77LJsh1Cfv6Y1mMkkm2WdCXPgXfsnd8dTW//vH3pYLCh/ip4Lj1xzI0fLEadq
17MaMy8XLDy4SvqoFQSmvrE+QYOEOoKNTW+fuQPvMoNol45KoDvo0d/s7k0Du6Rp
v8LkiCp9cChKFHND2UDf6N0SuW4s9gsA6l671EvbPuLJ00daIT9GoHWVWPDGHJ/i
fRZA4exJQfqEdvldJrVD8JcT8EFf2juyVRWOnafXW+9iU0LJKfePKx9w54WVqFGw
mycPwTKQKlwLQDOud8etg2CdbceI59ZegbNltqP/nu6f3jIfpiLwguS7h7XsgFob
w78XiEb0cX235zztFrjEp6l3RomLVQZg01tje5zLnwQsvCtPf5UD6TieKAjIgkYn
1rfKr1c6yMY3pClXVwvESJfcb6nPy3nVPNOQtjiiWMVpKuMnZAmEKouhJxZmoKUi
py5Di3G3lU/VYlTaM0JG
=NIhm
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
