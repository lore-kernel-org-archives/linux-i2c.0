From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: busses: i2c-bcm2835: S-Register clear reserved bits
Date: Wed, 17 Jun 2015 14:10:15 +0200
Message-ID: <20150617121015.GA13393@katana>
References: <1434469259-6474-1-git-send-email-linux_wi@tinag.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434469259-6474-1-git-send-email-linux_wi-ADq4ffItWIY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2015 at 05:40:59PM +0200, Silvan Wicki wrote:
> The Datasheet mentions on page 31 that the bits 10-31 must be read as
> don't care and written as 0.
> https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Periph=
erals.pdf
>=20
> We cannot guarantee that we reed bits 10-31 as always 0 (becuase the
> datasheet says read as don't care). We clear the bits with a bitmask to
> prevent writing back unknown data at the reserved bits.
>=20
> Signed-off-by: Silvan Wicki <linux_wi-ADq4ffItWIY@public.gmane.org>

Applied to for-next, thanks!

If possible, use a spell checker on your commit message.


--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgWOnAAoJEBQN5MwUoCm2HYkP/2qsOdPOpMQQ6fOsHDSFSk5b
Or0AlAfHsdC/p44O/BnWAD+vw3olE6O/tC6v/Uhjhx6RrA0hhYjjH12PPM8WFiP/
50rlH727+lXFvTWexwWneRzPXzOtiAxfQZFYaOsDnym4daUF80pCl0//1EL+CsZB
E7Fzd2Kqjz4MNJ88Da/Uw00AHQr5glspz6ZwQMqvTe7hA5qLTK/IMQmH6PUweKX3
tGtfrIigGxwxrwtUb3nY3MfnFwmWANfc+BuvNk5QFdqfA6Aw2aMP9/FnUJBLzWpy
NhYLxEyf8IojWseXbqKg1ij5T/Xw5IQlqmKYXdq7bCHE2KnozSKBHAbkCaNC4RE7
c6NYwIvbp8Rhf59q+6/vf9KCjtTnhZ8HT/b8SGjZwAjYThsWxwF2ap83LKikCk1U
PPIoW5Mx5sH1Ucn53MIdWT/0JTgz7gvEk2f18piZgHHIKcHgQnhhdTXxwd/ztLUz
/+/PPBXt9TiTQqBNtuqjMbT8p8HkU0irrBT1UvBDTpfpIs1B9WWtZ7jUGW8TR02p
mpKuMXUdW9HSrWrDuCOg8wZS80Lr0YDFFiyK3+5a3YjcTX67Hutd017rKwLUWqyR
lTq3LdasWb98W4vHdT8VGcFfrCTd5q6nFeYwOoriuazgLx8MKMeEIatj7/8TT91s
AMLlVwVzrkLKa1zpAmPq
=03qJ
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
