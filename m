From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: axxia: Add bus recovery functionality
Date: Wed, 3 Jun 2015 00:40:48 +0900
Message-ID: <20150602154047.GC2661@katana>
References: <5553136E.2000408@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5553136E.2000408-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, "ext Berg, Anders O" <anders.berg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wilshire Jay <jay.wilshire.ext-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Lawnick Michael <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 11:03:42AM +0200, Alexander Sverdlin wrote:
> Use recovery framework and implement bus recovery using "Bus Monitor" reg=
ister.
> Tests show that shortening SDA to GND results in "completion" timeout with
> "BUSY" bit still set, so initiate recovery in this case.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbc5/AAoJEBQN5MwUoCm253UP/R0pcs/4dCdUnkSfPXZ5d09z
9JOv08UpboTgF4j5XjwtUaNrqj29arnfvoO5z/7hkr0Uy6o7qxxyRjb4vuTbhoww
SG+CZ1rtwnWoBLMEYkAwSRh7keUbOFgRno7DK/+mB1vQuYyC0o65Y9fBDzTDFL7U
1cjVHKcsT9+pesBQL9/Og8bTZyt7vL1fgZEijaCOIjHepdgNH7yxJ0eXEgrURBgJ
ljrpSSEkrkrF5HHff+maoWOM4yPzp+wStAhSjEJlmDBmphDVismqJ94kZ54KX0wt
CE2NSKLeCz1nsFcQJ2lT+xki3l1VF0bIstge6M1tXiZK4dPziAWQkCTWr6IIzBoY
oXSR9/YuM6zcf4+F/1JuAPSl0Z+X8FLpk/5e72geQb9QGDN2BIHDtbBww8lb96VR
aOPZEVLhMNbMfmcACtebxTb9VNSTuTwQWvcNGjR/LJ2ooA/Rv6nACjodP13yirpN
lvZcQ3xeXql6cCUiPLgtnbY6N6NclmUqitoja66Ketr72mjgrQeuML+qFBFgoxXL
mGOudG6qzqLVoWEfJajYlNWRg+NH8NIfIFLmOD61QkusqPFD/z1+sY4nGYjrWT2K
OOpvK2OKja0xujee35T9h2meq0lBLfYZoI1LQmGWqtNBlD6q9cXGSHdyQjCoe1mu
jZPDeCf91WxhcMCPAHZz
=PVM2
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
