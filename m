From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V4 16/17] i2c: nomadik: Remove busy check for transfers
 at suspend late
Date: Wed, 19 Feb 2014 17:05:04 +0100
Message-ID: <20140219160504.GC13973@katana>
References: <1392812867-19212-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392812867-19212-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2014 at 01:27:47PM +0100, Ulf Hansson wrote:
> We should never be busy performing transfers at suspend late, thus
> there are no reason to check for it.
>=20
> Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>
> Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Okay applied up to patch 16 in a local branch. Waiting for LinusW to
comment on the 100kHz vs 400kHz issue before pushing out. If patch 17
can be applied now, please say so. If not, please resend when
dependencies are upstream.


--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTBNYwAAoJEBQN5MwUoCm2+loP/2JXqxGOO/0qtR0+gSSRz0Le
Nxz2Nx3u9GjVqdNKke/EqvLOwNMu3Nlazf2iydKHP+NpUQ5wo4AV83c8/Qf0mGXP
hVPjmLKbV40/c/pzRJ2LSTLc80WSpOYh7VQ9UcxhHHvIG5UPTTuDnpVPtGck7wTY
Dm9PJVbu4Q6sQcuiofAmcNVPLzh6aHKTR1ru4x8Ns9DcyNg0jgI/T9QqPH3ZV+pF
x6IEcU2R4KpU+Dr+V+mF/3mIBBYIa77Lk5z6YE+gxdn6VGuTTLQflmTW3AfnhV/q
aWNjrk085VDh/ZRMRHSPu1Ri2ipt4ppXwPmP4y6VvY7N9onSbSsz0ARzUDklMKVL
9PVy8M9eUnl4CQC2z9JDbcNiajsqLeK0avRLsSa8ACxxOF1OG3d3I5JAc89AEAoI
HYeqstYyIe5fHNQQMJLBJDNedl9DBSpuSiuswiDGsQr0RyLsc5DBWuiVyyPHoFAx
Zwv/AwAPoq2PftI8SmlVGtoRpnKneWQMmmaYzer0r+6U/Q1EosHYXc1naAzpj1u6
EKj5SdI9p1WOqSzmmK6r+3jEWj0WdpPb8kYDi2wrJ7EF5zfS7XaiKcEQonwBsLXA
8ebGSCYOSUA2ilDenBuPzngpl14sFhO5ofylHGs+56kO5z6PoJeCn+vGd/6ZHYBs
D/hF9ES4zUpv36ISLdyw
=jffE
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
