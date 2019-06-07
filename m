From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] regmap: add i3c bus support
Date: Fri, 7 Jun 2019 13:25:08 +0100
Message-ID: <20190607122508.GG2456@sirena.org.uk>
References: <cover.1559831663.git.vitor.soares@synopsys.com>
 <ff5e96bdd6b2789122afe1980bb20cfa22900760.1559831663.git.vitor.soares@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V+NFTlk1jviwRvZ9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ff5e96bdd6b2789122afe1980bb20cfa22900760.1559831663.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitor Soares <Vitor.Soares@synopsys.com>
Cc: linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, bbrezillon@kernel.org, Joao.Pinto@synopsys.com, lorenzo.bianconi83@gmail.com
List-Id: linux-i2c@vger.kernel.org


--V+NFTlk1jviwRvZ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2019 at 05:12:02PM +0200, Vitor Soares wrote:
> Add basic support for i3c bus.
> This is a simple implementation that only give support
> for SDR Read and Write commands.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-i3c

for you to fetch changes up to 6445500b43129baac36c56d629cf1dd9e1104167:

  regmap: add i3c bus support (2019-06-07 13:09:55 +0100)

----------------------------------------------------------------
regmap: Add I3C bus support

----------------------------------------------------------------
Vitor Soares (1):
      regmap: add i3c bus support

 drivers/base/regmap/Kconfig      |  6 +++-
 drivers/base/regmap/Makefile     |  1 +
 drivers/base/regmap/regmap-i3c.c | 60 ++++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h           | 20 ++++++++++++++
 4 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-i3c.c

--V+NFTlk1jviwRvZ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz6V58ACgkQJNaLcl1U
h9Bgrwf/RXFqk+t+LK0ZAHmeClzyFdvIjZIVL4GILktZ8eCNYn2qztVNFZFCen7N
w6a1vXa3vIwsMEKzreQRjalsBa/8GwnKtnXfJNKME9CVnuK9W9QYxSEocYRvllWk
ZqNj1fYGVsaGDxQ8KQAWZIP3bCF5z/aEZF3F2P+F29OuFVXuyER25r6IojVWO6mx
6ZQySCocUFPeEWj0iin552BqmHTsOjfzUaBz9SIJAjfkxRY8vsROqKcSAfO4dqDV
ZDLAqtE+b8mTsHPDjaEpJXN+rWZtwEahCgAUEBHLgYbAFPhnxwou+LhDv5zMZAYN
iCswU76fTiqPiH3IkR1gE2AN+IExXA==
=gpGF
-----END PGP SIGNATURE-----

--V+NFTlk1jviwRvZ9--
