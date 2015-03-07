From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 4.0
Date: Sat, 7 Mar 2015 19:14:54 +0100
Message-ID: <20150307181449.GA3371@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a set of updates and bugfixes for the new designware-baytrail
driver. And a documentation bugfix.

Please pull.

Thanks,

   Wolfram


The following changes since commit 13a7a6ac0a11197edcd0f756a035f472b42cdf8b:

  Linux 4.0-rc2 (2015-03-03 09:04:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 5d232112f94b0f3920dc4fec09688ef6cb5c09df:

  i2c: imx: add required clocks property to binding (2015-03-07 01:13:00 +0100)

----------------------------------------------------------------
Andy Shevchenko (5):
      i2c: designware-baytrail: describe magic numbers
      i2c: designware-baytrail: fix typo in error path
      i2c: designware-baytrail: fix sparse warnings
      i2c: designware-baytrail: cross-check lock functions
      i2c: designware-baytrail: baytrail_i2c_acquire() might sleep

Matt Porter (1):
      i2c: imx: add required clocks property to binding

 Documentation/devicetree/bindings/i2c/i2c-imx.txt |  1 +
 drivers/i2c/busses/i2c-designware-baytrail.c      | 40 ++++++++++++-----------
 2 files changed, 22 insertions(+), 19 deletions(-)

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU+0AZAAoJEBQN5MwUoCm27wcP/RX2ohAibQXVNtuUdjrneYsU
pZCOYc2bVtYOVGKHThllB4ncrz8gabQ9re/3h0h7BKh66zPtJq5XMryWIMvOytSZ
T9Mp/MVNgjyUriPXYTjV508qKu7bxyvVYAyqvLIEpES9hJH8d7A7bs9hULNT8ISL
lm2qbs7QBrNehvGBZbDApUS6a1NIJQ+FjbCS+y7yNyskwmNfA/QZ0r6N+N6/5lAW
wgghlPAO+BpGPsYdZdbbbEV2qGFz0T7AQqcXotXl3ZxN4tJMTZW/Y5mXepdp2QUY
WgL55iH/YqP9Ayb8m34LiL9yECc1nXOTD1h+O/qlsx5UPJ1GPgS2v2x8NH1g1BzM
snzi4QX0dR19soA7iv6UFt7aHWn9TNdcAn0ML1HnWH9KYcK4TJGyCCPH6QnnYiL1
pSYxvkT3Mv+AJ4W0SN00keaQMQmjES4qAQ8URGYhweTAyKmarMTjG6dyMt4tTOd5
34ElAOTuHC5af9pN80le6wayOp2/qjdjMr9nH5vZ74YX9KQPH8MgdnDdbu20JjK1
V0+UdrrOl7hiuFMg38y9lVu8Pw/8Gp2gHbed6R/jqZPiZSrpwfPvAHc9O+CSh6yM
eVGyIWiwyUOlaZS7xGgZek9zK1IOvCdex+GOVpb6RzcXA7B8tzb1AXCcoK5AJFtq
DhWRdF68t5vpnw59TE7y
=lPif
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
