From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Fri, 20 Jul 2018 13:05:49 +0200
Message-ID: <20180720110549.zgre7f7x7jkrbyt7@ninjato>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
 <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xkvhz6jgoqk4tzls"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Rosin <peda@axentia.se>, Boris Brezillon <boris.brezillon@bootlin.com>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.c>
List-Id: linux-i2c@vger.kernel.org


--xkvhz6jgoqk4tzls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> * What I understand from reading i2c-demux-pinctrl.c, a slave device
>   will only ever be observable from one master at a time, when you
>   switch over, all children get removed on one master and added to
>   the other one, to be probed again by their respective drivers.

Yes. The very first versions of the demuxer tried to do it in a
hot-swapping like fashion but then I switched over because of...

> it definitely opens up questions in what happens to e.g. the sysfs
> representation, lock order, and power management that I'd rather
> not have to think about.

... this! There are dragons, I can tell you :)

> * The other thing we definitely have to support for i3c is to deal with
>    handing over control of the bus between the i3c master owned
>    by Linux, and other masters that are /not/ owned by the same
>    Linux instance. This is the part that the spec discusses in much
>    detail, with the intention of temporarily giving up control of the
>    bus to let another master do its thing on a shared slave without
>    user interaction.

I can't comment about this one.


--xkvhz6jgoqk4tzls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltRwgkACgkQFA3kzBSg
KbZY3w/9Fp795KxCTRbIxeQgXGj98k3Bl1La27iUL2CwndG4xQaRfaVIEkXTTCfF
5mFk/Ui4wzofIK3d6s97bmiu3WyMG+wR6rIEB7ikVZUeuGbXmSrygcidPkCbw7ka
EDrbnA+Sfj5+a0yOUGquZ6sho2+jFeTnTIG2zRm8vsbqXqHkqZMrFrrf5EFH27GH
stpmRZhfHzimbLLbq5fw1Q0GdPz2g5xlMbioBkGGVq4Q26B2XE4Ggp26UcGlyraF
wBEfTYW23JQ/uepPhvxVR/Cj63s9hq5e4o4YMb9PJsTmJ/FG4Ja317hYc0MR+jS8
6G5eYdzve2P+6tz0+syo8OVS0gjWSm1b7XXsYpeeZtoM2/2sDHMrEGPkvsfrLtBQ
2xT9SrClmT8SX9Sc3rQEFJNxlzVTv/bp+kfMRnN1DVG+Aa6KnPLJxoLhfMapEzgf
JUZ2fZs35Puo1Aw/dQWuBQiqvPpqyd4PEsC/f0WiebQYviXnDgXpV3WmEwCAWOyz
2qVFZwYoQ3LuzOVSNLY42FDyHAgrS/TOzKP2WExlFIin0yyjCmEWBmhwH5Tfr9ww
MMzy3E2VIFpHlFEW4LwhbheT7BMt3Rrn42aJ+7FBw8NVgsTTuublb8F+tt5fN1B8
mX9y6VFUJWd/BMf/RIYNB3HZCxIwvRAJWYuv0SwWighqYetB0NU=
=qblC
-----END PGP SIGNATURE-----

--xkvhz6jgoqk4tzls--
