From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: I2C_MT65XX should depend on HAS_DMA
Date: Thu, 9 Jul 2015 22:10:37 +0200
Message-ID: <20150709201037.GM4744@katana>
References: <1435320730-5506-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YIwHDYD8sUXtBKvt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435320730-5506-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--YIwHDYD8sUXtBKvt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2015 at 02:12:10PM +0200, Geert Uytterhoeven wrote:
> If NO_DMA=3Dy:
>=20
>     ERROR: "dma_unmap_single" [drivers/i2c/busses/i2c-mt65xx.ko] undefine=
d!
>     ERROR: "dma_mapping_error" [drivers/i2c/busses/i2c-mt65xx.ko] undefin=
ed!
>     ERROR: "dma_map_single" [drivers/i2c/busses/i2c-mt65xx.ko] undefined!
>=20
> Add a dependency on HAS_DMA to fix this.
>=20
> Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Applied to for-current, thanks!


--YIwHDYD8sUXtBKvt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVntU8AAoJEBQN5MwUoCm2zpIP/0E75Wu1eXfpsMTs12Hmdx1v
fHgDafQQmvZxXvZFVKjvQCYldXRfndYnxllDB0W0hapmOC8eJisGQ9cuc5RJRdDh
gplPD8D/DgZyVmsZJaFgquLX4CBUdrpErZRkEOnq2F2peDZGDFvNTXMxSZexKWAV
2ijWVbjhf2Wlj9Q1DixnvB+sPcXrT45H55z0alk5OmgZ86Y39bWKtj9Fpi7BCuZC
FKLUd8AIildfda6eQk5JuPdFn7xoprEwVpWX08A1/0r0W37o8jQlp+tkHmDHDCND
1B6lV/jXbbvOUpeMQST/JThG+GDk4Rcb6whumznFrc8Wq5iihTF5pq2dIyOy0bMV
R5M785g3ZiWnV9AGe/RIcTRsoPDnO+ColuLW+6pk9mxoz5jsiafQ9gU9q4x4ydyO
5mGvGTrMbCn+9SWBJv6rjqr/1sC+W5Nhq1lvyarkgmTM1mXurX6ISUfnhRTQh+xl
Gg5cutrVmefDgiCqI1YBaVWGKnpWu0SlB0wG/7+sTHgNLBZm+8Y7E1Vv0x8zCkT9
wUxjfcUXfCJcdTFdVGTvThnmWFV5qhFe4dp6D9in0UiLbxgIemSwQI3I6fJ+4Yhq
pCubGzcCs7yqvJneqAcMj5mIKD81XDO5JQaYmEoMYNr4ilnVoienNLyROjbj36kF
zp9orFDUBohrvPBets7f
=zJjG
-----END PGP SIGNATURE-----

--YIwHDYD8sUXtBKvt--
