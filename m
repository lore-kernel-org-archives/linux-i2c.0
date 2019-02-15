From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: bcm2835: Clear current buffer pointers and
 counts after a transfer
Date: Fri, 15 Feb 2019 09:47:31 +0100
Message-ID: <20190215084731.gy7khiydgyzgfsjk@ninjato>
References: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zp4qokiwiqe3hwav"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Eben Upton <eben@raspberrypi.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org


--zp4qokiwiqe3hwav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 27, 2018 at 04:42:25PM +0100, Paul Kocialkowski wrote:
> The driver's interrupt handler checks whether a message is currently
> being handled with the curr_msg pointer. When it is NULL, the interrupt
> is considered to be unexpected. Similarly, the i2c_start_transfer
> routine checks for the remaining number of messages to handle in
> num_msgs.
>=20
> However, these values are never cleared and always keep the message and
> number relevant to the latest transfer (which might be done already and
> the underlying message memory might have been freed).
>=20
> When an unexpected interrupt hits with the DONE bit set, the isr will
> then try to access the flags field of the curr_msg structure, leading
> to a fatal page fault.
>=20
> The msg_buf and msg_buf_remaining fields are also never cleared at the
> end of the transfer, which can lead to similar pitfalls.
>=20
> Fix these issues by introducing a cleanup function and always calling
> it after a transfer is finished.
>=20
> Fixes: e2474541032d ("i2c: bcm2835: Fix hang for writing messages larger =
than 16 bytes")
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied to for-current, thanks!


--zp4qokiwiqe3hwav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxmfKMACgkQFA3kzBSg
KbZtrxAAohPOgZx5no3ThwDEyYTFd9bMJTKd+4Vz+n1rXHl2K9Ib1/rNfkPq9fiq
7HteQbVVbxw+KOLBUUjGBv6oqF7Wf7D6Im6JDEJvMINRXXvkyKODS/x+4QkPLmzl
4h+r2BkzJpR9Bd5hmWYvot8dia8sUM0qJpEGxKoxezbarIwK6gGeXBZb5hDm94R+
Qb2robryMxM5URI15D8wPFPUhnOxFhv01fRb1bVgJgcF1k2iBIFWHDU+13YGqgPX
v2q6DjebSMv/riI5o/wxOuM9o77cvYA8O8OKyc2bdtLxVuoi9yHIvR0LtG/t4ylS
ZODqbfhu2hk4qlqGVYaq9kYxtH0W/eiE7nTUpM8aNvqLKOrK0HVM6kCm2Tt+TBJI
XpZGBUPdS9YHv5bWJEQvT2svoli0whFKa16glpK3lzl7f6e2xxG2rqfV4xiqaZSt
vW+x2XO07lvZgVYBi/PyfPD+WazQZaZdxk8kWuYwO6KN8if4h8ltoqrfbbhFGQGa
Bs/kFkddb5hzAXBPUdHGr+dEgKT9VrIEYRrdc1PtSeSrbOFeu+xJviH8zgnlar56
romtLgZ3AoxcColAq7JFrMa1ZiYI1torjIxfMFtoNRZZv/JxgDMPuaSwCBMywlxZ
joUf0GbmiGtLW+zMeTb0B6RNTVMimxXB/XqQ0rirCkv8o0N0oP8=
=JjNL
-----END PGP SIGNATURE-----

--zp4qokiwiqe3hwav--
