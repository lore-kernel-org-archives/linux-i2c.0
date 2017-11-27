From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RFT 0/5] i2c: sh_mobile: refactor HW init/deinit
Date: Mon, 27 Nov 2017 18:56:37 +0100
Message-ID: <20171127175637.fmorzefw3bqfi56r@ninjato>
References: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q76gsqptxkvxqlb7"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171102124731.10484-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Jacopo Mondi <jacopo@jmondi.org>
List-Id: linux-i2c@vger.kernel.org


--q76gsqptxkvxqlb7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2017 at 01:47:26PM +0100, Wolfram Sang wrote:
> When clearing the ICE bit, all registers fall back to their defaut value.=
 That
> allows for some simplifications in the code.
>=20
> Tested on a Renesas Lager board (R-Car H2) doing a bunch of consecutive
> commands. No spurious interrupts have been observed and the signals look
> exactly the same when visualized with sigrok.
>=20
> According to the docs, the ICE bit behaviour is the same since the beginn=
ing of
> this driver (sh7722) for the migo-r board.
>=20
> jacopo: can you please test this series while you work on migo-r anyhow? =
Thank
> you a ton for that!
>=20
> Looking forward to other comments, as well...

Whole series applied to i2c/for-next!


--q76gsqptxkvxqlb7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlocUdUACgkQFA3kzBSg
KbZUSRAAk33kft9nsYlLNMRxhiZz4F3cZ8fNXWVw+YdKFX0QvOTUBcwEr9BD8M+n
2eRkLvZWMgjSjdv7j9A25GZMNIkVyJksU/7WrpGL5XMyDwxtbh/SgKbvnjn4AJNW
9V9o1HQ8vdxWthK3tJyfsFhztCe/vu7G7GC/SfZ5n9AkEA/CSj3r0G7es9N8JLSr
KDG35vUEsFGtaX2wVj1uqiTbMm1/aA5UaBhePDoA+eJiZKqeqAGLbfSIidZQi9xp
Ch55C6/IcEB9lj8vEWN8tJVEx1WYc7ZVliuTDoLpK+Nbg2Ne3nfhPvdRzrpdiEeh
Y3yHl+bEuJtyWmfoO+3K6deDr7ycoNIPXlw39uGbNlFDzHcL/dR3uoyCk+Y7OY0o
iQtUXNq0h2dL8ub0vORrj0Zf6Y9/y1n/wXivQmNgI216LUhlb0IcqN1IushOj8Fn
Ws8T+hcSBIj42zThjhGJ6wJ4WM5n0UZOdKZquYoj1NTmZ7tnMB8MvX4x7JkTre1s
/gndmfA5CSSjoR+QHn01hB/+fb4dKlvj59J9HVvwbiLUED4UAGH/FdNelxpwoiaI
UAHRN48SdEmTneK9KcVYTJrxJuQMzed/LfV7rLQdgI6x35wuSMWADzB+0d7j/udj
hmi+5YzJmk+qHVi66QLdUpOR4gR3Wo4/MFJFBry7y7a4OzNhgNQ=
=9kG/
-----END PGP SIGNATURE-----

--q76gsqptxkvxqlb7--
