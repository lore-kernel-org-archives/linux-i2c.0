From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v6 0/3] ARM: mediatek: Add driver for Mediatek I2C
Date: Tue, 28 Apr 2015 12:08:12 +0200
Message-ID: <1430215692.4445.16.camel@chaos.site>
References: <1430209869-6631-1-git-send-email-eddie.huang@mediatek.com>
	 <20150428100206.GL11956@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150428100206.GL11956@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Eddie Huang <eddie.huang@mediatek.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, David Box <david.e.box@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Doug Anderson <dianders@chromium.org>, Max Schwarz <max.schwarz@online.de>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Anders Berg <anders.berg@avagotech.com>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Simon Glass <sjg@chromium.org>, Jim Cromie <jim.cromie@gmail.com>, Wei Yan <sledge.yanwei@huawei.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Beniamino Galvani <b.galvani@gmail.com>, Xudong Chen <xudong.chen@mediatek.com>, Liguo Zhang <liguo.zhang>
List-Id: linux-i2c@vger.kernel.org

Hi Lee, Eddie,

Le Tuesday 28 April 2015 =C3=A0 11:02 +0100, Lee Jones a =C3=A9crit :
> On Tue, 28 Apr 2015, Eddie Huang wrote:
>=20
> > This series is for Mediatek SoCs I2C controller common bus driver.
> >=20
> > Earlier MTK SoC ((for example, MT6589, MT8135)) I2C HW has some lim=
itationes.
> > New generation SoC like MT8173 fix following limitations:
> >=20
> > 1. Only support one i2c_msg number. One exception is WRRD (write th=
en read)
> > mode. WRRD can have two i2c_msg numbers.
> >=20
> > 2. Mediatek I2C controller support WRRD(write then read) mode, in W=
RRD
> > mode the Repeat Start will be issued between 2 messages.
> > In this driver if 2 messages is first write then read, the driver w=
ill
> > combine 2 messages using Write-Read mode so the RS will be issued b=
etween
> > the 2 messages.
> >=20
> > 3. The max transfer data length is 255 in one message. In WRRD mode=
, the
> > max data length of second msg is 31.
> >=20
> > MT8135 and MT6589 can control I2C pins on PMIC(MT6397) by setting t=
he i2c
> > registers in MT8135 side. In this case, driver should set OFFSET_PA=
TH_DIR
> > bit first, the operation on other registers are still the same.
> > For now MT6589/MT8135 support this, MT6577/MT6595/MT8127 do not sup=
port.
> > For example, If want to use I2C4/5/6 pins on MT8135 just need to en=
able
> > the pinmux, else if want to use I2C pins on PMIC(MT6397) need to ad=
d
> > "mediatek,have-pmic" property in the .dts file of each platform.
> >=20
> > This driver is based on 4.1-rc1.
> >=20
> > Change in v6:
> > 1. Update binding document not use default clock-frequency as examp=
le.
> > 2. Add mtk_i2c_compatible struct and pass hardware capabilities
> >    through of_device_id
> > 3. Remove some hardware setting in mtk_i2c_do_transfer to mtk_i2c_i=
nit_hw
> >    so just init one time.
> > 4. Correct mtk_i2c_parse_dt don't set default clock bug.
> >=20
> > Change in v5:
> > Apply new i2c_adapter_quirks patch [2]. Change to use dam_map_singl=
e to map
> > dma buffer. Add spinlock to fix race condition. Check of_property_r=
ead_u32
> > return value. Remove I2C_FUNC_10BIT_ADDR capability due to driver n=
ot implement.
> > Add MT8173 I2C driver.
> >=20
> > Change in v4:
> > Modify to support i2c_adapter_quirks base on Wolfram's patch [1].
> > Remove check transfer size and WRRD combine code. Instead, fill qui=
rk
> > property and let i2c_check_for_quirks to do the filter.
> >=20
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-Janu=
ary/314804.html
> > [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-Febr=
uary/325744.html
> >=20
> > Eddie Huang (1):
> >   I2C: mediatek: Add driver for MediaTek MT8173 I2C controller
> >=20
> > Xudong Chen (2):
> >   dt-bindings: Add I2C bindings for mt65xx/mt81xx.
> >   I2C: mediatek: Add driver for MediaTek I2C controller
> >=20
> >  .../devicetree/bindings/i2c/i2c-mt6577.txt         |  41 ++
> >  drivers/i2c/busses/Kconfig                         |   9 +
> >  drivers/i2c/busses/Makefile                        |   1 +
> >  drivers/i2c/busses/i2c-mt65xx.c                    | 748 +++++++++=
++++++++++++
> >  4 files changed, 799 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt657=
7.txt
> >  create mode 100644 drivers/i2c/busses/i2c-mt65xx.c
>=20
> Why have you sent me this?

Mind you, I was wondering exactly the same ;-)


--=20
Jean Delvare
SUSE L3 Support
