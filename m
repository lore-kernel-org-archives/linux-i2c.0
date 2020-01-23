From: Alain Volmat <alain.volmat-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 0/5] i2c: i2c-stm32f7: enhance FastModePlus support
Date: Thu, 23 Jan 2020 17:12:45 +0100
Message-ID: <1579795970-22319-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, pierre-yves.mordret-qxv4g6HH51o@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-stm32-XDFAJ8BFU24N7RejjzZ/Li2xQDfSxrLKVpNB7YpNyf8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fabrice.gasnier-qxv4g6HH51o@public.gmane.org, alain.volmat-qxv4g6HH51o@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This serie enhance Fast Mode Plus support in the i2c-stm32f7 driver
(support suspend/resume) and add the support for the stm32mp15 SoC
that has new syscfg bits.

Alain Volmat (5):
  i2c: i2c-stm32f7: disable/restore Fast Mode Plus bits in low power
    modes
  dt-bindings: i2c: i2c-stm32f7: add st,stm32mp15-i2c compatible
  i2c: i2c-stm32f7: add a new st,stm32mp15-i2c compatible
  ARM: dts: stm32: use st,stm32mp15-i2c compatible for stm32mp151
  ARM: dts: stm32: add Fast Mode Plus info in I2C nodes of stm32mp151

 .../devicetree/bindings/i2c/st,stm32-i2c.yaml      |  6 +-
 arch/arm/boot/dts/stm32mp151.dtsi                  | 18 ++++--
 drivers/i2c/busses/i2c-stm32f7.c                   | 75 +++++++++++++++++++---
 3 files changed, 83 insertions(+), 16 deletions(-)

-- 
2.7.4
