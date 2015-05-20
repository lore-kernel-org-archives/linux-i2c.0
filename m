From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Wed, 20 May 2015 11:07:39 +0800
Message-ID: <1432091259.20394.7.camel@mtksdaap41>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
	 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
	 <20150518184300.GB28888@pengutronix.de>
	 <CABuKBeJcpufi-eEWmDRK6F2kgpz3DmCz8rp4hVPCJVgkmGr-KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABuKBeJcpufi-eEWmDRK6F2kgpz3DmCz8rp4hVPCJVgkmGr-KA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Xudong Chen <xudong.chen@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Pawel Moll <pawel.moll@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liguo Zhang <liguo.zhang@mediatek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Eddie Huang <eddie.huang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2015-05-19 at 16:48 +0200, Matthias Brugger wrote:
> 2015-05-18 20:43 GMT+02:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pen=
gutronix.de>:
<...>
> >> --- /dev/null
> >> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> >> @@ -0,0 +1,675 @@
> >> +/*
> >> + * Copyright (c) 2014 MediaTek Inc.
> >> + * Author: Xudong.chen <xudong.chen@mediatek.com>
> > s/Xudong.chen/Xudong Chen/
> >
> >> +#define I2C_DRV_NAME         "mt-i2c"
> > i2c-mt65xx ?
>=20
> As this works for all SoCs so far, I would propose: i2c-mtk

Hi,

I'm pretty sure this driver won't work for MTK TV socs(mt53xx) and BDP
mt8580, they are using different I2C IP. They are not working on
upstream now, but I think using i2c-mt65xx make more sense here.

Joe.C
