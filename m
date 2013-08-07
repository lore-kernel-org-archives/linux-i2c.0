From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: add sanity check to i2c_put_adapter
Date: Wed, 7 Aug 2013 17:05:59 +0200
Message-ID: <20130807150559.GG2978@katana>
References: <1375359046-17472-1-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m0vRWufqUC70IDnR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1375359046-17472-1-git-send-email-sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--m0vRWufqUC70IDnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2013 at 02:10:46PM +0200, Sebastian Hesselbarth wrote:
> i2c_put_adapter dereferences i2c_adapter pointer passed without check
> for NULL. This adds a check for non-NULL pointer to allow i2c_put_adapter
> called with NULL and behave the same way i2c_release_client does already.
>=20
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks! Please describe the use case next time in
the patch description. The current text describes more what is changed
not why. You did that later ("easier probing").


--m0vRWufqUC70IDnR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSAmJXAAoJEBQN5MwUoCm2AeoP/20nrJWH5NFyRVfnQrfBXuus
LdGSUrnYw2O5mfclbr81n+BEPn5eSSJGn+gmdPnaQD6k32woQsMD8casz77vMeNv
OU3HCP0/mczidq2J85TnTniLkJWuaGf4K5M0cyiapUUwUhF+hrp31Rxbmfja4N4G
qFUBDmZutRiiipmGtS7LDLOy4RWI4MyqVdq8fStYAYS2cZb+ODj4zVSCfM0YQgpk
gv1oxtH6LYicTyRMgWxp+ZXubs8Rn+U2Fq9BSaWCVR7BLPix8KkRpns1qHCfpOEu
jJ+XBnvVObrJIUA1menP3hR0T4r49YZFyRxm1XACQwRL/6hy8WxnbVKFEv/9Xonh
KZs5IcW+SXYQC+pj3JoFK7xURvwLgmZ5+0uITH5IhV1uznGeDEB18EP7oeex9ZPk
SY45/+TJQeLRbsNlHSnTJx294C8llHaFPQLTKXiZZj5in1qDjGXRt5Qn2Jck5Mu/
dp36ha0YRYLpV8Vupr5VluU/EOtJAmFiGeP5vACbF5gCV21y5A59jIg5FjaDSJ21
i3uMJRRnmsVV6PcKxXtnRMndqinbwf5SiSE6GMZd5p4qsE6+LSaHsmsSbjbhTESZ
JXXtfJ3RQghpU+yWp6WkFv9f2svzN0zuUqveLFO4YN2OlrvLTf39l4zDviYW6vxn
Ccze4uBJnq5pGk3GJhCW
=3PMH
-----END PGP SIGNATURE-----

--m0vRWufqUC70IDnR--
