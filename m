From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/6] i2c: rcar: do not print error if device nacks
 transfer
Date: Sun, 16 Feb 2014 12:46:38 +0100
Message-ID: <20140216114638.GC2644@katana>
References: <1390752337-22386-1-git-send-email-ben.dooks@codethink.co.uk>
 <1390752337-22386-4-git-send-email-ben.dooks@codethink.co.uk>
 <20140216094655.GA2644@katana>
 <CAMuHMdXKPFpMZeN9wPmBQEuDGxLHGkGmwsfMDWZr5FUbVHt+Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXKPFpMZeN9wPmBQEuDGxLHGkGmwsfMDWZr5FUbVHt+Qw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, Simon Horman <horms+renesas@verge.net.au>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2014 at 11:25:37AM +0100, Geert Uytterhoeven wrote:
> On Sun, Feb 16, 2014 at 10:46 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > On Sun, Jan 26, 2014 at 04:05:34PM +0000, Ben Dooks wrote:
> >> The i2c-rcar driver currently prints an error message if the master_xf=
er
> >> callback fails. However if the bus is being probed then lots of NAKs
> >> will be generated, causing the output of a number of errors printed.
> >>
> >> To solve this, disable the print if the error is not -EREMOTEIO.
> >>
> >> An example of running i2cdetect:
> >
> > So, after this patch i2cdetect runs fine for you? I assume you are
> > working with the lager/r8a7790 board? With koelsch/r8a7791, it stalls
> > the bus :(
>=20
> Do you know at which i2c client device it stalls?

It gives errors when it scans for the first device. The errors are
different depending on if I use SMBUS_QUICK or BYTE_READ, but the bus is
unusable afterwards. I can read/write the eeprom on that bus before I
use i2cdetect, but not afterwards.


--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTAKUeAAoJEBQN5MwUoCm20EAQAKfPcjU070A8YqRY8hc5XAVq
tjXXHV0Btxx8CN3haQ89B93YqC0MjGUuLxbGucF/bv7AHTC+pRxul9EJFbJ1bRSP
6MVfdJaSNp4ubwnqyA4gDU5cHIFPFZr2gdoDUZslVbGLhjwagBLAP+asWT7IdVWP
qjdWpA4f57XqifIkK/iUTwL0CccPUNMb30MvaL9nWrRbfyRfURO3nL/f+ecxeMkX
+Wr424M8mBvWzKDKL0vCdhKvHTD7L34DbG3qJW3H+CjcrgLIKdwE1jw4AoWkAmwe
EranDfoAaFqzGR/G/mLZDq0GZ/t0JlEjqEcCj+HhYgQFt+eHwjEvy0xC5Hkcm5rs
7gcdfP+3WywRC5AJ2dWJsa2jMOEtjAZ9OUzcbinuOTfZtAGbB71gjOOALRo55D+S
6vvKEAR/thET4c8bXOtHqQY+fZFNjF80ymSOA8LUKMrHyzpCXy7H4O7BVyNZ7m3I
NNqCUSmfd6U45HA7Ir9o+amWOjs9zq3q/xY9IDzVxAi9l/V1bI0vqqncNSsk7UXm
wbv9Nmw1o+2v4eSRFMf/m7+Wp7hr4OtGrC6WCL9Yk9FHJ9xcGfM6/ERySYMCGpZK
DNpk4rpcVjPSaYF4ZKV+TF/h47ioeSrXzAY5Q4b2aDGgyQQSDmGp/KbpgR3T+l84
I77IeE3cViqYwcRDaG8L
=LPjW
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
