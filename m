From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: randconfig build error with next-20151216, in drivers/i2c/busses
Date: Thu, 17 Dec 2015 13:34:23 +0100
Message-ID: <20151217123423.GD3958@katana>
References: <CA+r1Zhj5+kE6J2kvmUz3T1591DFcoWFuEVgjmNAy9TZNmo7p8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:53646 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755983AbbLQMe2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 17 Dec 2015 07:34:28 -0500
Content-Disposition: inline
In-Reply-To: <CA+r1Zhj5+kE6J2kvmUz3T1591DFcoWFuEVgjmNAy9TZNmo7p8Q@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jim Davis <jim.epost@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2015 at 09:44:00AM -0700, Jim Davis wrote:
> Building with the attached random configuration file,
>=20
> ERROR: "i2c_parse_fw_timings" [drivers/i2c/busses/i2c-rcar.ko] undefined!

Thanks! I just sent a patch to fix it.


--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcqvPAAoJEBQN5MwUoCm27bIP/RMKSyx3LYFRnS/63WW0GdKg
S8GoCSlBrzVesybzeAncD1onIfL1l7B4Xca5qyJ8ZqqGLHVIkB95HNfzSAFLWnCi
O2RBysB6SST53m9chH88231oLwVzs1Gxp4mCY02yVYvxXNJUXMYWseMQQVeU5Vx3
GFXIzikzXQ4SNqMzdD1HfopS9XpuJeCtfA6kA4pbnucV/hn/rqVUW3i9WfkfLA+2
HJ6IjnUP3umS7qhRu8NkaBjb9ZDmWxclPpQCOL7a4fva3L2dMFhxvSkoUYEOWN/y
izPLVc+LBTC5M8er3LakQan4GpuKc2cf69AVFLtKn9cE0SOwF8JpQdkebtBvs+oz
0oyYh3XMXAyePB/XhedQ9+g7D2mpHetunsxf4w8Fptrf9Zg9xv91MOO6NwYBzTzb
WpJEj2izWkYj4vOIXfvVS+6jV5/c/MiqLCbLtrgF/KNYA5iBVuU/5WceTxykP/SA
6jRYigT/7eTepHvjbERsFNWen3lkopmWK8mFs9oR/uTin+kCEKU11T9nJ61YB3p/
zVo2O/oLJU26RfWiitaXBGWi/G0sHWZlYGIpLli3KYtMHvLjzk+n5T2U1lxYD2xM
jylMdeHw9/4jBmV5HseV6pH3fpCGOBJUDRnxxLQORTXPwq45j1yTj+PFMG/qF7u6
rUapCQYp6yvY3h5V5EkF
=Gt07
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
