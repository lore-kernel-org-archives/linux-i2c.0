From: Lee Jones <lee.jones@linaro.org>
Subject: Re: Why isn't IRQ shared for i2c-ocore
Date: Fri, 8 May 2015 08:27:35 +0100
Message-ID: <20150508072735.GJ16220@x1>
References: <20150420064231.GE3447@x1>
 <55352839.70905@freescale.com>
 <20150420181651.GF3447@x1>
 <5535460B.2060309@freescale.com>
 <20150421073534.GK3447@x1>
 <554A8A8B.1020703@freescale.com>
 <20150507070149.GB3400@x1>
 <CAMuHMdWXFmPWsL4QyjwV+X-mruS0pU2Uzj7aSSxTQDJ=K+32XA@mail.gmail.com>
 <20150508065747.GG16220@x1>
 <CAMuHMdUFj40OjEHOovFVbtOgr92fJeAq41Hf3h+CqsfPm4aSsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUFj40OjEHOovFVbtOgr92fJeAq41Hf3h+CqsfPm4aSsQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: York Sun <yorksun@freescale.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Linux I2C <linux-i2c@vger.kernel.org>, wolfram@the-dreams.de, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 08 May 2015, Geert Uytterhoeven wrote:

> On Fri, May 8, 2015 at 8:57 AM, Lee Jones <lee.jones@linaro.org> wrot=
e:
> > On Fri, 08 May 2015, Geert Uytterhoeven wrote:
> >
> >> On Thu, May 7, 2015 at 9:01 AM, Lee Jones <lee.jones@linaro.org> w=
rote:
> >> >> I have a follow up question regarding interrupt. I see many I2C=
 bus drivers
> >> >> request interrupt with flag =3D 0. Why not using IRQF_SHARED?
> >> >
> >> > Probably because that particular IRQ is only used by the I2C
> >> > Controller.  I'm not exactly sure that you're getting at?  Why d=
o you
> >> > think it should be shared?  You should only flag it as shared if=
 it
> >> > is.
> >>
> >> However, that's something the driver can't know.
> >> Sharing interrupts is an integration property. The same IP core ma=
y share its
> >> interrupt on one SoC, and not on another.
> >
> > I guess that would depend on the IP.  If this is part of an MFD, yo=
u'd
> > know if you only hand a single interrupt line coming into the chip =
or
> > not.  If the IP can be moved around (copy & pasted) into different
> > chips, then yes, that might change.
> >
> > How does one share an interrupt with other drivers if all them don'=
t
> > know the IRQ is shared thought?
>=20
> All drivers sharing the same interrupt must pass IRQF_SHARED, cfr. th=
e
> checks in __setup_irq().
>=20
> Traditionally, PC (ISA) drivers didn't share interrupts, as the ISA b=
us
> prohibited interrupt sharing.
> Amiga drivers did.
>=20
> New drivers should support IRQ sharing.

Precisely, which is why I'm confused by:

  "However, that's something the driver can't know."

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
