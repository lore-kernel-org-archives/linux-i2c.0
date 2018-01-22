From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] Use demuxer for i2c1 and i2c5
Date: Mon, 22 Jan 2018 12:40:26 +0100
Message-ID: <20180122114026.uqozk4cbhfrjwqmd@katana>
References: <1516620563-7965-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xlmzbpnnwlophwkz"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516620563-7965-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--xlmzbpnnwlophwkz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2018 at 11:29:21AM +0000, Biju Das wrote:
> We have observed that on iWave RZ/G1E boards, randomly HDMI slave device
> is holding data line after a soft reboot.
>=20
> We applied demuxer patch for i2c1 and using an oscilloscope verified that
> i2c recovery works on the failure condition.

Do you really need the demuxer for that?

I posted and just merged bus recovery to the i2c-rcar driver. Did you
test that? In theory, this should be enough.


--xlmzbpnnwlophwkz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlplzaYACgkQFA3kzBSg
KbZwtw//WpIo+5pAlGO4H0ONpqHrFZ+MGq2dTJ7/hTHlJWrtQZoJrMp6qwnbSec6
L56W6HjWf9gU1FX9UBiXIuoZ9Jciet2yiOYmqvN20PFu/2XXxli01pSfg0tqY2lt
ZA6/NE3YzWK6u+fU29iW1bloi6jb2VwQVCCRYVcyAqh8YIf2QilPABDn7mQ0claT
i1adoRgiOQM4dtgYHc9NyfJYXEbUD+/KeQbbsnbjBTGOncDdPxe5EHOIUDWUTjhq
FfTXApCuWQp2lfmoNNT5wd0IxRS7dYEYVV1hYvzf65H+sp6NCGMoKut17/7CCLHu
iJWo+LIU7CAstW7apCTzPtO9JXFzSE9VwIoJq1J3QhgHiXQhnBtgI8oku4JWuy7a
rGbJA24SqxxZGqddQkWH8kOEFlKjgVxYUuyMNVU/Elplqi57Fz4WMp+dspHNWrj8
evF+HzRUd4EcG3Q664db7bAKq9IrEes7wJHhrmTjv7AnXKAzS72LGJzp0JFIs+zW
vTLiffhrPtPCucvsBWrZWqjZBQicNGGUPpGJuWeGYmVicAtH3M8FJcf6NI8NuG/g
G/Xv6Sih/W07Gh/jJPe42y5aJ7/0nts7QRTwXidirvMbHHw7stHmEPlaZCOgYnZt
zowqAL3YuUfrn95vET2O8mo2qu6XJgcZ6s5IWz+tXvwRflLrkXQ=
=rF8p
-----END PGP SIGNATURE-----

--xlmzbpnnwlophwkz--
