From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: [PATCH v6 0/5] Add support for the STM32F4 I2C
Date: Mon, 12 Dec 2016 17:15:37 +0100
Message-ID: <1481559342-6106-1-git-send-email-cedric.madianga@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34241 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbcLLQP6 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Dec 2016 11:15:58 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linus.walleij@linaro.org, patrice.chotard@st.com, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: M'boumba Cedric Madianga <cedric.madianga@gmail.com>

This patchset adds support for the I2C controller embedded in STM32F4xx SoC.
It enables I2C transfer in interrupt mode with Standard-mode and Fast-mode bus
speed.

Changes since v5:
- Change commit header from "ARM: dts:" to "ARM: dts: stm32:" (Alex)
- Change commit header from "ARM: configs:" to "ARM: configs: stm32:" (Alex)
- Fix warnings due to variable set but unused (Wolfram)
- Remove double space in Kconfig (Wolfram)
- Fix warning due to bad type parameter when using clamp() function
  (build-bot)

M'boumba Cedric Madianga (5):
  dt-bindings: Document the STM32 I2C bindings
  i2c: Add STM32F4 I2C driver
  ARM: dts: stm32: Add I2C1 support for STM32F429 SoC
  ARM: dts: stm32: Add I2C1 support for STM32429 eval board
  ARM: configs: stm32: Add I2C support for STM32 defconfig

 .../devicetree/bindings/i2c/i2c-stm32.txt          |  33 +
 arch/arm/boot/dts/stm32429i-eval.dts               |   6 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  23 +
 arch/arm/configs/stm32_defconfig                   |   3 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-stm32f4.c                   | 849 +++++++++++++++++++++
 7 files changed, 925 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt
 create mode 100644 drivers/i2c/busses/i2c-stm32f4.c

-- 
1.9.1
