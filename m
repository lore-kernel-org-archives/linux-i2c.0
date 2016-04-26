From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: imx: use usleep_range(50,100) instead of udelay(50)
Date: Tue, 26 Apr 2016 23:35:27 +0200
Message-ID: <20160426213527.GI4587@katana>
References: <1461652066-16456-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461652066-16456-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>
List-Id: linux-i2c@vger.kernel.org


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 26, 2016 at 08:27:46AM +0200, Dirk Behme wrote:
> From: Oleksij Rempel <linux@rempel-privat.de>
>=20
> Documentation/timers/timers-howto.txt recommends to use
> usleep_range on delays > 10usec. According to my test results
> with Neonode zForce touchscreen driver, usleep_range indeed
> reduces CPU load.
>=20
> Stats collected with "./perf record -a -g -F 1000 sleep 10"
>=20
> i2c-imx with udelay(50):
> 34.19% 0.00% irq/220-Neonode [kernel.kallsyms] [k] irq_thread
>     ---irq_thread
>        |--33.75%--irq_thread_fn
>        |    |--19.27%--0x7f08a878
>        |    |     i2c_master_recv
>        |    |     i2c_transfer
>        |    |     __i2c_transfer
>        |    |     i2c_imx_xfer
>        |    |     |--11.71%--i2c_imx_trx_complete

Reworded $subject to match code and applied to for-next, thanks!


--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXH98fAAoJEBQN5MwUoCm2+iEP/1xpIa7d1OBm/dbm3MkgTr6j
d5bCX9fSQ50CKuKQWXs1zx1rhUuPfL1M1vTgxZDzHmRxUGooD0grBc6LrCxDp2AR
IAyFhvPKXiRpY5UYlagFMi0SaPTnlHdAQ5Uo+1ADOypq5CD+4AgHlQC4ZxLweKi7
WJ5rBqfpeS6khTjB3LjFNOZbA+x1E6Xr0ssn73bCE6gCWMDdeUYk0izX4isd8f2G
ztAEfprLZ5umezRwQ3HB043xFpfcQB0aLGNHWKkbiOODWODDPzdqIagMFJirPT79
oIPpMZAYwDKhzuTq+wNlEU44CCp7HLuYXucLuCx80yWBXud2b3C3lWpF84VsSCmA
h0tVscdfeYesNpGOl1EvFxrptIMLTKGZgloFFvjNJ5JwW9H5UB28lcnrJ/9xo+yX
QnX3NlfJM/e+6KNnS/ulObcy5Wu44KMUa0Zm9zWJSV1wZQkRFNo5EjhexDYyOH9j
IRAjnXUr5o5P7JMuN/AD7SEeBTn2xS773oaVmMoRza/T1bmcroXMb/opqzxtrLdh
vigqkUijUqjSTVOhPTX04wr4SxoYKBnr4QYQMOjxZCSIRIcb3GS+4inAlbNBT3ww
1EFmcxucrZAIX0LClerb/zBLJns9AbB5576QiAwnpE9Y7cUsA7a6HunSQIc7BENx
bnEbkTIOc+TQ2Uh/DQtO
=vm/Y
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--
