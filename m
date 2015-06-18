From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 4.1
Date: Thu, 18 Jun 2015 17:23:48 +0200
Message-ID: <20150618152344.GA1684@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a small documentation fix for I2C. We already had a user who
unsuccessfully tried to get the new slave framework running with the
currently broken example. So, before this happens again, I'd like to
have this how-to-use section fixed for 4.1 already. So that no more
hacking time is wasted.

Please pull.

Thanks,

   Wolfram


The following changes since commit 0f57d86787d8b1076ea8f9cbdddda2a46d534a27:

  Linux 4.1-rc8 (2015-06-14 15:51:10 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 8366610283d08564f65a1af2ec8458df08418727:

  i2c: slave: fix the example how to instantiate from userspace (2015-06-17 14:16:27 +0200)

----------------------------------------------------------------
Wolfram Sang (1):
      i2c: slave: fix the example how to instantiate from userspace

 Documentation/i2c/slave-interface | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVguKAAAoJEBQN5MwUoCm2974P/1JrKSKs6UnojEPG2WlKYHTy
/nKa+Bw0YVG4ceI0KTA6s9KcTxmQcEvHKhVq5OTuX4KKJXu2pnGNnzfgzKoUoLXj
yknmj9IHR+QD6lNgl6In11gMcXonVxtEJDUzLDdA1tqDwFVRzTXPGNXaO6IPsfDt
850fKBTY8R9C7extt8tgQJwrgcSkyegrU16MW2Q9K4Irkn8MyuISgPIhgDQfC4P5
k4gZT6E+9dmDYtAhIsHFklqLXYpWZ3fjeLXNQH428Q4yAe7qnSoUFzWtXFsoSwcY
Bb7FRSZ1dvuRAkbshCRs6yJuVh9x/Qczfdk757vCPvZ1qpVC3ZBBQ+Njbyb0JDI9
4CAEwJzNFlPpGBWxHLEMMh+1mEerLe4AWbyY5qmuhEMtD+OjzLxUQuMOXDmLSX/J
CyA7Eey9P5b+8xiQZmSwVTJPPKhxqxCE06eAvVAwKEKzC5eI/ScaKbU+MbmL8JSE
uCLV9yiFjaPeQt1TGrg19JEZexF1GqNakGQvlMieS0JNJZ1QIwwTOxRJwL20iKdI
p1u9oJ1gsdxMDCtUAizxEjvwFyUdGbZj5N5eF2keGV8yqHT0g2CSnNgohdOPOx1G
uZehki3Xa92PPeCAADkP7SM4CKkQgaStLvL5UhYR0Z6rU2tRC3IiQ+GqtWqY0cln
y/xSJat3zW7cUTXNqwZ0
=BScp
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
