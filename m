From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-isch: Add module parameter for backbone clock rate
 if divider is unset
Date: Fri, 25 Jan 2013 10:32:31 +0100
Message-ID: <20130125093231.GG5684@pengutronix.de>
References: <1358937274-14908-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TmwHKJoIRFM7Mu/A"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1358937274-14908-1-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--TmwHKJoIRFM7Mu/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2013 at 11:34:34AM +0100, Alexander Stein wrote:
> It was observed the Host Clock Divider was not written by the driver. It
> was still set to (default) 0, if not already set by BIOS, which caused
> garbage on SMBus.
> This driver adds a parameters which is used to calculate the divider
> appropriately for a default bitrate of 100 KHz. This new divider is only
> applied if the clock divider is still default 0.
>=20
> Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>

Maybe Jean has something to add, but my remarks are...

> ---
> This patch supersedes the older patch
>  i2c-isch: Add module parameter which actually set the clock divider
> from 2012. It now has only one parameter to set the backbone clock rate w=
hich
> is guessed to 33 MHz which is the maximum for both device the lpc_sch dri=
ver
> is for. It registers a single i2c_smbus platform device.
> To my knowledge we can't determine if we have 33 or 25 MHz clock for SMBu=
s,
> so expect 33 MHz and calculate a bus clock of 100 kHz. If we actually run
> at 25 MHz the bus will be run ~75 kHz instead which should do no harm.

This last paragraph should be a comment at the place you set the default
value.

>=20
>  drivers/i2c/busses/i2c-isch.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
> index 4099f79..495d28f 100644
> --- a/drivers/i2c/busses/i2c-isch.c
> +++ b/drivers/i2c/busses/i2c-isch.c
> @@ -40,6 +40,7 @@
>  /* SCH SMBus address offsets */
>  #define SMBHSTCNT	(0 + sch_smba)
>  #define SMBHSTSTS	(1 + sch_smba)
> +#define SMBHSTCLK	(2 + sch_smba)
>  #define SMBHSTADD	(4 + sch_smba) /* TSA */
>  #define SMBHSTCMD	(5 + sch_smba)
>  #define SMBHSTDAT0	(6 + sch_smba)
> @@ -58,6 +59,7 @@
> =20
>  static unsigned short sch_smba;
>  static struct i2c_adapter sch_adapter;
> +static int backbone_speed =3D 33000; /* backbone speed in KHz */
> =20
>  /*
>   * Start the i2c transaction -- the i2c_access will prepare the transact=
ion
> @@ -156,6 +158,14 @@ static s32 sch_access(struct i2c_adapter *adap, u16 =
addr,
>  		dev_dbg(&sch_adapter.dev, "SMBus busy (%02x)\n", temp);
>  		return -EAGAIN;
>  	}
> +	temp =3D inw(SMBHSTCLK);
> +	if (!temp) {
> +		int smbus_speed =3D 100;
> +		dev_notice(&sch_adapter.dev, "clock divider unitialized. Setting modul=
e defaults\n");
> +		dev_dbg(&sch_adapter.dev, "access speed: %d KHz\n", smbus_speed);

That debug can go since this is a constant value anyhow.

> +		outw((backbone_speed / 4) / smbus_speed, SMBHSTCLK);
> +	}
> +
>  	dev_dbg(&sch_adapter.dev, "access size: %d %s\n", size,
>  		(read_write)?"READ":"WRITE");
>  	switch (size) {
> @@ -312,3 +322,4 @@ MODULE_AUTHOR("Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
>  MODULE_DESCRIPTION("Intel SCH SMBus driver");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:isch_smbus");
> +module_param(backbone_speed, int, (S_IRUSR | S_IWUSR));

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--TmwHKJoIRFM7Mu/A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlECUS8ACgkQD27XaX1/VRvNfgCeLiwFw2vkvIsscwPz4yd21JQF
qPgAn1GxAA4xYAybiOUft6xx6LYhSxf0
=2tHH
-----END PGP SIGNATURE-----

--TmwHKJoIRFM7Mu/A--
