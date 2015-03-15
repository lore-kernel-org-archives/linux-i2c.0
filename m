From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-bcm2835: match return type of
 wait_for_completion_timeout
Date: Sun, 15 Mar 2015 10:29:09 +0100
Message-ID: <20150315092909.GF3393@katana>
References: <1423393458-30334-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423393458-30334-1-git-send-email-hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 08, 2015 at 06:04:18AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. as
> time_left is used for wait_for_completion_timeout exclusively here its=20
> type is simply changed to unsigned long.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>

Applied to for-next, thanks!


--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVBVDlAAoJEBQN5MwUoCm2pI4P/jgRnhmf9XCOEZ35A++O9wpu
WQapo2/TfmUNBZxrcrcsGGr6jEmL+hSRXqTSCAe9mLWevzjFmMktYJMNG5Joumel
kelWvaT1ukE+gKAV4OTSE+6GQzIDxuJaOqLTt8ADST39Vrin9rtgUtB7w1JXu9jL
jE44AOtmlATj+5lI8OrLRsnRidDmD6VBTZ7hUsatIwUL236JH1XiKmF+MCw4MtBd
di72dpWB1SR/dQE1juTJDOooqiYiWikCi7OFAsfHs+ui6R2XXXPbfX98rp1J8l1O
eTpDUGXTteNkOJKP4Xgn3hBUAFV/oe8Wt4AaFSkXCQBFXgX0oqlItNjIkiqLmAKd
XrUODJNhu/043npkjqu7dgvONJkVqKn3apIou7vnbmSj1OJVDzAtNDDUwNobaXZq
66uF1w4qjK8BN0aMbNsUVUJtSAHmzT3h1lKWyOgrKdTgPXcntCCILyZrtsZzv35H
KLf5OLhE6eLlyoyW648MiD4ZR7FTIcjh97Uj1UJf5QoAn7S+1TCoUcKO8pyhFUKw
YcexvxE4u8kkAMpAB0pCnsZdVq0di2ll8XJtK36SEs4p6r0ft6TzVWDC3RuaDc71
N4irkSPE/3oz/A/W6yh0b1oJkP7UsMuwOGQvpBNwgAu1V0ecCYTvQzJXjA7RN537
iKHoKllaFaO/xWDvONqG
=UCia
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
