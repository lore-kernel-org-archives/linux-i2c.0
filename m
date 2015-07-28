From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 4/8] i2c: img-scb: fix LOW and HIGH period values for
 the SCL clock
Date: Tue, 28 Jul 2015 12:27:09 +0100
Message-ID: <55B7670D.7080806@imgtec.com>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com> <1437997641-32575-5-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="dq2VmBCQgS6WjsIKiX4D3FWimPw0NbsEp"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437997641-32575-5-git-send-email-sifan.naeem@imgtec.com>
Sender: stable-owner@vger.kernel.org
To: Sifan Naeem <sifan.naeem@imgtec.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: "Stable kernel (v3.19+)" <stable@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

--dq2VmBCQgS6WjsIKiX4D3FWimPw0NbsEp
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Sifan,

On 27/07/15 12:47, Sifan Naeem wrote:
> After determining the minimum value for the High period (TCKH) the
> remainder of the internal clock pulses is set as the Low period (TCKL).=

> This causes the i2c clock duty cycle to be much less than 50%.
>=20
> The fix suggested here, start with TCKH and TCKL at 50% of the internal=

> clock pulses and adjusts the TCKH and TCKL values from there if the
> minimum value for TCKL is not met. This will make sure the i2c clock
> duty cycle is at 50% or close 50% whenever possible.
>=20
> Fixes: 27bce4 ("i2c: img-scb: Add Imagination Technologies I2C SCB driv=
er")
> Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
> Cc: Stable kernel (v3.19+) <stable@vger.kernel.org>
> ---
>  drivers/i2c/busses/i2c-img-scb.c |   30 +++++++++++++++++-------------=

>  1 file changed, 17 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-=
img-scb.c
> index b4f59e1..51a5be8 100644
> --- a/drivers/i2c/busses/i2c-img-scb.c
> +++ b/drivers/i2c/busses/i2c-img-scb.c
> @@ -1178,25 +1178,29 @@ static int img_i2c_init(struct img_i2c *i2c)
>  	    ((bitrate_khz * clk_period) / 2))
>  		int_bitrate++;
> =20
> -	/* Setup TCKH value */
> -	tckh =3D DIV_ROUND_UP(timing.tckh, clk_period);
> +	/*
> +	 * Setup clock duty cycle, start with 50% and adjust TCKH and TCKL
> +	 * values from there if they don't meet minimum timing requirements
> +	 */
> +	 tckh =3D int_bitrate / 2;
> +	 tckl =3D int_bitrate - tckh;

too much indentation here.

Otherwise looks good to me.

Acked-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

> =20
> -	if (tckh > 0)
> -		data =3D tckh - 1;
> -	else
> -		data =3D 0;
> +	/* Adjust TCKH and TCKL values */
> +	data =3D DIV_ROUND_UP(timing.tckl, clk_period);
> =20
> -	img_i2c_writel(i2c, SCB_TIME_TCKH_REG, data);
> +	if (tckl < data) {
> +		tckl =3D data;
> +		tckh =3D int_bitrate - tckl;
> +	}
> =20
> -	/* Setup TCKL value */
> -	tckl =3D int_bitrate - tckh;
> +	if (tckh > 0)
> +		--tckh;
> =20
>  	if (tckl > 0)
> -		data =3D tckl - 1;
> -	else
> -		data =3D 0;
> +		--tckl;
> =20
> -	img_i2c_writel(i2c, SCB_TIME_TCKL_REG, data);
> +	img_i2c_writel(i2c, SCB_TIME_TCKH_REG, tckh);
> +	img_i2c_writel(i2c, SCB_TIME_TCKL_REG, tckl);
> =20
>  	/* Setup TSDH value */
>  	tsdh =3D DIV_ROUND_UP(timing.tsdh, clk_period);
>=20


--dq2VmBCQgS6WjsIKiX4D3FWimPw0NbsEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVt2cNAAoJEGwLaZPeOHZ6OJ8QAL6h7SkhzWPAJimHJXdnxp3N
OJp0c4kC7kdH7LkPiOvK3bbnN7/vxhp8QtvK1wGen/svG5rbblsjeVaGuTF/T3+X
TKLlPIwEkBDyidRtm1KY9NREK2lZJ5os0G9RGDCoHEJReLsEx7+2X5JY3dC6trZu
J+deAMeogpdJ4GfrkjssiT+iXasXhsXmA/M7G1Pl+llSGBuyxAJJd+FRGFQeiTAN
d4cb3+O9ZqKJLH77PtXeH0u4iSTB/uINuhI5kxdLft/F+lQTGJWUYN/qLXrEadIL
qyL97N8CpNQB7yB/+NRNY+zr1e5zmZ2HD8bAC7IWjYg0DvJVAT7uj003djujGjjt
8YmVwsKASVNWAFVxJKQD8lw2b0nOH/WHFim+5ndE+Y9Lj3smIjRZjftwe5QYYFgk
dx/4Pb6gbsA+jaT39IfcpyBTbku2DT+HCJCsnRFEOlBqqUlqI73Ii821Phtj1yVL
tBJE6KTYhXKs0gCr2o3ETzEFHYPgUGr1bz8ICyL4hsydJd2yMO3zRdqPhCi8XXdn
FIp/IR2UxmAjzvCWGuFe8YLcdVoQrjfYpT2EYDad0KhyJ//8c5a49+QRdtjqlWxS
ajsKhowb6yRsf0jvmk5kUK6N/nYbNJ1vRxjB+qTBlvCqY81PlR6V+ezV0MvJ3Mv/
oKpUIIH0j1U4MCdB13t6
=JE5l
-----END PGP SIGNATURE-----

--dq2VmBCQgS6WjsIKiX4D3FWimPw0NbsEp--
