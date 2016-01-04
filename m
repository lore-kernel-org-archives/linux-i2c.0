From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch V1] imx: i2c: fix i2c resource leak with dma transfer
Date: Mon, 4 Jan 2016 20:32:34 +0100
Message-ID: <20160104193234.GC1522@katana>
References: <1449049958-6820-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52822 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbcADTcj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 4 Jan 2016 14:32:39 -0500
Content-Disposition: inline
In-Reply-To: <1449049958-6820-1-git-send-email-b54642@freescale.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <b54642@freescale.com>
Cc: u.kleine-koenig@pengutronix.de, linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, kernel@pengutronix.de, s.hauer@pengutronix.de, p.zabel@pengutronix.de, yao.yuan@freescale.com


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2015 at 05:52:38PM +0800, Gao Pan wrote:
> In i2c_imx_dma_xfer(), when dmaengine_prep_slave_single() returns
> NULL, the context goto label err_desc and then return. However,
> the memory allocated by dmaengine_prep_slave_single() has not been
> freed yet, which leads to resource leak.

dmaengine_prep_slave_single() still owns allocated memory although it
returns NULL? Isn't this a bug?

>=20
> (reported by coverity check)
>=20
> Signed-off-by: Gao Pan <b54642@freescale.com>
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 0ab8424..6dcfff5 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -397,6 +397,7 @@ static int i2c_imx_dma_xfer(struct imx_i2c_struct *i2=
c_imx,
> =20
>  err_submit:
>  err_desc:
> +	dmaengine_terminate_all(dma->chan_using);
>  	dma_unmap_single(chan_dev, dma->dma_buf,
>  			dma->dma_len, dma->dma_data_dir);
>  err_map:
> --=20
> 1.9.1
>=20

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWisjSAAoJEBQN5MwUoCm2GucQALEKM9+hisM/dmh0/DEe1nul
GlCGTK9SUbktYVjIqXKKlhghnEgnC0LwvVynM7uZL/KP1CZehGySb1BF4HDeYbNB
YEAmJVP2wj/JyhcbZX6rh1eFQrg/iLKZ2jk3SgCStqLpufAZLHpkirBhZgOXnju+
SugmarV5Dz61/Pv48dIWYFCGy5lJ06TgGbxlEG6gOtg+CMMFG4RVfHyaRIstqXnU
ffmCYzUF8z9Jhs4vJ2DO5xKUpXJ9OUqhfv8EANEAIvcqW9VJMIdB5ikVt0GxAfF4
eITvL6Su1aWLpUO3011Cj4Z2QhWB/jqADbVqeisU6ruoioWRSR+Vf5ut9Ik9eTNV
ku++9oz4uIZFcpjqJmx1+JqxCufoGK4L8aovB0Jqwsjky5GcFqbt6oS+cUnONzSp
nN/L7oBsUqa9zsHnbqpYi3jCa5e+cPIL7UFzquoSsYzp+kSEkH7ix2+O2UcGzCOQ
gumASjCqbZGaUArDxgh+P4te6WCLK7Kr71R8sK6JBDGyI6+Ca23nmTveNW+/o109
YKkyDp/+SH7axrPJv0XkEDva8LSF5Rn2ZF1p4/1qA8KtQELH5cIQHsLisDwnzukf
e1j617mVBFJB7XCuXQvVRvQ0sxB7BGo/Q4dTUEhPeJu5fwJ9ANL11A1OAnjPbEMJ
4Wfqmd3uVmTJa8XV1MXq
=Xj3F
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
