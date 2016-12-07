From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: [PATCH v4 0/5] Add support for the STM32F4 I2C
Date: Wed,  7 Dec 2016 17:51:27 +0100
Message-ID: <1481129492-26600-1-git-send-email-cedric.madianga@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34593 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbcLGQvp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 7 Dec 2016 11:51:45 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linus.walleij@linaro.org, patrice.chotard@st.com, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: M'boumba Cedric Madianga <cedric.madianga@gmail.com>

This patchset adds support for the I2C controller embedded in STM32F4xx SoC.
It enables I2C transfer in interrupt mode with Standard-mode and Fast-mode bus
speed.

Changes since v3 after Wolfram's review:
- Add COMPILE_TEST flag in Kconfig
- Use correct driver name in Kconfig i.e i2c-stm32f4 instead of i2c-st
- Use more comprehensible name stm32f4_i2c_msg for client specific data
- Don't store reset control node as just needed in probe
- Use clamp() function to test value between 2 ranges
- Use new "i2c_8bit_addr_from_msg() function to build I2C address
- Don't write error messages for timeout
- Remove error message when i2c_add_adapter() fails as it is already handled by
  the i2c core driver

M'boumba Cedric Madianga (5):
  dt-bindings: Document the STM32 I2C bindings
  i2c: Add STM32F4 I2C driver
  ARM: dts: Add I2C1 support for STM32F429 SoC
  ARM: dts: Add I2C1 support for STM32429 eval board
  ARM: configs: Add I2C support for STM32 defconfig

 .../devicetree/bindings/i2c/i2c-stm32.txt          |  33 +
 arch/arm/boot/dts/stm32429i-eval.dts               |   6 +
 arch/arm/boot/dts/stm32f429.dtsi                   |  23 +
 arch/arm/configs/stm32_defconfig                   |   3 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-stm32f4.c                   | 857 +++++++++++++++++++++
 7 files changed, 933 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt
 create mode 100644 drivers/i2c/busses/i2c-stm32f4.c

-- 
1.9.1
