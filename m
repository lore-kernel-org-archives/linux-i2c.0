From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: xgene-slimpro: Support v2
Date: Sat, 28 Oct 2017 14:11:36 +0200
Message-ID: <20171028121135.nltpjjdinzdtfvgj@ninjato>
References: <1508796740-2294-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tellzccxyalxrcil"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:37922 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbdJ1MLj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 28 Oct 2017 08:11:39 -0400
Content-Disposition: inline
In-Reply-To: <1508796740-2294-1-git-send-email-hotran@apm.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hoan Tran <hotran@apm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Loc Ho <lho@apm.com>, patches@apm.com


--tellzccxyalxrcil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Thanks for the patch!

On Mon, Oct 23, 2017 at 03:12:20PM -0700, Hoan Tran wrote:
> This patch supports xgene-slimpro-i2c v2 which uses the non-cachable memo=
ry
> as the PCC shared memory.
>=20
> Signed-off-by: Hoan Tran <hotran@apm.com>

I can't tell if __force is justified here but I don't know much about
ACPI... Andy, can you have a look?

> ---
>  drivers/i2c/busses/i2c-xgene-slimpro.c | 45 +++++++++++++++++++++++++---=
------
>  1 file changed, 34 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/=
i2c-xgene-slimpro.c
> index 7e89ba6..31314d8 100644
> --- a/drivers/i2c/busses/i2c-xgene-slimpro.c
> +++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
> @@ -129,6 +129,11 @@ struct slimpro_i2c_dev {
>  #define to_slimpro_i2c_dev(cl)	\
>  		container_of(cl, struct slimpro_i2c_dev, mbox_client)
> =20
> +enum slimpro_i2c_version {
> +	XGENE_SLIMPRO_I2C_V1 =3D 0,
> +	XGENE_SLIMPRO_I2C_V2 =3D 1,
> +};
> +
>  /*
>   * This function tests and clears a bitmask then returns its old value
>   */
> @@ -446,6 +451,15 @@ static u32 xgene_slimpro_i2c_func(struct i2c_adapter=
 *adapter)
>  	.functionality =3D xgene_slimpro_i2c_func,
>  };
> =20
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id xgene_slimpro_i2c_acpi_ids[] =3D {
> +	{"APMC0D40", XGENE_SLIMPRO_I2C_V1},
> +	{"APMC0D8B", XGENE_SLIMPRO_I2C_V2},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, xgene_slimpro_i2c_acpi_ids);
> +#endif
> +
>  static int xgene_slimpro_i2c_probe(struct platform_device *pdev)
>  {
>  	struct slimpro_i2c_dev *ctx;
> @@ -476,6 +490,17 @@ static int xgene_slimpro_i2c_probe(struct platform_d=
evice *pdev)
>  		}
>  	} else {
>  		struct acpi_pcct_hw_reduced *cppc_ss;
> +		int version =3D XGENE_SLIMPRO_I2C_V1;
> +#ifdef CONFIG_ACPI
> +		const struct acpi_device_id *acpi_id;
> +
> +		acpi_id =3D acpi_match_device(xgene_slimpro_i2c_acpi_ids,
> +					    &pdev->dev);
> +		if (!acpi_id)
> +			return -EINVAL;
> +
> +		version =3D (int)acpi_id->driver_data;
> +#endif
> =20
>  		if (device_property_read_u32(&pdev->dev, "pcc-channel",
>  					     &ctx->mbox_idx))
> @@ -514,9 +539,15 @@ static int xgene_slimpro_i2c_probe(struct platform_d=
evice *pdev)
>  		 */
>  		ctx->comm_base_addr =3D cppc_ss->base_address;
>  		if (ctx->comm_base_addr) {
> -			ctx->pcc_comm_addr =3D memremap(ctx->comm_base_addr,
> -						      cppc_ss->length,
> -						      MEMREMAP_WB);
> +			if (version =3D=3D XGENE_SLIMPRO_I2C_V2)
> +				ctx->pcc_comm_addr =3D (void __force *)ioremap(
> +							ctx->comm_base_addr,
> +							cppc_ss->length);
> +			else
> +				ctx->pcc_comm_addr =3D memremap(
> +							ctx->comm_base_addr,
> +							cppc_ss->length,
> +							MEMREMAP_WB);
>  		} else {
>  			dev_err(&pdev->dev, "Failed to get PCC comm region\n");
>  			rc =3D -ENOENT;
> @@ -579,14 +610,6 @@ static int xgene_slimpro_i2c_remove(struct platform_=
device *pdev)
>  };
>  MODULE_DEVICE_TABLE(of, xgene_slimpro_i2c_dt_ids);
> =20
> -#ifdef CONFIG_ACPI
> -static const struct acpi_device_id xgene_slimpro_i2c_acpi_ids[] =3D {
> -	{"APMC0D40", 0},
> -	{}
> -};
> -MODULE_DEVICE_TABLE(acpi, xgene_slimpro_i2c_acpi_ids);
> -#endif
> -
>  static struct platform_driver xgene_slimpro_i2c_driver =3D {
>  	.probe	=3D xgene_slimpro_i2c_probe,
>  	.remove	=3D xgene_slimpro_i2c_remove,
> --=20
> 1.9.1
>=20

--tellzccxyalxrcil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln0c/cACgkQFA3kzBSg
Kbb8rhAAibVGZTYZuC4oQJbs6IWxhBCkGLBVdg9PIQt1S+OiHBSD4GM+rBfFuZ//
kzSjXQ7xjdj+icG1wDabDboIj0dDwV0idS3S+k5veQU4zMv+TrlxmFUTvt2i6/jT
LaIndc9622AOXjJzF4Hc2vn8mdt/2WyV166Qzjqs3yV2L8oI2hmWH0icIsYbZibZ
XzkJ9X9ifoSSmgiTkvn8pUD4Fi3ExNMHeMefqLFWvGJ3Mc89/rDqt3XDuhPJNmhH
nGGoiv/zeQO1V9NfcTDFhJpFPMWWdDpUICgCSxoX2KYO6Cr8milAC2gwU4xeQV31
qdq4bf6fyUk0+zFb8928s+lgd5+6G5Hxlo6r7VwAy/xnEJLxchFl92wmw3NwUPPb
F3uumqHSnaMovLm5jKUSKGSoDfSq9sJfS8qHKyKm3ebLzrQGe2sNGY7TF+BJ8EZn
9lgd0RFjuTIqdXPG/CK6lCx9EqCfDHCxPeN4tQ+KVldfFI4julRQXKZHqSdWbnuZ
vHm+OQw+NOlkPemgpnxEGAIfxeRgBsm5Ev0+bCkcYFRtK1GD9djpQwUoZ3fvhx4b
wKXeRCaO6I4ehpz6jL4xS0TtZ9rdDue8DFjViMgSW1KBAoHUJr3BevaBXKUryg09
/MYa3VSs6TGWxNNiDNhNqeEtavjqY/EzbYylO1+DlqiWdXmyFiA=
=PsjA
-----END PGP SIGNATURE-----

--tellzccxyalxrcil--
