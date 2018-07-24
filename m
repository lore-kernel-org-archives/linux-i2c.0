From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Date: Tue, 24 Jul 2018 18:04:07 +0200
Message-ID: <20180724160407.jdjofll5clmzwnr2@katana>
References: <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
 <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se>
 <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <20180720151751.242d4809@bbrezillon>
 <CAK8P3a14_6uf9VLYU0YnmFp0Q=DZBKc0cAesBh0opanGDZMFRA@mail.gmail.com>
 <20180724162806.318a92c6@bbrezillon>
 <CAK8P3a3YQbiiJMTHTVh63fOvtA1sa0J5Eb4z7xbnpBPwUDkqxg@mail.gmail.com>
 <CAMuHMdXif_iufXx0Y+UJjKs9TNLfrTONoFvUSyrpkfaT0=ydRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azurd2khkr4qdjyu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXif_iufXx0Y+UJjKs9TNLfrTONoFvUSyrpkfaT0=ydRQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Boris Brezillon <boris.brezillon@bootlin.com>, Peter Rosin <peda@axentia.se>, Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@ar>
List-Id: linux-i2c@vger.kernel.org


--azurd2khkr4qdjyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The major disadvantage of reprobing is that it may cause visual disturbances
> when i2c slaves are involved with e.g. the display pipeline (think HDMI encoders
> etc.).

Another one is that you might find bugs related to re-binding which can
be surprisingly hard to solve... IIRC we had a case with the regulator
subsystem where rebinding the PMIC which regulated the CPU is still
unresolved. I think. I'd need to recheck to be sure.


--azurd2khkr4qdjyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltXTfcACgkQFA3kzBSg
KbZJMRAAoASg3Xz5S+EiFA1oGbaG/eYs1kMV30Fa71M1Aw2ZMbiMSj80M+O2u6e9
mAcE/YmG6C6Kjmoq/kqRCxH2ow0lq2XYwKDskvb/F7VqEJSK032gaeSR8SM8LAzf
Kfw11CLk69jkkg8n7pEcP7Y7RQA/5rkcOQ6xCKAmHlcbK6cO60C0CFjZNEp0u8wI
bFooAy0YP4kq87YwEv+He6L2Gc0/B9oHr/38ZVacpIKy6/f+5pV62jy2vlN03TqZ
an5lQhn1E8FvGmv9sP4fYXXs37luC2gVooB/Vif+klUKBXeio7Mv37Y6qLhZq7m8
08CUDc9tRUrZwdd4aBiMHEVH8bxbuu9MIWMGoOoRy9lYDY1GygJ+t3BBTs20LPqw
C8CInPnUHAw65GAn5v3BmD408JNAjCFvlQxeuh9kAgPovvA5lh2WCg7SCPCNan0x
X1nST092EdDP8kq4F8wMRRnvvs5VTZC44cpjxx4le6WfF0PnIa4QN5RSFpGm3Hg1
Vpu2m//myn8kv9PKH9FBBNcSMKbSCbYq7IX0IEkLJ76CHwoQlE/COdG1hG2TL4JM
bJcwi1GlHB7D1UnfHGfo1QaBkEaAEJy/lwVWreNsj1x7FOfClu1LnjCJe0vTmY9s
Ce2zyepKxfrrygojEkVZyBOeZFPmvsXvywu0tUP2+8CLFq0ssEw=
=Or7q
-----END PGP SIGNATURE-----

--azurd2khkr4qdjyu--
