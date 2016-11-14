From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: mux: fix up dependencies
Date: Mon, 14 Nov 2016 18:24:10 +0100
Message-ID: <20161114172410.GA19028@katana>
References: <1479134057-30653-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50400 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752158AbcKNRYS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Nov 2016 12:24:18 -0500
Content-Disposition: inline
In-Reply-To: <1479134057-30653-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-i2c@vger.kernel.org, stable@vger.kernel.org, Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Peter Rosin <peda@axentia.se>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2016 at 03:34:17PM +0100, Linus Walleij wrote:
> We get the following build error from UM Linux after adding
> an entry to drivers/iio/gyro/Kconfig that issues "select I2C_MUX":
>=20
> ERROR: "devm_ioremap_resource"
>    [drivers/i2c/muxes/i2c-mux-reg.ko] undefined!
> ERROR: "of_address_to_resource"
>    [drivers/i2c/muxes/i2c-mux-reg.ko] undefined!
>=20
> It appears that the I2C mux core code depends on HAS_IOMEM
> for historical reasons, while CONFIG_I2C_MUX_REG does *not*
> have a direct dependency on HAS_IOMEM.
>=20
> This creates a situation where a allyesconfig or allmodconfig
> for UM Linux will select I2C_MUX, and will implicitly enable
> I2C_MUX_REG as well, and the compilation will fail for the
> register driver.
>=20
> Fix this up by making I2C_MUX_REG depend on HAS_IOMEM and
> removing the dependency from I2C_MUX.
>=20
> Cc: stable@vger.kernel.org
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Reported-by: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
> Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to for-current, thanks!


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYKfM6AAoJEBQN5MwUoCm2t0UQAKI2kpLofNKNLnzeJ4Ua8dAa
tQYNVcJWY2YWCqGcllU4+PYJrpnznsEwo4+pXz1PZ7hLlm8dRceGPjVUhMn7Wlqd
bXhAeha6jWZGzrh6b8HSRf/oE/3zly6peXeHrJTOYXdRqLt/o2mhicBK8zjexAPO
HEH5cTauxX+Ds6UO/tKtUXuKmzjPd9fxApx5t1jsNq2O56vwV5DHyyie0TUYDHgo
ciR80LLks0agQ6nLjqHG6nCh+l75953aQ4hi1nejZCDNLQZxOKpdqIaBixvWo4dp
fnhvr6XNWdrMUW/vXafaHxD0t6CSdWDAZpd6aYp8jwLFuYtyPUVHwFoMmsWWgiLZ
PM+xhxSAKpvl51xfaem65/GnKx6XeBvjS17KnoAI1m90K4ejX89H0DyPbEWscZIT
sSM1rTHpxMxsum7QBH6tUT+F3e3W+eLuowVQ4Kk2M/peKbA9N1i4UkAS522Ut12D
8vwLTc7MILqhvmRPKLX6ZtlMywXyprkAoqsgwgLuLoGgx/fC4wu3qC33vanNmcNf
HAhitq6VMse0zGMJDbQu02EDVJsyGitDeCx0QDoOsExM9Tdau0nvEglI/v0x/gHh
d/9zCjGRb4huv1QPKJb3xRHyQiQpByGjgDxuX8Cruvgaq3wKttYndNK1p4NjzJ4D
nQpPNvbjzpj2IPjFZGKu
=/GWY
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
