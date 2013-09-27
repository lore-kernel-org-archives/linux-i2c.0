From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: bfin-twi: Remove casting the return value which
 is a void pointer
Date: Fri, 27 Sep 2013 18:56:33 +0200
Message-ID: <20130927165633.GE3094@katana>
References: <005001cead1d$d68d3bc0$83a7b340$%han@samsung.com>
 <005101cead1d$f7411ee0$e5c35ca0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pY3vCvL1qV+PayAL"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <005101cead1d$f7411ee0$e5c35ca0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2013 at 02:32:25PM +0900, Jingoo Han wrote:
> Casting the return value which is a void pointer is redundant.
> The conversion from void pointer to any other pointer type is
> guaranteed by the C programming language.
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied to for-next, thanks!


--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSRbjBAAoJEBQN5MwUoCm2PvEP/3YdwStuVxgaUqe3NXChHw8I
My3tBYwMO+qN1fvOuUS3iHsji1K83Xz8d1TL/Y5keZPWHYRrd/4kBO1mAc/rBfqK
8HjvXXR1j0TwfEJ2W6zH2FfVozs9fomy6miy60F68/dfDQi1cuRr++q4KAw2q1Ye
gdebuV7DncPs9cuz279xPWNE9H8sWgpaPFZGQuLZtgqQEq+immOmr54ZUkSC3OHS
1uLedDR/MTQEkbg9NYI/YoMBj8X8sFakjuncuag7OTu5uI7F7yBSQm1/HKBHLYeZ
UFU4wEvk6Q2AJ9MEXXxAD0qsEIXuKJaBBQKmum1BqxTrKQxhD+5amyYCLG3bEZU1
SO1gASZC07Jn2Jr1EvOPSM0FZHsFgjS7O6+vt4zkNn3LwHs7uRU+rFrqyEAuIKod
0l5T1Ae88nHFZC1q7d+i3snskzKS5c5ObOMWDPxxGtJt7gLNVojShgtPWD3VV4ju
IC/qt1kfXplA77ajMAdGuw1DCniOwy7oLSd/xWVprb2yAQRqIBsVwM9H4/NLjWnp
TVrYN8cXJKreKyynJVL8Ex3KQjIVPuCvq6MPB/i5WwvL0Y3F2UB7jlQKSe26dN92
CbCF4ZUckq6jFHQg+yRegxBb57gF6bm6nHoV1WL/fKD8EKzvnguf83C7LyeYh7Be
5SRd4jtjrOk+9mvBTHij
=KHkA
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
