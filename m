From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.7
Date: Fri, 27 May 2016 22:59:17 +0200
Message-ID: <20160527205914.GA1987@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

here is the second pull request from I2C for this merge window:

* one new feature (which nearly fell through the cracks): i2c-dev does now
  use the cdev API so it can handle >256 minors. Seems people do need
  that.
* two fixes for the just added DMA feature for i2c-rcar
* some typo fixes

Please pull. Thanks,

   Wolfram


The following changes since commit ea8ea737c46cffa5d0ee74309f81e55a7e5e9c2a:

  Merge tag 'nfs-for-4.7-1' of git://git.linux-nfs.org/projects/anna/linux-=
nfs (2016-05-26 10:33:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

for you to fetch changes up to 72a71f869c95dc11b73f09fe18c593d4a0618c3f:

  i2c: dev: don't start function name with 'return' (2016-05-27 13:13:01 +0=
200)

----------------------------------------------------------------
Erico Nunes (1):
      i2c: dev: switch from register_chrdev to cdev API

Geert Uytterhoeven (1):
      i2c: rcar: should depend on HAS_DMA

Ludovic Desroches (1):
      i2c: at91: change log when dma configuration fails

Marc Gonzalez (1):
      i2c: xlr: rename ARCH_TANGOX to ARCH_TANGO

Moritz Fischer (1):
      misc: at24: Fix typo in at24 header file

Niklas S=C3=B6derlund (1):
      i2c: rcar: use dma_request_chan()

Wolfram Sang (1):
      i2c: dev: don't start function name with 'return'

 drivers/i2c/busses/Kconfig         |  3 ++-
 drivers/i2c/busses/i2c-at91.c      |  2 +-
 drivers/i2c/busses/i2c-rcar.c      |  2 +-
 drivers/i2c/i2c-dev.c              | 25 ++++++++++++++++++-------
 include/linux/platform_data/at24.h |  2 +-
 5 files changed, 23 insertions(+), 11 deletions(-)

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXSLUiAAoJEBQN5MwUoCm267oQALSCtPK+RbCCy3SSp8BgYvQk
qdOwOJYOjMoNZmMfR2nAVde3dRaw1ikDZhSHVlF+rmV8Y/nOzT/nAL2ZhV7xKUTh
ju1lBotGmPNtpyIHjgrnJ7amytEQt3LLDNluaMmDPdzzPWJcJsXQSytcu+fWE22+
QwW8UrnYoqgqN2J7+6esFyvHqb2GjpkBpfMTEeOWHXW3Q9N5iyx8pX0u2WFBUDFM
OS5pu5ApHXwbcPgnPctQ4BOnKWM4m+sE9LaXv1RCOSgf+ZDMLnPvlY0jb+65oW2z
pd3FQxgdfDjQ7/FyiTZsYTZ73By0bqpauIiJX+vnXIPx3eo80NX0+isMSZe5u2/Q
7iGPsKOu5Vttbla2AsZpP+pH8skt+YTIk83Mfc+oyIhqKB4ZBTw7g4pdL7nHPXPC
EBQKwHXzAoJCqHG5KY46cqNt9FRJV8IupZ+ITy9DObH/f34RXQVKkPFhMlcvBTgT
+j480qyuPhAdlfmZnnTgreaaSp/NisGyQ/lo6OGp4AKpPYStLcksgE6syZMbA7Qc
KNjC1hKbb9jPDMNuzrzjmNHIAirAr/J0cvhoIz1+S76nLhfdwDgDPAtkiFcBAo/n
TT99ovnC+SgMjQqkIo6mzYgPy/L4JXeGTkkugHxLZK8vwST8yvMGdCOZtleRsaBp
iHZOXAPDWCqYXRXOa9SV
=mQ+8
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
