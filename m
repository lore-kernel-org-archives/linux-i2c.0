From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 3/6] i2c: rcar: do not print error if device nacks
 transfer
Date: Sun, 26 Jan 2014 22:50:25 +0100
Message-ID: <20140126215025.GA7643@katana>
References: <1390752337-22386-1-git-send-email-ben.dooks@codethink.co.uk>
 <1390752337-22386-4-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390752337-22386-4-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2014 at 04:05:34PM +0000, Ben Dooks wrote:
> The i2c-rcar driver currently prints an error message if the master_xfer
> callback fails. However if the bus is being probed then lots of NAKs
> will be generated, causing the output of a number of errors printed.
>=20
> To solve this, disable the print if the error is not -EREMOTEIO.
>=20
> An example of running i2cdetect:
>=20
> 10: i2c-rcar e6530000.i2c: error -121 : 15
> -- i2c-rcar e6530000.i2c: error -121 : 15
> -- 12 i2c-rcar e6530000.i2c: error -121 : 15
> -- i2c-rcar e6530000.i2c: error -121 : 15
> -- i2c-rcar e6530000.i2c: error -121 : 15
> -- i2c-rcar e6530000.i2c: error -121 : 15
> -- i2c-rcar e6530000.i2c: error -121 : 15
> -- i2c-rcar e6530000.i2c: error -121 : 15
>=20
> Cc: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>

All applied to for-current, thanks, especially for doing the extra
kernel-doc update!


--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS5YMgAAoJEBQN5MwUoCm2rxwP/jufy/68AC2MErggBqKwaB1D
x2ASG2babodijQ/MuRNe3bXPanOtwKj/Y97qMMUOhUxrx5MbdRinBUlgjUqhYJSE
PhkAIyRME15SC+VQkQs+HdLhsodUZqwM0d+qiXEXKI2snuRswmuCCqneCRFTTdV3
NrpX7Zbb/gqWvlBdXyFxk5iWewpgik+5JTyJU+Lfy4dQ5nrBhqQNWzCKc1W2Xiq9
yLUtpoZ1SNgmvIw7v2okA04Bhhbd5hU34/OWe0wV6j6mrZeii0wtO/7TJIGVGIzB
I+Hu4E3UnrRtO64s12RnSMD2/4NnGYvhm6GrQxmZ+eJVzIJZDxPZFnnXeZYOSoDa
niKZxwZqpyJUlymlBrPnJAZiU4CIUpeBVAh7Zz7kuBIZOg8qWMCejBZxXYRikpW8
5Qqqdy7xtFTHiJ/dHFtIr0IvGxDg9GuOeZyo1CY3Q0MrOJ81qkPSjlW/DfGs6ffQ
lcqc68xVeiUsFyGmgceRFz954EoBDyQQ1hJEQfXoYGFG6pJdxgn2sIRKWxzu/r8t
CAATd8l/ZeViTIZHtNf7YeR4dzBrlBZPrrf045p4pohSLLacrE+o2QZ7ghjeRQYv
HB9S5m7gTemhqX1zoYfJs9K+dM0YUZIPwZZ+chsa3JU3W4+NsSxmggyfFoSDUs0I
N0UCKox+4QmzIeFh6oxW
=wxmo
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
