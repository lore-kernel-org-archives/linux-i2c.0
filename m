From: Douglas Gilbert <dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c-dev: Add support for I2C_M_RECV_LEN
Date: Fri, 06 Apr 2012 12:16:19 -0400
Message-ID: <4F7F16D3.6080307@interlog.com>
References: <20120315180835.2e669111@endymion.delvare> <20120331081927.2438ea9e@endymion.delvare> <4F7CD11C.2090801@interlog.com> <20120405092422.453edecf@endymion.delvare> <4F7E3267.9040306@interlog.com> <20120406083751.46fd23c5@endymion.delvare>
Reply-To: dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090503070203010707020406"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120406083751.46fd23c5-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--------------090503070203010707020406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 12-04-06 02:37 AM, Jean Delvare wrote:
> On Thu, 05 Apr 2012 20:01:43 -0400, Douglas Gilbert wrote:
>> On 12-04-05 03:24 AM, Jean Delvare wrote:
>>> As the bus driver side implementation of I2C_M_RECV_LEN is heavily
>>> tied to SMBus, we can't support received length over 32 bytes, but
>>> let's at least support that.
>>>
>>> In practice, the caller will have to setup a buffer large enough to
>>> cover the case where received length byte has value 32, so minimum
>>> 32 + 1 = 33 bytes, possibly more if there is a fixed number of bytes
>>> added for the specific slave (for example a checksum.)
>>
>> Either I am misunderstanding how to use this new patch or it is
>> broken. After replacing the original patch with this one, setting
>> msg->buf[0] to 2, my test program only sees the first two bytes
>> of expected data:
>>     08 81
>> That is down from 8 bytes from the previous patch and 10 bytes
>> expected from the SM130.
>
> Does your I2C bus driver process I2C_M_RECV_LEN at all? I bet not.
> You'll have to fix that. It's fairly easy, see the reference
> implementation in i2c-algo-bit.c:readbytes(). The completely untested
> attempt below may do, if not you'll have to fix my code:

Jean,
Yes again, the modified i2c-at91.c driver that I am using does not
have support for I2C_M_RECV_LEN.

However stepping back from the minor I2C_M_RECV_LEN issue and looking
directly at the i2c-at91 driver itself. My patch to this broken
driver is included below and applies clean against lk 3.2.8
(but I note that it needs work to apply against lk 3.3). My patch
works for the AT91SAM9G20 and I have positive feedback from
the users of board-foxg20 based on that MCU.

However I see that Nikolaus Voss has submitted a replacement driver
for the i2c-at91 that works for the G45 which has two TWI units.
Is that driver going into the mainline? Surely it is much better
than the broken i2c-at91 driver that has been sitting broken for
way too long. Atmel are bringing out new MCUs in that family which
have 3 TWI units (e.g. AT91SAM9G25). Apart from the limitations
about repeated starts surely Atmel have fixed the problems referred
to in existing mainline i2c-at91.c driver from circa 2006.

My vote would be to add Nikolaus Voss's driver ASAP.

Doug Gilbert

--------------090503070203010707020406
Content-Type: text/x-patch;
 name="i2c-at91_32dpg1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="i2c-at91_32dpg1.patch"

--- a/drivers/i2c/busses/Kconfig	2009-12-18 17:27:07.000000000 -0500
+++ b/drivers/i2c/busses/Kconfig	2010-01-21 00:28:07.000000000 -0500
@@ -283,7 +283,7 @@
 
 config I2C_AT91
 	tristate "Atmel AT91 I2C Two-Wire interface (TWI)"
-	depends on ARCH_AT91 && EXPERIMENTAL && BROKEN
+	depends on ARCH_AT91 && EXPERIMENTAL
 	help
 	  This supports the use of the I2C interface on Atmel AT91
 	  processors.
--- a/drivers/i2c/busses/i2c-at91.c	2010-08-03 18:04:08.000000000 -0400
+++ b/drivers/i2c/busses/i2c-at91.c	2012-02-26 22:44:08.856672677 -0500
@@ -11,8 +11,38 @@
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
     (at your option) any later version.
+
+    D. Gilbert (dpg) [20100318+20110219 tested on AT91SAM9G20]
+	- Check for NACK, a NACK will abort current tranfser,
+          returned as errno=EREMOTEIO unless I2C_M_IGNORE_NAK is set
+        - Only supports 7 bit I2C device (slave) address
+	- clockrate adjustable (module_param)
+	- see "AT91-AN01: Using the Two-wire interface (TWI) in Master
+	  Mode on AT91SAM Microcontrollers" from Atmel
+    dpg [20120225]
+	- treat i2c_rdwr_ioctl_data::nmsgs=0 is TWI software reset
 */
 
