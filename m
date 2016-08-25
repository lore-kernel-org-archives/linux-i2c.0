From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: rcar: use proper device with dma_mapping_error
Date: Thu, 25 Aug 2016 18:50:17 +0200
Message-ID: <20160825165017.GL2856@katana>
References: <20160824091929.2082-1-wsa+renesas@sang-engineering.com>
 <20160824091929.2082-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0qVF/w3MHQqLSynd"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160824091929.2082-2-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
List-Id: linux-i2c@vger.kernel.org


--0qVF/w3MHQqLSynd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2016 at 11:19:29AM +0200, Wolfram Sang wrote:
> We must use the same device we used for mapping.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--0qVF/w3MHQqLSynd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvyHJAAoJEBQN5MwUoCm2DGUP/2w6GuFJ+WPQ3w7w4vxeWrbr
wYwiVMvauN6YWzOOQXOmZPDjtLKCOH+qwOqnuC8PHUpICBroA8XMf1RbgMWl3rUf
1yvUXnedaHiuJRHJGKcMeIiCNwlhFSg0T1p9gMbD3zpg+JUElMdG6bJzOukW7eBd
S9ZfTi41dOrqeH0+gRaAyFgahhp/jQli0jQ2m6dBtgmo6BNFV52lnu/s9Uij1I0w
hBQxduZdPYz/Qa96xgotkSkbC0pOJX/cHB6UwexmypWofZs1Z8t/4WHv/pe44Vbf
FVgqVYL98QLfLGj4u/Dcp6XKBArShJ7+w9IXfuJr5Bvr52EetbjoLpRChoY0Wja4
qLo5pK2GRCuyIYn00liP4MY/R/uMHIXxrjn0Mf49LpJPUXQtiQ5t9p2vOiiKkQ+u
9f+kYVQEgU/Mbi9BCqJui0ZkYZJVGOp5/CRh1fAosHr7d8yjMaksEybhYOTzOl4c
kkhiSAZcFkDU17QLfEDA5WksBEmttkXbtYsljSCj0vuUv3evjEu+h3R7FBw2mA5J
yekfMgAhrMZk28nGi+2iWeuNb2rs35+eERQ+8U6JaGJkDEt+YZ818u7TSokZxmmk
MJLsgP85dIGEm/ZPpE/WplgKHoc2eCAo10mEmNjI50PpADZURdVMoKjSN8JNKN0m
p0FiuDG4WJJ6lJTKUwrA
=z+am
-----END PGP SIGNATURE-----

--0qVF/w3MHQqLSynd--
