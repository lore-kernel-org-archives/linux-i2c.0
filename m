From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/3] Add driver for Synopsys DesignWare I3C master IP
Date: Fri, 20 Jul 2018 23:58:01 +0200
Message-ID: <20180720215801.dmklhwxsgakj4exd@ninjato>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x2lspxohbhnfcm6l"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1532120272-17157-1-git-send-email-soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vitor soares <Vitor.Soares@synopsys.com>
Cc: boris.brezillon@bootlin.com, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, Joao.Pinto@synopsys.com
List-Id: linux-i2c@vger.kernel.org


--x2lspxohbhnfcm6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 20, 2018 at 09:57:49PM +0100, Vitor soares wrote:
> This patch series is a proposal for the I3C master driver for Synopsys IP.
> This patch is to be applied on top of I3C subsystem RFC V6 submitted
> by Boris Brezillon.

Nice! More users will help the subsystem evolve.

Yet, I also think this may be a good timing for a seperate I3C mailing
list? We can always cross-post if I2C is relevant, but I guess new I3C
masters usually are very I3C specific. I think a seperate mailing list
would also look good in the MAINTAINERS entry.


--x2lspxohbhnfcm6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltSWukACgkQFA3kzBSg
KbY5ig/9EK7rk7249vzONpuTF/gM8ZBE6c+8Bxu8bxp0fhItU6oF/+FoNigAUO/x
U2uRGxUChHNyQXeT89+TRC0Hc7IDmUMw5fnLfgUBORinA5IdzYMHZ3TMuT6HMQbR
+8O9wiK4MQMvTQLvWO9Zfeqq+cG8Ra5Ff2/Ahgg3Kh1yNsilspEDeVfCMXc0/Vao
WC2Gam+W70ZaYizAH7PnWgDsB/AP25MC9VKaQqsl7UhGBNKidB+oogPknUm72ePO
Uhq8S3+3uvF98zpGE7dX49+6fm4KYkRj1Y2u1riVUvwrlw+ACJLeCotUqvq71KZH
D6Tb5EcPz+1MIxz5f/ZS7LubxLAmclRvXsYqhF0UcCCGpy0Ppf1hhMGoYEU3gTWf
mFQAlPEY12j/mmqIWGh58LQlMTjH8WW5ns1jz0UHxECu0o8yIAXFIn+QgEgKC1Ap
s1MpAsMotU2keQ+ZZe+iZu+RSjMYhHMl5RPHt8yAqm6fk5kHjitlPVAnwuIEfGrR
xSaAPmFF9BLXZKWHU7nGWJrxcJC1s9SEEinZrNN/p0wezKyRjCTr8u+/WeF6kNWS
fe3MMSF/xrEE2pHSNyRc3lW/rNh9ii7igo8wL5kSyaRvtA9qb6bro8AODZMsz84E
60HCFjRFT7WSK1nb6OlXkjn0R0byc939hZjo/r0voplsChncgmM=
=lZ8H
-----END PGP SIGNATURE-----

--x2lspxohbhnfcm6l--
