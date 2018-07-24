From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH/RFT 2/6] i2c: imx: use open drain for recovery GPIO
Date: Tue, 24 Jul 2018 09:28:00 +0200
Message-ID: <20180724072759.iirtq7qhydn4ep34@ninjato>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
 <20180713210920.3648-3-wsa+renesas@sang-engineering.com>
 <1532350048.3163.101.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="skzrjsklhy4e4dwq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1532350048.3163.101.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-i2c@vger.kernel.org


--skzrjsklhy4e4dwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> I don't think this matters on any of the i.MX platforms, as the GPIO
> pin configuration (including open-drain) is only taken from the DT
> pinctrl, with the GPIO driver not being able to change any of those. On
>  the flipside this results in a near zero probability of regressions.
> ;)

I see. Thanks for the heads up.

> As this is obviously right even if it doesn't have any effect on
> current software:
>=20
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Thanks. Yeah, let's fix it. It might serve as an example for other
people.


--skzrjsklhy4e4dwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltW1P8ACgkQFA3kzBSg
KbYdPhAAppSjM0SiZ8UDMEQHF9emyutkO1hSHCJ4vhBCqrOES9NpXTBRT3fmVwsl
Sw6D1VwDETyIFIj4LNyZwBc//lLednhElmgPygr3TQoSjdNnoKlvoZ2+pwSDfFam
Fulr2dfaNv/rlG+pin+ROGZN4SM2FHIPBUIflqK3xt8nkhNWCFVfVyseQBvTF60N
RswcuVF/kke3ilsjnEONyZ3HzaL7XXFk5A0kjX7GRBbhYOqXoZbIpgxSU8IQ4Syw
8kItgDn9DnrtnWjLg/HZsFD8FENPkXqMcei5fVnRZgDSzKHXn3wraZNe9adAjCHG
CjuoKuCjLjSVrY35tb9lNWa8NYhEOPE8Avn922nlgS7kGn6ACX/vQUDbRPQxic9i
C20/mTvh6IfhQpoyAsxAeqIMlxdX5n9IA+R0v8e/Az9Y/dTo6Pwl0YVeyPNmrbCd
X28csVWqYu3tJ7Quizg/c6DeYl40G0RQgvQymtINNjEBnqK8nKAqu3KDqA8GLFe7
R+RiDeN7Pf0mUVkUj0kZMcpyXwkBdzM6UvPnVaxTNbJQZMwk+Kx624VHWRyqJEON
HQsMblFcFhmmNkXfeJdI7EiqkURq5TGgYh7vK7NOTevPuwYIewOhFzKVQzyaqQ9o
Qgk3NTHfBA0gI1q72iRCVcQS4RB1pWFB7N+mDIKaeImzieMh+1M=
=Msjr
-----END PGP SIGNATURE-----

--skzrjsklhy4e4dwq--
