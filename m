From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 14/28] i2c: eg20t: allow build on MIPS platforms
Date: Thu, 3 Dec 2015 22:05:54 +0100
Message-ID: <20151203210554.GE8509@katana>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
 <1448900513-20856-15-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1448900513-20856-15-git-send-email-paul.burton@imgtec.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 04:21:39PM +0000, Paul Burton wrote:
> Allow the eg20t I2C driver to be built for MIPS platforms, in
> preparation for use on the MIPS Boston board.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Applied to for-next, thanks!


--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWYK6yAAoJEBQN5MwUoCm2QAIQAJD9Ov4gGYRg5xXYol7lYiKd
jmJTxDQnIn3hI9QuRt2+06vrpTwsAZxmm/f022gnnnYUb3IFih5ZOfVIlbAHoS2n
PfDAPyTT+IlWJpHoKnmW6Asb9SXRwW2B035oTYEIVbX1BC7NH8ZIqKcr5X3ovtyH
6nX3ba0rL3uG7rcYWLsvyb/fK8D/pt0G9V/s3NF0cZaymgabUi81hH4aKiJDBkts
F43vVoW7FdnJXx5HPEVjrnE3Tv+w18sYVBAuXDazfzUwz4Ht47UYDjEFCWSE+zps
Nf7GpPYKQpZO9eTnX4AKByuo7kX9vvH/GmcUpgGPwzbo+zIqyWU/mviY/qv+lC1N
wrNqOROZfB3OZpjzwBZ+VOeaaryjD2VepemTyycVK59AWEFZwPviikeYuhBQJygR
EhdgLyV0qbRadlYte6lkfpVOhYw9zBXVzjiI5ZyYzIyFWEQ/kPv8JlppVOowGeyH
ima6NPLd1PZau81mUDoET7FsFwAPiejb/O2d2MZV8T95mbHaxySYnoFyXARNp5wR
Mt/Vw+0N4uCmXO+BpAXOla6o+roiLsSSY7kDLOC06fJ7aEFcSG92h5ItrprGjeoI
6Lf2c4iaObsRu0vqaSk+VHlCY1XErWh60tSAHlmXHxOQEwkyqKv0mkY0y1E+pe5p
+KVCzY3HNTb1NaozS2vC
=5nrn
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