+/* This module source file is called i2c-at91.c but it is named at91_i2c by
+ * this code. [It was called at91_i2c in the past.] In sysfs it is found
+ * under the /sys/module/i2c_at91 directory (even when it is built in) .
+ *
+ * Once successfully initialized this driver will return one of two errors:
+ *   - EREMOTEIO: most likely the addressed slave is not present or not
+ *                responding. The I2C_M_IGNORE_NAK flag can be used to bypass
+ *                the lacks of ACKs from the slave.
+ *   - ETIMEDOUT: probably some slave is holding down the bus. Both SDA and
+ *                SCL need to be high (probably around 3 volts) when not
+ *                active. If SDA or SCL are around 0 volts then the bus is
+ *                being held down by a slave (or perhaps the master). The
+ *                irresponsible slave needs to be reset (some I2C devices
+ *                have a reset line). Power cycling the slave works as a
+ *                reset.
+ */
+
+/* Uncomment following line to see dev_dbg() output in logs */
+/* #define DEBUG 1 */
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
@@ -29,73 +59,143 @@
 #include <mach/board.h>
 #include <mach/cpu.h>
 
-#define TWI_CLOCK		100000		/* Hz. max 400 Kbits/sec */
+#define DRV_VERSION	"2.1"
+#define TWI_CLOCK	100000	/* Hertz, I2C standard mode clock */
 
 
+static unsigned int clockrate = TWI_CLOCK;
+static unsigned int prev_clockrate = TWI_CLOCK;
 static struct clk *twi_clk;
 static void __iomem *twi_base;
 
 #define at91_twi_read(reg)		__raw_readl(twi_base + (reg))
 #define at91_twi_write(reg, val)	__raw_writel((val), twi_base + (reg))
 
-
 /*
- * Initialize the TWI hardware registers.
+ * Set TWI clock dividers based on clockrate (clock rate for SCL)
  */
