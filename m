From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/3] i2c: Cocci spatch "of_table"
Date: Thu, 5 Oct 2017 13:26:44 +0200
Message-ID: <20171005112644.pndi3upya3cflunk@ninjato>
References: <1505974912018-1637125348-0-diffsplit-thomas@m3y3r.de>
 <1505974912018-1581728551-2-diffsplit-thomas@m3y3r.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="552puj7itg6tabud"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505974912018-1581728551-2-diffsplit-thomas@m3y3r.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Meyer <thomas@m3y3r.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--552puj7itg6tabud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 08:24:27AM +0200, Thomas Meyer wrote:
> Make sure (of/i2c/platform)_device_id tables are NULL terminated.
> Found by coccinelle spatch "misc/of_table.cocci"
>=20
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

Applied to for-current, thanks! But please use descriptive subjects, I
cahanged it to "i2c: ensure termination of *_device_id tables"


--552puj7itg6tabud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnWFvQACgkQFA3kzBSg
KbZpZg/+JYGZZLkNTg7fdWZWKJpi3Bna7ZfiCBgMlqy6y2zkVrDj7BDY2AWyWbrC
JD++LN9indQCExbtnUgOC00wZrRfvwqa1mLroBNlu/0BPycRFeK4HtQ2bE0U5v5S
zE984yFYQ2theAc9+m8vo2iz8iRZEhmeOSN+APg/pIvgDHg/wvN2kXJUmjXAwLNm
g/WAj4tIfHp9yIsD19TPFlChPTttZpQ5LNOPL8CGMAEJtL+JdoZXa0pqBH38rSTq
aNUmGbwUvLfcUAdZBZ4QQeaws1z08RjGUVcmxJKIYFqRa+p33fS3qHufA0p53l5A
f2cTnIhP0X07309PMQbhuM0NBObYsUT81JxyQ997guZVHeDOJhRk1jaeBVI/hD+b
Jc0R5PZC7cDZ9T4ncO7jPQcXSlOejtjzt7sHTZP4SeIWiWjAPRrYkuRA+rw1M7hn
cESLUcJd8yl7HHGSWkbYNgob5YtmETPsoSu5N+v49sjJSSoUV0QBDfGTq1K3QYVK
+6OQrOSZp8uKqxalJY8O2dE7br9Lqqd4edns9Etr2anr1zmOqaTrlQOadAtGulO8
3B1OOnrCCWu//zzubPWHs4w5kizCH57j/xfh5Wn2qgiqRfwvbrVlbwtCeKOMd2gF
sroNqQqotQG3tpk9mv3zSN7q+JCMkDCXSQkGyEWzrBGeCdFXPfg=
=Po5U
-----END PGP SIGNATURE-----

--552puj7itg6tabud--
