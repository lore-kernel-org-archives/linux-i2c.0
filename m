From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PULL REQUEST] i2c for 4.0
Date: Thu, 12 Mar 2015 17:26:42 +0100
Message-ID: <20150312162637.GA26978@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is an important bugfix for the I2C subsystem core. Please pull.

Thanks,

   Wolfram


The following changes since commit 9eccca0843205f87c00404b663188b88eb248051:

  Linux 4.0-rc3 (2015-03-08 16:09:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to a49445727014216703a3c28ccee4cef36d41571e:

  Revert "i2c: core: Dispose OF IRQ mapping at client removal time" (2015-03-12 10:23:05 +0100)

----------------------------------------------------------------
Jakub Kicinski (1):
      Revert "i2c: core: Dispose OF IRQ mapping at client removal time"

 drivers/i2c/i2c-core.c | 3 ---
 1 file changed, 3 deletions(-)

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAb49AAoJEBQN5MwUoCm2FiYQAKnnVgWf5GLVuTw6gFLZG6oF
JKQrjY5XcRlOpv5abbNnrANMNA4ZzXaOpZKgB+cOIOzreSh8gEfwcKv2GZv8ccTr
1nljBBCFmo8+jnawehIbAlBwci7oLwSHCnwjUD/bon/BnWaA/V+9IQPKI+gGJJua
BzFA2rTbxlgwmwtMlhu0dO7spvrG85q1oQ6XrhfGMhXElp82uAFqEq9W1zIIK+N6
z+KKyz8MGv7VLXnNwEQbZRxDRK/6vjHRSNCnV7UkfVktc1h8p1Vr2P9c1pINlSh6
gcwwSEB0ONwbIJ0dXMp92rvbmrTmQIOE/DOmfUcRpJtrRlkI5YRVa8TDJOYlIHDY
S/wS4wEwOPwxU1MUW43uiULisazmItHggL7CuWgduloO6hHGIKR+yTvZy5JTnz20
3WfHmdkP8tG14nHC2m4mNVzu6W6sI26K8MxnwjvhWdoFRDzt4Z6FJqPduv/BbUI9
SdiSLSicM0UJuubsdw1mJ+GrSzInOskkMiQVdpgOuNHVHMxKpYjrmXU10BK434Hd
c7mAe4RedV886w0chTvB2C47rpmvROqMNESyb01enmS+LTDw7txs0bv72Tf/PSTE
G6qv3xlkaFNbV0DJrRzKqEFfeUSCDMXoIM6KKGTsMmmmFlwrm7VYWFXvIGVqMv4b
oQV1Rk+w76zx9DVWMfZe
=S9iQ
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
