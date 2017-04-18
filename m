From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC] i2c: rcar: reinit hardware on resume
Date: Tue, 18 Apr 2017 09:07:49 +0200
Message-ID: <20170418070748.GA1431@katana>
References: <20170417183249.19128-1-wsa+renesas@sang-engineering.com>
 <87y3uyy2sl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87y3uyy2sl.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Thus, just calling rcar_i2c_init() is not enough ?

Yes, where is my brown paper bag...

I noticed this yesterday as well before falling asleep... ;)

> But in my opinion, all register settings should be merged in one please
> (= transfer function) and call pm_runtime_get/put there only.
> R-Car I2C is not related, but I2C power domain might be
> power OFF if SoC has power domain control feature (SH-Mobile has it).

OK, so you want this feture even if R-Car is not affected? No problem,
just want to make sure. But yes, this is a seperate patch.


--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY9btEAAoJEBQN5MwUoCm2AgIP/A+7AgboC4VvRknTvHedQnG4
vRc8vkiRhKBdm4xVJCTcOsz/1/1jkwLfSNKKrNizomXgZ9jh4umXPTPo4KoMxgOL
jbr/En+rITap7hjEg7T9fvFKXMp+6zdrQTq3sqV7WdEr9IzbfC6SXrGnBm6ciC5O
j5bGq3/SnYWlAoKoEznSGkkAh1BOsTFAWRYQ5dSVj/Uy3mkOReIy5Pj/Dm1jS1wg
0Chv9AQAecPw2KuDCj+qpqOkz3xaEv8cYmJaVoh0bov/z2XL6ycw6aE+bUXrNnxY
yYFiVjN3VEP/V4nMPRUZBdNDWf5rmqrT6j3D6ibVc7XU4NlXHWnnSJ9zfeV6W9l5
jSDSKoGaKgdFKOO3oLV2uZ/o8Cimd8hv7B/AudvwYeuniBops3t7x6iksX6fDUwL
9LYd+bVe9u1ItFs1X67xyavnxxUFvuiXxAT9UPIipn0T3ehEXFSjQrXmwLShznra
ADQgwB4ckT/19/YzV3DhjAMFaIeveuncA563n4Q8d1bQzMVQpfdcsuhr1M1tfbo4
hfnY5zgcwnPDgQB1IK8b27zHG9SH5N0Pk6ER5n/6RYlpZDnIOZDidms0qPUGxu4o
vY6+Pl9qiv3SDARPBvf2jeEcdjMvqhhO1ELHNVhsq+6qh/7bHsgV/w9WwL9VMuq9
BuCQ+tzK7JECks7+z0vT
=1tON
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
