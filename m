From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: hix5hd2: add COMPILE_TEST
Date: Thu, 5 Feb 2015 20:20:25 +0100
Message-ID: <20150205192025.GD15307@katana>
References: <1422696495-27282-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422696495-27282-1-git-send-email-zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2015 at 05:28:15PM +0800, Zhangfei Gao wrote:
> Commit 9439eb3ab9d1ec ("asm-generic: io: implement relaxed
> accessor macros as conditional wrappers") has added
> {read,write}{b,w,l,q}_relaxed to include/asm-generic/io.h.
> So COMPILE_TEST can be added.
>=20
> Signed-off-by: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks!


--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU08J5AAoJEBQN5MwUoCm2aT8QAKfKDO7/fBEBrzfuxHX3xxSZ
6CdV2h4KIOclsZ5B71wxboVIcrNXdAf2/CrFgcsGas5Vt9V/YnWLkgHG0wSYDHxg
lOl1admZQhrqamGram0gTBNWsBcD1dfFJpEsYT4Tin2TojfncsP0FYdTPZ1bH7ph
ZojW9mQnAB70YcdZN4zb+xF0kfVeB8YUywHWto0CzvdKwfpeOIwWKp1PKcJTwxRt
i3qmpsxyLwS8KS/wX0lQipFDssEsleckDUn0SzQBlxsxIEUuWXCT9xNUcGRO8+Xs
BY653aZFmLxvOurU9f5Ydan/1zw6OuRo0UuVmEYO0cs9fbDhxGlxJtqvct49x5B8
uqr1xQqh2mx90z1WRCg3ieoR+cakjSuKxPdTXEqUxfBtUxu42hCERHiXBIJ+/9pp
4RQxgUZ04JNHR4+bGlU8PGweSEtJKyiaj69UaqAoLdOOCGAV4q6D9hcu3lM3tWvB
KwFUTYTrjFNamNurxGzN0QSQkPZ8fGb+WpcpQ708+AjGlGgFYPAjZk7AaVvf+9AE
+hLo03MH2BCU6UJ6tlDIUZV0xK3n+klj/2ykxFpxxy78uqlSswpTpThwHNCHmhOm
KStgjdhNIwbFt/XN+cIOqCZqtGFND2US4b4TE1ksXsN8usm2Pn4hFwqCy2XDbm5C
Ij/Cixq7s7Xx06e+mKXd
=GEDX
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
