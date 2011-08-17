From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: I2C_ELEKTOR should depend on HAS_IOPORT
Date: Wed, 17 Aug 2011 11:39:10 +0200
Message-ID: <20110817113910.47dc819f@endymion.delvare>
References: <1312802446-19154-1-git-send-email-geert@linux-m68k.org>
	<20110816195033.014f302b@endymion.delvare>
	<CAMuHMdUk_xTwGbhG0MHkS-8rkF76b1fg193pPcs+9MVyB-qHQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUk_xTwGbhG0MHkS-8rkF76b1fg193pPcs+9MVyB-qHQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Hans Berglund <hb-wBUg6WsUcUgXWF+eFR7m5Q@public.gmane.org>, Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 16 Aug 2011 21:14:42 +0200, Geert Uytterhoeven wrote:
> Hi Jean,
>=20
> On Tue, Aug 16, 2011 at 19:50, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> > On Mon, =C2=A08 Aug 2011 13:20:46 +0200, Geert Uytterhoeven wrote:
> >> drivers/i2c/busses/i2c-elektor.c: In function =E2=80=98pcf_isa_ini=
t=E2=80=99:
> >> drivers/i2c/busses/i2c-elektor.c:153: error: implicit declaration =
of function =E2=80=98ioport_map=E2=80=99
> >> drivers/i2c/busses/i2c-elektor.c:153: warning: assignment makes po=
inter from integer without a cast
> >> drivers/i2c/busses/i2c-elektor.c: In function =E2=80=98elektor_pro=
be=E2=80=99:
> >> drivers/i2c/busses/i2c-elektor.c:287: error: implicit declaration =
of function =E2=80=98ioport_unmap=E2=80=99
> >>
> >> Since commit 82ed223c264def2b15ee4bec2e8c3048092ceb5f ("iomap: mak=
e IOPORT/PCI
> >> mapping functions conditional"), ioport_map() is only available on=
 platforms
> >> that set HAS_IOPORT.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> >> ---
> >> =C2=A0drivers/i2c/busses/Kconfig | =C2=A0 =C2=A02 +-
> >> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconf=
ig
> >> index 646068e..d1fc5cf 100644
> >> --- a/drivers/i2c/busses/Kconfig
> >> +++ b/drivers/i2c/busses/Kconfig
> >> @@ -789,7 +789,7 @@ config I2C_ACORN
> >>
> >> =C2=A0config I2C_ELEKTOR
> >> =C2=A0 =C2=A0 =C2=A0 tristate "Elektor ISA card"
> >> - =C2=A0 =C2=A0 depends on ISA && BROKEN_ON_SMP
> >> + =C2=A0 =C2=A0 depends on ISA && HAS_IOPORT && BROKEN_ON_SMP
> >> =C2=A0 =C2=A0 =C2=A0 select I2C_ALGOPCF
> >> =C2=A0 =C2=A0 =C2=A0 help
> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 This supports the PCF8584 ISA bus I2C =
adapter. =C2=A0Say Y if you own
> >
> > How can ISA be set if HAS_IOPORT is not? This shouldn't be allowed.
>=20
> It's always been like that. With CONFIG_ISA, we have inb() and friend=
s. But not
> ioport_map(), which was introduced more recently.

OK, fair enough. Patch applied, thanks.

--=20
Jean Delvare
