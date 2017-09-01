From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.13
Date: Fri, 1 Sep 2017 23:40:14 +0200
Message-ID: <20170901214009.o6co5thathhxhifh@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="apla4bt75ozldw27"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:58232 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752400AbdIAVkR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 1 Sep 2017 17:40:17 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--apla4bt75ozldw27
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

I2C has two bugfixes for you: the ismt driver had a problem with a rarely
used transaction type and the designware driver was made even more
robust against non standard ACPI tables.

Please pull.

Thanks,

   Wolfram


The following changes since commit cc4a41fe5541a73019a864883297bd5043aa6d98:

  Linux 4.13-rc7 (2017-08-27 17:20:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 231d069fcde22bd0582c2c9564f1b334d280c7d7:

  i2c: designware: Round down ACPI provided clk to nearest supported clk (2017-08-31 20:27:39 +0200)

----------------------------------------------------------------
Hans de Goede (1):
      i2c: designware: Round down ACPI provided clk to nearest supported clk

Stephen Douthit (2):
      i2c: ismt: Don't duplicate the receive length for block reads
      i2c: ismt: Return EMSGSIZE for block reads with bogus length


with much appreciated quality assurance from
----------------------------------------------------------------
Dan Priamo (2):
      (Test) i2c: ismt: Return EMSGSIZE for block reads with bogus length
      (Test) i2c: ismt: Don't duplicate the receive length for block reads

 drivers/i2c/busses/i2c-designware-platdrv.c | 16 ++++++++++++----
 drivers/i2c/busses/i2c-ismt.c               |  6 ++++--
 2 files changed, 16 insertions(+), 6 deletions(-)

--apla4bt75ozldw27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmp07UACgkQFA3kzBSg
KbYhVA//TO6AhMuCa5Z/4oF9INt80UX6B8NSP+twr+RlMN+C66HpG9kvZqoYDTYv
HOJvW5O/Yaus+6EcDHB9+wtRJXCZlbXDPJUrvCW0CGRp8as4SjMmZ3cejs2VwNu9
OEhWB/7sGcjyv47M8o/KhVfdA4TG5Y2T0U6sl8gM0jLycmiUo7tnBRbgP+PpJnFr
4EoB3L91/18gNfR/Qn4FpmQ707Ue6ta+FCcgZhiHGKR7gmDWhGnNiRW/clGqVdMq
s9XR6cgrO1dy5tFFZo4L/s4wjF926oAsW2fD7QCqExikxQN5Mu8gmi9ybEIWNUlB
6k1dj6BHBeNBM7Q+yf3nOaGm82MSWoKgUgNYUkGfBiqVPc0TaCz9c6LMzeTrQOot
Lvvy0gdG787qnxLiaGNucVi3rSDhcyVpTp7hwFKkJkXhgvwpcVTq5/p1X3c7nAd2
B5co5Xk8xhAHKY7/YgHyRS8DBUMEiauSvrP8WSRl0APeielrZ3robFMnlitY5inX
aUfKkPgH+NaFS8j/B5sPpI9ptq2rjWDL1uHvNTu6gabqKp+NvHKygmQCDwkWojtY
91Qnv01rjbz90dmPDECyttppub42SyoxcrBGmklRkNeH4fCzeKuQe9b2v//Cvb24
vLoo3d0bJTTQlyRzbH8/K0wmq4/ZSQSo+NkiFzhebp8VyCAdDJo=
=gKr0
-----END PGP SIGNATURE-----

--apla4bt75ozldw27--
