From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 0/3] ARM: mediatek: Add driver for Mediatek I2C
Date: Thu, 7 May 2015 09:27:00 +0100
Message-ID: <20150507082700.GE12484@x1>
References: <1430901427-65146-1-git-send-email-eddie.huang@mediatek.com>
 <20150507073900.GC12484@x1>
 <1430985284.22615.3.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430985284.22615.3.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Box <david.e.box@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Xudong Chen <xudong.chen@mediatek.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, Liguo Zhang <liguo.zhang@mediatek.com>, Wei Yan <sledge.yanwei@huawei.com>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Ray Jui <rjui@broadcom.com>, Beniamino Galvani <b.galvani@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, Anders Berg <anders.berg@avagote>
List-Id: linux-i2c@vger.kernel.org

On Thu, 07 May 2015, Eddie Huang wrote:
> On Thu, 2015-05-07 at 08:39 +0100, Lee Jones wrote:
> > On Wed, 06 May 2015, Eddie Huang wrote:
> >=20
> > >=20
> > > Eddie Huang (1):
> > >   I2C: mediatek: Add driver for MediaTek MT8173 I2C controller
> > >=20
> > > Xudong Chen (2):
> > >   dt-bindings: Add I2C bindings for mt65xx/mt81xx.
> > >   I2C: mediatek: Add driver for MediaTek I2C controller
> > >=20
> > >  .../devicetree/bindings/i2c/i2c-mt6577.txt         |  41 ++
> > >  drivers/i2c/busses/Kconfig                         |   9 +
> > >  drivers/i2c/busses/Makefile                        |   1 +
> > >  drivers/i2c/busses/i2c-mt65xx.c                    | 748 +++++++=
++++++++++++++
> > >  4 files changed, 799 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt6=
577.txt
> > >  create mode 100644 drivers/i2c/busses/i2c-mt65xx.c
> >=20
> > Again, you've sent me a patch-set that has absolutely nothing to do
> > with me.  Can you please stop doing that, my inbox is full enough
> > already!
> >=20
>=20
> Sorry, I use "scripts/get_maintainer.pl" to get mail receiver, and yo=
u
> are on list.

Yes, the "Commit Signer" entry is the bane of my life.  It's best not
to Cc everyone who has every touched a file in a given subsystem.

> I will narrow down receiver next time.

Thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