-static void __devinit at91_twi_hwinit(void)
+static void at91_twi_clock_dividers(void)
 {
-	unsigned long cdiv, ckdiv;
+	unsigned ckdiv, cldiv, chdiv;
 
-	at91_twi_write(AT91_TWI_IDR, 0xffffffff);	/* Disable all interrupts */
-	at91_twi_write(AT91_TWI_CR, AT91_TWI_SWRST);	/* Reset peripheral */
-	at91_twi_write(AT91_TWI_CR, AT91_TWI_MSEN);	/* Set Master mode */
+	/* Restrict clockrate to be between 1 kHz and 4 Mhz */
+	if (clockrate < 1000)
+		clockrate = 1000;	
+	else if (clockrate > 4000000)
+		clockrate = 4000000;	
 
-	/* Calcuate clock dividers */
-	cdiv = (clk_get_rate(twi_clk) / (2 * TWI_CLOCK)) - 3;
-	cdiv = cdiv + 1;	/* round up */
+	/* According to G20 and G45 manuals we want to solve these: */
+	/* T_low = ((cldiv * (2 ** ckdiv)) + 4) * T_mclk  */
+	/* T_high = ((chdiv * (2 ** ckdiv)) + 4) * T_mclk  */
+	/* where T_low = T_high; cldiv and chdiv are 8 bits each and */
+	/* ckdiv is no more that 7 (sometimes less) */
 	ckdiv = 0;
-	while (cdiv > 255) {
-		ckdiv++;
-		cdiv = cdiv >> 1;
+	/* The twi_clk is the Mclk on the G20 and G45 */
+	cldiv = clk_get_rate(twi_clk) / (2 * clockrate);
+	if (cldiv < 4)
+		cldiv = 4;
+	cldiv -= 4;
+	while (cldiv > 255) {
+		cldiv >>= 1;
+		++ckdiv;
 	}
+	chdiv = cldiv;	/* 1:1 mark space ratio (why get such a choice) */
 
-	if (cpu_is_at91rm9200()) {			/* AT91RM9200 Errata #22 */
+	if (cpu_is_at91rm9200()) {		/* AT91RM9200 Errata #22 */
 		if (ckdiv > 5) {
-			printk(KERN_ERR "AT91 I2C: Invalid TWI_CLOCK value!\n");
+			printk(KERN_ERR "i2c-at91: AT91RM9200 clock rate too "
+			       "low, ckdiv=%u, set to 5\n", ckdiv);
 			ckdiv = 5;
 		}
+	} else if (cpu_is_at91sam9g20()) {
+		/* AT91SAM9G20 has 3 bits for ckdiv so it cannot exceed 7 */
+		if (ckdiv > 7) {
+			printk(KERN_ERR "i2c-at91: AT91SAM9G20 clock rate "
+			       "too low, ckdiv=%u, set to 7\n", ckdiv);
+			ckdiv = 7;
+		}
+	} else {
+		/* Assume others in AT91 family have 3 bits for ckdiv */
+		if (ckdiv > 7) {
+			printk(KERN_ERR "i2c-at91: AT91 clock rate too low, "
+			       "ckdiv=%u, set to 7\n", ckdiv);
+			ckdiv = 7;
+		}
 	}
 
-	at91_twi_write(AT91_TWI_CWGR, (ckdiv << 16) | (cdiv << 8) | cdiv);
+	at91_twi_write(AT91_TWI_CWGR, (ckdiv << 16) | (chdiv << 8) | cldiv);
+	prev_clockrate = clockrate;
 }
 
 /*
- * Poll the i2c status register until the specified bit is set.
- * Returns 0 if timed out (100 msec).
+ * Initialize the TWI hardware registers.
  */
-static short at91_poll_status(unsigned long bit)
+static void at91_twi_hwinit(void)
 {
-	int loop_cntr = 10000;
+	at91_twi_write(AT91_TWI_IDR, 0xffffffff);  /* Disable all interrupts */
+	at91_twi_write(AT91_TWI_CR, AT91_TWI_SWRST);     /* Reset peripheral */
+	/* Set Master mode; Atmel suggests disabling slave mode */
+	at91_twi_write(AT91_TWI_CR, AT91_TWI_MSEN | AT91_TWI_SVDIS);
 
+	at91_twi_clock_dividers();
+}
+
+/*
+ * Poll the i2c status register until the specified bit is set or a NACK
+ * occurs. Returns 0 if timed out (50 msec). If nack_seen_p is non-NULL
+ * then write 0 to it first, then if the NACK bit is set in the status
+ * register then write 1 to it and immediately return with a value of 1.
+ */
+static short at91_poll_status(unsigned long bit, int * nack_seen_p)
+{
+	int loop_cntr = 5000;
+	unsigned long stat;
+
+	if (nack_seen_p)
+		*nack_seen_p = 0;
+	if (clockrate <= 20000)
+		loop_cntr = 100;
 	do {
-		udelay(10);
-	} while (!(at91_twi_read(AT91_TWI_SR) & bit) && (--loop_cntr > 0));
+		if (clockrate <= 20000)
+			udelay(100);
+		else if (clockrate <= 100000)
+			udelay(10);
+		else
+			udelay(3);
+		stat = at91_twi_read(AT91_TWI_SR);
+		if ((stat & AT91_TWI_NACK) && nack_seen_p) {
+			*nack_seen_p = 1;
+			return 1;
+		}
+	} while (!(stat & bit) && (--loop_cntr > 0));
 
 	return (loop_cntr > 0);
 }
 
 static int xfer_read(struct i2c_adapter *adap, unsigned char *buf, int length)
 {
+	int nack_seen = 0;
+	int sent_stop = 0;
+
 	/* Send Start */
-	at91_twi_write(AT91_TWI_CR, AT91_TWI_START);
+	if (1 == length) {
+	    at91_twi_write(AT91_TWI_CR, AT91_TWI_START | AT91_TWI_STOP);
+	    sent_stop = 1;
+	} else
+	    at91_twi_write(AT91_TWI_CR, AT91_TWI_START);
 
 	/* Read data */
 	while (length--) {
-		if (!length)	/* need to send Stop before reading last byte */
+		/* send Stop before reading last byte (if not already done) */
+		if ((0 == length) && (0 == sent_stop))
 			at91_twi_write(AT91_TWI_CR, AT91_TWI_STOP);
-		if (!at91_poll_status(AT91_TWI_RXRDY)) {
+		if (!at91_poll_status(AT91_TWI_RXRDY, &nack_seen)) {
 			dev_dbg(&adap->dev, "RXRDY timeout\n");
 			return -ETIMEDOUT;
+		} else if (nack_seen) {
+			dev_dbg(&adap->dev, "read NACKed\n");
+			/* NACK supplies Stop */
+			return -EREMOTEIO;
 		}
 		*buf++ = (at91_twi_read(AT91_TWI_RHR) & 0xff);
 	}
@@ -105,16 +205,24 @@
 
 static int xfer_write(struct i2c_adapter *adap, unsigned char *buf, int length)
 {
+	int nack_seen = 0;
+
 	/* Load first byte into transmitter */
 	at91_twi_write(AT91_TWI_THR, *buf++);
 
-	/* Send Start */
+	/* Send Start [AT91SAM9G20 does not need this on write] */
 	at91_twi_write(AT91_TWI_CR, AT91_TWI_START);
 
 	do {
-		if (!at91_poll_status(AT91_TWI_TXRDY)) {
+		if (!at91_poll_status(AT91_TWI_TXRDY, &nack_seen)) {
 			dev_dbg(&adap->dev, "TXRDY timeout\n");
+			/* Set Master mode again */
+			at91_twi_write(AT91_TWI_CR, AT91_TWI_MSEN);
 			return -ETIMEDOUT;
+		} else if (nack_seen) {
+			dev_dbg(&adap->dev, "write NACKed\n");
+			/* NACK supplies Stop */
+			return -EREMOTEIO;
 		}
 
 		length--;	/* byte was transmitted */
@@ -123,7 +231,7 @@
 			at91_twi_write(AT91_TWI_THR, *buf++);
 	} while (length);
 
-	/* Send Stop */
+	/* Send Stop [AT91SAM9G20 does not need this on write] */
 	at91_twi_write(AT91_TWI_CR, AT91_TWI_STOP);
 
 	return 0;
@@ -136,11 +244,25 @@
  * Instead the "internal device address" has to be written using a separate
  * i2c message.
  * http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2004-September/024411.html
+ * [dpg] By 2010 silicon bugs should be fixed, will need IADR for 10 bit device address
  */
 static int at91_xfer(struct i2c_adapter *adap, struct i2c_msg *pmsg, int num)
 {
 	int i, ret;
-
+	int nack_seen = 0;
+ 
+	if (0 == num) {
+		dev_dbg(&adap->dev, "at91_xfer: treat num==0 as at91 twi "
+			"reset\n");
+		at91_twi_hwinit();
+		return num;
+	}
+	if (prev_clockrate != clockrate) {
+		dev_dbg(&adap->dev, "at91_xfer: prev_clockrate=%u "
+			"clockrate=%u, change\n", prev_clockrate, clockrate);
+		at91_twi_clock_dividers();
+		msleep(1);	/* let things settle */
+	}
 	dev_dbg(&adap->dev, "at91_xfer: processing %d messages:\n", num);
 
 	for (i = 0; i < num; i++) {
@@ -158,13 +280,23 @@
 			else
 				ret = xfer_write(adap, pmsg->buf, pmsg->len);
 
-			if (ret)
-				return ret;
-
+			if (ret) {
+				if ((I2C_M_IGNORE_NAK & pmsg->flags) &&
+				    (-EREMOTEIO == ret)) {
+					dev_dbg(&adap->dev, "transfer "
+						"NACKed, skip to next\n");
+					pmsg++;
+					continue;
+				} else
+					return ret;
+			}
 			/* Wait until transfer is finished */
-			if (!at91_poll_status(AT91_TWI_TXCOMP)) {
+			if (!at91_poll_status(AT91_TWI_TXCOMP, &nack_seen)) {
 				dev_dbg(&adap->dev, "TXCOMP timeout\n");
 				return -ETIMEDOUT;
+			} else if (nack_seen) {
+				dev_dbg(&adap->dev, "TXCOMP NACKed\n");
+				return -EREMOTEIO;
 			}
 		}
 		dev_dbg(&adap->dev, "transfer complete\n");
@@ -239,7 +371,8 @@
 		goto fail3;
 	}
 
-	dev_info(&pdev->dev, "AT91 i2c bus driver.\n");
+	dev_info(&pdev->dev, "Atmel TWI (I2C) master [SCL %d Hz], version: "
+		 "%s\n", clockrate, DRV_VERSION);
 	return 0;
 
 fail3:
@@ -287,7 +420,11 @@
 
 static int at91_i2c_resume(struct platform_device *pdev)
 {
-	return clk_enable(twi_clk);
+	int res;
+
+	res = clk_enable(twi_clk);
+	at91_twi_hwinit();
+	return res;
 }
 
 #else
@@ -295,6 +432,11 @@
 #define at91_i2c_resume		NULL
 #endif
 
+/* I2C clock speed, in Hz 0-400kHz*/
+module_param(clockrate, uint,  S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(clockrate,
+		 "SCL clock rate, 1000 to 4000000 Hz (def: 100 kHz)");
+
 /* work with "modprobe at91_i2c" from hotplugging or coldplugging */
 MODULE_ALIAS("platform:at91_i2c");
 
@@ -323,5 +465,6 @@
 module_exit(at91_i2c_exit);
 
 MODULE_AUTHOR("Rick Bronson");
-MODULE_DESCRIPTION("I2C (TWI) driver for Atmel AT91");
+MODULE_DESCRIPTION("I2C (TWI) master for Atmel AT91 series");
 MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);

--------------090503070203010707020406--
