From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 4/5] intel_mid_i2c: minor cleanups
Date: Thu, 17 Jun 2010 15:06:15 +0100
Message-ID: <20100617140613.17861.79039.stgit@localhost.localdomain>
References: <20100617140352.17861.29664.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100617140352.17861.29664.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

uint32t -> u32
bracketing of case statements
spacing and '!' usage

Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 drivers/i2c/busses/i2c-mrst.c |   54 +++++++++++++++++++----------------------
 1 files changed, 25 insertions(+), 29 deletions(-)


diff --git a/drivers/i2c/busses/i2c-mrst.c b/drivers/i2c/busses/i2c-mrst.c
index 9a8dfc8..974c189 100644
--- a/drivers/i2c/busses/i2c-mrst.c
+++ b/drivers/i2c/busses/i2c-mrst.c
@@ -240,50 +240,45 @@ static void mrst_i2c_abort(struct mrst_i2c_private *i2c)
 	 * the abort interrupt occured.
 	 */
 	switch (abort) {
-	case (ABRT_MASTER_DIS):
+	case ABRT_MASTER_DIS:
 		dev_err(&adap->dev,
-			"initiate Master operation with Master mode"
-			"disabled.\n");
+		"initiate Master operation with Master mode disabled.\n");
 
 		break;
-	case (ABRT_10B_RD_NORSTRT):
+	case ABRT_10B_RD_NORSTRT:
 		dev_err(&adap->dev,
-			"RESTART disabled and master sends READ cmd in 10-BIT"
-			"addressing.\n");
+	"RESTART disabled and master sends READ cmd in 10-BIT addressing.\n");
 		break;
-	case (ABRT_SBYTE_NORSTRT):
+	case ABRT_SBYTE_NORSTRT:
 		dev_err(&adap->dev,
-			"RESTART disabled and user is trying to send START"
-			"byte.\n");
+		"RESTART disabled and user is trying to send START byte.\n");
 		mrst_i2c_write(i2c->base + IC_TX_ABRT_SOURCE,
 			       !(ABRT_SBYTE_NORSTRT));
 		mrst_i2c_write(i2c->base + IC_CON, RESTART);
 		mrst_i2c_write(i2c->base + IC_TAR, !(IC_TAR_SPECIAL));
 		break;
-	case (ABRT_SBYTE_ACKDET):
+	case ABRT_SBYTE_ACKDET:
 		dev_err(&adap->dev,
 			"START byte was acknowledged.\n");
 		break;
-	case (ABRT_TXDATA_NOACK):
+	case ABRT_TXDATA_NOACK:
 		dev_err(&adap->dev,
 			"No acknowledge received from slave.\n");
 		break;
-	case (ABRT_10ADDR2_NOACK):
+	case ABRT_10ADDR2_NOACK:
 		dev_err(&adap->dev,
-			"The 2nd address byte of 10-bit address not"
-			"acknowledged.\n");
+	"The 2nd address byte of the 10-bit address not acknowledged.\n");
 		break;
-	case (ABRT_10ADDR1_NOACK):
+	case ABRT_10ADDR1_NOACK:
 		dev_dbg(&adap->dev,
-			"The 1st address byte of 10-bit address not"
-			"acknowledged.\n");
+		"The 1st address byte of 10-bit address not acknowledged.\n");
 		break;
-	case (ABRT_7B_ADDR_NOACK):
+	case ABRT_7B_ADDR_NOACK:
 		dev_err(&adap->dev,
 			"I2C slave device not acknowledge.\n");
 		break;
 	default:
-		;;
+		;
 	}
 
 	/* Clear TX_ABRT bit */
@@ -403,15 +398,15 @@ static int mrst_i2c_setup(struct i2c_adapter *adap,  struct i2c_msg *pmsg)
 	struct mrst_i2c_private *i2c =
 	    (struct mrst_i2c_private *)i2c_get_adapdata(adap);
 	int err;
-	uint32_t reg_val;
-	uint32_t bit_mask;
-	uint32_t mode;
+	u32 reg_val;
+	u32 bit_mask;
+	u32 mode;
 
 	/* Disable device first */
 	err = mrst_i2c_disable(adap);
 	if (err) {
 		dev_err(&adap->dev,
-			"Cannot disable i2c controller, timeout!\n");
+			"Cannot disable i2c controller, timeout\n");
 		return -ETIMEDOUT;
 	}
 
@@ -461,14 +456,15 @@ static int mrst_i2c_setup(struct i2c_adapter *adap,  struct i2c_msg *pmsg)
 	bit_mask = 1 << 11 | 1 << 10;
 
 	if ((reg_val & bit_mask) != 0x0) {
-		dev_dbg(&adap->dev, "WR: use target address when intiating"
-			"transfer, i2c_tx_target\n");
+		dev_dbg(&adap->dev,
+	 "WR: use target address when intiating transfer, i2c_tx_target\n");
 		mrst_i2c_write(i2c->base + IC_TAR, reg_val & ~bit_mask);
 	}
 
 	/* set target address to the I2C slave address */
-	dev_dbg(&adap->dev, "set target address to the I2C slave address,"
-		"addr is %x\n", pmsg->addr);
+	dev_dbg(&adap->dev,
+		"set target address to the I2C slave address, addr is %x\n",
+			pmsg->addr);
 	mrst_i2c_write(i2c->base + IC_TAR, pmsg->addr
 		       | (pmsg->flags & I2C_M_TEN ? IC_TAR_10BIT_ADDR : 0));
 
@@ -776,14 +772,14 @@ static int __devinit mrst_i2c_probe(struct pci_dev *dev,
 	/* Allocate the per-device data structure, mrst_i2c_private */
 	mrst = kzalloc(sizeof(struct mrst_i2c_private), GFP_KERNEL);
 	if (mrst == NULL) {
-		dev_err(&dev->dev, "Can't allocate interface!\n");
+		dev_err(&dev->dev, "Can't allocate interface\n");
 		err = -ENOMEM;
 		goto fail1;
 	}
 
 	adap = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
 	if (adap == NULL) {
-		dev_err(&dev->dev, "Can't allocate interface!\n");
+		dev_err(&dev->dev, "Can't allocate interface\n");
 		err = -ENOMEM;
 		goto fail2;
 	}
