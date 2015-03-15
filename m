From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: nomadik: match return type of
 wait_for_completion_timeout
Date: Sun, 15 Mar 2015 11:02:26 +0100
Message-ID: <20150315100226.GE6770@katana>
References: <1423398873-24653-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423398873-24653-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Alessandro Rubini <rubini@unipv.it>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 08, 2015 at 07:34:33AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. as
> timeout is used for wait_for_completion_timeout exclusively here its
> type is simply changed to unsigned long.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied to for-next, thanks!


--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBVixAAoJEBQN5MwUoCm2e+IP/RR0PQsvvDFomMKFraFlVVGJ
S/UynJ7Bx9+SrKHSSq4ceUzBWPDVwqjxEYq71MMg2qqLlJLy0HYuhOJcGPuYfFY5
Xf10V7n/dRhXo0BrWJcekYGI18pmAp3M4f/n3GUkA+36ppkWcn8WLbIu8gcoPG9Q
HUE9kiXs0p1tE/aJ4ailAdRQrXcsyCZvK/FLLpznRDwdkddn5cajz2MN0GxjXe1N
MA9Yn58rf/CLS7IMHdxoxypls5BEzwo/mhWZF/JmgkC9TunCFmJowmrnOxcY+hW+
k39Q+I4cuGDKst/5yD8bNeYnjCn/j56XMix4FKY8CexQAn2/pL8DlHCeCN5V17x6
o+hc3CaC/cUJAoul33IJJkTcjQL0J0BJ1o0xfiE2bwtINhgsxNAS8W5ecYTg4LAr
5xxbUKRYPwQxW+s39wdqQZmQUfjrZv8zo8PdJH8ZHoKswuLQSlm1GwMHBnUmUsJ7
GMq9fus5I2KUN4WlMDGGCf147PMScN9Sce1WMbScvZwRfOHt9MCDYC+LRCO+wLF5
UHL8BaiNrd9V62oaILmtHrkyPSaup1uGix0ZiWTrOA74Y6529TCk2mOyko8pUcsM
1ErSUqIxedXY52Cbg8gpU6ou9ciSqQcGjvkC8I5LvrTgyUVnhYmgDy2QvTFNYQmL
LL+q2a/3Tabl9+XN2yPW
=KaUC
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--
