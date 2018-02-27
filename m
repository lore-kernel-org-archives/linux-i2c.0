From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [RESEND PATCH v1 0/6] Add different features for I2C
Date: Tue, 27 Feb 2018 10:48:08 +0100
Message-ID: <1519724894-21363-1-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
List-Id: linux-i2c@vger.kernel.org

Append new I2C STM32F7 feature set. This includes 10 bit support, slave
support, SMBBus protocols support, DMA Support and eventually an I2C recovery
mechanism

---
  Version history:
    v1:
        * Initial
---
Pierre-Yves MORDRET (6):
  i2c: i2c-stm32f7: Add 10-bit address support
  i2c: i2c-stm32f7: Add slave support
  i2c: i2c-stm32f7: Add initial SMBus protocols support
  i2c: i2c-stm32: Add generic DMA API
  i2c: i2c-stm32f7: Add DMA support
  i2c: i2c-stm32f7: Implement I2C recovery mechanism

 drivers/i2c/busses/Kconfig       |    1 +
 drivers/i2c/busses/Makefile      |    3 +-
 drivers/i2c/busses/i2c-stm32.c   |  153 ++++++
 drivers/i2c/busses/i2c-stm32.h   |   37 ++
 drivers/i2c/busses/i2c-stm32f7.c | 1047 +++++++++++++++++++++++++++++++++++++-
 5 files changed, 1214 insertions(+), 27 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-stm32.c

-- 
2.7.4
