From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch v1] i2c: imx7ulp: add i.MX7ULP i2c controller bus driver
Date: Sat, 16 Apr 2016 23:29:11 +0200
Message-ID: <20160416212911.GE1522@katana>
References: <1458035482-14905-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52820 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbcDPV3S (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 16 Apr 2016 17:29:18 -0400
Content-Disposition: inline
In-Reply-To: <1458035482-14905-1-git-send-email-pandy.gao@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>
Cc: u.kleine-koenig@pengutronix.de, linux-i2c@vger.kernel.org, frank.li@nxp.com, fugang.duan@nxp.com


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 15, 2016 at 05:51:22PM +0800, Gao Pan wrote:
> Add i.MX7ULP i2c bus driver which can continue operating
> in stop modes provided an appropriate clock is available.
>=20
> It is also designed for low CPU overhead with DMA offloading
> of FIFO register accesses.
>=20
> Signed-off-by: Gao Pan <pandy.gao@nxp.com>

Since you need to resend anyhow (DT support?), just a few high-level
things.

There is a lot of dev_dbg in here. Some of them are helpful when
developing the driver, but not anymore once the driver is upstream.
Please check for that.

> +static int __init i2c_adap_imx_init(void)
> +{
> +	return platform_driver_register(&i2c_imx7ulp_driver);
> +}
> +subsys_initcall(i2c_adap_imx_init);

I usually don't accept subsys_initcall() for new drivers anymore. It
usually works around problems. Make sure your I2C clients do defer
probing properly.


--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXEq6nAAoJEBQN5MwUoCm217sQAJm/qyMwjwgHEjtNLB/kBUlM
q3mZPH5oEXbDsnPrBEJqY9VGHu4SGMm1YtyHF0RPuH6/jgJgF7QMWIIr5EUKNYaL
iJcxf3ZGRb2iS95VOsgJ1SpHvOwvyVTFYXD4QPmhYt1FSu05asMNPaelFFyRnriR
inzjrd3tWwhh5rNtKl/dKIX0bURd+PC2/t7THR/3jy9JG+t0Vi3jbrtK9G2ddTJp
jonZz8srgbDyOzg0xy/3plRKUAymICszSNaQ6JC0c0XwF9FxN7g6/N+OsRC00M9+
HOsWdSdnG9Fa+YqpCoNO8xZa2zLlU8fGW+p12hA9RHMKT5jQu9C/AqVl3dapXRQ3
zm/6i+rsT58VfQ0OpLni9MRWxloI7cR3QfL2YZ/L0Od2jTYwCSPolvT7cV+6CYLo
kwySFcM6xfRJQUFj/ufEe4mQjfs1hYfc5WAQP8viMh6ml9YewLYr/MHF61OiU2UL
Dtbox2iT4s8PICzbwkK8h/0LuCMxnRNVdFxi/MhtSU0rXMRb2//0LitDVTpFbtrj
i57YS88A1q/WbjNoGayZwLhMW2tSJC2g90BWjHNb9qIhB7MgyqBZ3zgYfYO6qf4t
y3x9Fkg7ntiBnHqsu6t+1THOOb5/udxP2J94vpyUfDV8qK+DCwI68g4ybKwfJWkI
JSwSZcHVSBM5/56LvqvX
=X7B0
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--
