From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Optimize SCL generation
Date: Wed, 17 Jun 2015 14:45:48 +0200
Message-ID: <20150617124547.GF13393@katana>
References: <5579565E.1020908@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nYySOmuH/HDX6pKp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5579565E.1020908-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Lawnick, Michael (Nokia - DE/Ulm)" <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2015 at 11:35:26AM +0200, Alexander Sverdlin wrote:
> There are several cases where current clock configuration algorithm produ=
ces
> not optimal results:
> - truncation in "clk" calculation leads to the fact that actual BUS frequ=
ency
>   will be always higher than spec except two exact module frequences 8MHz=
 and
>   12MHz in the whole 7-12MHz range of permitted frequences
> - driver configures SCL HIGH to LOW ratio always 1 to 1 and this doesn't =
work
>   well in 400kHz case, namely minimum time of LOW state (according to I2C=
 Spec
>   2.1) 1.3us will not be fulfilled. HIGH to LOW ratio 1 to 2 would be more
>   approriate here.
>=20
> Signed-off-by: Michael Lawnick <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--nYySOmuH/HDX6pKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgWv7AAoJEBQN5MwUoCm29IgQAKhQIB+fKPYA94Mc7Tp3lNlF
v3EZCXXlW8+lQQCGETIima7xviLgNfuXAE04+lLD6iHBH4GM5gVgk8NDBN13nuAr
XQBV3z6VlMwWTShbu0zW/4NJ/EWgaO9TUbtYoL4DGT2E25hQzg/d3IY6iAHyU3AA
tyJGc5T3QusbSUI1fJGJE5PQO+LOhuHLzpQVkK7KKvoIEGQeeI+KTASYEa12rRPk
HMI6NSMZAsqqCYsrtebo0giP9rZdUIAicxRQQ8Nc1uFwfS7YeAdhilvjW9K9oQe6
R8CoHZmo9F/hRNKS9UzbWxnTBaUEkPvH6VCUnMpLj1hdO0dEMQvOLHHRNUbrcVc+
5DF52bXIRGr7556cZ0PO7qtIik8Lfv1760LS7nH752b7E4wY9+3KiZGUGED5gMxj
0/w0OeY8PGsUOw3m4p5ahbZuoCZfTXHqyVUpDH4e2AQU0f0XMUCTrBIvW9fmcQ0k
NzC9ADBpgxNmERzvjZBeAXnh6f/M/xl0XEQfwINNKJ9UucXv2rFk7sh9BERSSbxf
jyQGuKNoSTS7kJ33IXql/1qBj2Hl0ryvpugN/4szWyQHpzz9WhO6nsTnmo2xVZUv
wBYzaKxoHiPWW0rsuawtJWk2eyI241rRI90yjQOz8KUcfeQKyE6LTgfV6RUs0Rt5
GwnsKkRmu6pMi0ZwSF8/
=ZN3e
-----END PGP SIGNATURE-----

--nYySOmuH/HDX6pKp--
