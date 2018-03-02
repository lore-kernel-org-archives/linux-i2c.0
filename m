From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: octeon: Prevent error message on bus error
Date: Fri, 2 Mar 2018 11:11:50 +0100
Message-ID: <20180302101150.4mrrms3sn6spnicu@ninjato>
References: <20180227154213.3023-1-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xe6jzn6iqr7jy6zr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180227154213.3023-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--xe6jzn6iqr7jy6zr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 04:42:13PM +0100, Jan Glauber wrote:
> The error message:
>=20
> [Fri Feb 16 13:42:13 2018] i2c-thunderx 0000:01:09.4: unhandled state: 0
>=20
> is mis-leading as state 0 (bus error) is not an unknown state.
>=20
> Return -EIO as before but avoid printing the message. Also rename
> STAT_ERROR to STATE_BUS_ERROR.
>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-current, thanks!


--xe6jzn6iqr7jy6zr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqZI2YACgkQFA3kzBSg
KbbGtQ/6A8bag+g61PFe5EHMFbgzl0hvvxcAUpPCd/zIUO7RvR4pw9vaWTGRGC6B
eeeUhfAqtAsjj681WuP+/KcL7RLBhHDOjAj3SJIQpfTIICrsY34zyuEZqjjVOzib
zevR1sZWA80O7doGH++zBPSWAVU5mtaFuxEKXJtfjL+PNa65CFcXcoxgCl3J1RRv
Zmfvzy94VKyyfAshHp3iy2VuifE+ttmQvH9QGJRPyi/ZdMKNiGn6R0uXVYPGveua
l7ikNeDylHNlcla5I9SOvOBC6qMivouKLfGHVf9QEljwopScrjawacV3L0/3V60U
eVjl89GEmOi0dcXwiveLH1QItmDtJwPCtH3OqC6UH2202JYYVS9Q5nZHWvrPqenx
NQTPkfW9A5g+pJDJs38v2Wq4fuC9j1U4wazt/iGB3KFha99qkUlU91H+cVraxLE2
gda2Z/i4lhCff0JStagu/xi+hs21CYn3q41i1tmj/vDoniGvTrX8edoV6gT4xT3w
C0IHFVBuYFKAYK9YsOCzHhIOcUsJXV270Q92z5rfqDFMh33ZLyM1QwrUgBM14YaH
/80f7Cw8Hk72Epj//sD1yE5vy5O6KXfR2eomJYpOqpSSe86YzdLBhjnjvVb9bVgq
VSf9lLekdRkeUpo2Vt/JuygxrCdqU3VuGns7gqOzCBFNKOjppvk=
=KaWi
-----END PGP SIGNATURE-----

--xe6jzn6iqr7jy6zr--
