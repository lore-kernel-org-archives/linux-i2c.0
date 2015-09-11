From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH-v5 RESEND 2/5] i2c: pxa: enable/disable i2c module across
 msg xfer
Date: Fri, 11 Sep 2015 20:53:12 +0200
Message-ID: <20150911185312.GA1516@katana>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440395978-9065-3-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1440395978-9065-3-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2015 at 11:29:35AM +0530, Vaibhav Hiremath wrote:
> From: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>=20
> Enable i2c module/unit before transmission and disable when it
> finishes.
>=20
> why?
> It's because the i2c bus may be disturbed if the slave device,
> typically a touch, powers on.

I am not convinced, "may disturb" is too weak for me. It would need a
way more detailed description of the problem which makes clear that
this mechanism is the only way to go forward.

Can't you use Runtime PM for that?


--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV8yMYAAoJEBQN5MwUoCm2XG8QAI/cC6wWQMNF18RQYDLoHvBH
R+6TYPM/Z5HodA+WPrDlI4XgI9Lzm5eAmBx5chG2KKKq2bpUwabYlQHQScxIeeNW
SvQyF3AdUgTElKlg1ibA+TeNMyFDyRzNJ52V+tQ5QpSdV0eU1r0xZFGAr/26QHWs
6D/cL8v47Vd5grTsryK/oXI4ZR9PEk7lXjCLbIAhbv84vsckoid2+cYHxGjKfU0D
6GNQmYctBbfixSFIfSbavxS7F+ekq3j4lzOK8BiW8dQsUcWt6xkl/6wPqMNVULgs
26Ue+bWcAc8kBbaUrkLae0AqfzKR0lpLMF3ARF15ukLeybf9R2HJSy6kxM4cj95b
SBeG50ExRea2sZHkOyyBPho4IMehDlAZCevpfxsi2qGqIBR56JDJX3MLwn/O+d3H
s93WKFfAJj/7lQ5OMn8h9mc/OHAUbKKO2Xdj7raCSqDzRMKsjwfHs/TWCo4gETNV
Iad2Dx+6OfveNKHT2DJhv/ZFLG33w4OsleVoof8T0y3UJnysy7CcxjL5L75ckQtZ
BEd/LEr00QSKgjbFg21f64+zvfFj7QuuwNAshdu9KWCWk63vnaTUhTu8FbVdwwCd
ZCr9An6lKj/n9C9lQUoPTUHuSiSm1pexC09YjVKKAHGkj1eO/+xp4weIHPfQaucs
kKZIpw8a7hhH6OYBUpuF
=7OSn
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
