From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Fri, 20 Jul 2018 17:41:32 +0200
Message-ID: <20180720154132.2fwmwpiwtxa73ljf@ninjato>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
 <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se>
 <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <a74a7472-e900-d031-d10b-b12f03ea9ff1@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5qjmuivse67kaw4q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a74a7472-e900-d031-d10b-b12f03ea9ff1@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Arnd Bergmann <arnd@arndb.de>, Boris Brezillon <boris.brezillon@bootlin.com>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.c>
List-Id: linux-i2c@vger.kernel.org


--5qjmuivse67kaw4q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I don't have an actual example for I2C, maybe Wolfram does? But I can
> invent a case. E.g. the speedy DMA-enabled master cannot generate
> RESTART, which is a must for (re-)configuration, but not for passing
> data to the device.

DMA capable controllers may also not react adequate to the slave doing
clock stretching (which is forbidden in I3C).

Renesas R-Car Gen2 has two I2C IP cores. One can do DMA and automatic
transfers to the PMIC, the other has I2C slave functionality. One cannot
do I2C_SMBUS_QUICK, the other can. And some more kind of quirks.
Sometimes you can mux the pins to GPIO, so you have a third option.

This setup is the reason the demux driver exists.

> Also consider some future HW that has several I3C blocks, but they
> are not identical. There's one beefy kind and one slim kind (I'm sure
> you can find HW with different flavors of I2C blocks). Even if the
> HW designers intended for one type of block to be superior in every
> aspect, they might have made a mistake? This HW also has a pinmux, so
> the SW is free to route different I3C blocks to the actual I3C bus.

So, basically this is what happened with R-Car. Now, I tend to think
that I3C is much more complex and noone would put two I3C IP cores into
on SoC. But it was not too long ago that I wouldn't believe someone put
two different I2C IP cores into a SoC. Then again, it happened when I2C
was around for 35 years...


--5qjmuivse67kaw4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltSAqgACgkQFA3kzBSg
KbbN1g//WcDSNStRmr0iBDO0XSjnWhcI+kcUTf8ETxISUPklVAzkORin4E42FKXC
soxRpX/m7z5tU5QjHJRq5MFXFp3JShO3kUpofLAhC6eQt60C75Unk48QP7Doktmg
Rx4OoWOkNwykZEYglRN1pSjdCzu0kRboRsxpAuUD41YVSRebRdzxwXpgVEUeA9pG
W4apNVpmjn1CBxDP9UmM7rE+6hJIUS5tzA0KtRHaF3QoAn2kH1F/c+lHFYaTqSUR
WZw7hcyIOky6ylSQShY2OTV4xurZm8Qx84QE0i+DJ9VENTMuhvZisEKlxm5pSelL
TGWqDNHe16kxNMaheRP/rZVMlbLosbtlhvRrrYwfoH+1M2tl50nk7rDCqd/EBgv/
KIrCprk6tZeSITJUd+GO5Srx3JYD1Cwj0L9wbt0IEHHj+ZamisgO5VhqqqcXcp0e
NXPsp1vcbnoUTNqk7P8yK6UDlhSRoCbcMlQ0BE6hm6qvwYfwLHnLlVnDi9fShsnd
m4ielcyEKVvj8VSufzYNuRy3G0FZmujMJJlnaMa/ZqESjfaRquWlhKvpwDyvghdC
5i0VNH1dAJoCyMejMlMFTLc/4+Gew1I6p0pCmfI5NJDLmyTuQQpRk4lA57qHueY4
4hkWptnUuKNTE1+C7xXKj25gm/lnr4HoF+4aT1H6vI6FNT1y8OI=
=nV3b
-----END PGP SIGNATURE-----

--5qjmuivse67kaw4q--
