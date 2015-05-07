From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 0/3] ARM: mediatek: Add driver for Mediatek I2C
Date: Thu, 7 May 2015 08:39:00 +0100
Message-ID: <20150507073900.GC12484@x1>
References: <1430901427-65146-1-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430901427-65146-1-git-send-email-eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Liguo
List-Id: linux-i2c@vger.kernel.org

On Wed, 06 May 2015, Eddie Huang wrote:

> This series is for Mediatek SoCs I2C controller common bus driver.
>=20
> Earlier MTK SoC ((for example, MT6589, MT8135)) I2C HW has some limit=
ationes.
> New generation SoC like MT8173 fix following limitations:
>=20
> 1. Only support one i2c_msg number. One exception is WRRD (write then=
 read)
> mode. WRRD can have two i2c_msg numbers.
>=20
> 2. Mediatek I2C controller support WRRD(write then read) mode, in WRR=
D
> mode the Repeat Start will be issued between 2 messages.
> In this driver if 2 messages is first write then read, the driver wil=
l
> combine 2 messages using Write-Read mode so the RS will be issued bet=
ween
> the 2 messages.
>=20
> 3. The max transfer data length is 255 in one message. In WRRD mode, =
the
> max data length of second msg is 31.
>=20
> MT8135 and MT6589 can control I2C pins on PMIC(MT6397) by setting the=
 i2c
> registers in MT8135 side. In this case, driver should set OFFSET_PATH=
_DIR
> bit first, the operation on other registers are still the same.
> For now MT6589/MT8135 support this, MT6577/MT6595/MT8127 do not suppo=
rt.
> For example, If want to use I2C4/5/6 pins on MT8135 just need to enab=
le
> the pinmux, else if want to use I2C pins on PMIC(MT6397) need to add
> "mediatek,have-pmic" property in the .dts file of each platform.
>=20
> This driver is based on 4.1-rc1.
>=20
> Change in v7:
> Fix mtk_i2c_of_match in wrong patch bug.
>=20
> Change in v6:
> 1. Update binding document not use default clock-frequency as example=
=2E
> 2. Add mtk_i2c_compatible struct and pass hardware capabilities
>    through of_device_id
> 3. Remove some hardware setting in mtk_i2c_do_transfer to mtk_i2c_ini=
t_hw
>    so just init one time.
> 4. Correct mtk_i2c_parse_dt don't set default clock bug.
>=20
> Change in v5:
> Apply new i2c_adapter_quirks patch [2]. Change to use dam_map_single =
to map
> dma buffer. Add spinlock to fix race condition. Check of_property_rea=
d_u32
> return value. Remove I2C_FUNC_10BIT_ADDR capability due to driver not=
 implement.
> Add MT8173 I2C driver.
>=20
> Change in v4:
> Modify to support i2c_adapter_quirks base on Wolfram's patch [1].
> Remove check transfer size and WRRD combine code. Instead, fill quirk
> property and let i2c_check_for_quirks to do the filter.
>=20
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-Januar=
y/314804.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-Februa=
ry/325744.html
>=20
> Eddie Huang (1):
>   I2C: mediatek: Add driver for MediaTek MT8173 I2C controller
>=20
> Xudong Chen (2):
>   dt-bindings: Add I2C bindings for mt65xx/mt81xx.
>   I2C: mediatek: Add driver for MediaTek I2C controller
>=20
>  .../devicetree/bindings/i2c/i2c-mt6577.txt         |  41 ++
>  drivers/i2c/busses/Kconfig                         |   9 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-mt65xx.c                    | 748 +++++++++++=
++++++++++
>  4 files changed, 799 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt6577.=
txt
>  create mode 100644 drivers/i2c/busses/i2c-mt65xx.c

Again, you've sent me a patch-set that has absolutely nothing to do
with me.  Can you please stop doing that, my inbox is full enough
already!

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
