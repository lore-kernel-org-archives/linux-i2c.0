From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] i2c: i2c-adi: move twi header from arch folder to generic include folder
Date: Sun, 26 Jan 2014 15:16:45 +0800
Message-ID: <1390720607-447-2-git-send-email-sonic.adi@gmail.com>
References: <1390720607-447-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390720607-447-1-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 arch/blackfin/include/asm/twi.h | 139 +++-----------------------------------
 include/linux/i2c/i2c-adi.h     | 145 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+), 131 deletions(-)
 create mode 100644 include/linux/i2c/i2c-adi.h

diff --git a/arch/blackfin/include/asm/twi.h b/arch/blackfin/include/asm/twi.h
index 90c3c00..6f057ee 100644
--- a/arch/blackfin/include/asm/twi.h
+++ b/arch/blackfin/include/asm/twi.h
@@ -1,73 +1,21 @@
 /*
- * bfin_twi.h - interface to Blackfin TWIs
+ * twi.h - TWI register access header
  *
  * Copyright 2005-2010 Analog Devices Inc.
  *
  * Licensed under the GPL-2 or later.
  */
 
-#ifndef __ASM_BFIN_TWI_H__
-#define __ASM_BFIN_TWI_H__
+#ifndef __ASM_TWI_H__
+#define __ASM_TWI_H__
 
 #include <linux/types.h>
-#include <linux/i2c.h>
-
-/*
- * All Blackfin system MMRs are padded to 32bits even if the register
- * itself is only 16bits.  So use a helper macro to streamline this.
- */
-#define __BFP(m) u16 m; u16 __pad_##m
-
-/*
- * bfin twi registers layout
- */
-struct bfin_twi_regs {
-	__BFP(clkdiv);
-	__BFP(control);
-	__BFP(slave_ctl);
-	__BFP(slave_stat);
-	__BFP(slave_addr);
-	__BFP(master_ctl);
-	__BFP(master_stat);
-	__BFP(master_addr);
-	__BFP(int_stat);
-	__BFP(int_mask);
-	__BFP(fifo_ctl);
-	__BFP(fifo_stat);
-	u32 __pad[20];
-	__BFP(xmt_data8);
-	__BFP(xmt_data16);
-	__BFP(rcv_data8);
-	__BFP(rcv_data16);
-};
-
-#undef __BFP
-
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
-	struct i2c_msg		*pmsg;
-	int			msg_num;
-	int			cur_msg;
-	u16			saved_clkdiv;
-	u16			saved_control;
-	struct bfin_twi_regs __iomem *regs_base;
-};
+#include <asm/blackfin.h>
 
 #define DEFINE_TWI_REG(reg_name, reg) \
-static inline u16 read_##reg_name(struct bfin_twi_iface *iface) \
+static inline u16 read_##reg_name(struct adi_twi_iface *iface) \
 	{ return bfin_read16(&iface->regs_base->reg); } \
-static inline void write_##reg_name(struct bfin_twi_iface *iface, u16 v) \
+static inline void write_##reg_name(struct adi_twi_iface *iface, u16 v) \
 	{ bfin_write16(&iface->regs_base->reg, v); }
 
 DEFINE_TWI_REG(CLKDIV, clkdiv)
@@ -88,7 +36,7 @@ DEFINE_TWI_REG(XMT_DATA16, xmt_data16)
 DEFINE_TWI_REG(RCV_DATA8, rcv_data8)
 DEFINE_TWI_REG(RCV_DATA16, rcv_data16)
 #else
-static inline u16 read_RCV_DATA8(struct bfin_twi_iface *iface)
+static inline u16 read_RCV_DATA8(struct adi_twi_iface *iface)
 {
 	u16 ret;
 	unsigned long flags;
@@ -100,7 +48,7 @@ static inline u16 read_RCV_DATA8(struct bfin_twi_iface *iface)
 	return ret;
 }
 
-static inline u16 read_RCV_DATA16(struct bfin_twi_iface *iface)
+static inline u16 read_RCV_DATA16(struct adi_twi_iface *iface)
 {
 	u16 ret;
 	unsigned long flags;
@@ -113,75 +61,4 @@ static inline u16 read_RCV_DATA16(struct bfin_twi_iface *iface)
 }
 #endif
 
