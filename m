From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C controller
Date: Tue, 19 May 2015 16:48:23 +0200
Message-ID: <CABuKBeJcpufi-eEWmDRK6F2kgpz3DmCz8rp4hVPCJVgkmGr-KA@mail.gmail.com>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
	<1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
	<20150518184300.GB28888@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150518184300.GB28888@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Eddie Huang <eddie.huang@mediatek.com>, Wolfram Sang <wsa@the-dreams.de>, srv_heupstream <srv_heupstream@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Xudong Chen <xudong.chen@mediatek.com>, Liguo Zhang <liguo.zhang@mediatek.com>, linux-i2c@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

2015-05-18 20:43 GMT+02:00 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutro=
nix.de>:
> Hello,
>
> On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
>> From: Xudong Chen <xudong.chen@mediatek.com>
>>
>> The mediatek SoCs have I2C controller that handle I2C transfer.
>> This patch include common I2C bus driver.
>> This driver is compatible with I2C controller on mt65xx/mt81xx.
>>
>> Signed-off-by: Xudong Chen <xudong.chen@mediatek.com>
>> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
>> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>>  drivers/i2c/busses/Kconfig      |   9 +
>>  drivers/i2c/busses/Makefile     |   1 +
>>  drivers/i2c/busses/i2c-mt65xx.c | 675 +++++++++++++++++++++++++++++=
+++++++++++
>>  3 files changed, 685 insertions(+)
>>  create mode 100644 drivers/i2c/busses/i2c-mt65xx.c
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 2255af2..14c7266 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -620,6 +620,15 @@ config I2C_MPC
>>         This driver can also be built as a module.  If so, the modul=
e
>>         will be called i2c-mpc.
>>
>> +config I2C_MT65XX
>> +     tristate "MediaTek I2C adapter"
>> +     depends on ARCH_MEDIATEK || COMPILE_TEST
>> +     help
>> +       This selects the MediaTek(R) Integrated Inter Circuit bus dr=
iver
>> +       for MT65xx and MT81xx.
>> +       If you want to use MediaTek(R) I2C interface, say Y or M her=
e.
>> +       If unsure, say N.
>> +
>>  config I2C_MV64XXX
>>       tristate "Marvell mv64xxx I2C Controller"
>>       depends on MV64X60 || PLAT_ORION || ARCH_SUNXI
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefi=
le
>> index cdf941d..abbf422 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -60,6 +60,7 @@ obj-$(CONFIG_I2C_JZ4780)    +=3D i2c-jz4780.o
>>  obj-$(CONFIG_I2C_KEMPLD)     +=3D i2c-kempld.o
>>  obj-$(CONFIG_I2C_MESON)              +=3D i2c-meson.o
>>  obj-$(CONFIG_I2C_MPC)                +=3D i2c-mpc.o
>> +obj-$(CONFIG_I2C_MT65XX)     +=3D i2c-mt65xx.o
>>  obj-$(CONFIG_I2C_MV64XXX)    +=3D i2c-mv64xxx.o
>>  obj-$(CONFIG_I2C_MXS)                +=3D i2c-mxs.o
>>  obj-$(CONFIG_I2C_NOMADIK)    +=3D i2c-nomadik.o
>> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2=
c-mt65xx.c
>> new file mode 100644
>> index 0000000..7462f05
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-mt65xx.c
>> @@ -0,0 +1,675 @@
>> +/*
>> + * Copyright (c) 2014 MediaTek Inc.
>> + * Author: Xudong.chen <xudong.chen@mediatek.com>
> s/Xudong.chen/Xudong Chen/
>
>> +#define I2C_DRV_NAME         "mt-i2c"
> i2c-mt65xx ?

As this works for all SoCs so far, I would propose: i2c-mtk

--=20
motzblog.wordpress.com
