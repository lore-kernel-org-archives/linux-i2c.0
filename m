From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/4] i2c: designware-pci: shrink dw_pci_controllers
 array
Date: Fri, 23 Jan 2015 13:41:55 +0100
Message-ID: <20150123124155.GA1906@katana>
References: <1422014045-20584-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1422014045-20584-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422014045-20584-2-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2015 at 01:54:03PM +0200, Andy Shevchenko wrote:
> There is no need to duplicate same data for each controller. If we need
> specific stuff for a certain controller in the future we may add it later=
=2E The
> patch leaves one controller per platform.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 63 ++++++------------------=
------
>  1 file changed, 11 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/bus=
ses/i2c-designware-pcidrv.c
> index 5c6fca7..435a8ec 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -40,13 +40,7 @@
>  #define DRIVER_NAME "i2c-designware-pci"
> =20
>  enum dw_pci_ctl_id_t {
> -	medfield_0,
> -	medfield_1,
> -	medfield_2,
> -	medfield_3,
> -	medfield_4,
> -	medfield_5,
> -
> +	medfield,
>  	baytrail,
>  	haswell,
>  };
> @@ -98,47 +92,12 @@ static struct dw_scl_sda_cfg hsw_config =3D {
>  };
> =20
>  static struct  dw_pci_controller  dw_pci_controllers[] =3D {
> -	[medfield_0] =3D {
> -		.bus_num     =3D 0,

Wasn't that bus_num used to ensure stable bus numbers? Adding Mika.

> -		.bus_cfg   =3D INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
> -		.tx_fifo_depth =3D 32,
> -		.rx_fifo_depth =3D 32,
> -		.clk_khz      =3D 25000,
> -	},
> -	[medfield_1] =3D {
> -		.bus_num     =3D 1,
> -		.bus_cfg   =3D INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
> -		.tx_fifo_depth =3D 32,
> -		.rx_fifo_depth =3D 32,
> -		.clk_khz      =3D 25000,
> -	},
> -	[medfield_2] =3D {
> -		.bus_num     =3D 2,
> -		.bus_cfg   =3D INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
> -		.tx_fifo_depth =3D 32,
> -		.rx_fifo_depth =3D 32,
> -		.clk_khz      =3D 25000,
> -	},
> -	[medfield_3] =3D {
> -		.bus_num     =3D 3,
> -		.bus_cfg   =3D INTEL_MID_STD_CFG | DW_IC_CON_SPEED_STD,
> -		.tx_fifo_depth =3D 32,
> -		.rx_fifo_depth =3D 32,
> -		.clk_khz      =3D 25000,
> -	},
> -	[medfield_4] =3D {
> -		.bus_num     =3D 4,
> -		.bus_cfg   =3D INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
> -		.tx_fifo_depth =3D 32,
> -		.rx_fifo_depth =3D 32,
> -		.clk_khz      =3D 25000,
> -	},
> -	[medfield_5] =3D {
> -		.bus_num     =3D 5,
> -		.bus_cfg   =3D INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
> +	[medfield] =3D {
> +		.bus_num =3D -1,
> +		.bus_cfg =3D INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
>  		.tx_fifo_depth =3D 32,
>  		.rx_fifo_depth =3D 32,
> -		.clk_khz      =3D 25000,
> +		.clk_khz =3D 25000,
>  	},
>  	[baytrail] =3D {
>  		.bus_num =3D -1,
> @@ -301,12 +260,12 @@ MODULE_ALIAS("i2c_designware-pci");
> =20
>  static const struct pci_device_id i2_designware_pci_ids[] =3D {
>  	/* Medfield */
> -	{ PCI_VDEVICE(INTEL, 0x0817), medfield_3,},
> -	{ PCI_VDEVICE(INTEL, 0x0818), medfield_4 },
> -	{ PCI_VDEVICE(INTEL, 0x0819), medfield_5 },
> -	{ PCI_VDEVICE(INTEL, 0x082C), medfield_0 },
> -	{ PCI_VDEVICE(INTEL, 0x082D), medfield_1 },
> -	{ PCI_VDEVICE(INTEL, 0x082E), medfield_2 },
> +	{ PCI_VDEVICE(INTEL, 0x0817), medfield },
> +	{ PCI_VDEVICE(INTEL, 0x0818), medfield },
> +	{ PCI_VDEVICE(INTEL, 0x0819), medfield },
> +	{ PCI_VDEVICE(INTEL, 0x082c), medfield },
> +	{ PCI_VDEVICE(INTEL, 0x082d), medfield },
> +	{ PCI_VDEVICE(INTEL, 0x082e), medfield },
>  	/* Baytrail */
>  	{ PCI_VDEVICE(INTEL, 0x0F41), baytrail },
>  	{ PCI_VDEVICE(INTEL, 0x0F42), baytrail },
> --=20
> 2.1.4
>=20

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUwkGTAAoJEBQN5MwUoCm2iPoP/1DixFljdAWm1YGdELIv6akJ
xaNIEKACVYYy8u87KB2ogHcMIIMEAjsMA4p/oqhUHq/O/FS5km7JxhTPFxuIHRx4
M2hu6T6cZcj8+zf0wGziZY7abYw8cR5Bg38tv/LUt/lfldYRXm88m/HpnBYbiaiC
tCIfQO8ywj7glZowVrtQxAUetHERtNVwGjrUBHSNxaGLhSl2tfTE/q/Zwf8Qw0Um
kRp+Hv4j/X5jaa7pLKH25/GpbebRcbLozFoyFlnK6GEw+qUeF/Cwv/jfyic0rDJq
hJ5ZGbW/vKzZTkzBdYQLbMjyEiKlnXyZlROvufmwBKPHiEnltuOzlLY9ERvE9FMu
dOfnR3CLvynq7SsJjWnfGHrMWweQQJFWIlk/IWwa7ydWI2zvlnoi5GTbnlvnFwi+
oX4s/jjcowRaDaxU/eZhRR5nqrzsd4CysXgGcysw0qGmF8WXeYYP8gKy83rI+2v8
OgUvZcQE7DzuifTFTF8Pw61nB6sCvZhqYyIZtnwwHQqHWxydiY640h/ttWs8Twkw
QMPPTuGOaKYSv6kkDvpXU1V0yqZmUwFzFK8mCrEnESXLIfYAQD1aBBSE8Vh30wSI
Mme6xCc8CygPwb90Y7RCEWRXOTUdFN+D5kTn0c/Q1mKBFsqeTDQjVrh8d81UfR9c
A/pqZOMKllJ13JvRiNqp
=rGf1
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
