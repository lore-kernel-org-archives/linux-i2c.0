From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [[RESEND]PATCHv6 2/2] i2c: altera: Add Altera I2C Controller
 driver
Date: Wed, 13 Sep 2017 22:50:38 +0200
Message-ID: <20170913205038.ndlkaivkdgxa3ee2@ninjato>
References: <1505164640-26413-1-git-send-email-thor.thayer@linux.intel.com>
 <1505164640-26413-2-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pi4mtplocq5gytux"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505164640-26413-2-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thor.thayer@linux.intel.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, andy.shevchenko@gmail.com, davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--pi4mtplocq5gytux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 04:17:20PM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
>=20
> Add driver support for the Altera I2C Controller. The I2C
> controller is soft IP for use in FPGAs.
>=20
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Applied to for-next (will be in v4.14), thanks!

> +	if (finish) {
> +		/* Wait for the Core to finish */
> +		ret =3D readl_poll_timeout_atomic(idev->base + ALTR_I2C_STATUS,

I wonder a bit about polling in an interrupt handler (maybe threaded
irqs?) but we can fix that later, I think.


--pi4mtplocq5gytux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlm5mh0ACgkQFA3kzBSg
KbY0nw//W8o8vGfiQj6spiCOXbT8RPUdzZHTZHUSXPEx9HGxqFRMkG6aWQdCObWz
DsDtPa1eH8A0M9AOR38/BYxSoshoWQ4jLpIdi+uBWqarM/L3EmdP4Z9mSAVOVT7z
af5hX9884n697WT1wXgg7z5EtcZNIvcvh2BHj88wCEsyrdZ6DTT0DmHpnpHOInXx
QIt74Zb3ZsM72yJYpYhuxAxr80fm4PfBUFOn/OZpFt508ZVDMml2VPuThwSIZz+b
apoYKQoIRg2dA3wlC8GrLI+wxwBuiPrL8VzF2fruVSpKt03dCJYdttaJUIwOKG4I
wMX5CKJzzaaw2LICDlE9SrvRQQfGulPQtnZXi/CzqbHSdU7dBel+IP/hkmIKo2x1
FKM90LJGo6rF0lwI71hq/c8LOb0vQBGLAoOBopiFMJseTjJQ8NgMn+Lveh2KEt5j
9eLxF150NC6TrueBT0F/7oRw2SBGQqz3bqrOlgLH41OdiyRvuOMMBPBoJupUjfs8
aGLIz5tU+lt5XY16ALJZ9lEJkwx7xl+m9nUoTTZyxOHfzEVSFY5krQueOhqXZ49t
sFRWQZhpHLbz1AUJoPb4eggzq3FBfUu9SauU9CsSQcCoTBnOPhLQ0JLC7bwVi0mb
Qpk2Y6XpNPbWpJxqhmUqeM2I084CEPhPAwnGbfaEWG78n3hjJxQ=
=nlPw
-----END PGP SIGNATURE-----

--pi4mtplocq5gytux--
