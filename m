From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: scx200: drop GPIO based i2c driver
Date: Wed, 16 Jul 2014 19:12:11 +0200
Message-ID: <20140716171211.GB2759@katana>
References: <1404916029-3319-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404916029-3319-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jim Cromie <jim.cromie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2014 at 04:27:09PM +0200, Wolfram Sang wrote:
> This driver is marked as deprecated since the pre-git era. Any user
> left(?) should really have switched to i2c-gpio meanwhile.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTxrJrAAoJEBQN5MwUoCm2ukkP/iiV5ZNgJnwuALLm7OJy+quh
jn29BeXNisSvuaNv5WBZL0a5bMW3LrDDaksOqjDssZih5q6Sp1NIVPP0uYaxcwxE
+T+g/ac4NqPRu/bEcqO7LlygfwW+lL/kFERMg9ZS1t4CpCxwr+zm76FIgGriVDLm
VTPhh2ehBTQ6gHxknk5fCLgKQZBwpRONNK13LDEmAFQaozgI3oqb1Cod3X6H3T+O
hhf3Bz8lTSsycFEx7mz78ovVKg4o5ygazvdoYmh/Eg5y5fvda1YychJhIPsjoIrI
yF8q44tOV/owtplsIYMcMzz1y7f14uLc/6sCGpai5W2ByAn/Us6vAzbl5/8Cq6DU
3nH9/sfBPkbiSsdQDMohDhIYiCvdgItp2+0d9Vcg0WKQmrvv4hfUMe90NcHx1iCq
+NGUifz5Aef9TCTWqVB7oGeM4CUDGseKJuH6nK4ihWYLosy/X8uuu/lCmze4/dz4
PQDLQsiqBkDsi03zVPDQ6W2g4oS5YsG5Vr2q2/n3ISHnQGcSM2zCBOMBdTHqApuM
rrJ2K+pHOGlZGsV9fbYUqrrn6ZTSlDkshXySg6CSvDNLbzU0aDeIhSRzxThbRW3o
mniQsPencKL11Oip5DJsM0uDrtkCaDIm8KDDoJVt9jslKQUujiAYop6IFwKZDoPz
69z6ghw4RLMhv0z0aIpm
=KQrd
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