-
-/*  ********************  TWO-WIRE INTERFACE (TWI) MASKS  ***********************/
-/* TWI_CLKDIV Macros (Use: *pTWI_CLKDIV = CLKLOW(x)|CLKHI(y);  )				*/
-#define	CLKLOW(x)	((x) & 0xFF)	/* Periods Clock Is Held Low                    */
-#define CLKHI(y)	(((y)&0xFF)<<0x8)	/* Periods Before New Clock Low                 */
-
-/* TWI_PRESCALE Masks															*/
-#define	PRESCALE	0x007F	/* SCLKs Per Internal Time Reference (10MHz)    */
-#define	TWI_ENA		0x0080	/* TWI Enable                                                                   */
-#define	SCCB		0x0200	/* SCCB Compatibility Enable                                    */
-
-/* TWI_SLAVE_CTL Masks															*/
-#define	SEN			0x0001	/* Slave Enable                                                                 */
-#define	SADD_LEN	0x0002	/* Slave Address Length                                                 */
-#define	STDVAL		0x0004	/* Slave Transmit Data Valid                                    */
-#define	NAK			0x0008	/* NAK/ACK* Generated At Conclusion Of Transfer */
-#define	GEN			0x0010	/* General Call Address Matching Enabled                */
-
-/* TWI_SLAVE_STAT Masks															*/
-#define	SDIR		0x0001	/* Slave Transfer Direction (Transmit/Receive*) */
-#define GCALL		0x0002	/* General Call Indicator                                               */
-
-/* TWI_MASTER_CTL Masks													*/
-#define	MEN			0x0001	/* Master Mode Enable                                           */
-#define	MADD_LEN	0x0002	/* Master Address Length                                        */
-#define	MDIR		0x0004	/* Master Transmit Direction (RX/TX*)           */
-#define	FAST		0x0008	/* Use Fast Mode Timing Specs                           */
-#define	STOP		0x0010	/* Issue Stop Condition                                         */
-#define	RSTART		0x0020	/* Repeat Start or Stop* At End Of Transfer     */
-#define	DCNT		0x3FC0	/* Data Bytes To Transfer                                       */
-#define	SDAOVR		0x4000	/* Serial Data Override                                         */
-#define	SCLOVR		0x8000	/* Serial Clock Override                                        */
-
-/* TWI_MASTER_STAT Masks														*/
-#define	MPROG		0x0001	/* Master Transfer In Progress                                  */
-#define	LOSTARB		0x0002	/* Lost Arbitration Indicator (Xfer Aborted)    */
-#define	ANAK		0x0004	/* Address Not Acknowledged                                             */
-#define	DNAK		0x0008	/* Data Not Acknowledged                                                */
-#define	BUFRDERR	0x0010	/* Buffer Read Error                                                    */
-#define	BUFWRERR	0x0020	/* Buffer Write Error                                                   */
-#define	SDASEN		0x0040	/* Serial Data Sense                                                    */
-#define	SCLSEN		0x0080	/* Serial Clock Sense                                                   */
-#define	BUSBUSY		0x0100	/* Bus Busy Indicator                                                   */
-
-/* TWI_INT_SRC and TWI_INT_ENABLE Masks						*/
-#define	SINIT		0x0001	/* Slave Transfer Initiated     */
-#define	SCOMP		0x0002	/* Slave Transfer Complete      */
-#define	SERR		0x0004	/* Slave Transfer Error         */
-#define	SOVF		0x0008	/* Slave Overflow                       */
-#define	MCOMP		0x0010	/* Master Transfer Complete     */
-#define	MERR		0x0020	/* Master Transfer Error        */
-#define	XMTSERV		0x0040	/* Transmit FIFO Service        */
-#define	RCVSERV		0x0080	/* Receive FIFO Service         */
-
-/* TWI_FIFO_CTRL Masks												*/
-#define	XMTFLUSH	0x0001	/* Transmit Buffer Flush                        */
-#define	RCVFLUSH	0x0002	/* Receive Buffer Flush                         */
-#define	XMTINTLEN	0x0004	/* Transmit Buffer Interrupt Length     */
-#define	RCVINTLEN	0x0008	/* Receive Buffer Interrupt Length      */
-
-/* TWI_FIFO_STAT Masks															*/
-#define	XMTSTAT		0x0003	/* Transmit FIFO Status                                                 */
-#define	XMT_EMPTY	0x0000	/*              Transmit FIFO Empty                                             */
-#define	XMT_HALF	0x0001	/*              Transmit FIFO Has 1 Byte To Write               */
-#define	XMT_FULL	0x0003	/*              Transmit FIFO Full (2 Bytes To Write)   */
-
-#define	RCVSTAT		0x000C	/* Receive FIFO Status                                                  */
-#define	RCV_EMPTY	0x0000	/*              Receive FIFO Empty                                              */
-#define	RCV_HALF	0x0004	/*              Receive FIFO Has 1 Byte To Read                 */
-#define	RCV_FULL	0x000C	/*              Receive FIFO Full (2 Bytes To Read)             */
-
 #endif
