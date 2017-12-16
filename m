From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.15
Date: Sat, 16 Dec 2017 17:52:18 +0100
Message-ID: <20171216165214.qrd75nivc2lz3qep@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cdvdmgdzpjxmpcoh"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60512 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752746AbdLPQwW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 16 Dec 2017 11:52:22 -0500
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>


--cdvdmgdzpjxmpcoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here are two bugfixes for the AT24 I2C eeprom driver and some minor
corrections for I2C bus drivers.

Please pull.

Thanks,

   Wolfram


The following changes since commit ae64f9bd1d3621b5e60d7363bc20afb46aede215:

  Linux 4.15-rc2 (2017-12-03 11:01:47 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 45fd4470ba86e9ca2837b666a52cc65dc69f0fa3:

  i2c: piix4: Fix port number check on release (2017-12-12 23:27:04 +0100)

----------------------------------------------------------------
Arvind Yadav (1):
      i2c-cht-wc: constify platform_device_id

Benjamin Gaignard (1):
      i2c: stm32: Fix copyrights

David Lechner (1):
      eeprom: at24: change nvmem stride to 1

Jean Delvare (1):
      i2c: piix4: Fix port number check on release

Sakari Ailus (1):
      eeprom: at24: fix I2C device selection for runtime PM

Wolfram Sang (1):
      Merge tag 'at24-4.15-rc3-fixes-for-wolfram' of git://git.kernel.org/.../brgl/linux into i2c/for-current

 drivers/i2c/busses/i2c-cht-wc.c  |  2 +-
 drivers/i2c/busses/i2c-piix4.c   |  2 +-
 drivers/i2c/busses/i2c-stm32.h   |  3 ++-
 drivers/i2c/busses/i2c-stm32f4.c |  3 ++-
 drivers/i2c/busses/i2c-stm32f7.c |  3 ++-
 drivers/misc/eeprom/at24.c       | 26 +++++++++++---------------
 6 files changed, 19 insertions(+), 20 deletions(-)

--cdvdmgdzpjxmpcoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlo1TzoACgkQFA3kzBSg
KbaMKA//c2RKO2ksBJvOTZYrjGQFN4JBUfUZyVSAYsiM0uLUDOlrkNG/VFWdhvP1
1A/mbsJNwpyNFCztPM8nR3X1Dvmm9bJ8hhFBqwqmL1kuPS+aIdyU67jqn+Rf+wyn
eygcfYUINBezuuvPUshuwgp8Qci8hDZFxyMAwf5jOHODPUhjFEV1AQCu6mRiQS7L
N9SUdr3R5+c4QXHhY3jxpZZp28ilnRaO8MIoF5UTeF7m7y2pcaThuAelrZr+9mUu
NfnTGvtpTzPgLoCiajmHhyqRiRNn6Z01PgBJqwEuwUTRmwSs8Qsl4yeoDYDfyl6j
6WXJHdYMv8yNm9zDz3hHZREZHQwoLsxdAflQ0J3KLHe+Ply2dreLV4fxQ4eBVTMi
wcwsMHc6RH9C0uTqzv4Ga3nkUvhr8f8wkbesQGSXxF9d4y7k5pzI6qw/wxaHNzf3
Rx7dw/aDdog9OoEeoGUdFP+b9DeCRLr0AZRqWf9w0asT72MUdKH/QYpCQH70niDw
uw3j/MURAWabGv1LjOrPukRDZWDOS2yvF60dmVjoKw8OG2NYit9yGWLrfLHZIi+B
8XgNQWNXGo3/5jGE3JXp8AOEFh+7zajlGquBYRa+4gSWR6P+bHWd0zIUHnkAwSln
MiKNrd2W7LRf6JHJ9tHNc9+vHhZdWF8NdTokmZFv7+4OSwnIV20=
=Z5KD
-----END PGP SIGNATURE-----

--cdvdmgdzpjxmpcoh--
