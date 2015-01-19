From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC 01/11] i2c: add quirk structure to describe adapter flaws
Date: Mon, 19 Jan 2015 16:00:11 +0100
Message-ID: <20150119150010.GA3820@katana>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
 <1421396295.11671.50.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421396295.11671.50.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Eddie Huang <eddie.huang@mediatek.com>, Xudong Chen <xudong.chen@mediatek.com>, Liguo Zhang <Liguo.Zhang@mediatek.com>
List-Id: linux-i2c@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> This can describe the behavior of our current upstream driver[1], which
> only support combine write-then-read.
>=20
> After checking with Xudong & HW guys, it seems our HW can do more.=20
> On MT8135, it can support at most 2 messages, no matter read or write,
> with the limitation that the length of the second message must <=3D
> 31bytes.
>=20
> So this RFC is enough for our driver, but it would be better if we could
> also support other case.

Hmm, I think we can convert max_comb_{read|write}_len to
max_comb_{1st|2nd}_msg_len or similar.

I'll check but it will probably not before next week.

Thanks for the input!


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvRv6AAoJEBQN5MwUoCm2BtUP/j0J77NsM7yPGZCkW0ukxlje
DlX4KwNdJfkLoKAXA4Mihfl33bzS7Vs7S0LN9ZSAu2wgxp5kl/+ZKMMCIauMLt1o
CYtAZuHvQBMPmsDRyumir597NOE9oDd31ttZs3USzwG5SiIHSGh1yU/MMHezG5Qp
HxyQ42NhSUY55h88FEHm3GrEXCBJ3JS765t7USm6/HriyvHoPrzS+X8dhvPWwZup
u8LRbL10HYHjYNXBo918+KvHvMO8tmVET/tqqShcLsTo1+xadr9p3xzuqu7VwETX
j7UgnJtkpBv1xftkqp3vVNQ6seLPd/ozaIdTfHtnIPlD3f9aGZBIcHS9uOBtwfuJ
ptR0EFR0RYDws84ipI85veGB7QTJOlKonSyGKfSIdvmjMGwSnVCBe2wO6jWv9IWw
d76+/R/53nwI+IyZK99wmzDNfMhK4EVybKzdLqtt4/7RYlifGB79Vrorlo9t26hD
XnJNxUAJZiwn9yaoeuKI/pH67tGKfjMGe3A7+HISdaSwwAn5aLLWggBeI9pIHB6r
ZeoXhSXK3RskAM5/50OpwPfXn/oMCq/XUBycBRJwXzQs+ab49wD+ptX/QCXqk4N0
vGnrT41MLD+U6mhgwtLqd9idT7U1lg44cbe8lBmnhbhaYwhp+L01HJbaK6ALfEJy
VESLiRjTpngaAEIGYvQH
=GLeY
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
