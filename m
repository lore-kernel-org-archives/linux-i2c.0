From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 0/5] intel_mid_i2c: I2C driver support with IRQs
Date: Thu, 17 Jun 2010 15:05:06 +0100
Message-ID: <20100617140352.17861.29664.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This series enables the I2C on the Intel MID platforms. I've kept it as a
series of five patches to keep ownership and history. The first two add the
x86 irq handling and the driver, the rest then polish it up.

Alan

---

Alan Cox (2):
      intel_mid_i2c: minor cleanups
      intel_mid_i2c: Do a bit of compaction and tidying

Alek Du (1):
      gpio: implement x86 gpio_to_irq convert function

Wen Wang (2):
      intel_mid_i2c: Minor changes after verification
      intel_mid_i2c: I2C driver supporting Moorestown and Medfield platform


 arch/x86/include/asm/gpio.h   |    5 
 drivers/i2c/busses/Kconfig    |    9 
 drivers/i2c/busses/Makefile   |    1 
 drivers/i2c/busses/i2c-mrst.c |  902 +++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-mrst.h |  269 ++++++++++++
 5 files changed, 1182 insertions(+), 4 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-mrst.c
 create mode 100644 drivers/i2c/busses/i2c-mrst.h
