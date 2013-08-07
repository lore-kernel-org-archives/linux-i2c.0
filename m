From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2 2/3] i2c: mxs: Rework the PIO mode operation
Date: Wed, 7 Aug 2013 16:14:34 +0200
Message-ID: <20130807141433.GB2978@katana>
References: <1375219237-9594-1-git-send-email-marex@denx.de>
 <201308061535.50470.marex@denx.de>
 <20130806211348.GA3429@katana>
 <201308070018.12773.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201308070018.12773.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>, Fabio Estevam <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Torsten Fleischer <to-fleischer-zqRNUXuvxA0b1SvskN2V4Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Thinking about it harder, WARN might be more appropriate. Maybe I'll just=
 remove=20
> it altogether, I'll think about it some more.

And when resending, please rebase on top of "i2c: i2c-mxs: Use DMA
mode even for small transfers" which I pushed out a few minutes ago.

Thanks.

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSAlZJAAoJEBQN5MwUoCm2t7IQALWHJsMWxaEOGP4jmlC/XEzl
Uj6wx9mREJe0U+papDfnxuP7c+KJfOgVoLTe2/Z9no9o6fPSemGgLrDxR4dmv7K7
x2GdtcygRgKxbt66jQyM8h4f3jW5fBBVexs8M+iS6rAya+H6r1XMizR+LLjexpIb
knk/AwQVaPuSeDQBCEz7UZ2x5Tw3vjTeU12/rSmxAS9uVFA+c4As/y8wGJnXB1eD
0xoD4jh+xr4Xm3KXWJeowk5SebR/Uckyekpbo5u6XTuf9Y/gnhx6upMz2ByN91p7
4brkckl+gRVIaEQ6M1yEQg+upTHzxhuZE9k+YWppVldXTFQKeZex/dTqSHX0k+Da
4d48WhdIVSwJOJhch2Kvf0y/X687EXuvGwDIgAdLPJIxvP9MdAKWuw0rIBuGn10I
YqcneNJmoMTVbYluBZ04CAeNIu9ax4wX1pkKso68TleYM0j0i1Gx4qmqima/ij5+
Ob2J3Bf3U/O7XI2tNPMaFSCcQP2Q0hr9aLCcYS3xIX/cqZMMr+A/XROn4GNndRXr
nhSvZaUR6CSOEaMbPqevtayxJhhq0Xw078vbsNtO44eMh88/L5PBzLL//LORlbAE
2rjuxRichnbj8bADdjD2QBRq8cXRXD+tpJMpu/J46C3ZbyO2sTY9U4boRhrbdICr
Ans3h70KMSE3W8Cwrg+G
=AdGV
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
