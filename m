From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: OF gpio code does not handle defered probe case
Date: Thu, 13 Mar 2014 22:17:31 +0100
Message-ID: <20140313211731.GC2696@katana>
References: <1394721458-23585-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394721458-23585-1-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2014 at 02:37:38PM +0000, Ben Dooks wrote:
> When using device-tree and the i2c-gpio driver is called before the
> GPIO node has been probed then it needs to correctly defer the probe
> instead of returning a permanent error that the gpio numbers are not
> valid.
>=20
> This fixes the following error:
> 	/i2c@2: invalid GPIO pins, sda=3D-517/scl=3D-517
>=20
> Signed-off-by: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>

Applied to for-next, thanks!


--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTIiBrAAoJEBQN5MwUoCm2v6IQAK04BxhWQamfU1Xcpb5P4aq3
NDsATcoDlXkpoaNck0IU8c35pPPtHYg1EjAhGCq6dxfspYkcKJ71ZFMJ4IeZG6pu
OzJEbWUElK1uwiDJKnExhffbMFdCWssOllEoFkME1WGC1r8VcWjZL1QWmbPefqw2
MaLDt7UDwiC6DTGeRahog5XVVI45SlfPXJ9ZZ9nIbEsMlB64uLCYI0HvA3aE6cgI
K9U8gLGLm/s1xDr0nJxOkfdDSs0U5ZeBLWbbl7EtiboVvwJzEUo/dEa3UJ4XgC0K
HlBA1+RfAg5s73l/4qIaw8da0jR2izZ7DA8Ev+MHJhCJb30EEGNUEsBc1xOtVv7s
HEDB+NyokPgeVCLVR8P8zxtmPsC7+6M0sDPy3UbuMl+3FQg4cualGR8TDoC+Greb
8fsYUM2WU2Y6CjQ6mIu9eHT7k2MP/5IG2OV2IvPv7HuUHhp6HHZYfZMLaMdB7vMR
Z9hrr0Ut7zWi+qsMq37oh8cu0Ge51X+EZRQRKz7UIOIxkXE81f+NwbGID64EtWi0
3x0LcUeO/DJRg/TpUilb69Er1Xr3+iNRAfN1apbxxqLUgqzw10H2IN3Nm+hAzFZ2
DSrjjsK668+aph622curq0GpHPK13r+u21Ab4DLQrXt2rT0zpILZb3K+vLKyYeP5
1rr47IKUzaNzcvXds3pe
=rf52
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
