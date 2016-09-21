From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/5] i2c: octeon,thunderx: Avoid sending STOP during
 recovery
Date: Wed, 21 Sep 2016 23:00:44 +0200
Message-ID: <20160921210044.GE1513@katana>
References: <cover.1474439371.git.jglauber@cavium.com>
 <9791f6fb5fba70ddf9bd6b92e113e97bc0483317.1474439371.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9791f6fb5fba70ddf9bd6b92e113e97bc0483317.1474439371.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
List-Id: linux-i2c@vger.kernel.org


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2016 at 08:51:03AM +0200, Jan Glauber wrote:
> From: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
>=20
> Due to a bug in the ThunderX I2C hardware sending STOP during
> a recovery attempt could lock up the hardware. To work around
> this problem do not send STOP at the beginning of the recovery
> but use the override registers to bring the TWSI including
> the high-level controller out of the bad state.
>=20
> Signed-off-by: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> [Changed commit message]

Applied to for-next, thanks!


--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4vT8AAoJEBQN5MwUoCm21b0P/3raGEW6CVb6sXt0WoBWpQiG
VAjiYrOh/hwc3Kx2442WsQEUMsleEOvK/e+jaz+dOTx5Q9ekRCyiDLYyhjUJKZ0v
N+0jNrsRJKpZITP+jKAPO0Y9bR+VgBVhZJ+SHOPRxFhbbi6lMSdey9LP/8/LoB+t
qAi0BG30dfVMN+6zXva91kc1ox3gE0zKEGXATi3mCKjdbFZiJ1chohbPfofcY4rd
EC39+7H+1k045+tkeG6XsfvxXpwWg885j3bYCFyxUovxIxmVy4G5mire2259jj0i
K9vlgC0b2AyH+/s2mHpnDJbz9t+XWAzoAIFBxX3x3Gqp2vCVwCN5nVicQuKAuAmK
Hd0VuyrTLDupogeO8zlyaqZN6TNTiZHpOIbAjGy8FF6rmfZ8x5pbJDRQLXE/hGG5
QAgdCibP/J+va939RthxXQ702sNGPlynkWI8HpmPUfEcXugQ/PmuZALWlgfR024i
YGo2BS+KQWO9ZpBTZNChHngLR+jV7VSuM3eI3NktBWd3+R70tkoaOjwIrXSNbFko
oUxpxDT9rYbqpZF7/W0mF6ksycAy6SkklCv5mHM+CrBGcVakhSCxHiqV8snSSpoL
/iBRWOvR8Idgf7jRFLvQenRdUBNYp0bnEXEHhm77AMGyHQUmj8R5ClzOplRlGnml
hCwo+ifBgPQQ+FouYl42
=iIVk
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
