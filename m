From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: riic: Clear NACK in tend isr
Date: Sat, 28 Sep 2019 20:24:29 +0200
Message-ID: <20190928182423.GC12219@kunai>
References: <20190926121909.1795-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190926121909.1795-1-chris.brandt@renesas.com>
Sender: stable-owner@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org, Chien Nguyen <chien.nguyen.eb@rvc.renesas.com>
List-Id: linux-i2c@vger.kernel.org


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2019 at 07:19:09AM -0500, Chris Brandt wrote:
> The NACKF flag should be cleared in INTRIICNAKI interrupt processing as
> description in HW manual.
>=20
> This issue shows up quickly when PREEMPT_RT is applied and a device is
> probed that is not plugged in (like a touchscreen controller). The result
> is endless interrupts that halt system boot.
>=20
> Fixes: 310c18a41450 ("i2c: riic: add driver")
> Cc: stable@vger.kernel.org
> Reported-by: Chien Nguyen <chien.nguyen.eb@rvc.renesas.com>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
>=20

Applied to for-current, thanks!


--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2PpVcACgkQFA3kzBSg
KbZtXw/+LLgzjDx2AqGztOvytSm+LJzDaDWx5E1ZHDGJuAnuU167yv4u+4Uxcx9S
4u3zG7ZlniHvRNu1fKz8/0QcRtiJMnwqupjHFRzf6v3xFluRsNPykYL9YipNgUgZ
clNCGxJjhEeaqLxHCP9XR2LtZMbiukafQTp+bbaa1YJM4JwPIwGDc5QasdbdP4/0
C6+KRSRkBhgL+VFtZUL21UwXxUkAem2q/pQtA08/Vrk3Uvu5tcLTJytn+kqOBPvh
lcvRQ080lapDUVrLzsZqk7fHQvBpxwXAZliaGwmCGtqMDgeCHdyisblXqNFWO1bE
jTqnm27un/h7SZxVhc1mRUv0uWSHn1V3fGP1yXGWhk1LfSAgJFefck/eZZovXjsh
KUFR5lxn1y728z++2lI+djH419C0zpTkMWqgZO/0zT8H2Wc6zkC1BGGCxxSJe6Dc
V2ZHEeZPgaQAngDeAGTU0zIzVYzhHcUUfi6L8JvemkEtYF+7H36aJhgjNyEz4/KT
SvUOOfT9yg3havUBGkcFf/mFwb2vPe0+AdoNbvOhEN9zFO0GD3DQXPKwxZdHKNuJ
Ah376vQkTWehzK9XBJl3GlzQKam+6YS6YeZHuhKo2QNEhiZ0e7/We09x99vgkzsX
46OUdWg4dtMBCdJ4NYcfMdBYb9oeu7+LAB3qAomREPB9KrkCfd4=
=sGSV
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
