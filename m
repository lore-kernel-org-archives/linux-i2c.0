From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PULL REQUEST] i2c for 3.13
Date: Wed, 15 Jan 2014 13:26:49 +0100
Message-ID: <20140115122635.GA4004@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

please pull this bugfix for the i2c subsystem for 3.13.

Thanks,

   Wolfram


The following changes since commit 7e22e91102c6b9df7c4ae2168910e19d2bb14cd6:

  Linux 3.13-rc8 (2014-01-12 17:04:18 +0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

for you to fetch changes up to 2fac2b891f287691c27ee8d2eeecf39571b27fea:

  i2c: Re-instate body of i2c_parent_is_i2c_adapter() (2014-01-14 17:11:13 +0100)

----------------------------------------------------------------
Stephen Warren (1):
      i2c: Re-instate body of i2c_parent_is_i2c_adapter()

 include/linux/i2c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS1n57AAoJEBQN5MwUoCm2xGgP/jih9lYi1LQSB7WStvaLH3bB
jxnNRCu9o9o3j6iNUkow9BfVbm9qwQiFqp+mxAfimEP1kI+fAi5tsA/BnU7FrW+T
3FRRhaIcYdBj4MaGwc4xiDuni2xb/bSiTVGxLw8jIcCJZeADTrbBqPjZJTFVSHG2
HROZqIr+RUbaO8hvKc4d43mnH+nza9P+nHcH1FThMt0S39xuiv61kaKpq19TyP8D
PpY3Xsai0eWmsJo+5+1TV9XisnOm87NNgdBF+O7DXtk1q5khVDIprKvfub5hjYkG
F1kQciKcH1F8C8pyBkUink2Upx9vsEE6XmPooCXqpfoJKBxSci2+6jNmHZOkvdmQ
YEfr0jy/Zfgmbo3xFAWPHklczULGBOkGNeh5Pp4ehI17cFQCatRhPXl9UIe8Ryfp
D327eDB/d/7Ob5xaGNdyF8g+gJKOP6NL0fg1XvCznw8m6z6a6L4vEbnaZ7WnIsLo
Adw8fmkCLtZasjCb5JJ1qPKPzvfv+tx/J1u29jbi+uxFjBxKtcQlQcSMKPSeth8u
P6mBiQbAxy/h0bfQadit+ODFiBxz2SS82gB0HczEfpyXBD10yDwql4TJQa3PwYFp
Wv6/WM+rvNfvBJb/62+UbAOrKljTckk6nyVcBFfUFvAKUtUNs5+DTNDrGLaxn/qN
/y9NSO4nGo6j5TjEwIMU
=RbvI
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
