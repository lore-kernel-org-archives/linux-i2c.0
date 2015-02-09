From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v9 3/3] ARM: dts: add I2C device nodes for Broadcom Cygnus
Date: Mon, 9 Feb 2015 13:11:03 +0100
Message-ID: <20150209121103.GC2491@katana>
References: <rjui@broadcom.com>
 <1423373126-30024-1-git-send-email-rjui@broadcom.com>
 <1423373126-30024-4-git-send-email-rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423373126-30024-4-git-send-email-rjui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ray Jui <rjui@broadcom.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Arend van Spriel <arend@broadcom.com>, Kevin Cernekee <cernekee@chromium.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Christian Daudt <bcm@fixthebug.org>, Matt Porter <mporter@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@arm.linux.org.uk>, Scott Branden <sbranden@broadcom.com>, Dmitry Torokhov <dtor@google.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2015 at 09:25:26PM -0800, Ray Jui wrote:
> Add I2C device nodes and its properties in bcm-cygnus.dtsi but keep
> them disabled there. Individual I2C devices can be enabled in board
> specific dts file when I2C slave devices are enabled in the future
>=20
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> Reviewed-by: Kevin Cernekee <cernekee@chromium.org>

I usually don't take DTS patches. They should go via arm-soc. Please say
so if there are reasons I should take them.


--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU2KPXAAoJEBQN5MwUoCm2G/QQAIrn/SC0DC02xmTkaPKvdgnn
KOvx3/szr2rxsEVcBU9QvESvngKLmbwHppFQW5TULBljhg43Ws/EoC/wb4O5ySKo
Gr7UzZBvZIS7FZJRtyA1YVGCJRIkY+2Da/wGmygkO3vjU9Ly4KHxR/guKwlpFMWe
2Sgrt7pqpNVdWoQgeIndt4E8ac1D6aIa3plUxkLeD7LlQ0FDUK2LdMntNOEt3nii
r0rK5pU/o/tmViMYJXeBlG9UC50HitLVV5JJLQnNsymaLBIHjzcKZ0xj8aik8Uet
MyYXpYZvcVOgx/DBsuxh0SVaxisyXK2tgZ61mKM6CnYQgvkk+CVWoFJEQBojEVcV
puNm9N+eO4jQWK/28UUZ27FqKgQ0NOSbCPUe6oShky6MAt6e4ejBYQs90On35P8q
G9bToCJlfHlCZSLHwYWY6ub7xBj8k/7hGoUGX1YBAE0yKWKCLxv57y7C024f3Suk
ur3gz2i2mi8xxvg6UonJK5Urz99GdvwBkVQmdfe5c919DnnOyNO6IooeBaNIimnx
jExv6ZtVujv7DJGlAlC/PUI2OSJe53dRqCuOvQU5jRmy60k5/vZ0ZOETurYvtKfB
El+Ef/897RQVU+h6tjjzDFEVnMrYJ/wt6IAOcsfS6gO+5wLRnrsUOr4ZNZxnfBc1
UxV0lZ8C5jaYzKBNzdj0
=EEwA
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
