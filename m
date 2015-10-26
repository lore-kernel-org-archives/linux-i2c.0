From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 0/2] i2c: uniphier: add two I2C controller drivers for
 UniPhier SoC platform
Date: Mon, 26 Oct 2015 10:47:32 +0000
Message-ID: <20151026104732.GG597@x1>
References: <1445597520-6299-1-git-send-email-yamada.masahiro@socionext.com>
 <20151026081746.GC597@x1>
 <CAK7LNATVmVi=4ugv0MgoCUzusphNeAXTC_K-PsXDiTLoCkV4-Q@mail.gmail.com>
 <CAMuHMdXLMRji80Ma9hbUJg_PChS1s2JaGy00L3M3rmyOnYKqHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXLMRji80Ma9hbUJg_PChS1s2JaGy00L3M3rmyOnYKqHQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux I2C <linux-i2c@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, James Hogan <james.hogan@imgtec.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ray Jui <rjui@broadcom.com>, Tejun Heo <tj@kernel.org>, Andrew Bresticker <abrestic@chromium.org>, Scott Branden <sbranden@broadcom.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Pawel Moll <pawel.moll@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Xudong Chen <xudong.chen@mediatek.com>, Mauro
List-Id: linux-i2c@vger.kernel.org

On Mon, 26 Oct 2015, Geert Uytterhoeven wrote:
> On Mon, Oct 26, 2015 at 9:27 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > 2015-10-26 17:17 GMT+09:00 Lee Jones <lee.jones@linaro.org>:
> >>> This series adds two I2C controller drivers.
> >>> (they are completely different IPs.)
> >>>
> >>> The first one is a very simple FIFO-less I2C controller,
> >>> which is used on some older UniPhier SoCs.
> >>>
> >>> The other one is higher-performance I2C controller with TX/RX FIF=
O,
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
> > Using get_maintainer.pl is a normal process when sending patches, I=
 think.
>=20
> Please use common sense. It doesn't make much sense to CC everybody w=
ho
> ever made a minor edit to an affected file.
>=20
> If checkpatch comes up with more than 5 names, this should ring a bel=
l.

+1

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
