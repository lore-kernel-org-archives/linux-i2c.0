From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mux: pca954x: fix i2c mux selection caching
Date: Sat, 17 Dec 2016 19:30:34 +0100
Message-ID: <20161217183034.GC27020@katana>
References: <E1cIDpI-0005y4-SW@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:50994 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758139AbcLQSah (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 17 Dec 2016 13:30:37 -0500
Content-Disposition: inline
In-Reply-To: <E1cIDpI-0005y4-SW@rmk-PC.armlinux.org.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 17, 2016 at 12:10:56PM +0000, Russell King wrote:
> smbus functions return -ve on error, 0 on success.  However,
> __i2c_transfer() have a different return signature - -ve on error, or
> number of buffers transferred (which may be zero or greater.)
>=20
> The upshot of this is that the sense of the test is reversed when using
> the mux on a bus supporting the master_xfer method: we cache the value
> and never retry if we fail to transfer any buffers, but if we succeed,
> we clear the cached value.
>=20
> Fix this by making pca954x_reg_write() return a negative error code for
> all failure cases.
>=20
> Fixes: 463e8f845cbf ("i2c: mux: pca954x: retry updating the mux selection=
 on failure")
> Acked-by: Peter Rosin <peda@axentia.se>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied to for-current, thanks!


--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYVYRKAAoJEBQN5MwUoCm2gI8P+wV2SywlfEihGklcoWVMJ11l
RdjlyZ3T7OqOjAtqRInZuTDoUBeMQVWARSKTmvfqvT9gm86JOzbko62w9Y2oQDTF
KZ8VKts5a/tVwUW/9JAsec8A5kCt+arLHl7fE4M7Q85U90gA9OK8ik9zR0LpxxF5
OTPpxMHTQo0fv+6wIJ1wf32Bvgqej3hKnB1mG+k24vugHsCq4zYJSwnCOb9z0J6k
e3u/cGtuqT7VERfR7sSwQU2VOoa/T5+xh5IH5prATsdejOaWGhXsMm8ttlofWhDD
gZwFkvpDPK0XWB0RcozSEJ0hbWPsSqtCTjyH0ICtoG0UBPcBs9DIT+uhNpO8PdPu
8ZlNgrgOPwMvVQXODuP5JJbAOvK1aarAumwLJxbn8kgNps5Zoog3mHbSdjGKjHvR
NtAL5v4ipV+26Z9A1LwgCqx5dR6vs34oDNwgNdeSbHiHWXre09ixulHC9RjYd/aF
D/GoYiShTBei6+Qo/vlR5vAikzPLblqeKLHRzgY2vLu+8UUiVU4tU+IfB5wUBGBY
H4H7e/MbhKmq3RhHlRLE297BwaxlpFi0va2aeHgy/62UNcW8cydZCb59qmgbDnF5
ckCNme6n7s4uSeVmQGgdHjXgshy1V1SkD2qkoYk9kHL6x+BS5m34X4eEeYgHS0j5
BOgHKakoL8NEjyVBaFTZ
=d1vP
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
