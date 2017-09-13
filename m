From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
Date: Wed, 13 Sep 2017 22:55:44 +0200
Message-ID: <20170913205544.iatsjsb3ffohruwi@ninjato>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <CAMuHMdXabvax2Wru8j+MC4X5F+z5hoUo1tEbX+zn2AUW6QENVA@mail.gmail.com>
 <CACRpkdb4LQAqyWpRAWGRxUOcTbWVksNc3FTWdPnYNE-AUHtfgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rpjnafryku246gtn"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43430 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751253AbdIMUzp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 13 Sep 2017 16:55:45 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdb4LQAqyWpRAWGRxUOcTbWVksNc3FTWdPnYNE-AUHtfgg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Steven Miao <realmz6@gmail.com>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>, Ralf Baechle <ralf@linux-mips.org>, "arm@kernel.org" <arm@kernel.org>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--rpjnafryku246gtn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> If Wolfram likes this series, I volunteer to rebase your patch
> (oh well rewrite patch 2 from scratch, haha) on top of it as well
> so he can apply the whole thing.

Yes, I like Geert's series. Merging the two series sounds great to me
and is probably easiest, but I'll leave it to you guys how to upstream
it.


--rpjnafryku246gtn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlm5m1AACgkQFA3kzBSg
Kba9IBAAn7uOLxskwT8kgRTLzPXBB74aK9mmLaD1FQwvVLF0EcVoFYod987Zg3WA
1QecZTUcKAqDFjc4HHUbHrzX8C/QrsKl2Bj+u8lt+iFkn5hlwpmE+mwjtcyT8OZF
Lb8tMzKH3fLxBN9aSjMzt7klbhl9y1CFxOlKVueNEuY0ienwMG4NZAsBhWEoJwe+
BCoeWK75P9Us1WFH4SbWqcxa5CMPfSfTTu0Rc8p1DFFrbo+ibjOAIcNNv/ac1RTT
b1fdMo+8NEJjW1rnyB8l50IbevhgtWpPRrYsCl0dRWUZeKdbu5crT006V/28CCpV
cc25Q+VGyBtGmTdtMtFIJBeRLrl6p3P1QS6d+/KBgZdYkbp5FKsjoXxGa1pQh7Lw
ssPm9LLwPJ8uGvP1gjZnOWgOEjdpWO53QqrUKS2fXuJEsQQDwdMmK4V4MHY95wk9
DDOnJ1YgeX6MbcfjS6j6lu6pwdji0g6IRIOYL1gCirTkDX/OpCAftRnbTVYwpuqR
FwU3xhNXz1p4eDy43DlTNmiCmugkkkYWx3DQLymCIoHjWbXP3/mVNzenF65eKUBr
wOgco1nJwC/1ktq7JEbZJ6jFce/TP5zGk/q69SCFZ3+mKhd/b07i/QIcr2yA0Vya
4jjqwNmJxWTYRyf3Dcsjb9ybA95VgL5SNkW3e7w88kA25QdmwdU=
=v60d
-----END PGP SIGNATURE-----

--rpjnafryku246gtn--