diff --git a/include/linux/i2c/i2c-adi.h b/include/linux/i2c/i2c-adi.h
new file mode 100644
index 0000000..28d4e02
--- /dev/null
+++ b/include/linux/i2c/i2c-adi.h
@@ -0,0 +1,145 @@
+/*
+ * i2c_adi.h - interface to ADI TWI controller
+ *
+ * Copyright 2005-2014 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#ifndef __I2C_ADI_H__
+#define __I2C_ADI_H__
+
+#include <linux/types.h>
+#include <linux/i2c.h>
+
+/*
+ * ADI twi registers layout
+ */
+struct adi_twi_regs {
+	u16 clkdiv;
+	u16 dummy1;
+	u16 control;
+	u16 dummy2;
+	u16 slave_ctl;
+	u16 dummy3;
+	u16 slave_stat;
+	u16 dummy4;
+	u16 slave_addr;
+	u16 dummy5;
+	u16 master_ctl;
+	u16 dummy6;
+	u16 master_stat;
+	u16 dummy7;
+	u16 master_addr;
+	u16 dummy8;
+	u16 int_stat;
+	u16 dummy9;
+	u16 int_mask;
+	u16 dummy10;
+	u16 fifo_ctl;
+	u16 dummy11;
+	u16 fifo_stat;
+	u16 dummy12;
+	u32 __pad[20];
+	u16 xmt_data8;
+	u16 dummy13;
+	u16 xmt_data16;
+	u16 dummy14;
+	u16 rcv_data8;
+	u16 dummy15;
+	u16 rcv_data16;
+	u16 dummy16;
+};
+
+struct adi_twi_iface {
+	int			irq;
+	spinlock_t		lock;
+	char			read_write;
+	u8			command;
+	u8			*transPtr;
+	int			readNum;
+	int			writeNum;
+	int			cur_mode;
+	int			manual_stop;
+	int			result;
+	struct i2c_adapter	adap;
+	struct completion	complete;
+	struct i2c_msg		*pmsg;
+	int			msg_num;
+	int			cur_msg;
+	u16			saved_clkdiv;
+	u16			saved_control;
+	struct adi_twi_regs __iomem *regs_base;
+};
+
+/*  ********************  TWO-WIRE INTERFACE (TWI) MASKS  ********************/
+/* TWI_CLKDIV Macros (Use: *pTWI_CLKDIV = CLKLOW(x)|CLKHI(y);  ) */
+#define	CLKLOW(x)	((x) & 0xFF)	/* Periods Clock Is Held Low */
+#define CLKHI(y)	(((y)&0xFF)<<0x8) /* Periods Before New Clock Low */
+
+/* TWI_PRESCALE Masks */
+#define	PRESCALE	0x007F	/* SCLKs Per Internal Time Reference (10MHz) */
+#define	TWI_ENA		0x0080	/* TWI Enable */
+#define	SCCB		0x0200	/* SCCB Compatibility Enable */
+
+/* TWI_SLAVE_CTL Masks */
+#define	SEN		0x0001	/* Slave Enable */
+#define	SADD_LEN	0x0002	/* Slave Address Length */
+#define	STDVAL		0x0004	/* Slave Transmit Data Valid */
+#define	NAK		0x0008	/* NAK Generated At Conclusion Of Transfer */
+#define	GEN		0x0010	/* General Call Address Matching Enabled */
+
+/* TWI_SLAVE_STAT Masks	*/
+#define	SDIR		0x0001	/* Slave Transfer Direction (RX/TX*) */
+#define GCALL		0x0002	/* General Call Indicator */
+
+/* TWI_MASTER_CTL Masks	*/
+#define	MEN		0x0001	/* Master Mode Enable          */
+#define	MADD_LEN	0x0002	/* Master Address Length       */
+#define	MDIR		0x0004	/* Master Transmit Direction (RX/TX*) */
+#define	FAST		0x0008	/* Use Fast Mode Timing Specs  */
+#define	STOP		0x0010	/* Issue Stop Condition        */
+#define	RSTART		0x0020	/* Repeat Start or Stop* At End Of Transfer */
+#define	DCNT		0x3FC0	/* Data Bytes To Transfer      */
+#define	SDAOVR		0x4000	/* Serial Data Override        */
+#define	SCLOVR		0x8000	/* Serial Clock Override       */
+
+/* TWI_MASTER_STAT Masks */
+#define	MPROG		0x0001	/* Master Transfer In Progress */
+#define	LOSTARB		0x0002	/* Lost Arbitration Indicator (Xfer Aborted) */
+#define	ANAK		0x0004	/* Address Not Acknowledged    */
+#define	DNAK		0x0008	/* Data Not Acknowledged       */
+#define	BUFRDERR	0x0010	/* Buffer Read Error           */
+#define	BUFWRERR	0x0020	/* Buffer Write Error          */
+#define	SDASEN		0x0040	/* Serial Data Sense           */
+#define	SCLSEN		0x0080	/* Serial Clock Sense          */
+#define	BUSBUSY		0x0100	/* Bus Busy Indicator          */
+
+/* TWI_INT_SRC and TWI_INT_ENABLE Masks	*/
+#define	SINIT		0x0001	/* Slave Transfer Initiated    */
+#define	SCOMP		0x0002	/* Slave Transfer Complete     */
+#define	SERR		0x0004	/* Slave Transfer Error        */
+#define	SOVF		0x0008	/* Slave Overflow              */
+#define	MCOMP		0x0010	/* Master Transfer Complete    */
+#define	MERR		0x0020	/* Master Transfer Error       */
+#define	XMTSERV		0x0040	/* Transmit FIFO Service       */
+#define	RCVSERV		0x0080	/* Receive FIFO Service        */
+
+/* TWI_FIFO_CTRL Masks */
+#define	XMTFLUSH	0x0001	/* Transmit Buffer Flush                 */
+#define	RCVFLUSH	0x0002	/* Receive Buffer Flush                  */
+#define	XMTINTLEN	0x0004	/* Transmit Buffer Interrupt Length      */
+#define	RCVINTLEN	0x0008	/* Receive Buffer Interrupt Length       */
+
+/* TWI_FIFO_STAT Masks */
+#define	XMTSTAT		0x0003	/* Transmit FIFO Status                  */
+#define	XMT_EMPTY	0x0000	/* Transmit FIFO Empty                   */
+#define	XMT_HALF	0x0001	/* Transmit FIFO Has 1 Byte To Write     */
+#define	XMT_FULL	0x0003	/* Transmit FIFO Full (2 Bytes To Write) */
+
+#define	RCVSTAT		0x000C	/* Receive FIFO Status                   */
+#define	RCV_EMPTY	0x0000	/* Receive FIFO Empty                    */
+#define	RCV_HALF	0x0004	/* Receive FIFO Has 1 Byte To Read       */
+#define	RCV_FULL	0x000C	/* Receive FIFO Full (2 Bytes To Read)   */
+
+#endif
-- 
1.8.2.3
