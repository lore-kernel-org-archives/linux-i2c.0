From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/5] i2c: octeon,thunderx: Fix set SCL recovery function
Date: Wed, 21 Sep 2016 23:00:18 +0200
Message-ID: <20160921210018.GD1513@katana>
References: <cover.1474439371.git.jglauber@cavium.com>
 <cea4dddccc4f24d90c3783159c5236d6124facf0.1474439371.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46652 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933582AbcIUVAZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 21 Sep 2016 17:00:25 -0400
Content-Disposition: inline
In-Reply-To: <cea4dddccc4f24d90c3783159c5236d6124facf0.1474439371.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Dmitry Bazhenov <dmitry.bazhenov@auriga.com>


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2016 at 08:51:02AM +0200, Jan Glauber wrote:
> From: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
>=20
> The set SCL recovery function unconditionally pulls the SCL line low.
> Only pull SCL line low according to val parameter.
>=20
> Signed-off-by: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> [Changed commit message]

Applied to for-next, thanks!

Minor nit: please only use "octeon:" if you change octeon-core.


--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4vTiAAoJEBQN5MwUoCm2tHAP/j9ByQavP2XPY8VkUdtVEds2
EVu4twhDu7U6ILbIJKzkSBSTEpt3HJhW5qI6FL/YmtS765VTrr3J3C6qf8MRDUsa
Q2Yl+8ZVCjZx/77H+EPrTRgOlkJbeJqjZPa/S9fRlDUmulI+YYlPlGoYBPdbm+0i
vad5+Ma8adStJDah3kIuU6TSUDMDy/tUqj8I2ko9JcnFs2Ro/5q0yczFZ115ihny
+1T12yTLbZ+t3NDVKFLnEsaH7DA3qymYkw5QXlNEnXZtgkVowy55Dz5Z6Nk+IY5E
Sk4rSWOebgGj5eRl1hemZh5qkuMbMcVpmZArKp4lAtab1W9zIwSN5WJwcqWbKJHQ
3TCad14O59Y2jmSMLoZIUlIjRl/JzwovIB0c1m2ijmX3cjQ50qKe4UyZqJmaBIpi
vTk9wdfE0RGHnNF+DSfk4DxeKPtVFIQxpFOjJwg6wfipIz0iDfOcyP/GqW7B2y1e
6C9hodk7cEeXv8ZST+fQcLdoj8dmvrUPktFuq27BYFBKqY80vhL6PgLNY8knGJFK
0dGwKXf+f6pPlDNdypKuupzRRgEhU/UF6e/u5NhTuRepr2iQ2FuHoAtLYSoa3LGk
ZfnyAkO4PWzq/015Qg+fMTlBhwb+yaCq/DqdlpJndg6/An5WVkg6AY17c1gWvyVc
DKCFmv+vkZyw6sjkVyh+
=7bzY
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
