From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c/ARM: davinci: Deep refactoring of I2C recovery
Date: Sun, 31 Dec 2017 00:10:33 +0100
Message-ID: <20171230231033.agmapevszacyqje5@ninjato>
References: <20171220121749.12064-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6iuwk4qgmt5sbk3"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:32816 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbdL3XKe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 30 Dec 2017 18:10:34 -0500
Content-Disposition: inline
In-Reply-To: <20171220121749.12064-1-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arm@kernel.org, Kevin Hilman <khilman@kernel.org>, Keerthy <j-keerthy@ti.com>, Sekhar Nori <nsekhar@ti.com>


--d6iuwk4qgmt5sbk3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2017 at 01:17:49PM +0100, Linus Walleij wrote:
> Alter the DaVinci GPIO recovery fetch to use descriptors
> all the way down into the board files.
>=20
> Cc: arm@kernel.org
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> Tested-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to for-next, thanks!


--d6iuwk4qgmt5sbk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpIHOUACgkQFA3kzBSg
KbbGAQ/+KenLKRR0RWOgrY86v2MrLu7gx/2a5kx4MnoDg2AwucOF2EvnlkvLzBEQ
R7nnFU1dcRU2LJ92d8f41YRzA4RGddq3c8iszKI3++Xy6N19uE/glvDjQ0pWCoCI
xvB6q3nPXI7A+HhAIKoQZJ4VzA/Q2ETg8ReUY8zAEAJFBbbO4uBiZCD82OXyFRpx
FW5h/aiyODGpy4ZWrS+QawttmjZ3itwa90+NTq5pbWdFHQ+CFJxCJ08GH+ClYZ+b
p/RsdiD6bfSn2rZ0bFC1rr9xg70GKofqmRHZL263EKK1vKxYkH1RpCzpNJNRKaUr
Or8ubWgioo7lOcKIARtlOSNLS9ZwH66L/kAepR8scYYgvCSxBLo1Smdjb1+oaUoh
XGW9VYpsXptXTZn/hLKdNkeSCsj0Gjwk3ApmqswGrVRi5LKsJpQcSwaAsgqqNxbk
bCCrfdhGc0dMcMFvAYV/C3bxybtngl2DKnBpMzITbh1deDXCNPE59CR/NfRZKQ24
ecs6LfQ9Xg49efwqxqdLZwXd3r96xXWs8o+7RTVZW1h2MaqfbCScp8vwEQeflfoU
OquwKNElzuhqTAQw6FBMtHo2daWOYCu67Ek9nbxL8JY0Hp1F2HG67+Z01QwwrVLJ
bAAjsPlphRZvxjGm3vu/ccoeZsY3luEjo2mBa1MgTFecmYWQOMc=
=Xfps
-----END PGP SIGNATURE-----

--d6iuwk4qgmt5sbk3--
