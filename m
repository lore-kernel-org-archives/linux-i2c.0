From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v2 0/5] Add support for the STM32F7 I2C
Date: Tue, 20 Jun 2017 13:41:25 +0200
Message-ID: <1497958890-5530-1-git-send-email-pierre-yves.mordret@st.com>
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
Cc: pierre-yves.mordret@st.com
List-Id: linux-i2c@vger.kernel.org

This patchset adds support for the I2C controller embedded in STM32F7xx SoC.
It enables I2C transfer in interrupt mode with Standard-mode, Fast-mode and
Fast-mode+ bus speed.
---
Changes in V2
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
 drivers/i2c/busses/i2c-stm32f7.c                   | 968 +++++++++++++++++++++
 8 files changed, 1062 insertions(+), 14 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-stm32.h
 create mode 100644 drivers/i2c/busses/i2c-stm32f7.c

-- 
1.9.1
