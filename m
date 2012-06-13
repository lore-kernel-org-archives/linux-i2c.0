From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 8/8 v2] i2c: i2c-bfin-twi: Move blackfin TWI register access Macro to head file.
Date: Wed, 13 Jun 2012 16:22:47 +0800
Message-ID: <1339575767-22985-8-git-send-email-sonic.adi@gmail.com>
References: <1339575767-22985-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339575767-22985-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>
Cc: linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang@analog.com>

Depend on 1e92bf6d80b5a0a137455c96bf6cdd9c1a5b531e

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/i2c/busses/i2c-bfin-twi.c |   45 -------------------------------------
 1 files changed, 0 insertions(+), 45 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 5c57623..e1abf50 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -33,51 +33,6 @@
 #define TWI_I2C_MODE_COMBINED		3
 #define TWI_I2C_MODE_REPEAT		4
 
-struct bfin_twi_iface {
-	int			irq;
-	spinlock_t		lock;
-	char			read_write;
-	u8			command;
-	u8			*transPtr;
-	int			readNum;
-	int			writeNum;
-	int			cur_mode;
-	int			manual_stop;
-	int			result;
-	struct i2c_adapter	adap;
-	struct completion	complete;
-	struct i2c_msg 		*pmsg;
-	int			msg_num;
-	int			cur_msg;
-	u16			saved_clkdiv;
-	u16			saved_control;
-	void __iomem		*regs_base;
-};
-
-
-#define DEFINE_TWI_REG(reg, off) \
-static inline u16 read_##reg(struct bfin_twi_iface *iface) \
-	{ return bfin_read16(iface->regs_base + (off)); } \
-static inline void write_##reg(struct bfin_twi_iface *iface, u16 v) \
-	{ bfin_write16(iface->regs_base + (off), v); }
-
-DEFINE_TWI_REG(CLKDIV, 0x00)
-DEFINE_TWI_REG(CONTROL, 0x04)
-DEFINE_TWI_REG(SLAVE_CTL, 0x08)
-DEFINE_TWI_REG(SLAVE_STAT, 0x0C)
-DEFINE_TWI_REG(SLAVE_ADDR, 0x10)
-DEFINE_TWI_REG(MASTER_CTL, 0x14)
-DEFINE_TWI_REG(MASTER_STAT, 0x18)
-DEFINE_TWI_REG(MASTER_ADDR, 0x1C)
-DEFINE_TWI_REG(INT_STAT, 0x20)
-DEFINE_TWI_REG(INT_MASK, 0x24)
-DEFINE_TWI_REG(FIFO_CTL, 0x28)
-DEFINE_TWI_REG(FIFO_STAT, 0x2C)
-DEFINE_TWI_REG(XMT_DATA8, 0x80)
-DEFINE_TWI_REG(XMT_DATA16, 0x84)
-DEFINE_TWI_REG(RCV_DATA8, 0x88)
-DEFINE_TWI_REG(RCV_DATA16, 0x8C)
-
 static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
 					unsigned short twi_int_status)
 {
-- 
1.7.0.4
