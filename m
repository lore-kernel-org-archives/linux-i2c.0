From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 08/15] i2c: octeon: Improve performance if interrupt
 is early
Date: Tue, 26 Apr 2016 23:10:38 +0200
Message-ID: <20160426211038.GC4587@katana>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-9-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52364 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbcDZVKn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Apr 2016 17:10:43 -0400
Content-Disposition: inline
In-Reply-To: <1461594824-7215-9-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Peter Swain <pswain@cavium.com>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2016 at 04:33:37PM +0200, Jan Glauber wrote:
> From: Peter Swain <pswain@cavium.com>
>=20
> There is a race between the TWSI interrupt and the condition
> that is required before proceeding:
>=20
> Low-level: interrupt flag bit must be set
> High-level controller: valid bit must be clear
>=20
> If the interrupt comes too early and the condition is not met
> the wait will time out, and the transfer is aborted leading
> to very poor performance.
>=20
> To avoid this race retry for the condition ~80 =C2=B5s later.
> The retry is avoided on the very first invocation of
> wait_event_timeout() (which tests the condition before entering
> the wait and is therefore always wrong in this case).
>=20
> EEPROM reads on 100kHz i2c now measure ~5.2kB/s, about 1/2 what's
> achievable, and much better than the worst-case 100 bytes/sec before.
>=20
> While at it remove the debug print from the low-level wait function.
>=20
> Signed-off-by: Peter Swain <pswain@cavium.com>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Applied to for-next, thanks!

Assigned 'true' instead of '1' to bool...


--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXH9lOAAoJEBQN5MwUoCm2ttAP/Ry083VaTvtlryRiGUkAtyu3
QDVDrrPsHVGf00zuVndaSFGjSnBra222GIin7UmWHiGV0BYvbds4F3dLZgge5s2K
XPlLaL1b2g6zv+rhR7/cmVSp7qvZERYNqco0nTtsJ0rYvPrOaBzw3odDZVU5d/Wv
ibHsruAg9l9X+8u1Sl2Dvx8qtQeEWG/TgdGk9Xzuv/lGkVc+Gykgqu0Gw1dXYn/9
1b0QICEoC/1KWzy1r8gNi2tJ67N12nZQoRrTot7DexV8Wz3PFfF+WRziJ0BasQ4y
RIUaE5jk7lcEA3tTuvbMHcARYFKbgxrCGCTGkVGNri1+gXki4duMv2x0/Egw1p/P
qA4SFobdTH1T5MBW4Or9uTuUMWY6deNt4tgidP6IgwFXj1xS6wcSq2ChpyIruREe
lGLOdrgObD8HZKIKRPfQR58rap6Z9GKgs1MAJ4bmb6w9j73qyIj0N8gzcJN2gpt0
4RQLAy+Jae+Pkqd+rayg4m4BDg3+Hx3vM3JRjg58ftsOHyLLTYJj5PmhD3ew5xVZ
P0TkxnPkDP1vYHRJunVJrnw4ObsuFYTjQEGReqpH3sZXY1JkT3HShRGtyuXJB5y4
8jpvdTdRNhfI0NDhqvS8Dux0B85GL5TpLPUmJ4B/h/dPoE+IiuqE9VoI0q6mVoHO
prqAAtcQtYctPiLppZ1m
=qFYf
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
