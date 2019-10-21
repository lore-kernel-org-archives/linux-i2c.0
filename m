From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: Aspeed: Add AST2600 compatible
Date: Mon, 21 Oct 2019 14:23:12 +0200
Message-ID: <20191021122312.GH1145@ninjato>
References: <1568392510-866-1-git-send-email-eajames@linux.ibm.com>
 <1568392510-866-2-git-send-email-eajames@linux.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1568392510-866-2-git-send-email-eajames@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, brendanhiggins@google.com, joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org, mark.rutland@arm.com, benh@kernel.crashing.org
List-Id: linux-i2c@vger.kernel.org


--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2019 at 11:35:09AM -0500, Eddie James wrote:
> The driver default behavior works with the AST2600. We need a new
> compatible though to make sure the driver doesn't enable AST2400 or
> AST2500 behavior.
>=20
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied to for-next, thanks!


--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl2tozAACgkQFA3kzBSg
KbYdpBAAnGFjPjHU1RjWdIIjcluWngIiPZ4G1nJ1990ogSV1Q2RKuhVRRP/w2D4B
3iUiqcFxj86bwQdXxTo+Jesvj9OJw7oHgG8x8aP7cUdSDU2PyB+hhl1kOFj3qKd4
oLsEDK9yftYvg7VGs56wq7IOM4VkVTEprq7x/2Hf7eIt6t8XEk+YI+op9mjmendq
6yGM9zspyjGyOwyuTpS6zzcGtJ+pHIOkiV9sju5nvaO0UuhzoMFC35kpLYZbm+rX
go8RSN/CAgOkeeEBYpeUvKnZLk1Ml/nZ/FdR/YCUDkrvAJjkKqBF3LEuLS6+8iE4
Un/QFG6OEKLCEQu9KVU4dVovTXGjILK7zpvwPW/gr3U5jeJH4c5xto+agWLA8G3F
q1UWh6GUq3FV4fEqo0InpazTuEdUcBnIcbPZR/QMWSIoE4CWD2SCQoAHyzk3Jrma
Seyn0WZEMe2zJfhVQXHidgCbc0gO0NYjPqMQeHYhCnWfhk3pJVfzqKJSLCNsJbBX
xubXKQu3hgZRGv6vqvPZpRp0ItOYL0lv0TCdTu/f5Maxv0cZ3xzCrU7ZndRcaKtE
QfhMiXOMjhk5H0VRujNpLN5bHH2RDnGOqW4xeJukteVDidyFLJCQMUkEsVAK1y3p
FUC3TuW6Oypz7/zx74MgTGZFagWixLFBXz6qzEt0rp+6ANibX/4=
=a1zx
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--
