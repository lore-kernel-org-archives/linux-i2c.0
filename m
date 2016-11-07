From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 0/7] i2c: bcm2835: Bring in changes from downstream
Date: Mon, 7 Nov 2016 01:36:39 +0100
Message-ID: <20161107003639.GC1442@katana>
References: <1475525174-28604-1-git-send-email-noralf@tronnes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1475525174-28604-1-git-send-email-noralf@tronnes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc: swarren@wwwdotorg.org, eric@anholt.net, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 03, 2016 at 10:06:07PM +0200, Noralf Tr=C3=B8nnes wrote:

> This patchset tries to bring in the lessons learned in the downstream
> driver i2c-bcm2708. The downstream clock stretcing timeout patch has
> been left out since clock stretching is broken/unreliable on this
> controller, so no point in setting it.
>=20
> Changes since version 3:
> - Add comment about I2C_C_CLEAR on error

Looks like some serious hacking to get around HW limitations. Thanks for
upporting it.

Applied to for-next.


--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYH8yXAAoJEBQN5MwUoCm2iywQALF3qzdTRX7xnzU+p4719v+0
3gAiRlGfdUk8m/hqsWLjBfTVihpx6uQABUYqVRDjwNtalWgOdgaqAXyXw7yqBX5y
cdnSW1uqnOy/SS25zMUydTp36dR3N3P/GbhmNRTWqZ/9OiOP3cdL04czvJ+9oajA
UypXcJrEiB47XrGh30AxdMxhKET5M/kxkye7rOrC7aeDK7dhBAgeTbcopvtgIJw5
Nrtd8c+JDgRol8fZc7kKanwIfLODit6Evi+zGsfQhwZ9nN3PQhrTKv5UE+ZrdTrx
0Nov9Oa+KLIrhB9tXQ6/4XlDRGVBnUzstNFhTrLl97WtK4ZIv6rrj5zpfILu0o6J
odwqMoxuNZvhWKVziDhpcwhKgFisfqHOGlpz3mM+xZ9zcptv6U6XOGlkvpuDDf0F
sXwQFTrB7L0Mewws1eQErIsmAFxAkPNw8pf7CFYmki2xc2O5QIj2Gj+N0P2rdEVV
JdQGhSEWOQCaOMtRUrHMZIWJjkiTAY8s7q62OK/Th2jqvWfNjj5stryCHHpEoe7+
y+M27mzUBQ5ejARELpfwK65MknKWi/Cf6zgVPu1gb5jeIaXX1qda9vrdypZWAVb3
ir4lDh0XdcBFygLBvIV6n6NJ+hf/0lfD5be9rlkkH7eOoB3hPd/d62JcaEaEQqlN
OKidtn6jt9GiMCZoGWuW
=lxPY
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
