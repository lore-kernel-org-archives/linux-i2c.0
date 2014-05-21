From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 1/2] i2c: sunxi: Change i2c compatibles
Date: Wed, 21 May 2014 09:52:51 +0200
Message-ID: <20140521075251.GA2708@katana>
References: <1396270498-30703-1-git-send-email-maxime.ripard@free-electrons.com>
 <1396270498-30703-2-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396270498-30703-2-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2014 at 02:54:57PM +0200, Maxime Ripard wrote:
> The Allwinner A10 compatibles were following a slightly different compati=
ble
> patterns than the rest of the SoCs for historical reasons. Move to the ot=
her
> pattern for consistency across all Allwinner Socs.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

I still don't prefer the removal of the old binding, but as this has
been discussed:

Applied to for-next, thanks!


--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTfFtTAAoJEBQN5MwUoCm23TsP/2Sh0/36gfs91q+oBWF2Zvn7
KBBub5eLQYwLHJf4By5cvqBU5AUsMCV0SBw+r7U6Xty14GoWIwuAphgmDU+lATmn
F0nY/hKy6MoBi2nxzNMYapnmnB5bp1f0pTYO1vetFg27e6n7laCgIALVfkVP6bDZ
rzFS8K+S2PBYr+QJwmOEtyP/EnXI3F0zHtrUzLZXFOwkNNadQz1C5VDHNYwXb7ge
RxHiFHflzVdJCEisq0DGns9yZxOFtUlFi1feN+n4TpPRbA5jQhG0dZrQoCnkL+3t
ZVleT6336fYmEXi+7IaCJpt3TT6Di06BDpu1zj1DkI4gANZ9n8fskHA3mb6NGULt
RScn/MQjuAVMQFhhv7jeaxgtrL5hLzrp+361oMjsDxMQCMvkuvJkkX0VMJ+8fotK
PwJTbI/eytDR/WohzcAyJfS8qgi3SYjaRISOmYwLAr/CgS11qdSUHwFRK+q1kgY4
dVOl26NyGy3UCxmNG2lWjX9zdt5PUpn2o+Ge3+bseRy3MPlmqZh7mCJRREHXU+eX
Y91P2XwhxMJPhurNM2PkhmTmdXlLKDVnVFLeQZB9PkwsNn0M/byxqDyCirhVSJYS
KkvQ1tZaFzebuMtFuoGUWldpUENdeYxuFO+SmMJ0QaYmDB1lNieoDHsYqidWqSjH
pI9aI58knl0mJKT6H0u4
=hK8s
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
