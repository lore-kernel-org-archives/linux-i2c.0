From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: Do not calculate SCL timing parameters
 needlessly
Date: Mon, 26 Jan 2015 16:59:07 +0100
Message-ID: <20150126155907.GC13494@katana>
References: <1422005755-20285-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422005755-20285-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2015 at 11:35:55AM +0200, Jarkko Nikula wrote:
> Do SCL timing parameter calculation conditionally depending are custom
> parameters provided since calculated values will get instantly overwritten
> by provided parameters.
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Applied to for-next, thanks!


--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxmRKAAoJEBQN5MwUoCm2eksP/A5IejsrmcMJWr+PREDjN3kF
bV++EFPwO3YLpRqzNHt9FK6MMQPUvPIqTmUrElz7MVdmAghfaMi5xjjaLR1TZydg
XZji08dSu/AaGwlO/B3KkABTAHAIGZOB0eAQPYMZAFm7WqtTCVE4h9EZ3ks5KW3k
CZnZ6JQD4yiZHIYKHCiwkslOj6gKX+VcwHJRhb7YGZyiDxYW4wQMfYfpAt8SWbQl
WWLa8Gv6tmbQz2HvAF//wSonq2deZ6+za3aEO1bwl+32gF1TXipjgXScBy3Xmnu3
aY9GA8SNqXrOWLQJNh2jCAs9obrw83E2MMaGGFjE8ujG3PTOdvm330J44n8Iie7F
BKkfyF9mQUXBtnAPRdAxZweQ13qX1GZ0AYJILMfkhZlJaqTGq+knswzQ1vka/UMD
lDemQ/aQvgzPfUuXoLxw6iwUyYZiZTuSTVlfbdUZ5LCIdkPT/SsfEmYKVgFRbqQs
v35FS1jZTDukBcoi5cizwnSLDQ1S4BvI9E91UVDSieP20vMVAig7XKUvEaWANfYF
gQheaOcGfianOAdZU3/prnaMtItPY3M5K8E8ofV9x0AvMm3xLGPG+csNqEDznmN+
aJT1JscT6zlbftY9p0n3VLEp8Ic1acr+3mngJhRQtLkIco0LR28JMxFIskrlSb7H
qyM+LHVml7fnUMghIcdT
=t+Tg
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
