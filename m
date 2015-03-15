From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: img-scb: fixup of wait_for_completion_timeout
 return handling
Date: Sun, 15 Mar 2015 11:01:18 +0100
Message-ID: <20150315100118.GA6770@katana>
References: <1423494921-2708-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423494921-2708-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2015 at 10:15:21AM -0500, Nicholas Mc Guire wrote:
> Return type of wait_for_completion_timeout is unsigned long not int.=20
> Appropriately typed/named variable are added and assignment fixed up.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
> ---

Fixed variable name to 'time_left' and applied to for-next, thanks!


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBVhtAAoJEBQN5MwUoCm20mEP+gLo7VcFV/bXrt+yZ73cySgL
k+ocHAlj4kXlbSl+8WsWDZ+BeMafZe1DSCb+pT8dEKffge3pgSQ1FFpkF178v4q9
pfHiqylPiEQBwtpBNc4ngpQa65PLpGW2khLztTO7U7utpNTpe2MAsVj2pV7P/6G5
QXRm8P/SHKiJmXTLJgbDX5yWtjH0tJCogfNbqJ89+bO7pDY/i6utrqMGxla+8GDU
knUx+Uz5Ov/DJ6ey2/A7584hRbEWAnGOPEuXNHuQrdpM6x2ngAKObCqimLvR+Yz2
FeknEmEcz7dzTG0rMm+2AYwXB0aqeXoqY/gi0x7PnnwYGdkX4w/mHVmn6xKpB65R
0ga6m9kI73mvyJSnPR5pFxU6VE2Gx7KnRugvuPp6yjk9AyAk5m9X4gxwR/dxfVxB
0/a+qaFpxheF/rAv5Ws/la0DxSSI1YdOiT+UUI4b3Ps0lG2/PuZ9wVySkPVReJzU
+YCQnsL9lX6yFHfz2BxPleAl2tl0eIvSi0B4Wmx+kRp6AQnfO8xI6RZgpoB+j/ki
QUuOxuoubvL2dOcyaRQ55vrg19Tmdro47ya8P/vpEmIGKiItYHivZA91HOvRCg4W
YojFFG3vBUqkyVmtrvKfY2Rj9RWKc7TGqzCoNkhA+jFWPq05cka4bBaGWC21Sw2N
/pznc7PB3jsB382fAIpq
=FG4P
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
