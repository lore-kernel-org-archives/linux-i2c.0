From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: bcm2835: Clear current buffer pointers and
 counts after a transfer
Date: Tue, 5 Feb 2019 13:09:06 +0100
Message-ID: <20190205120905.GB1045@kunai>
References: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181227154225.5492-1-paul.kocialkowski@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Eben Upton <eben@raspberrypi.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-i2c@vger.kernel.org


--tjCHc7DPkfUGtrlw
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

Stefan, Florian, any comment about this patch?


--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZfOEACgkQFA3kzBSg
KbYpQw/+I5EVIhwbmysIh+L9Au4/Gm2PS/klKGFRPiiV5gJZWeYg6Pnb7exKsPet
Jht6B6C5nDf2c8UcGc4Sj3vdJMeu3hln3j8Xv/mQQo5bUYU2VYsf5+wTwrh8NFbH
CUBP32dXvZMyDl5wI4dDXwyiOOtJYwMr76SXaeQuxsNZITBPMqI8sl3TYbCeaT2x
/UoYyCD4GTBed3lRUknOqmtr07bbnsohBS3IFVKZMCiSSCoTAHNe9q3XptYVEdlp
0KyaaKrlEa4XvrZmolJMlgcHMoQMSptmARj6ZTl664WmwD90TrjsHoyPKAtFPn/B
bP+XzwsAJqhasN/CrUrebDxd1vzMSGtj0kShlQABvZRXN7DK4vdmLfKrOYcCZ5ra
bWigpqGuGOnyQOJCWfPh4o0EpHQt8Fqu06cKZLQDIGz7x7n7rqp5PRFJzxhGK3Go
gY7ESo/VZ0rXGawuYFWVpGw3r/TAWNNIR39v1vmN7+lr7mfnKjvnZnwOS7+HwcBN
CehQ9lS/pM2jvZZfs8mWbWx3wnmZ1tfWooacHBi9FRksTylHLoiOaPONfUXB4l5z
exhP7ryt4iN/HS/wAVUYcTVzpIlDsDyf0kwsfXwRg+rj9ykl6DKC72nnK1bg/lEh
HPuolBp1p71U5oY3AgfDSwtuEL1CR6IU/+vI6fnWTgRMJqbyxNY=
=fC0y
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
