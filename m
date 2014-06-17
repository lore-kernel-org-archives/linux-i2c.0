From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: sun6-p2wi: fix call to snprintf
Date: Tue, 17 Jun 2014 14:28:59 +0200
Message-ID: <20140617122859.GB2683@katana>
References: <1402655028-6214-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402655028-6214-1-git-send-email-boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Kees Cook <keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Shuge <shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2014 at 12:23:48PM +0200, Boris BREZILLON wrote:
> Fixes possible issue in case pdev name contains formatting characters.
>=20
> Signed-off-by: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Reported-by: Kees Cook <keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

Applied to for-next, thanks!


--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToDSLAAoJEBQN5MwUoCm2NrkP+wcPvYBqBsyI5hG9itkiKcvS
wGayPH2UN0b4dm6qdnhPKk/Yvxdnza8GvrVqW57CFrJ7rNj/S2m3ZBER9M7IZVTd
qcLtNA04mDMkb62I/ccEjA7/ja26NZOhzlcPOjoVaK6wVmCMcO1iyIVngeTKepwO
RlLqgk1fo/FY2KvQDkHPjVphoYcFJdjWJ/9FOvW2Jp/qGDw9BzKMDDsSG1ECUjQJ
liFs9ZttdHYZidbARAptSPhkgVF9Z64dd3UEGMi3MEbh8Z08sWCI6e3j1BrW1bdW
EQpsUB61oeqEAdwLZtDFBaI9X8H7KzSgdigCGxfO6as58rraVjoqps8mU0qfHxTm
u84u0UrSINb6mNxbARig1/QBVy7+VEWAgIGjy8yhKwWMwfaoOasSYc8i88riCDn8
Y9oSe66ovxfQxpHP6j8Tvm3Q3DC3IcBCDv/fY3Yqpb8v3ctjTd2+c25qN5+ZTrMn
96fybDtGDNz9rg+Q4Rx7blV4B2MrD45Xk2II3K+5IGzE3L0Ctjpnk6IHHTWDe3iq
jTdWfZc1IIzSBQH2aFM5EGkGX21u3OW+x2TOJhV1N2qRMZhpgv0N1jmp3VuyrP4M
oheI1Stcn0j6kvewU/xfeCnSRfm/CBuTrExM6r3NM58xzoZwwOY7u3VfGEhy75RQ
HsKgP98Uvb+Dlva/+S2S
=9QFI
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
