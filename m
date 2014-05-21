From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: nomadik: Fixup system suspend
Date: Wed, 21 May 2014 10:33:44 +0200
Message-ID: <20140521083344.GH2708@katana>
References: <1397138376-28427-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+G3HLlWI7eRTl+h"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397138376-28427-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--k+G3HLlWI7eRTl+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2014 at 03:59:36PM +0200, Ulf Hansson wrote:
> For !CONFIG_PM_RUNTIME, the device were never put back into active
> state while resuming.
>=20
> For CONFIG_PM_RUNTIME, we blindly trusted the device to be inactive
> while we were about to handle it at suspend late, which is just too
> optimistic.
>=20
> Even if the driver uses pm_runtime_put_sync() after each tranfer to
> return it's runtime PM resources, there are no guarantees this will
> actually mean the device will inactivated. The reason is that the PM
> core will prevent runtime suspend during system suspend, and thus when
> a transfer occurs during the early phases of system suspend the device
> will be kept active after the transfer.
>=20
> To handle both issues above, use pm_runtime_force_suspend|resume() from
> the system suspend|resume callbacks.
>=20
> Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>
> Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-next, thanks!


--k+G3HLlWI7eRTl+h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTfGToAAoJEBQN5MwUoCm2jqYQAKLMV/TCoReTAdudwC5+iI1k
wmGQeI9yKGeQyqjxQiCzKXVFaZez4Vd4pbGQwFL1mBxrecWzVVbkpaImnSw3Nho8
znu7SCSJ7pI5mubp2PxzFxu3Pu/83NvKxHs0tjZVWHFTbL4ccHfm86lc3G8fruDN
NWVL5jSJxPYPqGclszTbVgzDl2k9OMXtz/+AGiYAAMJZm7em0RsWWBJs/+Ok6GkY
h7C2ec0FLyjgHL9pJYNNIHkpxXXzvLtptvSY/z7/y+RgmrAiWYnTUDigIj3g3OaQ
8v83iVIVldiFqN9rwH5hK1XU7TUYDx0hLnraaAhOLJfD5g39lf4sTDvToFMIgq6G
A5DF0XWDlmTnuULGm8BS/hEn0ltYP1VS3uW9zdwk+SsPg+Pj3rBJPGPJGGVt051l
/DvZjVn4T4sys1xE0CLaI+KUCVhjbtvfqio1eQ0PZWhYXLCIVAvZYb+bIY6h40py
GugMoOyIEs2bl3TdLPR17UllPF9I1+a+v0VrQMCpDBdey3y6f7S5XEoLHJ3gLCHp
jpiYeeYgnSYdIq8ePOq95TtYUfQmJo38kbKCtr8ufLsIR2Mv3e+R7DOxq93G1vjN
A6c36ZuVVTeLD1WQewWbklePMH5y1n3geYBNgU7F/A6YjFW4x4ED9sNLlPvf/jqd
Ne8p6wWcHm/+39n/C7TN
=ViS/
-----END PGP SIGNATURE-----

--k+G3HLlWI7eRTl+h--
