From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Mon, 31 Jul 2017 23:42:11 +0200
Message-ID: <20170731214211.GA11776@tetsubishi>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
 <CAK8P3a06GoMdKdn=3Cq0FUwYnjGX0oG+FQLjxfiasVDpbonWRw@mail.gmail.com>
 <20170731231509.77d1fba4@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170731231509.77d1fba4@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Jan Kotas <jank@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
List-Id: linux-i2c@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Actually, that's the first option I considered, but I3C and I2C are
> really different. I'm not talking about the physical layer here, but
> the way the bus has to be handled by the software layer. Actually, I
> thing the I3C bus is philosophically closer to auto-discoverable busses
> like USB than I2C or SPI.

Acked-by: Wolfram Sang <wsa@the-dreams.de>

> Of course, I can move all the code in drivers/i2c/, but that won't
> change the fact that I3C and I2C busses are completely different
> with little to share between them.

That wouldn't make sense.

> To me, the I2C backward compatibility is just a nice feature that was
> added to help people smoothly transition from mixed I3C busses with
> both I2C and I3C devices connected to it (I2C devices being here
> when no (affordable) equivalent exist in the I3C world) to pure I3C
> busses with only I3C devices connected to it.

Yeah, and it is still to be seen how good this really works. Devices
which do clock stretching are out of the question. Probably everything
which needs an interrupt as well?

> This being said, I'd be happy if you prove me wrong and propose a
> solution that allows us to extend the I2C framework to support I3C
> without to much pain ;-).

=46rom all I know, I don't see that coming.


--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJZf6QyAAoJEBQN5MwUoCm2W+AQAKTyNdS0YU2kbP1thGl2b6Vo
ye4IIrpYYduB4NhTI/oy45faAlTF9EvSzboN31T2npYNT6LjBPoPT33X8for7qQv
aMmEoZxiOdgqtwpQEOO8Gi/u6OiA6kX1cUCBU5GIzlnLH2BM788tbC5NONxRL8NN
A34Utk78jxuLssP09e4UKlfJVFkWy4ZpI/MV3mlpl/rzAIek3TlfrT9akmSYEh4V
e38OG0pfupzcLl+QXL4HpkBeZjN/9a87iNvkyaaoirL5rrLmvuHAOnsV7BVlgDVh
2yHAmMHfZcGNOPSEqouGiY0juOHQ1g9zYXEdPSFz84/mVLIxd17/4bV7f5lX0+s4
hDwE7vMtEmn0bKuTFmeFCWlG6YhiRp5Vf3P8hOjQq69ZgyaXPCANpLxbFV1h1Mim
ycl2BkVEkb942W3OSFvkS0eloQzFHrl/tKUV0aeo/rDdBp+LL1MhPg0IMxwNH9Ik
kKSiHSCuw7gsKZfNZbvBLUfCRO26V7PvB9dyVH/rN1igVjDJDDVLvZfSKaxdzvBF
EoybDHvC4zCiuKmgiSIlSh1Y968H7KdIq1p2yKtvTiEonh6AH61uLtByZpPxGDIM
vaVLHpu0naXtBd3qLCw4owiFx6AEq/pAakcWwd7/sgYA8MvNoBx1IBpRbqU89WG3
xXIMLXqiVafPsTSxd0/Q
=pqBS
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
