From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
Date: Thu, 11 Sep 2014 16:40:04 +0200
Message-ID: <20140911144003.GD5149@katana>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <1410274470-12712-5-git-send-email-wsa@the-dreams.de>
 <16809905.2REViph6WO@fb07-iapwap2>
 <20140911141257.GC5149@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140911141257.GC5149@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Marc Dietrich <marvin24@gmx.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Delvare <jdelvare@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Andrey Danin <danindrey@mail.ru>, devicetree@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-i2c@vger.kernel.org


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> b) could be seen as a configuration thing since the functionality
> backend could be changed at runtime even.

Come to think of it, not only the functionality, also the address can be
changed at runtime. This makes me think it should really not be in DT
after all.

People will probably find out that it is possible to put it in DT, but
it should not be encouraged and they should do it on their own risk.


--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUEbRDAAoJEBQN5MwUoCm2mroP/0w8jSiJeqad3OmegQK25LKo
a1N8zRgevYUcE1Znr0arnSaEjxLEc4dOBJikTOvwor9Lq2KTdHzXFdneR85JEQVf
R0lrMazJq8N5jSFBea+8Xp8PfMnZqRoazgMTB63vWIzSXBPNRuV6aL+VJwh2Onue
I9yuc2VbwWXbQ4zvYVNvln/NUP0tqFbTaspZH6m+mxPi/st45gKO+6/i6Auw2sYO
2+DlIX3Yk4tG9EdV4dcAGA4fjXWoIqqhn1oboSYGLnHg22a371NcmpAlKp6iCLpn
uyX/MFaNmzK9VNkZA9XqF9/K5NFWKRC/GyC9v7Gv5xrWMLFuua+0jGx2cJcCK01G
doNoML0+lO1R5xlIYMVeH9ypewgX4dJmdbTPx3aj40iP6DgsUrIPZlqL5LSpkomq
WA4AgKOuHFMav6B4q2KrlAmUbUCwJmJNOv67wodeVy09nBhzLwX+0aOkFTWfs2FD
QFhRMq4REH/K5zDvGYXCe4iSOS3i1pAINAX3apRYvgccKTeYvVr9wzNm0kiN7PHz
4AEalIPkXMT0LTrLeJ+59+1bHtMrlChpn0XNgBak0LNC2YEMM2arQREHeNSWbDqv
XSx1yL8fzTmLv5ij3TJvIGiiWTQqtHTKVc2VlbIICwTyK58hflzQNoDT9zzUS7k6
++g/e9WN7nBYmFYDvQ4+
=0xK1
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
