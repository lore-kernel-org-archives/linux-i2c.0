From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: [PATCH 0/5] Add support for the STM32F7 I2C
Date: Fri, 17 Mar 2017 10:58:53 +0100
Message-ID: <1489744738-21632-1-git-send-email-cedric.madianga@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linus.walleij@linaro.org, pierre-yves.mordret@st.com, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
List-Id: linux-i2c@vger.kernel.org

This patchset adds support for the I2C controller embedded in STM32F7xx SoC.
It enables I2C transfer in interrupt mode with Standard-mode, Fast-mode and
Fast-mode+ bus speed.

M'boumba Cedric Madianga (5):
  dt-bindings: i2c-stm32: Document the STM32F7 I2C bindings
  i2c: i2c-stm32f4: use generic definition of speed enum
  i2c: i2c-stm32f7: add driver
  ARM: dts: stm32: Add I2C1 support for STM32F746 SoC
  ARM: dts: stm32: Add I2C1 support for STM32F746 eval board

 .../devicetree/bindings/i2c/i2c-stm32.txt          |  22 +-
 arch/arm/boot/dts/stm32746g-eval.dts               |   6 +
 arch/arm/boot/dts/stm32f746.dtsi                   |  23 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-stm32.h                     |  20 +
 drivers/i2c/busses/i2c-stm32f4.c                   |  18 +-
 drivers/i2c/busses/i2c-stm32f7.c                   | 562 +++++++++++++++++++++
 8 files changed, 648 insertions(+), 14 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-stm32.h
 create mode 100644 drivers/i2c/busses/i2c-stm32f7.c

-- 
1.9.1
