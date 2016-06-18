From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V4 1/3] i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is
 enabled
Date: Sat, 18 Jun 2016 18:20:15 +0200
Message-ID: <20160618162014.GA3017@tetsubishi>
References: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
 <1465582101-19391-2-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465582101-19391-2-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org, nkaje@codeaurora.org, absahu@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2016 at 11:38:19PM +0530, Sricharan R wrote:
> With CONFIG_DEBUG_SG is enabled and when dma mode is used, below dump is =
seen,
>=20

Applied to for-next, thanks!


--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZXS+AAoJEBQN5MwUoCm2w1cP/2P3xm2Hk9NyxvKszB8puTEy
63tVPNe1WMIZ5YulSzUkuoGOAvIySX8vaQ2w+LOaWNkKkyqlIoMo6F7oMqvQMlfy
VEK2Yd5Pf8pKGzUJVAWDSrsMGE80L2AAggoEyg/i6PG5K7siUYwIKFca/fwCvh/a
DWbSbyBbNq63DIfH8pMa+GWKrfIX3cMj4pULaC+NYEzC9wo6hMIHhhWWWNpOik6z
ZEqL6Z4yK7UcCcqAB6JbLtbhILoiNOdwSRGTZ3DkcLQUkgcpLALBp1vHAvF8yhO5
/wsYpasAUkUsJ3L6bBDbZvIbE0Dfp6xQiYBKB1PPfBQFGna2iIpJgRr1RdZzNnor
x46m/Ajo0eX33V97V9URC2Fbv74nxsRHnTHYgQVhW4pn/iDyv+hhI23hJjVs6zyu
7h0em+HMjFbUvVbYPLIoYKHKM7Nw6tzmWpDcSel6XxPIrcJ22MghCK1AhR/s8wj9
1hT7/gKnUH+TOINt34QvG4xnj0na/2f74pVdwzuOeIw4iQHi6ZlmZMsDassm6mzT
e2L0UGkgrBgXShRtm0bXvLbV9I4iBQvmBoddcvJGQ9Er7p0BsGdeXcWumlvbLbbW
7AYFN5mYLAQoAnq1l62e1UdlLijnvJ2W82Yx708kED1NpTM4CoijYvjy/6HOw/TP
IKEsQUU0FM2P5yVM7WXE
=KnFG
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
