From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCHv2 1/3] Remove trailing whitespaces and unnecessary UTF
Date: Wed, 06 Feb 2008 21:20:57 +0100
Message-ID: <20080206203036.394734224@pengutronix.de>
References: <20080206202056.364404622@pengutronix.de>
Content-Type: multipart/mixed; boundary="===============5589952208648156395=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============5589952208648156395==
Content-Disposition: inline; filename=i2c-pca-trailing-spaces.diff

Remove trailing whitespaces to make further patches more readable.  Also remove
an unnecessary UTF-char for simplicity ("us" for microseconds is fine enough).

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

---
 drivers/i2c/algos/i2c-algo-pca.c |   42 +++++++++++++++++++--------------------
 drivers/i2c/busses/i2c-pca-isa.c |    4 +--
 2 files changed, 23 insertions(+), 23 deletions(-)

Index: linux-playground/drivers/i2c/algos/i2c-algo-pca.c
===================================================================
--- linux-playground.orig/drivers/i2c/algos/i2c-algo-pca.c	2008-02-06 20:15:38.000000000 +0100
+++ linux-playground/drivers/i2c/algos/i2c-algo-pca.c	2008-02-06 21:20:01.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  i2c-algo-pca.c i2c driver algorithms for PCA9564 adapters                
+ *  i2c-algo-pca.c i2c driver algorithms for PCA9564 adapters
  *    Copyright (C) 2004 Arcom Control Systems
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -99,7 +99,7 @@
  *
  * returns after the address has been sent
  */
