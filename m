From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v9 3/3] i2c: imx: add DMA support for freescale i2c driver
Date: Sat, 8 Nov 2014 18:35:13 +0100
Message-ID: <20141108173513.GA4900@katana>
References: <1413025032-14958-1-git-send-email-yao.yuan@freescale.com>
 <1413025032-14958-4-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413025032-14958-4-git-send-email-yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: marex-ynQEQJNshbs@public.gmane.org, LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

mostly looking good...

> +#define IMX_I2C_DMA_THRESHOLD	16

Have you guessed or measured this value? A comment about this value
would be nice.

> =20
> +struct imx_i2c_dma {
> +	struct dma_chan		*chan_tx;
> +	struct dma_chan		*chan_rx;
> +	struct dma_chan		*chan_using;
> +	struct completion	cmd_complete;
> +	dma_addr_t		dma_buf;
> +	unsigned int		dma_len;
> +	unsigned int		dma_transfer_dir;
> +	unsigned int		dma_data_dir;

Please use proper types as there are things like 'enum
dma_data_direction' and the likes...

> +	dmaengine_submit(txdesc);

This can fail, too. Use dma_submit_error() to check.

> +	result =3D wait_for_completion_interruptible_timeout(
> +				&i2c_imx->dma->cmd_complete,
> +				msecs_to_jiffies(IMX_I2C_DMA_TIMEOUT));

Have you tested signals extensively? I can't really recommend the
_intrruptible_ here. I don't see any cleaning up to get the bus to a
consistent state again. Most people drop the interruptible sooner or
later.

> +	/* Init DMA config if support*/
> +	i2c_imx_dma_request(i2c_imx, phy_addr);

Make this function void? DMA is optional anyhow.

Thanks,

   Wolfram


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXlRRAAoJEBQN5MwUoCm2U+EQAJ/DRCiZOK6+0nPvIzvKf0rk
Wo+0V2G/+ZWY0TNqQ/x4XuORsIvx3vyxvrzR7Kvm4+gHAiOrDqrH6LuX6jJXb/q7
3TbD8VPgJxmGaabJoUfXCgpUS3BU+CBM1DSiufSpKafoKWKV2eN6OmcS0sLZggKZ
ZtNn44neHVj2nx5texSRe69ABraT/jdyiV0SD10dcR6WkknfN/1GZdtuZkW5Fr5I
ZQroKMfs7vJPEmJsrWTgMqmk7U9Nd9hdEimHhOzHJQ+eJK5Uj+bHhhyq/1UPSuM0
m1WchTTlzfxl8LZn52UjVzpAPcls2SSUR9ADWFv3F3XJa5QonA0MasSUu0J0WkD0
rCMPX20+cilSDh01zcatWHVkgkoHazsWzDFJO151AmhskEUbu9G8aaw9F7VonynE
rF/a+bjVSfqN7Tp+zMoJP78rM/mcqyzoC0titXXYQs5mmV/4Wrf6OGwdo5aO+x2K
XfWD4jNCr8E5SMzYQSkabPqrReznLwRDHE56XoWSFaCLTJiJMrJU+HrdUP5zS18s
0hVaiBHMl6ti/lPaCkAzbcJQwr+9SmOKjWC8/pHJHwQbl63UpvpK7d/6Ixcx2qeC
akFMNMEbKjwyfMuquggp7g4ZY5pGcSMvGuYLt3q4JtCi1xWTYRjvBvYbE4Ty22tt
TGkSq1ohA2TEoTYWBNLp
=xq7W
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
