From: Alain Volmat <alain.volmat@st.com>
Subject: [PATCH 0/6] i2c-stm32f7: support suspend/resume & wakeup
Date: Mon, 6 Jan 2020 14:28:28 +0100
Message-ID: <1578317314-17197-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org
Cc: mark.rutland@arm.com, pierre-yves.mordret@st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com
List-Id: linux-i2c@vger.kernel.org

This serie replaces the previously sent serie "stm32: i2c: Add suspend/resume & add sleep pinctrls".

This serie adds support for pm sleep suspend / resume and allow I2C slave to be
a wakeup-source for the system.

Alain Volmat (6):
  ARM: dts: stm32: add i2c4 sleep pinctrl on stm32mp15xx-dkx
  ARM: dts: stm32: add i2c2/i2c5 sleep pinctrl on stm32mp157c-ev1
  ARM: dts: stm32: add i2c4 sleep pinctrl on stm32mp157c-ed1
  i2c: i2c-stm32f7: add PM_SLEEP suspend/resume support
  i2c: i2c-stm32f7: allow controller to be wakeup-source
  ARM: dts: stm32: add wakeup-source in all I2C nodes of stm32mp157c

 arch/arm/boot/dts/stm32mp151.dtsi      |   6 ++
 arch/arm/boot/dts/stm32mp157c-ed1.dts  |   3 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts  |   6 +-
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi |   3 +-
 drivers/i2c/busses/i2c-stm32f7.c       | 187 ++++++++++++++++++++++++++++++++-
 5 files changed, 196 insertions(+), 9 deletions(-)
