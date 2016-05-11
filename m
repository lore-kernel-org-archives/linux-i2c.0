From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: [PATCH 0/5] Add support for the STM32F4 I2C
Date: Wed, 11 May 2016 17:36:09 +0200
Message-ID: <1462980974-22091-1-git-send-email-cedric.madianga@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35059 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbcEKPh1 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 11 May 2016 11:37:27 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: mcoquelin.stm32@gmail.com, patrice.chotard@st.com, wsa@the-dreams.de, robh+dt@kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: M'boumba Cedric Madianga <cedric.madianga@gmail.com>

This patchset adds support for the I2C controller embedded in STM32F4xx SoC.
It enables I2C transfer in interrupt mode with Standard-mode and Fast-mode bus
speed.

M'boumba Cedric Madianga (5):
  dt-bindings: Document the STM32 I2C bindings
  i2c: Add STM32F4 I2C driver
  ARM: dts: Add I2C1 support for STM32F429 SoC
  ARM: dts: Add I2C1 support for STM32429 eval board
  ARM: configs: Add I2C support for STM32 defconfig

 .../devicetree/bindings/i2c/i2c-stm32.txt          |  33 +
 arch/arm/boot/dts/stm32429i-eval.dts               |   6 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  24 +
 arch/arm/configs/stm32_defconfig                   |   3 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-stm32f4.c                   | 872 +++++++++++++++++++++
 7 files changed, 949 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt
 create mode 100644 drivers/i2c/busses/i2c-stm32f4.c

-- 
1.9.1
