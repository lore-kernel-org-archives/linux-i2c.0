From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v11 0/8] i2c-octeon and i2c-thunderx driver
Date: Thu, 25 Aug 2016 18:37:09 +0200
Message-ID: <20160825163709.GG2856@katana>
References: <20160824212549.16140-1-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46112 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752541AbcHYQhM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 25 Aug 2016 12:37:12 -0400
Content-Disposition: inline
In-Reply-To: <20160824212549.16140-1-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2016 at 11:25:41PM +0200, Jan Glauber wrote:
> Hi Wolfram,
>=20
> this update should address all comments. The probe funtion
> is much easier to read now after using the managed device functions.
>=20
> We also had an issue with the 5ms timeout and some ipmi/ssif commands so
> I dropped the timeout setting to get the 1s default.
>=20
> Changes to v10:
> - Proper use of managed device functions
> - Renamed files
> - Removed i2c class setting
> - Droped timeout setting
> - Improved Kconfig dependency
> - Removed most probing kernel messages
> - select SMBUS instead of if-defing
> - Removed bogus i2c pointer check=20
> - Explicitely mention GPL version
> - Drop whitespace fixes from MAINTAINERS patch

Yay, looks much better now IMO.

Applied to for-next, thanks!


--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvx60AAoJEBQN5MwUoCm2TAgQAJIJzs4y1/GrYVmnaGDKBIQD
VM9FHYLJky7ENShVOEfcfszhuSUotBQzLK2Ya1svp4tIIBkzYLWE8YGe7zYtLTce
e++KIl0eQUyQQpK054z4AtO0FyVZcbCk1R+ZnNPg3DVPbH0UD0cz+uZP3sCJzuIw
4jUPDzbT49PxZNXKBAm09wZPW9ccU3iN7Spm9xc2WWzJe+dcrcn/r2OzVH5qdqZx
Z0Jl8o3L6tESpsCmVA2PZ1fYTErOp6+a7FmWfluY3qQ7CR1lU+PyEsJ/Kvj5B8uC
hBHqSjyzc5lllf+4H6+HKKV4ebIBwD+MxfWn/JXkaw1IYwNN2SF7frVQuFtdP6NK
nPkQNoDvCII4bmnUqxRRZmdfWKCpJxJk/9XE7YOPhLvuQ61PdQmAvhcbMASiTLa1
YE4n5u5Y0VHDQS6igLQ+b3NoPV0c+l3mgGsP4qYhy6lulAJbZnuAv5ntomyNtnXB
pyiWHhmkEODZWuFKnDSpfd1aazMcDcpNJ4g7o2y25m++0K7MYy2IfL8akcW0pT6J
bZogsGy24maVB/hWmet0IdnASVbUOuNTc5CCMbzvDJgbD0y5LtFYllspmZ+x9Nhu
QJ7qe4TDaxbwjUGkEikHSTywY2PsIC4UlkhBrWAXOS9MA9tluEj7LZDsqDPgQz4/
KmlYv7Rq13HecktbPTQv
=zcbk
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--
