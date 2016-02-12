From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/3] i2c: iproc: Add recovery mechanism in error case
Date: Fri, 12 Feb 2016 22:41:20 +0100
Message-ID: <20160212214120.GA1529@katana>
References: <1455311443-30590-1-git-send-email-ray.jui@broadcom.com>
 <1455311443-30590-2-git-send-email-ray.jui@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from 85.76.238.89.in-addr.arpa.manitu.net ([89.238.76.85]:60717 "EHLO
	pokefinder.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904AbcBLVl1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 12 Feb 2016 16:41:27 -0500
Content-Disposition: inline
In-Reply-To: <1455311443-30590-2-git-send-email-ray.jui@broadcom.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ray Jui <ray.jui@broadcom.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Icarus Chau <ichau@broadcom.com>, Ray Jui <rjui@broadcom.com>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 12, 2016 at 01:10:41PM -0800, Ray Jui wrote:
> From: Ray Jui <rjui@broadcom.com>
>=20
> Add proper recovery mechanism to the iProc I2C driver in error cases
>=20
> Signed-off-by: Icarus Chau <ichau@broadcom.com>
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Tested-by: Icarus Chau <ichau@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Please run checkpatch on your patches. Fixed some whitespace issues and
applied to for-next, thanks!


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWvlF/AAoJEBQN5MwUoCm2B30P/0zZ5WXnOvwJUuoEAGRHcgDj
1tHgs8t1fC+El6BQWB/PSv0oSrvUjQV6bSlnf+ad7UqpOli9v307R7JaOTJDe3aY
XR3ew9pYyynHKVj0TAc6G+ILzfEkx5BtqUbmpe91t1WY1X1wnNwOv64tjuSl1wyg
NjqjURdO541o1nyddQ13RAwQegSr3QPavE9ewgrS86c6EpgjK2phTeLz3zl8+qDU
L0uCyz/rmNYKI9JZCOuCb9TdT+md0YpRHytVfr3wLHvLw8vSq5GJSpQwQVBLss4e
Xn3f2ebuv/rQ4O4ZCGrtufJuhUvKhbdrNKd8hUTawVpdvOF45enksiVXozMDUUW4
l72cgxS17BWOS/uCmS0+t7Fx/35yT0h8LmJNhunTnE2qUxCJG5n6DtFEpfdQOONB
Lslc2B8TAIeoj7ek1jvcE59yXltfHrxGukkO9TGvQl7WdDuhpZc9KvGtuU3yoyOc
5LhUcw1TAIDvGv/w4vhM3ZOEyE4Kf6x97QVRhppFYhsCjS/Cp24Bqzm616YMPwLi
Ly92GuPPTVnlB5Ce6RpU3/brEbFjilLn7Utebus3fJ33LRI0GD2UumdJdUPmRlX5
kXH9FiiyL9ZgC/GvlpwI6WKqH2Ih3TeDU+It9Gh3YwC16xM0snKH02UQI/lPwlKs
N3udQVCUH5fBx9HT3NN6
=ix4H
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
