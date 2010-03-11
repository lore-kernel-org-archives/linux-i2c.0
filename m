From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress-KvP5wT2u2U0@public.gmane.org>
Subject: Re: [PATCH] misc/eeprom/at24: init dynamic bin_attribute structures
Date: Thu, 11 Mar 2010 19:21:11 +0100
Message-ID: <1268331680.2272.0@antares>
References: <1268268932-23447-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-PjGAUeH+AC5Cq2NV9On/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1268268932-23447-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> (from
	w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org on Thu Mar 11 01:55:32 2010)
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

--=-PjGAUeH+AC5Cq2NV9On/
Content-Type: text/plain; charset=ISO-8859-1; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfram:

your patch completely fixes the issue on my 5200B board.

Just an other dumb question:  as I mentioned, the driver is loaded even if =
no chip is attached to the i2c bus.  Wouldn't it make sense to check if the=
 chip is there (e.g. by reading the first byte), and eject with ENODEV if i=
t isn't?

Thanks, Albrecht.

Tested-By: Albrecht Dre=DF <albrecht.dress-KvP5wT2u2U0@public.gmane.org>

Am 11.03.10 01:55 schrieb(en) Wolfram Sang:
> Commit 6992f5334995af474c2b58d010d08bc597f0f2fe introduced this requireme=
nt.
>=20
> Reported-by: Albrecht Dre=DF <albrecht.dress-KvP5wT2u2U0@public.gmane.org>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Eric W. Biederman <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/misc/eeprom/at24.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> Depends on:
>=20
> http://thread.gmane.org/gmane.linux.drivers.i2c/5496
>=20
> ([PATCH V2] at24: Fall back to byte or word reads if needed)
>=20
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 88c20da..d2deea4 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -541,6 +541,7 @@ static int at24_probe(struct i2c_client *client, cons=
t struct i2c_device_id *id)
>  	at24->bin.attr.mode =3D chip.flags & AT24_FLAG_IRUGO ? S_IRUGO : S_IRUS=
R;
>  	at24->bin.read =3D at24_bin_read;
>  	at24->bin.size =3D chip.byte_len;
> +	sysfs_bin_attr_init(&at24->bin);
>=20
>  	at24->macc.read =3D at24_macc_read;
>=20
> --
> 1.7.0
>=20
>=20
>=20
>=20


--=-PjGAUeH+AC5Cq2NV9On/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iD8DBQBLmTSgn/9unNAn/9ERAvceAJ4rTGEUbbF3EcWvT94VOInfz0pImACfbnzt
AtRKc+kERMrmhFm0oxZ4iIE=
=SRYj
-----END PGP SIGNATURE-----

--=-PjGAUeH+AC5Cq2NV9On/--
