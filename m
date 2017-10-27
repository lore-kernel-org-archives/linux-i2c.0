From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c/cht-wc-fusb302-immutable branch for v4.15
Date: Fri, 27 Oct 2017 21:35:51 +0200
Message-ID: <20171027193546.x5wccdcd7kq3faa6@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ufwmqlvn7p3fmkzf"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-i2c@vger.kernel.org


--ufwmqlvn7p3fmkzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

as discussed before, here is the immutable branch for the i2c-cht-wc
driver, so you can safely apply Hans' patch "[PATCH resend v5 3/3]
platform/x86: intel_cht_int33fe: Update fusb302 type string, add
properties" [1] on top of this.

Thanks,

   Wolfram

[1] http://patchwork.ozlabs.org/patch/824314/


The following changes since commit bb176f67090ca54869fc1262c913aa69d2ede070:

  Linux 4.14-rc6 (2017-10-23 06:49:47 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/cht-wc-fusb302-immutable

for you to fetch changes up to 0224d45c9d46401b6d7018a96cfe049c5da7d91c:

  i2c-cht-wc: Add device-properties for fusb302 integration (2017-10-27 15:51:51 +0200)

----------------------------------------------------------------
Hans de Goede (2):
      i2c: Allow overriding dev_name through board_info
      i2c-cht-wc: Add device-properties for fusb302 integration

 drivers/i2c/busses/Kconfig      |  5 ++++
 drivers/i2c/busses/i2c-cht-wc.c | 51 +++++++++++++++++++++++++++++++++++------
 drivers/i2c/i2c-core-base.c     | 10 ++++++--
 include/linux/i2c.h             |  2 ++
 4 files changed, 59 insertions(+), 9 deletions(-)

--ufwmqlvn7p3fmkzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnzipIACgkQFA3kzBSg
KbZjEhAAo2IslrbeXykt87qA5+GLkbUyKGGLi+JIT6jfmt/wVYICUXsm0FRoLhSI
fz8ZDxmkip7u+VNy+awvHg36hnTXq2/TLQ7nMFwLw81CPpnMOrH0Lm/YoeZHbW9g
c+PEOBm0+QfRIc81Dk5X4/Vz19X++JvrJDPlJ9/YngLO8aeatQjJamr9ED0cGkZC
qaOGhUAOzgDureenY0ovNQdTknTr745uAcB09FSos1z2duG99pG5vh6RF1PjJWeX
E6WRqV7fySr9WohRhhOPPfS1QfsFrGTKALlYloVc1fGd4Bl+1/aRouL0fTaPzv7r
Z3Kxk5ZHFENjMi1CPETkjtIBARJ8ljsHYeEjWZBdfgmh2maCtFldycHv4qag5D75
ekM6sesItgFYhOgfEVt7qsq0e6ChrEZYWrLcRnzucoVQY3U+GfVvpvocSUf8uGwB
1UldsL+BKmplNpi4/ynIgli7X9VoJZxtgBHMfwX1rfc5XHdM8UpgBXSwq9mhXNZq
sLygaMG6kDRNPGa44ah2vw2aYLAhpi4KSVNi6+UFzW1Qzflh6LRS4Rs31DPgd0BQ
RdalNtD8Tlrmnz+r5DqgCKAhs32E0dsUm1Fk0MmhNK9sNru1sCvQVsjubaHs2LJ2
QWoIUDUPEK/XW/aILDYRFKPCa19bi1+t9778Kd4a+/JO5JDJ3bQ=
=lZcy
-----END PGP SIGNATURE-----

--ufwmqlvn7p3fmkzf--
