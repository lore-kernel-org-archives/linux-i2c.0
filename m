From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v8 2/3] I2C: mediatek: Add driver for MediaTek I2C
 controller
Date: Tue, 19 May 2015 21:49:17 +0200
Message-ID: <20150519194917.GI24769@pengutronix.de>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-3-git-send-email-eddie.huang@mediatek.com>
 <20150518184300.GB28888@pengutronix.de>
 <CABuKBeJcpufi-eEWmDRK6F2kgpz3DmCz8rp4hVPCJVgkmGr-KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABuKBeJcpufi-eEWmDRK6F2kgpz3DmCz8rp4hVPCJVgkmGr-KA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Xudong Chen <xudong.chen@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>, Pawel Moll <pawel.moll@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liguo Zhang <liguo.zhang@mediatek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Eddie Huang <eddie.huang@mediatek.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

Hello Matthias,

On Tue, May 19, 2015 at 04:48:23PM +0200, Matthias Brugger wrote:
> 2015-05-18 20:43 GMT+02:00 Uwe Kleine-K=F6nig <u.kleine-koenig@pengut=
ronix.de>:
> > On Tue, May 19, 2015 at 12:40:08AM +0800, Eddie Huang wrote:
> >> [...]
> >>  drivers/i2c/busses/i2c-mt65xx.c | 675 +++++++++++++++++++++++++++=
+++++++++++++
> >> [...]
> >> +#define I2C_DRV_NAME         "mt-i2c"
> > i2c-mt65xx ?
>=20
> As this works for all SoCs so far, I would propose: i2c-mtk
Hmm, currently we have:

  - #define I2C_DRV_NAME mt-i2c
  - dt-compatibles: "mediatek,mt6577-i2c" + "mediatek,mt6589-i2c"
  - function prefix: mtk_i2c_
  - filename: i2c-mt65xx.c
  - Kconfig symbol: I2C_MT65XX

Getting some harmonization here would definitly be nice.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
