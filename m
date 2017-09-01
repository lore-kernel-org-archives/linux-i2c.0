From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [RESEND PATCH v3 0/5] Add support for the STM32F7 I2C
Date: Fri, 1 Sep 2017 09:34:10 +0200
Message-ID: <1504251255-20469-1-git-send-email-pierre-yves.mordret@st.com>
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
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
List-Id: linux-i2c@vger.kernel.org

This patchset adds support for the I2C controller embedded in STM32F7xx SoC.
It enables I2C transfer in interrupt mode with Standard-mode, Fast-mode and
Fast-mode+ bus speed.
---
 Version history:
    v3:
        * Move stm32f7_i2c_match above stm32f7_i2c_driver
        * of_device_get_match_data instead of of_match_device
        * Improve I2C Speed DT gathering
        * dev_err into dev_dbg for Arbitration loss
        * Remove useless space aligned

    v2:
        * Implement an I2C timings computation algorithm instead of static
          values(bindings). Algorithm uses generic I2C SCL Falling/Rising
          bindings and System clock to compute its timings.
        * I2C Device Tree Update
---
Pierre-Yves MORDRET (5):
  dt-bindings: i2c-stm32: Document the STM32F7 I2C bindings
  i2c: i2c-stm32f4: use generic definition of speed enum
  i2c: i2c-stm32f7: add driver
  ARM: dts: stm32: Add I2C1 support for STM32F746 SoC
  ARM: dts: stm32: Add I2C1 support for STM32F746 eval board

 .../devicetree/bindings/i2c/i2c-stm32.txt          |  29 +-
 arch/arm/boot/dts/stm32746g-eval.dts               |   8 +
 arch/arm/boot/dts/stm32f746.dtsi                   |  22 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-stm32.h                     |  20 +
 drivers/i2c/busses/i2c-stm32f4.c                   |  18 +-
 drivers/i2c/busses/i2c-stm32f7.c                   | 974 +++++++++++++++++++++
 8 files changed, 1068 insertions(+), 14 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-stm32.h
 create mode 100644 drivers/i2c/busses/i2c-stm32f7.c

-- 
2.7.4
