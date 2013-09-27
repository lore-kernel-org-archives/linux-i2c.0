From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] misc: (at24) move header to linux/platform_data/
Date: Fri, 27 Sep 2013 23:04:24 +0200
Message-ID: <20130927210424.GA17407@katana>
References: <1380308788-15730-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380308788-15730-1-git-send-email-vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vivien Didelot <vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2013 at 03:06:28PM -0400, Vivien Didelot wrote:
> This patch moves the at24.h header from include/linux/i2c to
> include/linux/platform_data and updates existing support accordingly.
>=20
> It also fixes the following checkpatch warning:
>=20
>     WARNING: please, no space before tabs
>     #436: FILE: include/linux/platform_data/at24.h:31:
>     + * ^Iu8 *mac_addr =3D ethernet_pdata->mac_addr;$
>=20
> Signed-off-by: Vivien Didelot <vivien.didelot-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>

Applied to for-next, thanks!


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSRfLXAAoJEBQN5MwUoCm2m2wQAKqGWFi0D0CBEMItBtsqsqg4
aOJ8stsKwBPpTILvHedGu7DxRlGK2dWXOEBrcUrUCfmpSqTPfm02VNtySaPTy4zH
MYU3hFElV9bQJX+HNrJ5pht81KUyTJpVLYe86wSwb6WLIPJHlfJG4VzklxkxXIRe
JqsU/Lzhgy2ir9mhaRFzMQtsSMHOJO1BUj/1CNocfa8F6GPbLSCuimgmX+FGEZvo
TFA02JSJvqFE9yorTGsEZlVHkwQS6Jh8x7/mXl61ZLRB/pa9lsTc5bUNH8YGGvYb
NzDlR01ZPpyajB86drjcYFQdSDx+KsDxJr4dzQriZwlwT8Kx/GZtvuGXTPdVPXne
Y4RVZsbyAjZ0KIBVvvsbUx4zdausdhhR28cbamFT9dlIO4AOTXJfMsHwzeksH/N5
eD6ClTQp/wNHqk+bEna5V8yurSTqlXQmSiaZuheNTwl9qFGRfG27lz3ghHjgIv1y
jTrR/NZ2s/EwLmn6Vy2kT+lw9lcwjUwiNUlSubPKvw4V3i6KEJuWlhuz5podXE1z
xe5P8mHzcJnOyGgBv6GwKncY/eAxxzxYMdZGK7/zAnO2pXnHKeV1p4IK3D6eqy2/
IzE56iiVleMnj2uPt/5Y0pWjIa3GmfKmbvOpAy1m0FLHFun4rc1/ezMApx+thO9S
kvA/bugwlxGnZymCipeh
=/MFE
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