-static void pca_address(struct i2c_algo_pca_data *adap, 
+static void pca_address(struct i2c_algo_pca_data *adap,
 			struct i2c_msg *msg)
 {
 	int sta = pca_get_con(adap);
@@ -108,9 +108,9 @@
 	addr = ( (0x7f & msg->addr) << 1 );
 	if (msg->flags & I2C_M_RD )
 		addr |= 1;
-	DEB2("=== SLAVE ADDRESS %#04x+%c=%#04x\n", 
+	DEB2("=== SLAVE ADDRESS %#04x+%c=%#04x\n",
 	     msg->addr, msg->flags & I2C_M_RD ? 'R' : 'W', addr);
-	
+
 	pca_outw(adap, I2C_PCA_DAT, addr);
 
 	sta &= ~(I2C_PCA_CON_STO|I2C_PCA_CON_STA|I2C_PCA_CON_SI);
@@ -124,7 +124,7 @@
  *
  * Returns after the byte has been transmitted
  */
-static void pca_tx_byte(struct i2c_algo_pca_data *adap, 
+static void pca_tx_byte(struct i2c_algo_pca_data *adap,
 			__u8 b)
 {
 	int sta = pca_get_con(adap);
@@ -142,19 +142,19 @@
  *
  * returns immediately.
  */
-static void pca_rx_byte(struct i2c_algo_pca_data *adap, 
+static void pca_rx_byte(struct i2c_algo_pca_data *adap,
 			__u8 *b, int ack)
 {
 	*b = pca_inw(adap, I2C_PCA_DAT);
 	DEB2("=== READ %#04x %s\n", *b, ack ? "ACK" : "NACK");
 }
 
-/* 
+/*
  * Setup ACK or NACK for next received byte and wait for it to arrive.
  *
  * Returns after next byte has arrived.
  */
-static void pca_rx_ack(struct i2c_algo_pca_data *adap, 
+static void pca_rx_ack(struct i2c_algo_pca_data *adap,
 		       int ack)
 {
 	int sta = pca_get_con(adap);
@@ -168,8 +168,8 @@
 	pca_wait(adap);
 }
 
-/* 
- * Reset the i2c bus / SIO 
+/*
+ * Reset the i2c bus / SIO
  */
 static void pca_reset(struct i2c_algo_pca_data *adap)
 {
@@ -203,14 +203,14 @@
 		for (curmsg = 0; curmsg < num; curmsg++) {
 			int addr, i;
 			msg = &msgs[curmsg];
-			
+
 			addr = (0x7f & msg->addr) ;
-		
+
 			if (msg->flags & I2C_M_RD )
-				printk(KERN_INFO "    [%02d] RD %d bytes from %#02x [%#02x, ...]\n", 
+				printk(KERN_INFO "    [%02d] RD %d bytes from %#02x [%#02x, ...]\n",
 				       curmsg, msg->len, addr, (addr<<1) | 1);
 			else {
-				printk(KERN_INFO "    [%02d] WR %d bytes to %#02x [%#02x%s", 
+				printk(KERN_INFO "    [%02d] WR %d bytes to %#02x [%#02x%s",
 				       curmsg, msg->len, addr, addr<<1,
 				       msg->len == 0 ? "" : ", ");
 				for(i=0; i < msg->len; i++)
@@ -237,7 +237,7 @@
 		case 0x10: /* A repeated start condition has been transmitted */
 			pca_address(adap, msg);
 			break;
-			
+
 		case 0x18: /* SLA+W has been transmitted; ACK has been received */
 		case 0x28: /* Data byte in I2CDAT has been transmitted; ACK has been received */
 			if (numbytes < msg->len) {
@@ -287,7 +287,7 @@
 		case 0x38: /* Arbitration lost during SLA+W, SLA+R or data bytes */
 			DEB2("Arbitration lost\n");
 			goto out;
-			
+
 		case 0x58: /* Data byte has been received; NOT ACK has been returned */
 			if ( numbytes == msg->len - 1 ) {
 				pca_rx_byte(adap, &msg->buf[numbytes], 0);
@@ -320,13 +320,13 @@
 			printk(KERN_ERR DRIVER ": unhandled SIO state 0x%02x\n", state);
 			break;
 		}
-		
+
 	}
 
 	ret = curmsg;
  out:
 	DEB1(KERN_CRIT "}}} transfered %d/%d messages. "
-	     "status is %#04x. control is %#04x\n", 
+	     "status is %#04x. control is %#04x\n",
 	     curmsg, num, pca_status(adap),
 	     pca_get_con(adap));
 	return ret;
@@ -350,7 +350,7 @@
 	pca_outw(adap, I2C_PCA_ADR, own << 1);
 
 	pca_set_con(adap, I2C_PCA_CON_ENSIO | clock);
-	udelay(500); /* 500 µs for oscilator to stabilise */
+	udelay(500); /* 500 us for oscilator to stabilise */
 
 	return 0;
 }
@@ -360,8 +360,8 @@
 	.functionality	= pca_func,
 };
 
-/* 
- * registering functions to load algorithms at runtime 
+/*
+ * registering functions to load algorithms at runtime
  */
 int i2c_pca_add_bus(struct i2c_adapter *adap)
 {
Index: linux-playground/drivers/i2c/busses/i2c-pca-isa.c
===================================================================
--- linux-playground.orig/drivers/i2c/busses/i2c-pca-isa.c	2008-02-06 20:15:38.000000000 +0100
+++ linux-playground/drivers/i2c/busses/i2c-pca-isa.c	2008-02-06 21:20:01.000000000 +0100
@@ -78,7 +78,7 @@
 	int res = inb(base+reg);
 #ifdef DEBUG_IO
 	{
-		static char *names[] = { "STA", "DAT", "ADR", "CON" };	
+		static char *names[] = { "STA", "DAT", "ADR", "CON" };
 		printk("*** read  %s => %#04x\n", names[reg], res);
 	}
 #endif
@@ -93,7 +93,7 @@
 		ret = wait_event_interruptible(pca_wait,
 					       pca_isa_readbyte(adap, I2C_PCA_CON) & I2C_PCA_CON_SI);
 	} else {
-		while ((pca_isa_readbyte(adap, I2C_PCA_CON) & I2C_PCA_CON_SI) == 0) 
+		while ((pca_isa_readbyte(adap, I2C_PCA_CON) & I2C_PCA_CON_SI) == 0)
 			udelay(100);
 	}
 	return ret;

-- 
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry


--===============5589952208648156395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============5589952208648156395==--
