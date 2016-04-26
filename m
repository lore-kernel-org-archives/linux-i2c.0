From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: ls1/ls2: add workaround for erratum ERR010027
Date: Tue, 26 Apr 2016 23:29:19 +0200
Message-ID: <20160426212919.GF4587@katana>
References: <1453884283-33414-1-git-send-email-ying.zhang22455@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52443 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227AbcDZV3X (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Apr 2016 17:29:23 -0400
Content-Disposition: inline
In-Reply-To: <1453884283-33414-1-git-send-email-ying.zhang22455@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: ying.zhang22455@nxp.com
Cc: linux-i2c@vger.kernel.org, xiaobo.xie@nxp.com, york.sun@nxp.com, Ying Zhang <b40530@freescale.com>


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2016 at 04:44:42PM +0800, ying.zhang22455@nxp.com wrote:
> From: Ying Zhang <b40530@freescale.com>
>=20
> ERR010027/ERR008951: Attempting a start cycle while the
> bus is busy may generate a short clock pulse.
>=20
> Software must ensure that the I2C BUS is idle by checking the
> bus busy before switching to master mode and attempting a Start
> cycle.
>=20
> Signed-off-by: Ying Zhang <b40530@freescale.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index a2b132c..f1fe599 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -889,6 +889,13 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
> =20
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> =20
> +	/* workround for ERR010027: ensure that the I2C BUS is idle
> +	   before switching to master mode and attempting a Start cycle
> +	 */

Please use kernel coding style for comments.


> +	result =3D  i2c_imx_bus_busy(i2c_imx, 0);
> +	if (result)
> +		goto fail0;

This is wrong! You need 'goto out'. Please be careful.

> +
>  	result =3D pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
>  	if (result < 0)
>  		goto out;
> --=20
> 2.1.0.27.g96db324
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXH92vAAoJEBQN5MwUoCm2yIIP/0AjS7FEB9JE5XmXCmJmdCvD
5yWcn5628Ko3JZjK/LRhFThaNv5q/wM8FkjdXUr1qx1GkdFVKK0QyGUUR8VNPLCM
oU40qYxZfR4WPJ5uKHZqwQx4YaNJF1eIa+gcTStQNdiLpQ8bq1Wes18vTeUygfOi
+IqGSgy7S0ErHvExxF/dmLU/PkMFlWqcaTxGxMaG50H785kE4KfvuY7HBQmWVRrv
/W+u7CbeONMZ5QHKwolsi9032nPzYkbB9BOMtHrntLmzCjXRn7azN7nVuKAuS3Fm
9acO6CLnG4sVsqTjtwNjMDQIqnHglEV1IMflvKpYdR1C6024CRcxPeOBIzGCRZ58
qfZ+F2AOwn7teITL4FbcqRYBIqZpilcv6HMdmtX7Mfh6110SEh8eyJFEwcdHQd32
pqRNhL1mAOZUBnILn7U86UAbYZSUBqTszjOb6rSgqRLMQSJ+oj2XnfQcjBgSKHE7
Ma7Alor3dSU/6htS6YkMp9nt8uUxezLXOz2qphT5ZR6xE1rKlFZJnvbi9nrZLglM
q9OUqglY5H7gputWMuujeQGTKVvyRhP1IAkextmF7QK63ZdW3B4nrPR0IUGG4L8E
tL9grDUv0mjVguJ6IHcWueyddfIGHX9uFXHx0cx2IOOZuKMzCZN/aRp/e5+YQuVw
9qlPaa/9NSrkphgOhgJt
=w5nw
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--
