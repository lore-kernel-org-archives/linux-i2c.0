From: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH V2 00/11] enable imx6q_sabrelite sgtl5000 audio support
Date: Wed, 9 May 2012 19:32:59 +0800
Message-ID: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Changes since v1:

 - rebase to latest clk and pinctrl base
 - fix according v1 comments.

You can also get at:
https://github.com/riczhao/kernel-imx/tree/topics/audio

Richard Zhao (11):
  dma: imx-sdma: make channel0 operations atomic
  ARM: dts: imx6q-sabrelite: add i2c1 pinctrl support
  ASoC: imx-audmux: add pinctrl support
  ARM: dts: imx6q-sabrelite: add audmux pinctrl support
  ARM: imx6q: add ssi1_ipg clk_lookup
  ASoC: fsl_ssi: convert to use devm_clk_get
  ARM: imx6q_sabrelite: clk_register_clkdev cko1 for sgtl5000
  ARM: dts: imx6q-sabrelite: add sound device imx6q-sabrelite-sgtl5000
  ARM: dts: imx6q-sabrelite: add serial2 pinctrl support
  ARM: imx6q: change clkdev device name from xxxx.uart to xxxx.serial
  ARM: imx6q: change clkdev device name from xxxx.enet to xxxx.ethernet

 arch/arm/boot/dts/imx6q-sabrelite.dts |   20 +++++++++++
 arch/arm/boot/dts/imx6q.dtsi          |   23 +++++++++++++
 arch/arm/mach-imx/clk-imx6q.c         |   35 +++++++++++---------
 arch/arm/mach-imx/mach-imx6q.c        |   28 ++++++++++++++++
 drivers/dma/imx-sdma.c                |   57 ++++++++++++++++++---------------
 sound/soc/fsl/fsl_ssi.c               |    7 +---
 sound/soc/fsl/imx-audmux.c            |    8 +++++
 7 files changed, 132 insertions(+), 46 deletions(-)

-- 
1.7.5.4
