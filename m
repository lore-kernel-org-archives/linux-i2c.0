From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: powermac: Use of_node_name_eq for node name
 comparisons
Date: Tue, 11 Dec 2018 21:16:47 +0100
Message-ID: <20181211201646.2mdjgpp4ilwzwvja@ninjato>
References: <20181205195050.4759-8-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="km33xnxufwac6hzc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181205195050.4759-8-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-i2c@vger.kernel.org


--km33xnxufwac6hzc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 01:50:24PM -0600, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>=20
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-i2c@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-next, thanks!


--km33xnxufwac6hzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQGyoACgkQFA3kzBSg
KbbPEw/+L0vejcqiYVgjvQOhSRuegssHy7hONbA6r+I/ys7bfqO5LSl4oWZJQ32U
vQ0ugyxLVAdghU1RgWu0G8I4iazxA0kdn+dYJYd02tQsCyNNrvJN68Xp8rvSIOCf
H2eAN38HDfIIJxVBcxg6v+roiN0QBL3G+2HO1UdkAgni2rEOPDH2G62G0XKxVUiq
LOCz0kEqz2gZ0WlZyjV3+J1iP7HIyW6dqtiOuEkwO43UvOqKkYyccr+n18gSS57e
IEVK1JSfpf8ULyEl9gw01KTjPNzL2ZTIVLO3rLKRc4zMEQsSw7grbJHls3or7wk3
LKHvEMwDd8Ba2e0ukKZZkap1Vpz6wL8+Yj8aDZy9dZIzDZUIzaVHB18VyKd4p5Wa
hzXGTqg5WzZzoBp88wS3mQPKSwHpkm8ab69CBFSXOgduEo330oy4I8cOyPn+e3g5
Ub6bMH+fx/JhEv585+Bm1j5AN9hYU6KvBwxdTk7pDkb9e3d+ftqpPLAddJ6Od3P1
DvgU3QCf6pQoiwLO4pQ6kJUZACemldzo6Ycqvs+d3DqnkyVN7s0zpm5CSI26ycRM
oYGJQ8SLF5WORxOqN6j4qFJsFnvNKNIjxUT1NYD6rxFQH9JQ5A9tSTw1xFNGxcLP
7VrqEdm+5axqylDRa4+QqyNW7M4qMVqebS0/eGFeXcgpNzMvFb8=
=psiU
-----END PGP SIGNATURE-----

--km33xnxufwac6hzc--
