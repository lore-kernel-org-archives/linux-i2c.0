From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-pnx: fix error return code in i2c_pnx_probe()
Date: Wed, 28 Aug 2013 10:30:12 +0200
Message-ID: <20130828083012.GA4086@katana>
References: <CAPgLHd9W5GtFtt6yCHRJ2mmuy2ha2u_utF9jR3yLY5O_oYpLWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd9W5GtFtt6yCHRJ2mmuy2ha2u_utF9jR3yLY5O_oYpLWg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2013 at 10:55:51AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Fix to return a negative error code in the irq get error handling
> case instead of 0, as done elsewhere in this function.
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>

Moved it to for-next, since...

> ---
>  drivers/i2c/busses/i2c-pnx.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> index 5f39c6d..d2f02b3 100644
> --- a/drivers/i2c/busses/i2c-pnx.c
> +++ b/drivers/i2c/busses/i2c-pnx.c
> @@ -727,6 +727,7 @@ static int i2c_pnx_probe(struct platform_device *pdev)
>  	alg_data->irq =3D platform_get_irq(pdev, 0);
>  	if (alg_data->irq < 0) {
>  		dev_err(&pdev->dev, "Failed to get IRQ from platform resource\n");
> +		ret =3D alg_data->irq;
>  		goto out_irq;

=2E.. this surely needs to beu 'out_clock'. Fixed it here. If somebody
wants to convert it to devm_*, much appreciated.

>  	}
>  	ret =3D request_irq(alg_data->irq, i2c_pnx_interrupt,
>=20

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHbUUAAoJEBQN5MwUoCm233YP/008xwEXxCcb1+rMQLyYQGtG
3anhmCF5HuzcirtRCUGPtDz+cALr5hI69CldPe6nc+KbiEEfW2QKex58v2Nn9WUr
O5h8DK6v97AmiRIdQKB6mIAMb4/4eTBYJ0EvAHE6BvfUZf5erFHLtcQTmIals1q7
DTFEWQav571Pdqd5k1n/+37A6is9ojWTYX5uVpQoyDHqQJuO8WtmoFUEyo3e8AqS
RksLWSzBAmjmDvD7zx6k4CDgebBZcJZE1fMOmM06eKcTgAQ3h76dIhO+SuPXixIi
9rZ01o6zdENUcBuiOb5pX909GiTGLo5ad61ZMy2hLwJg55wCEk2mtS3vr/Y6P494
p+LWhLbX/KmTIb3f00ZEIlqLd060yMJv7e4ZmZFGPFvpAt6x72PlwvYgEhYSJcRb
JHM//3jU4MrxTHmXr3WvKu/zrZAOwk46UCrEJSpPrzmRo6egAkc7NzbAmXtOlAeF
eDUHIoAUacZOyKrSR5FNZoFh3dgM6UQgS0vtcihpCQRFt5bX650HFY+msU5qBHjG
uq9LevElvASR+kUtESwRN+fVzQZVo2tsgplHKM2PR8Vpr6Supd5r56nIRtsDdEvL
ppwC4RTqDNx2vAV112b7S5qHhpIef7da6pvGGfNnKAeIJLyuelwMWCtiyaizCyvO
oZX9qs/L9lYAoCEgc6Kh
=bwrl
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
