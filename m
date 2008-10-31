From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 3/9] i2c-s3c2410: fixup style problems from checkpatch.pl
Date: Fri, 31 Oct 2008 16:04:23 +0000
Message-ID: <20081031160437.041882772@fluff.org.uk>
References: <20081031160420.164160051@fluff.org.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=simtec/s3c64xx/i2c-fix-checkpatch-problems.patch
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fixup the 36 warnings and errors generated from running
checkpatch.pl on the driver. The warnings are too numerous
to be listed here.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Index: linux.git/drivers/i2c/busses/i2c-s3c2410.c
===================================================================
--- linux.git.orig/drivers/i2c/busses/i2c-s3c2410.c	2008-10-31 11:55:49.000000000 +0000
+++ linux.git/drivers/i2c/busses/i2c-s3c2410.c	2008-10-31 11:55:50.000000000 +0000
@@ -110,7 +110,8 @@ static inline int s3c24xx_i2c_is2440(str
  * the default if there is none
 */
 
-static inline struct s3c2410_platform_i2c *s3c24xx_i2c_get_platformdata(struct device *dev)
+static inline struct s3c2410_platform_i2c *
+s3c24xx_i2c_get_platformdata(struct device *dev)
 {
 	if (dev->platform_data != NULL)
 		return (struct s3c2410_platform_i2c *)dev->platform_data;
@@ -130,7 +131,7 @@ static inline void s3c24xx_i2c_master_co
 
 	i2c->msg_ptr = 0;
 	i2c->msg = NULL;
-	i2c->msg_idx ++;
+	i2c->msg_idx++;
 	i2c->msg_num = 0;
 	if (ret)
 		i2c->msg_idx = ret;
@@ -141,19 +142,17 @@ static inline void s3c24xx_i2c_master_co
 static inline void s3c24xx_i2c_disable_ack(struct s3c24xx_i2c *i2c)
 {
 	unsigned long tmp;
-	
+
 	tmp = readl(i2c->regs + S3C2410_IICCON);
 	writel(tmp & ~S3C2410_IICCON_ACKEN, i2c->regs + S3C2410_IICCON);
-
 }
 
 static inline void s3c24xx_i2c_enable_ack(struct s3c24xx_i2c *i2c)
 {
 	unsigned long tmp;
-	
+
 	tmp = readl(i2c->regs + S3C2410_IICCON);
 	writel(tmp | S3C2410_IICCON_ACKEN, i2c->regs + S3C2410_IICCON);
-
 }
 
 /* irq enable/disable functions */
@@ -161,7 +160,7 @@ static inline void s3c24xx_i2c_enable_ac
 static inline void s3c24xx_i2c_disable_irq(struct s3c24xx_i2c *i2c)
 {
 	unsigned long tmp;
-	
+
 	tmp = readl(i2c->regs + S3C2410_IICCON);
 	writel(tmp & ~S3C2410_IICCON_IRQEN, i2c->regs + S3C2410_IICCON);
 }
@@ -169,7 +168,7 @@ static inline void s3c24xx_i2c_disable_i
 static inline void s3c24xx_i2c_enable_irq(struct s3c24xx_i2c *i2c)
 {
 	unsigned long tmp;
-	
+
 	tmp = readl(i2c->regs + S3C2410_IICCON);
 	writel(tmp | S3C2410_IICCON_IRQEN, i2c->regs + S3C2410_IICCON);
 }
@@ -177,10 +176,10 @@ static inline void s3c24xx_i2c_enable_ir
 
 /* s3c24xx_i2c_message_start
  *
- * put the start of a message onto the bus 
+ * put the start of a message onto the bus
 */
 
-static void s3c24xx_i2c_message_start(struct s3c24xx_i2c *i2c, 
+static void s3c24xx_i2c_message_start(struct s3c24xx_i2c *i2c,
 				      struct i2c_msg *msg)
 {
 	unsigned int addr = (msg->addr & 0x7f) << 1;
@@ -199,15 +198,15 @@ static void s3c24xx_i2c_message_start(st
 	if (msg->flags & I2C_M_REV_DIR_ADDR)
 		addr ^= 1;
 
-	// todo - check for wether ack wanted or not
+	/* todo - check for wether ack wanted or not */
 	s3c24xx_i2c_enable_ack(i2c);
 
 	iiccon = readl(i2c->regs + S3C2410_IICCON);
 	writel(stat, i2c->regs + S3C2410_IICSTAT);
-	
+
 	dev_dbg(i2c->dev, "START: %08lx to IICSTAT, %02x to DS\n", stat, addr);
 	writeb(addr, i2c->regs + S3C2410_IICDS);
-	
+
 	/* delay here to ensure the data byte has gotten onto the bus
 	 * before the transaction is started */
 
@@ -215,8 +214,8 @@ static void s3c24xx_i2c_message_start(st
 
 	dev_dbg(i2c->dev, "iiccon, %08lx\n", iiccon);
 	writel(iiccon, i2c->regs + S3C2410_IICCON);
-	
-	stat |=  S3C2410_IICSTAT_START;
+
+	stat |= S3C2410_IICSTAT_START;
 	writel(stat, i2c->regs + S3C2410_IICSTAT);
 }
 
@@ -227,11 +226,11 @@ static inline void s3c24xx_i2c_stop(stru
 	dev_dbg(i2c->dev, "STOP\n");
 
 	/* stop the transfer */
-	iicstat &= ~ S3C2410_IICSTAT_START;
+	iicstat &= ~S3C2410_IICSTAT_START;
 	writel(iicstat, i2c->regs + S3C2410_IICSTAT);
-	
+
 	i2c->state = STATE_STOP;
-	
+
 	s3c24xx_i2c_master_complete(i2c, ret);
 	s3c24xx_i2c_disable_irq(i2c);
 }
@@ -241,7 +240,7 @@ static inline void s3c24xx_i2c_stop(stru
 
 /* is_lastmsg()
  *
- * returns TRUE if the current message is the last in the set 
+ * returns TRUE if the current message is the last in the set
 */
 
 static inline int is_lastmsg(struct s3c24xx_i2c *i2c)
@@ -289,14 +288,14 @@ static int i2s_s3c_irq_nextbyte(struct s
 
 	case STATE_STOP:
 		dev_err(i2c->dev, "%s: called in STATE_STOP\n", __func__);
-		s3c24xx_i2c_disable_irq(i2c);		
+		s3c24xx_i2c_disable_irq(i2c);
 		goto out_ack;
 
 	case STATE_START:
 		/* last thing we did was send a start condition on the
 		 * bus, or started a new i2c message
 		 */
-		
+
 		if (iicstat & S3C2410_IICSTAT_LASTBIT &&
 		    !(i2c->msg->flags & I2C_M_IGNORE_NAK)) {
 			/* ack was not received... */
@@ -322,7 +321,7 @@ static int i2s_s3c_irq_nextbyte(struct s
 		if (i2c->state == STATE_READ)
 			goto prepare_read;
 
-		/* fall through to the write state, as we will need to 
+		/* fall through to the write state, as we will need to
 		 * send a byte as well */
 
 	case STATE_WRITE:
@@ -339,7 +338,7 @@ static int i2s_s3c_irq_nextbyte(struct s
 			}
 		}
 
-	retry_write:
+ retry_write:
 
 		if (!is_msgend(i2c)) {
 			byte = i2c->msg->buf[i2c->msg_ptr++];
@@ -359,9 +358,9 @@ static int i2s_s3c_irq_nextbyte(struct s
 			dev_dbg(i2c->dev, "WRITE: Next Message\n");
 
 			i2c->msg_ptr = 0;
-			i2c->msg_idx ++;
+			i2c->msg_idx++;
 			i2c->msg++;
-			
+
 			/* check to see if we need to do another message */
 			if (i2c->msg->flags & I2C_M_NOSTART) {
 
@@ -375,7 +374,6 @@ static int i2s_s3c_irq_nextbyte(struct s
 
 				goto retry_write;
 			} else {
-			
 				/* send the new start */
 				s3c24xx_i2c_message_start(i2c, i2c->msg);
 				i2c->state = STATE_START;
@@ -389,7 +387,7 @@ static int i2s_s3c_irq_nextbyte(struct s
 		break;
 
 	case STATE_READ:
-		/* we have a byte of data in the data register, do 
+		/* we have a byte of data in the data register, do
 		 * something with it, and then work out wether we are
 		 * going to do any more read/write
 		 */
@@ -397,13 +395,13 @@ static int i2s_s3c_irq_nextbyte(struct s
 		byte = readb(i2c->regs + S3C2410_IICDS);
 		i2c->msg->buf[i2c->msg_ptr++] = byte;
 
-	prepare_read:
+ prepare_read:
 		if (is_msglast(i2c)) {
 			/* last byte of buffer */
 
 			if (is_lastmsg(i2c))
 				s3c24xx_i2c_disable_ack(i2c);
-			
+
 		} else if (is_msgend(i2c)) {
 			/* ok, we've read the entire buffer, see if there
 			 * is anything else we need to do */
@@ -429,7 +427,7 @@ static int i2s_s3c_irq_nextbyte(struct s
 	/* acknowlegde the IRQ and get back on with the work */
 
  out_ack:
-	tmp = readl(i2c->regs + S3C2410_IICCON);	
+	tmp = readl(i2c->regs + S3C2410_IICCON);
 	tmp &= ~S3C2410_IICCON_IRQPEND;
 	writel(tmp, i2c->regs + S3C2410_IICCON);
  out:
@@ -450,19 +448,19 @@ static irqreturn_t s3c24xx_i2c_irq(int i
 	status = readl(i2c->regs + S3C2410_IICSTAT);
 
 	if (status & S3C2410_IICSTAT_ARBITR) {
-		// deal with arbitration loss
+		/* deal with arbitration loss */
 		dev_err(i2c->dev, "deal with arbitration loss\n");
 	}
 
 	if (i2c->state == STATE_IDLE) {
 		dev_dbg(i2c->dev, "IRQ: error i2c->state == IDLE\n");
 
-		tmp = readl(i2c->regs + S3C2410_IICCON);	
+		tmp = readl(i2c->regs + S3C2410_IICCON);
 		tmp &= ~S3C2410_IICCON_IRQPEND;
 		writel(tmp, i2c->regs +  S3C2410_IICCON);
 		goto out;
 	}
-	
+
 	/* pretty much this leaves us with the fact that we've
 	 * transmitted or received whatever byte we last sent */
 
@@ -485,7 +483,7 @@ static int s3c24xx_i2c_set_master(struct
 
 	while (timeout-- > 0) {
 		iicstat = readl(i2c->regs + S3C2410_IICSTAT);
-		
+
 		if (!(iicstat & S3C2410_IICSTAT_BUSBUSY))
 			return 0;
 
@@ -503,7 +501,8 @@ static int s3c24xx_i2c_set_master(struct
  * this starts an i2c transfer
 */
 
-static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c, struct i2c_msg *msgs, int num)
+static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
+			      struct i2c_msg *msgs, int num)
 {
 	unsigned long timeout;
 	int ret;
@@ -529,12 +528,12 @@ static int s3c24xx_i2c_doxfer(struct s3c
 	s3c24xx_i2c_enable_irq(i2c);
 	s3c24xx_i2c_message_start(i2c, msgs);
 	spin_unlock_irq(&i2c->lock);
-	
+
 	timeout = wait_event_timeout(i2c->wait, i2c->msg_num == 0, HZ * 5);
 
 	ret = i2c->msg_idx;
 
-	/* having these next two as dev_err() makes life very 
+	/* having these next two as dev_err() makes life very
 	 * noisy when doing an i2cdetect */
 
 	if (timeout == 0)
@@ -643,7 +642,7 @@ static inline int freq_acceptable(unsign
 {
 	int diff = freq - wanted;
 
-	return (diff >= -2 && diff <= 2);
+	return diff >= -2 && diff <= 2;
 }
 
 /* s3c24xx_i2c_clockrate
@@ -666,7 +665,7 @@ static int s3c24xx_i2c_clockrate(struct 
 
 	pdata = s3c24xx_i2c_get_platformdata(i2c->adap.dev.parent);
 	clkin /= 1000;		/* clkin now in KHz */
-     
+
 	dev_dbg(i2c->dev, "pdata %p, freq %lu %lu..%lu\n",
 		 pdata, pdata->bus_freq, pdata->min_freq, pdata->max_freq);
 
@@ -774,7 +773,7 @@ static inline void s3c24xx_i2c_deregiste
 
 /* s3c24xx_i2c_init
  *
- * initialise the controller, set the IO lines and frequency 
+ * initialise the controller, set the IO lines and frequency
 */
 
 static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
@@ -793,7 +792,7 @@ static int s3c24xx_i2c_init(struct s3c24
 	s3c2410_gpio_cfgpin(S3C2410_GPE14, S3C2410_GPE14_IICSCL);
 
 	/* write slave address */
-	
+
 	writeb(pdata->slave_addr, i2c->regs + S3C2410_IICADD);
 
 	dev_info(i2c->dev, "slave address 0x%02x\n", pdata->slave_addr);
@@ -878,7 +877,8 @@ static int s3c24xx_i2c_probe(struct plat
 		goto err_ioarea;
 	}
 
-	dev_dbg(&pdev->dev, "registers %p (%p, %p)\n", i2c->regs, i2c->ioarea, res);
+	dev_dbg(&pdev->dev, "registers %p (%p, %p)\n",
+		i2c->regs, i2c->ioarea, res);
 
 	/* setup info block for the i2c core */
 
@@ -892,7 +892,7 @@ static int s3c24xx_i2c_probe(struct plat
 		goto err_iomap;
 
 	/* find the IRQ for this unit (note, this relies on the init call to
-	 * ensure no current IRQs pending 
+	 * ensure no current IRQs pending
 	 */
 
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
@@ -911,7 +911,7 @@ static int s3c24xx_i2c_probe(struct plat
 	}
 
 	i2c->irq = res;
-		
+
 	dev_dbg(&pdev->dev, "irq resource %p (%lu)\n", res,
 		(unsigned long)res->start);
 

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
