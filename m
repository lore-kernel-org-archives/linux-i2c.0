From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 0/2] i2c: uniphier: add two I2C controller drivers for
 UniPhier SoC platform
Date: Mon, 26 Oct 2015 09:35:41 +0100
Message-ID: <20151026083541.GB3041@katana>
References: <1445597520-6299-1-git-send-email-yamada.masahiro@socionext.com>
 <20151026081746.GC597@x1>
 <CAK7LNATVmVi=4ugv0MgoCUzusphNeAXTC_K-PsXDiTLoCkV4-Q@mail.gmail.com>
 <CAMuHMdXLMRji80Ma9hbUJg_PChS1s2JaGy00L3M3rmyOnYKqHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXLMRji80Ma9hbUJg_PChS1s2JaGy00L3M3rmyOnYKqHQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Lee Jones <lee.jones@linaro.org>, Linux I2C <linux-i2c@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, James Hogan <james.hogan@imgtec.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ray Jui <rjui@broadcom.com>, Tejun Heo <tj@kernel.org>, Andrew Bresticker <abrestic@chromium.org>, Scott Branden <sbranden@broadcom.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Pawel Moll <pawel.moll@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Xudong Chen <xud>
List-Id: linux-i2c@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2015 at 09:31:15AM +0100, Geert Uytterhoeven wrote:
> On Mon, Oct 26, 2015 at 9:27 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > 2015-10-26 17:17 GMT+09:00 Lee Jones <lee.jones@linaro.org>:
> >>> This series adds two I2C controller drivers.
> >>> (they are completely different IPs.)
> >>>
> >>> The first one is a very simple FIFO-less I2C controller,
> >>> which is used on some older UniPhier SoCs.
> >>>
> >>> The other one is higher-performance I2C controller with TX/RX FIFO,
> >>> used on newer UniPhier SoCs.
> >>
> >> And you have sent this to me because ... ?
> >
> >
> > No special reason.
> >
> >
> > I sent this series to linux-i2c@vger.kernel.org.
> >
> > I guess you were automatically CC'ed by scripts/get_maintainer.pl.
> >
> > Using get_maintainer.pl is a normal process when sending patches, I thi=
nk.
>=20
> Please use common sense. It doesn't make much sense to CC everybody who
> ever made a minor edit to an affected file.
>=20
> If checkpatch comes up with more than 5 names, this should ring a bell.

I usually use get_maintainer.pl with --no-git-fallback to catch people
listed in MAINTAINERS only. But mileages vary a lot in that area.


--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLeXdAAoJEBQN5MwUoCm2ZQYP/1CtX3DoCZR8Vx9phfpi1dIQ
v7Yre25PLXD8l7xt67A8W9wTB5xgzoHht6p8UAT5Bvw/EPX7O1S8vW6nEgsUI/4L
SoTWtwkSQXp0YYgjvU02sbTk5+o4AVMoiBj/tW7QJaCSfqrb2C5Mzca2Ho+mwqpv
jZWbtVUkmedUfprVzlEXWKCNGAwtptn3mH4p9YwASgYYbL/u1lkPECRvNO9rg6bT
/9JOyPMZecdz62X0XKWzZaDwl1mSBe+U24CF4DYhubIHxUOxjveA4UarGk+zCcFU
fPCLJdRoNCIkqzwKzr9aoo2y4/hX/KGFZM5pozB4+ejqcPD415WZfywldwxAtgGv
Ri4oZheG7FR50DWN6DhWiBGeeD0M95A614X3Jf107qO/dUkK7bPab7blIqS8OsyR
U1yOlNBx0Y2LdG1T7F9pmEtUPswEYyyhwry+vNJieAFAAJ+GqrKN4jiQFZ8vXj4m
ZLUX7kBxZ9ffWiz0DrNvxnl0wk4wt5NU5ra8k5G9DSsod65toUaTKwPHgd+1habO
qPekDvtAOGQMWRgwoFKx8FLAw8Ec/pkwMdDNEZR+0hVcKnXoDFYEovVIyxlCkfh5
0ZEnjO5x0a0xRzgiyJHCEYpkZIR8RmhWcFZDj1Mb39RazQdM+brPUrS8zxZX5zp+
2bcu/2Y14Z6jvrMxowlX
=ENLE
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
