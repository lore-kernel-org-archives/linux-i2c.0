From: Alain Volmat <alain.volmat@st.com>
Subject: [PATCH 0/4] stm32: i2c: Add suspend/resume & add sleep pinctrls
Date: Wed, 27 Nov 2019 11:46:01 +0100
Message-ID: <1574851561-25501-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org
Cc: mark.rutland@arm.com, pierre-yves.mordret@st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com
List-Id: linux-i2c@vger.kernel.org

This small series add missing sleep pinctrl in boards device-tree including
i2c-stm32f7 nodes.
The driver is also enhanced to add support for PM_SLEEP suspend/resume.

Alain Volmat (4):
  ARM: dts: stm32: add i2c4 sleep pinctrl on stm32mp157a-dk1
  ARM: dts: stm32: add i2c4 sleep pinctrl on stm32mp157c-ed1
  ARM: dts: stm32: add i2c2/i2c5 sleep pinctrl on stm32mp157c-ev1
  i2c: i2c-stm32f7: add PM_SLEEP suspend/resume support

 arch/arm/boot/dts/stm32mp157a-dk1.dts |   3 +-
 arch/arm/boot/dts/stm32mp157c-ed1.dts |   3 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts |   6 +-
 drivers/i2c/busses/i2c-stm32f7.c      | 118 ++++++++++++++++++++++++++++++++--
 4 files changed, 119 insertions(+), 8 deletions(-)

-- 
2.7.4
