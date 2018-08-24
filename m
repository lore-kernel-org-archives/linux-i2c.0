From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: Remove '-Wno-deprecated-declarations' compiler
 warning
Date: Fri, 24 Aug 2018 15:01:30 +0200
Message-ID: <20180824130130.bialyhjarwkwodzw@ninjato>
References: <20180819135135.8801-1-sedat.dilek@credativ.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4qlrxwaq262b2c2p"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180819135135.8801-1-sedat.dilek@credativ.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sedat Dilek <sedat.dilek@credativ.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-i2c@vger.kernel.org


--4qlrxwaq262b2c2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sedat,

> This can be dropped with commit 771c035372a036f83353eef46dbb829780330234
> ("deprecate the '__deprecated' attribute warnings entirely and for good")
> now in upstream.

The pull request removing attach_adapter() is on the way now. Thanks for
triggering all this!

Happy hacking,

   Wolfram


--4qlrxwaq262b2c2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluAAaoACgkQFA3kzBSg
Kba/Kw//SfMPEGby0Te5xq3rsh2auGUmBcNYGxLpQECdRjXFnIkyco2rbeSvpttb
NVtskxsNZW8Cc3XbzpM61cCwKXS7iw/VULmC5aNE3JB5h1vVuptZuf7FveSdNuaB
Plw2O00zjU6lflN39tdMyHEMtqc2tVyJQscH/B6dsz6ps6wDyLTStpdv4f5C/z9J
sRvLa0iHeBpd9VignMAVIpQ+PofWDb41PEPssLvEN65htOcD51u60AOXb+qQPo4t
hHUx2Foo8eXE1GP4Vcft8GSDdsqON6I/RoPPVVJMqY2RQ8UtaoDyeG+SjWDuIn/P
WFsPoDGm0Q1MLDL60yqui0KNEpNVRUZ8B5EfQ04NsPuOnC7W7uaXyeTlagP39vyV
Nw6UHEt8SI4m+eHh47I2VPZ6flAjf/+5H0WhPcuf3fMe5BYLmWfIVyeRoSEez0gd
GMp/ITvFPB/reYRoA5PlLowgjoJpVElee9s/FtvuBkCbOh8+soBMur7V1W1Bouia
qc6b4CLDBmNCoO4iF+bQRCYNZ7naN/1331kLbpScb5GqRs1rFkelN2vIamwc6S6N
GOgk9A6QxBwyhVupSbk2NVGy7vcOqUMRJQffZC5179HKziYAI6QB6oqprx/3hN1o
tPw64sefWKA40n3oQDE8/srMevDr/OItEHFgXY86Wci+RMLOm0g=
=e7D7
-----END PGP SIGNATURE-----

--4qlrxwaq262b2c2p--
