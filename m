From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [GIT PULL] i2c-embedded bugfixes for 3.3
Date: Thu, 1 Mar 2012 11:44:18 +0100
Message-ID: <20120301104418.GC2535@pengutronix.de>
References: <20120301103332.GA30156@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120301103332.GA30156@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

On Thu, Mar 01, 2012 at 11:33:32AM +0100, Wolfram Sang wrote:
> The following changes since commit b01543dfe67bb1d191998e90d20534dc354de0=
59:
>=20
>   Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)
>=20
> are available in the git repository at:
>=20
>   git://git.pengutronix.de/git/wsa/linux-2.6.git i2c-embedded/for-3.3
>=20
> for you to fetch changes up to 844990daa2e69a4258049ba9c2bae1180657dac3:
>=20
>   i2c: mxs: only flag completion when queue is completely done (2012-02-2=
4 22:28:27 +0100)
>=20
> ----------------------------------------------------------------
> Wolfram Sang (1):
>       i2c: mxs: only flag completion when queue is completely done
>=20
>  drivers/i2c/busses/i2c-mxs.c |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)

Oops, the message generation should have been a dry-run, that is why
this pull request message is missing a bit of context. I am sorry about
that.

This patch fixes a wrong assumption in the mxs-i2c-driver about a
command queue being done. Without it, we have seen races when the bus
was under load.

Please consider pulling.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9PUwIACgkQD27XaX1/VRszUwCdH949MHRoRFuK9nSfYd95nsmC
ucUAn2g97C5fFM6JSGoEKtmsdkMPPPbA
=m3Nj
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
