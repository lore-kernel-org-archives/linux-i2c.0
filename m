From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.19
Date: Fri, 7 Sep 2018 21:55:14 +0200
Message-ID: <20180907195510.GA1561@kunai>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has for you:

* bugfixes for uniphier, i801, and xiic drivers
* ID removal (never produced) for imx
* one MAINTAINER addition

Please pull.

Thanks,

   Wolfram


The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to da4dfaf8428d9f71e2ac4f736bacb81adab36504:

  i2c: xiic: Record xilinx i2c with Zynq fragment (2018-09-07 13:04:45 +0200)

----------------------------------------------------------------
Fabio Estevam (2):
      dt-bindings: imx-lpi2c: Remove mx8dv compatible entry
      i2c: imx-lpi2c: Remove mx8dv compatible entry

Felipe Balbi (1):
      i2c: i801: fix DNV's SMBCTRL register offset

Masahiro Yamada (2):
      i2c: uniphier: issue STOP only for last message or I2C_M_STOP
      i2c: uniphier-f: issue STOP only for last message or I2C_M_STOP

Michal Simek (1):
      i2c: xiic: Record xilinx i2c with Zynq fragment

Shubhrajyoti Datta (1):
      i2c: xiic: Make the start and the byte count write atomic


with much appreciated quality assurance from
----------------------------------------------------------------
Jean Delvare (1):
      (Rev.) i2c: i801: fix DNV's SMBCTRL register offset

 Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt | 3 +--
 MAINTAINERS                                             | 1 +
 drivers/i2c/busses/i2c-i801.c                           | 7 ++++++-
 drivers/i2c/busses/i2c-imx-lpi2c.c                      | 1 -
 drivers/i2c/busses/i2c-uniphier-f.c                     | 7 ++-----
 drivers/i2c/busses/i2c-uniphier.c                       | 7 ++-----
 drivers/i2c/busses/i2c-xiic.c                           | 4 ++++
 7 files changed, 16 insertions(+), 14 deletions(-)

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluS15oACgkQFA3kzBSg
KbYlKhAAjhxSklpQf1qvX7VacL7zvMxs6WpM4uO8knElyDRzDk8OXBT13B21UhwW
wXJnMaR5YYfdYASi5Zhuxf/drwaqwU25H+nlkvKwJ6RdeFh8D+Ws2zM3+cKMoNYy
kZ1iJjzr9+O/xOiYeyfKEUba1bD9BlpFhdy1sx8+AV0hN6WI6dEBskTPC7hH96xw
FT2BZvUie2oWIdId48jbBKzaj32zhd+pmtIn29tYSBWR9hA7mfDm6V4LIlQq9AJs
bka4CO57kDXyRRue0A8TU48P/D+LMP8LHi49HSfQTNpsPgd1yECPU0jsunDmfQN7
zzeZAlBY4ExfUY/DQ5mV9L7gncPRAXVX9nfKdqZYObBRWxqEcpP4fiJTQBOIicj3
ztWuie68wQ7FqAQo40uJ189fJgn51w0nmpSiCgPlhspQSiGwpLorZk3+fQfIYlR3
v3Y8LoeQ0md+wNRV9JenkkzCXZuCh5gtuR3DcD5ZaN56l0Wjgj1+X1Cc48btE7jF
FmH3f854ZJ8nvm3bxTxIzcKxRaQe7B58uvsHr0cUWwL7CAPlrtDjL9BJr+w4Oym7
Bmfh0DNSObhPmlWe1RRYWejRELgDbGzy0gVN4pLDcEtIeJSNLp7V0wxBRkmmlCpw
wfLsIUsQHVk4kTcaHXRll0SYHEMIPdjbkIU79zpxIBx5uwSNv+0=
=+Rf3
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
