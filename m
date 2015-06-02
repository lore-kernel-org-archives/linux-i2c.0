From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v1 1/1] i2c: designware: Fix hold and setup time issue
Date: Wed, 3 Jun 2015 02:46:00 +0900
Message-ID: <20150602174600.GB1494@katana>
References: <cover.1428374207.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b3d42396c046e4ab4a14edec84f3484b0f27d192.1428374207.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b3d42396c046e4ab4a14edec84f3484b0f27d192.1428374207.git.sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2015 at 07:40:28PM -0700, Kuppuswamy Sathyanarayanan wrote:
> If the device configuration is updated by firmware and
> the information is not passed to driver via firmware
> interfaces like ACPI or DT parameters, then that information
> will be lost once the device either resets or suspends. This
> patch checks the boot value of hold and setup time during
> device probe and updates the driver hold and setup time params.
> This fix will ensure that the updates to hold and setup time
> values are not lost after device suspend or resets.
>=20
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Adding Mika to CC.

> ---
>  drivers/i2c/busses/i2c-designware-core.c    | 37 +++++++++++++++++++++++=
++++++
>  drivers/i2c/busses/i2c-designware-core.h    |  2 ++
>  drivers/i2c/busses/i2c-designware-platdrv.c |  4 ++++
>  3 files changed, 43 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busse=
s/i2c-designware-core.c
> index 6e25c01..2598207 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -64,6 +64,7 @@
>  #define DW_IC_RXFLR		0x78
>  #define DW_IC_SDA_HOLD		0x7c
>  #define DW_IC_TX_ABRT_SOURCE	0x80
> +#define DW_IC_SDA_SETUP		0x94
>  #define DW_IC_ENABLE_STATUS	0x9c
>  #define DW_IC_COMP_PARAM_1	0xf4
>  #define DW_IC_COMP_VERSION	0xf8
> @@ -89,6 +90,9 @@
>  					 DW_IC_INTR_TX_ABRT | \
>  					 DW_IC_INTR_STOP_DET)
> =20
> +#define DW_IC_DEFAULT_SDA_SETUP	0x64
> +#define DW_IC_DEFAULT_SDA_HOLD	0x1
> +
>  #define DW_IC_STATUS_ACTIVITY	0x1
> =20
>  #define DW_IC_ERR_TX_ABRT	0x1
> @@ -271,6 +275,35 @@ static void __i2c_dw_enable(struct dw_i2c_dev *dev, =
bool enable)
>  		 enable ? "en" : "dis");
>  }
> =20
> +/*
> + * Update device default param values if its changed by
> + * firmware
> + */
> +void dw_i2c_update_defaults(struct dw_i2c_dev *dev)
> +{
> +	int ret;
> +
> +	/*
> +	 * make sure default is not updated by firmware
> +	 * interfaces like OF or ACPI
> +	 */
> +
> +	/* SDA hold time update */
> +	if (!dev->sda_hold_time) {
> +		ret =3D dw_readl(dev, DW_IC_SDA_HOLD);
> +		if ((ret > 0) && (ret !=3D DW_IC_DEFAULT_SDA_HOLD))
> +			dev->sda_hold_time =3D ret;
> +	}
> +
> +	/* SDA setup time update */
> +	if (!dev->sda_setup_time) {
> +		ret =3D dw_readl(dev, DW_IC_SDA_SETUP);
> +		if ((ret > 0) && (ret !=3D DW_IC_DEFAULT_SDA_SETUP))
> +			dev->sda_setup_time =3D ret;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(dw_i2c_update_defaults);
> +
>  /**
>   * i2c_dw_init() - initialize the designware i2c master hardware
>   * @dev: device private data
> @@ -368,6 +401,10 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
>  				"Hardware too old to adjust SDA hold time.");
>  	}
> =20
> +	/* Configure SDA setup time if required */
> +	if (dev->sda_setup_time)
> +		dw_writel(dev, dev->sda_setup_time, DW_IC_SDA_SETUP);
> +
>  	/* Configure Tx/Rx FIFO threshold levels */
>  	dw_writel(dev, dev->tx_fifo_depth / 2, DW_IC_TX_TL);
>  	dw_writel(dev, 0, DW_IC_RX_TL);
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busse=
s/i2c-designware-core.h
> index 9630222..23ae2e8 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -98,6 +98,7 @@ struct dw_i2c_dev {
>  	unsigned int		rx_fifo_depth;
>  	int			rx_outstanding;
>  	u32			sda_hold_time;
> +	u32			sda_setup_time;
>  	u32			sda_falling_time;
>  	u32			scl_falling_time;
>  	u16			ss_hcnt;
> @@ -131,3 +132,4 @@ extern int i2c_dw_eval_lock_support(struct dw_i2c_dev=
 *dev);
>  #else
>  static inline int i2c_dw_eval_lock_support(struct dw_i2c_dev *dev) { ret=
urn 0; }
>  #endif
> +extern void dw_i2c_update_defaults(struct dw_i2c_dev *dev);
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bu=
sses/i2c-designware-platdrv.c
> index c270f5f..d8995d8 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -233,6 +233,10 @@ static int dw_i2c_probe(struct platform_device *pdev)
>  		dev->rx_fifo_depth =3D ((param1 >> 8)  & 0xff) + 1;
>  		dev->adapter.nr =3D pdev->id;
>  	}
> +
> +	/* call after firmware param update */
> +	dw_i2c_update_defaults(dev);

What about calling this from the pci driver?


--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbevXAAoJEBQN5MwUoCm2sY4P/A9lsFkHwJF8PA7yN/lAFY/A
njDhmLqZM6lpq9pybBJL0q2Gt6Ex7yGP8u0SEseyOhu6el5qE22imXz3IDFXUht8
XbI3VxLqfeXkdIsmcNRTCx0g8b8Ijp3aH254SMj5dP4trNoco1jcPTKlPMDMJFEJ
CRwNt8qLDgJatMSv+no+7DW5rk/vPXVkAAchOUZmSkNTguWk7xprXIGG/E225Cpf
nrnoBgMO96F4XJAXLXGMQRVQBRTHuGOhtDaS3Nmj8oJfbM7cpyYEESRhz0d/jOtC
nvfmEHAz+AoFQgIFTHyQUbpJI7MBglnSYom7F6jimDnQLtdYyQMVEujYlSDL2RUW
fGurPsx4VI1YKVxg9Uaru6Fey7LkQpxe9sfR1RrlUm2O2c3BA7ODXGyUDj+u0Ka1
wvawkhoryZR8jM8758ImOT0oLJexYri54QgicGoZMx3zkP8olVa/b9fbIJf3AgTn
YH8tvBK519cANBX75GM7LiMl45/eXKwIizcEQhhbn10hcOElTpecsTwzeMiNZXSG
vWGfbc0280m23YVM4T4HUi1oOSbrkjjv3cTTf4AZOciCYerATWRYeXBYgaQ0R4MU
soGcZIk2jzeVp3IJ6ZvcKkSuTn4upWEhGyw3f2p/KVMtWDG51+xxTSuiiW2E3ZfM
/yntyNpn5Gh4OUGlhUoO
=/LFJ
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
