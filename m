From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-tiny-usb: do not use stack as URB transfer_buffer
Date: Mon, 19 Aug 2013 19:47:21 +0200
Message-ID: <20130819174720.GA8626@katana>
References: <20130806111742.25265.94046.stgit@localhost6.localdomain6>
 <20130815175550.GA5934@katana>
 <520D3018.3000709@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <520D3018.3000709-X3B1VOXEql0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jussi Kivilinna <jussi.kivilinna-X3B1VOXEql0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2013 at 10:46:32PM +0300, Jussi Kivilinna wrote:
> On 15.08.2013 20:55, Wolfram Sang wrote:
> > On Tue, Aug 06, 2013 at 02:17:42PM +0300, Jussi Kivilinna wrote:
> >> Patch fixes i2c-tiny-usb not to use stack as URB transfer_buffer. URB =
buffers
> >> need to be DMA-able, which stack is not.
> >>
> >> Patch is only compile tested.
> >>
> >> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> Signed-off-by: Jussi Kivilinna <jussi.kivilinna-X3B1VOXEql0@public.gmane.org>
> >=20
> > Looks OK to me. Till, are you there?
>=20
> That cc to stable should probably be removed if patch is not tested on hw.

Applied to for-next, thanks! And removed stable for now...


--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSElooAAoJEBQN5MwUoCm2xt0P/0vbctsgU585OfDSTikfzq0D
O3+lmlZEScJ9dQ3qCyeVKS/NvG0zn0106qRaqY6+Y2Q7OQnP5GBeB91s7UFlTpke
nBeX4Ilj0OeIuJwJ91/wsjlHHp6t8Pr+mt3ZCFYdErzoLZ8C8gCjxoVZtg6jlaLH
C2L3oDCGgJAoX0WJHfaicGQmxOVV0u6xBI8K5Z13hy8HJjP006iT3zsv8hwq2Sw4
ugajQAM/NS6CfKtMi0Y4Bi9gAsMd7W7yy1WAAeFN+zTOQJKGLxMWgGjIKbfyAJ5+
uO81gOiUyIjhlCPD6yeo5Jp7RI7dMlYt/rIt2VuIrSHi5Hee9K8G/fDoHisORweB
8Ldc0sBEg0DgQKxhpn84zN42D2UZDLdVGsT6P+iGxgVaN8Yks4baKwyL5Jbr1W5u
B5pqHbKlOagdR+y2K+lbtiLm9SGXWee9LpbkKtejLRJ3/OaZrBdZwMTc/eK2iAdQ
+gonDZHDAQdvQ27ZrEGK+W4f7WHODNV6KK8HAOW9VKz/9vMzc8DUSfqyYvUAx3au
AbVJRPxApbeaZqV3fjQhfSSXA6qKsEQDab1Yyr30nBOnOLn9XuhAdsZeEVXmnBVW
uPAA7mPnQ0FtAcASswnEQ361HZ8iv6A9iy15xNODzAf1xLsit8qRE6nGF44/wjXM
u2m2dJkTW4NNOC6LmuZw
=Bhy8
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
