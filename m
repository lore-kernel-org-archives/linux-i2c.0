From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] I2C/ACPI: Fix possible ZERO_SIZE_PTR pointer
 dereferencing error.
Date: Tue, 19 Aug 2014 10:03:55 -0500
Message-ID: <20140819150355.GD15371@katana>
References: <1407810818-33672-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407810818-33672-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2014 at 10:33:38AM +0800, Xiubo Li wrote:
> Since we cannot make sure the 'data_len' will always be none zero here,
> and then if 'data_len' equals to zero, the kzalloc() will return ZERO_SIZ=
E_PTR,
> which equals to ((void *)16).

I assume the read request with length =3D=3D 0 comes from a broken BIOS?

> So this patch fix this with just doing the 'data_len' zero check before c=
alling
> kzalloc().
>=20
> Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Looks good to me, yet adding ACPI experts to CC for further comments.

> ---
>  drivers/i2c/i2c-acpi.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-acpi.c b/drivers/i2c/i2c-acpi.c
> index e8b6196..e144c00 100644
> --- a/drivers/i2c/i2c-acpi.c
> +++ b/drivers/i2c/i2c-acpi.c
> @@ -134,6 +134,9 @@ static int acpi_gsb_i2c_read_bytes(struct i2c_client =
*client,
>  	int ret;
>  	u8 *buffer;
> =20
> +	if (!data_len)
> +		return -EINVAL;
> +
>  	buffer =3D kzalloc(data_len, GFP_KERNEL);
>  	if (!buffer)
>  		return AE_NO_MEMORY;
> --=20
> 1.8.5
>=20

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT82dbAAoJEBQN5MwUoCm290sP/ik4CvhheCAfyjidId8vJogq
bJDVxiFY/3qP5D0oyX2HmpNH51Wp4rO5QXNjPPYU1ZFILv5aXzdg57meUnOhHEb0
pm4mmWrPgm+7/mtOtE4Po1VhHgq51kYtGfjV9p4SBd42IKGriS/iT80jhpccVNUU
Rwb9ysNU18yztMzwhlHrkS/SWShCbnOI7ZCTNE7KCazcRB2Ts9mmWMWZ/eFGdkcX
178SFi1yl1Gk0p/Ao6MEvDecFKIPg/uIEEBMwBQU759C/EQLeJTuFabeXiqpYs1i
ZpAVh7deMDtmvPD9FNrSVyO1Mfay/h09aN+sgGNCDjRxBLsw8K5wPUPQFiXDzx2K
Ub03BpMedvJgFZ6WqPJ/qmhFGkFh3H/TvpHGVA6mseW8uw5vQI8CC4478F5orRxP
2nbEQfRHb+nAyRdTYHGTpdjQvtF5mNQNSayBhPJDl0M2sFpZ4+oAyK/YkLH5+ZcS
V2PNIobY1TYvCrnlI0NNrjcEcJHd+EHwIxm7E67RqyzWDBh06IXhB83vE5BRebFj
+lfO6aS0rJQqkpm/46RcBVA0aalJTm4sopalX9MtWXHPulPaeBEFxUyqLNMr2VrO
A6AIa4MXCjC2OYzjTT6RWWN4uRYFQhc9tDx4BRL9kuFtiuEhCS88B39mS6440Bmc
7kkHloNRc1boDZkBj8Ge
=mMGa
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
