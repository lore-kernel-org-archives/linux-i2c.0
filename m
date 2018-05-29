From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/6] Fix R-Car I2C data byte sent twice issue
Date: Tue, 29 May 2018 19:25:41 +0200
Message-ID: <20180529172541.nrbvlkolhmlzpavx@ninjato>
References: <1527600796-25901-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180529171957.y2ctsptsnjw6ykag@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d3pfeogoxfwyvit3"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180529171957.y2ctsptsnjw6ykag@ninjato>
Sender: stable-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, stable@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-i2c@vger.kernel.org


--d3pfeogoxfwyvit3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> the first transfer after boot (for whatever reason). And fixing it,
> together with another issue (double address byte), needed all this
> refactoring.

If you want this double address problem fixed, too, you need more
patches of this series up to commit 52df445f29b7 ("i2c: rcar: revoke
START request early").


--d3pfeogoxfwyvit3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsNjRUACgkQFA3kzBSg
KbaREw//TiKnIBymjCPcu8tH4qsa6ubAZT8dp1aCHiCzwto86gsgLW7sWoDDgPHx
cE0ixXYJ8gVxTApzn1JYGTms/3z5H+hrGQxCEwbTG/qaJMdvDjGWaM+jqZI1OXtx
7QdcEz9VI7QgoCwkrNI/F9pvJ6syXRnzg83yGbl4KyY/YDJGShZG2Kn/JJiO7g39
0x0WsCJ6R0K4H4CzgYasLa4qFeEAsy62SMIxATxYJqn8Xvd5pOEev6lGAVpWO8Lb
5+HWjJXbGHyyawabEGdFd0udO1CiUjn+GuRtG+S+xZVyu0dJNa+/rouQT9oB/PMk
z9cr34JbOBTuzefiwZGiRAOLz4f7AmYSXFjKieFfyseu0slqvgo92EtNAGNEzJaP
7KmRU8LKlEWsXVyMZMA7mjLV5CA24feMxKU1qq9DFm4IHdiGu50usP0/yfoR01iZ
LLGZyKwjrp+GZuyNsiy6idaLMTLnLvdQQRnzKgReNSTJyBMaDiTwu9QgvcNOL5JE
/eU7wgJObQLbtN9woTFe9EpNs4T9HFQDfv1abyIh17fe3RiDiapSthv02fKqEZV7
fpyAJBqo/1ouliynUiKVR1ZJgaj9atJV1rxWRAPC0TB/sYQHd7kdRBsU8Bq0UM6M
bE6Wp3hIiLRP4bxxrc7l22QxINO28hG1tt+DFQCk4cASylb7SoE=
=svkx
-----END PGP SIGNATURE-----

--d3pfeogoxfwyvit3--
