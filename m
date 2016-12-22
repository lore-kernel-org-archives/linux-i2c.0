From: M'boumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 0/5] Add support for the STM32F4 I2C
Date: Thu, 22 Dec 2016 14:34:59 +0100
Message-ID: <1482413704-17531-1-git-send-email-cedric.madianga@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: M'boumba Cedric Madianga <cedric.madianga-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patchset adds support for the I2C controller embedded in STM32F4xx SoC.
It enables I2C transfer in interrupt mode with Standard-mode and Fast-mode bus
speed.

Changes since v6:
- Add commit message for the patches in defconfig, .dtsi and .dts files (Alex)
- Order I2C instance base address in .dtsi file (Alex)
- Add commit message for the patch in stm32429i-eval.dts  (Alex)
- Add link to the STM32F4 Soc ref manual where I2C device is described (Uwe)
- Use more usal way to define constants with several lines (Uwe)
- Remove rate variable from stm32f4_i2c_timings as it is not used (Uwe)
- Remove irq variable from stm32f4_i2c_dev struct are they are only needed
  during probe (Uwe)
- Add comment from datasheet to explain stm32f4_i2c_timings values (Uwe)
- Rework i2c soft_reset implementation (Uwe)
- Replace "it" by "irq" as it is a more usual abbreviation for interrupt (Uwe)
- Add comment from datasheet to explain periph clk freq calculation (Uwe)
- Use DIV_ROUND_UP instead of plain division when required (Uwe)
- Add comment from datasheet to explain timing rise calculation (Uwe)
- Rework timing rise calculation by using shorter computation (Uwe)
- Remove (u8) cast when reading I2C data register (Uwe)
- Rework isr_event routine to handle several events during one call of the
  routine (Uwe)
- Precise which type of irq is failed when a irq request error occurs (Uwe)
- Use devm_request_irq() instead of devm_request_threaded_irq() to avoid
  spurious evt irq when clearing status registers in threaded context

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
 drivers/i2c/busses/i2c-stm32f4.c                   | 896 +++++++++++++++++++++
 7 files changed, 972 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt
 create mode 100644 drivers/i2c/busses/i2c-stm32f4.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
