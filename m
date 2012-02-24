From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c-isch: Add module parameter which actually set
 the clock divider
Date: Fri, 24 Feb 2012 13:23:48 +0100
Message-ID: <20120224122348.GF2479@pengutronix.de>
References: <1329316609-14570-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1329316609-14570-1-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2012 at 03:36:49PM +0100, Alexander Stein wrote:
> It was observed the Host Clock Divider was not written by the driver. It
> was still set to (default) 0, if not already set by BIOS, which caused
> garbage on SMBus.
> This driver adds 2 parameters which are used to calculate the divider
> appropriately. This new divider is only applied if the clock divider is
> still default 0.
>=20
> Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
> Tested-by: Adam Pribyl <pribyl-CRPBUER/Gz7twjQa/ONI9g@public.gmane.org>
> ---

I don't know the hardware: Can it have multiple SmBusses? Then, a module
parameter would force all of them to the selected mode. Do you really
need the parameter? Maybe defaulting to 100Kbps is sane enough?

@Jean: Is this an embedded driver? :)

> Changes in v2:
> * HSTCLK register is 16 Bit, not 8 Bit. Thanks to Adam for detecting
>=20
>  drivers/i2c/busses/i2c-isch.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
> index 6561d27..bdfddf8 100644
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
> @@ -58,6 +59,8 @@
> =20
>  static unsigned short sch_smba;
>  static struct i2c_adapter sch_adapter;
> +static int smbus_speed =3D 100; /* SMBus bus speed in Kbps */
> +static int backbone_speed =3D 33000; /* backbone speed in KHz */
> =20
>  /*
>   * Start the i2c transaction -- the i2c_access will prepare the transact=
ion
> @@ -156,6 +159,13 @@ static s32 sch_access(struct i2c_adapter *adap, u16 =
addr,
>  		dev_dbg(&sch_adapter.dev, "SMBus busy (%02x)\n", temp);
>  		return -EAGAIN;
>  	}
> +	temp =3D inw(SMBHSTCLK);
> +	if (!temp) {
> +		dev_notice(&sch_adapter.dev, "clock divider unitialized. Setting modul=
e defaults\n");
> +		dev_dbg(&sch_adapter.dev, "access speed: %d KHz\n", smbus_speed);
> +		outw((backbone_speed / 4) / smbus_speed, SMBHSTCLK);
> +	}
> +
>  	dev_dbg(&sch_adapter.dev, "access size: %d %s\n", size,
>  		(read_write)?"READ":"WRITE");
>  	switch (size) {
> @@ -312,3 +322,5 @@ MODULE_AUTHOR("Jacob Pan <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
>  MODULE_DESCRIPTION("Intel SCH SMBus driver");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:isch_smbus");
> +module_param(smbus_speed, int, (S_IRUSR | S_IWUSR));
> +module_param(backbone_speed, int, (S_IRUSR | S_IWUSR));
> --=20
> 1.7.3.4
>=20

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9HgVQACgkQD27XaX1/VRvoWwCgxtngr1igPkFM1SfDqV7iW7zM
r4IAnRFzWXeOigfSE6pZkg3Wigawfqbx
=4Dw5
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
