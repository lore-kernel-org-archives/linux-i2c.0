From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] I2C STU300 stability updates
Date: Thu, 13 Aug 2009 22:14:23 +0200
Message-ID: <1250194463-14415-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

- blk clk is enabled when an irq arrives. The clk should be enabled,
  but just to make sure.
- All error bits are handled no matter state machine state
- All irq's will run complete() except for irq's that wasn't an event.
- No more looking into status registers just in case an interrupt
  has happend and the irq handle wasn't executed.
- irq_disable/enable are now separete functions.
- clk settings calculation changed to round upwards instead of
  downwards.
- Number of address send attempts before giving up is increased to 12
  from 10 since it most times take 8 tries before getting through.

Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/i2c/busses/i2c-stu300.c |  157 +++++++++++++++++++++++----------------
 1 files changed, 92 insertions(+), 65 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 182e711..d2728a2 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -117,7 +117,8 @@ enum stu300_error {
 	STU300_ERROR_NONE = 0,
 	STU300_ERROR_ACKNOWLEDGE_FAILURE,
 	STU300_ERROR_BUS_ERROR,
-	STU300_ERROR_ARBITRATION_LOST
+	STU300_ERROR_ARBITRATION_LOST,
+	STU300_ERROR_UNKNOWN
 };
 
 /* timeout waiting for the controller to respond */
@@ -127,7 +128,7 @@ enum stu300_error {
  * The number of address send athemps tried before giving up.
  * If the first one failes it seems like 5 to 8 attempts are required.
  */
-#define NUM_ADDR_RESEND_ATTEMPTS 10
+#define NUM_ADDR_RESEND_ATTEMPTS 12
 
 /* I2C clock speed, in Hz 0-400kHz*/
 static unsigned int scl_frequency = 100000;
@@ -149,6 +150,7 @@ module_param(scl_frequency, uint,  0644);
  * @msg_index: index of current message
  * @msg_len: length of current message
  */
+
 struct stu300_dev {
 	struct platform_device	*pdev;
 	struct i2c_adapter	adapter;
@@ -188,6 +190,27 @@ static inline u32 stu300_r8(void __iomem *address)
 	return readl(address) & 0x000000FFU;
 }
 
+static void stu300_irq_enable(struct stu300_dev *dev)
+{
+	u32 val;
+	val = stu300_r8(dev->virtbase + I2C_CR);
+	val |= I2C_CR_INTERRUPT_ENABLE;
+	/* Twice paranoia (possible HW glitch) */
+	stu300_wr8(val, dev->virtbase + I2C_CR);
+	stu300_wr8(val, dev->virtbase + I2C_CR);
+}
+
+static void stu300_irq_disable(struct stu300_dev *dev)
+{
+	u32 val;
+	val = stu300_r8(dev->virtbase + I2C_CR);
+	val &= ~I2C_CR_INTERRUPT_ENABLE;
+	/* Twice paranoia (possible HW glitch) */
+	stu300_wr8(val, dev->virtbase + I2C_CR);
+	stu300_wr8(val, dev->virtbase + I2C_CR);
+}
+
+
 /*
  * Tells whether a certain event or events occurred in
  * response to a command. The events represent states in
@@ -196,9 +219,10 @@ static inline u32 stu300_r8(void __iomem *address)
  * documentation and can only be treated as abstract state
  * machine states.
  *
- * @ret 0 = event has not occurred, any other value means
- * the event occurred.
+ * @ret 0 = event has not occurred or unknown error, any
+ * other value means the correct event occurred or an error.
  */
+
 static int stu300_event_occurred(struct stu300_dev *dev,
 				   enum stu300_event mr_event) {
 	u32 status1;
@@ -206,11 +230,28 @@ static int stu300_event_occurred(struct stu300_dev *dev,
 
 	/* What event happened? */
 	status1 = stu300_r8(dev->virtbase + I2C_SR1);
+
 	if (!(status1 & I2C_SR1_EVF_IND))
 		/* No event at all */
 		return 0;
+
 	status2 = stu300_r8(dev->virtbase + I2C_SR2);
 
+	/* Block any multiple interrupts */
+	stu300_irq_disable(dev);
+
+	/* Check for errors first */
+	if (status2 & I2C_SR2_AF_IND) {
+		dev->cmd_err = STU300_ERROR_ACKNOWLEDGE_FAILURE;
+		return 1;
+	} else if (status2 & I2C_SR2_BERR_IND) {
+		dev->cmd_err = STU300_ERROR_BUS_ERROR;
+		return 1;
+	} else if (status2 & I2C_SR2_ARLO_IND) {
+		dev->cmd_err = STU300_ERROR_ARBITRATION_LOST;
+		return 1;
+	}
+
 	switch (mr_event) {
 	case STU300_EVENT_1:
 		if (status1 & I2C_SR1_ADSL_IND)
@@ -221,10 +262,6 @@ static int stu300_event_occurred(struct stu300_dev *dev,
 	case STU300_EVENT_7:
 	case STU300_EVENT_8:
 		if (status1 & I2C_SR1_BTF_IND) {
-			if (status2 & I2C_SR2_AF_IND)
-				dev->cmd_err = STU300_ERROR_ACKNOWLEDGE_FAILURE;
-			else if (status2 & I2C_SR2_BERR_IND)
-				dev->cmd_err = STU300_ERROR_BUS_ERROR;
 			return 1;
 		}
 		break;
@@ -240,8 +277,6 @@ static int stu300_event_occurred(struct stu300_dev *dev,
 	case STU300_EVENT_6:
 		if (status2 & I2C_SR2_ENDAD_IND) {
 			/* First check for any errors */
-			if (status2 & I2C_SR2_AF_IND)
-				dev->cmd_err = STU300_ERROR_ACKNOWLEDGE_FAILURE;
 			return 1;
 		}
 		break;
@@ -252,8 +287,15 @@ static int stu300_event_occurred(struct stu300_dev *dev,
 	default:
 		break;
 	}
-	if (status2 & I2C_SR2_ARLO_IND)
-		dev->cmd_err = STU300_ERROR_ARBITRATION_LOST;
+	/* If we get here, we're on thin ice.
+	 * Here we are in a status where we have
+	 * gotten a response that does not match
+	 * what we requested.
+	 */
+	dev->cmd_err = STU300_ERROR_UNKNOWN;
+	dev_err(&dev->pdev->dev,
+		"Unhandled interrupt! %d sr1: 0x%x sr2: 0x%x\n",
+		mr_event, status1, status2);
 	return 0;
 }
 
@@ -262,21 +304,20 @@ static irqreturn_t stu300_irh(int irq, void *data)
 	struct stu300_dev *dev = data;
 	int res;
 
+	/* Just make sure that the block is clocked */
+	clk_enable(dev->clk);
+
 	/* See if this was what we were waiting for */
 	spin_lock(&dev->cmd_issue_lock);
-	if (dev->cmd_event != STU300_EVENT_NONE) {
-		res = stu300_event_occurred(dev, dev->cmd_event);
-		if (res || dev->cmd_err != STU300_ERROR_NONE) {
-			u32 val;
-
-			complete(&dev->cmd_complete);
-			/* Block any multiple interrupts */
-			val = stu300_r8(dev->virtbase + I2C_CR);
-			val &= ~I2C_CR_INTERRUPT_ENABLE;
-			stu300_wr8(val, dev->virtbase + I2C_CR);
-		}
-	}
+
+	res = stu300_event_occurred(dev, dev->cmd_event);
+	if (res || dev->cmd_err != STU300_ERROR_NONE)
+		complete(&dev->cmd_complete);
+
 	spin_unlock(&dev->cmd_issue_lock);
+
+	clk_disable(dev->clk);
+
 	return IRQ_HANDLED;
 }
 
@@ -308,7 +349,6 @@ static int stu300_start_and_await_event(struct stu300_dev *dev,
 	stu300_wr8(cr_value, dev->virtbase + I2C_CR);
 	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
 							STU300_TIMEOUT);
-
 	if (ret < 0) {
 		dev_err(&dev->pdev->dev,
 		       "wait_for_completion_interruptible_timeout() "
@@ -342,7 +382,6 @@ static int stu300_await_event(struct stu300_dev *dev,
 				enum stu300_event mr_event)
 {
 	int ret;
-	u32 val;
 
 	if (unlikely(irqs_disabled())) {
 		/* TODO: implement polling for this case if need be. */
@@ -354,36 +393,18 @@ static int stu300_await_event(struct stu300_dev *dev,
 	/* Is it already here? */
 	spin_lock_irq(&dev->cmd_issue_lock);
 	dev->cmd_err = STU300_ERROR_NONE;
-	if (stu300_event_occurred(dev, mr_event)) {
-		spin_unlock_irq(&dev->cmd_issue_lock);
-		goto exit_await_check_err;
-	}
-	init_completion(&dev->cmd_complete);
-	dev->cmd_err = STU300_ERROR_NONE;
 	dev->cmd_event = mr_event;
 
-	/* Turn on the I2C interrupt for current operation */
-	val = stu300_r8(dev->virtbase + I2C_CR);
-	val |= I2C_CR_INTERRUPT_ENABLE;
-	stu300_wr8(val, dev->virtbase + I2C_CR);
-
-	/* Twice paranoia (possible HW glitch) */
-	stu300_wr8(val, dev->virtbase + I2C_CR);
+	init_completion(&dev->cmd_complete);
 
-	/* Check again: is it already here? */
-	if (unlikely(stu300_event_occurred(dev, mr_event))) {
-		/* Disable IRQ again. */
-		val &= ~I2C_CR_INTERRUPT_ENABLE;
-		stu300_wr8(val, dev->virtbase + I2C_CR);
-		spin_unlock_irq(&dev->cmd_issue_lock);
-		goto exit_await_check_err;
-	}
+	/* Turn on the I2C interrupt for current operation */
+	stu300_irq_enable(dev);
 
 	/* Unlock the command block and wait for the event to occur */
 	spin_unlock_irq(&dev->cmd_issue_lock);
+
 	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
 							STU300_TIMEOUT);
-
 	if (ret < 0) {
 		dev_err(&dev->pdev->dev,
 		       "wait_for_completion_interruptible_timeout()"
@@ -401,7 +422,6 @@ static int stu300_await_event(struct stu300_dev *dev,
 		return -ETIMEDOUT;
 	}
 
- exit_await_check_err:
 	if (dev->cmd_err != STU300_ERROR_NONE) {
 		if (mr_event != STU300_EVENT_6) {
 			dev_err(&dev->pdev->dev, "controller "
@@ -457,18 +477,19 @@ struct stu300_clkset {
 };
 
 static const struct stu300_clkset stu300_clktable[] = {
-	{ 0, 0xFFU },
-	{ 2500000, I2C_OAR2_FR_25_10MHZ },
-	{ 10000000, I2C_OAR2_FR_10_1667MHZ },
-	{ 16670000, I2C_OAR2_FR_1667_2667MHZ },
-	{ 26670000, I2C_OAR2_FR_2667_40MHZ },
-	{ 40000000, I2C_OAR2_FR_40_5333MHZ },
-	{ 53330000, I2C_OAR2_FR_5333_66MHZ },
-	{ 66000000, I2C_OAR2_FR_66_80MHZ },
-	{ 80000000, I2C_OAR2_FR_80_100MHZ },
+	{ 0,         0xFFU },
+	{ 2500000,   I2C_OAR2_FR_25_10MHZ },
+	{ 10000000,  I2C_OAR2_FR_10_1667MHZ },
+	{ 16670000,  I2C_OAR2_FR_1667_2667MHZ },
+	{ 26670000,  I2C_OAR2_FR_2667_40MHZ },
+	{ 40000000,  I2C_OAR2_FR_40_5333MHZ },
+	{ 53330000,  I2C_OAR2_FR_5333_66MHZ },
+	{ 66000000,  I2C_OAR2_FR_66_80MHZ },
+	{ 80000000,  I2C_OAR2_FR_80_100MHZ },
 	{ 100000000, 0xFFU },
 };
 
+
 static int stu300_set_clk(struct stu300_dev *dev, unsigned long clkrate)
 {
 
@@ -494,10 +515,10 @@ static int stu300_set_clk(struct stu300_dev *dev, unsigned long clkrate)
 
 	if (dev->speed > 100000)
 		/* Fast Mode I2C */
-		val = ((clkrate/dev->speed)-9)/3;
+		val = ((clkrate/dev->speed) - 9)/3 + 1;
 	else
 		/* Standard Mode I2C */
-		val = ((clkrate/dev->speed)-7)/2;
+		val = ((clkrate/dev->speed) - 7)/2 + 1;
 
 	/* According to spec the divider must be > 2 */
 	if (val < 0x002) {
@@ -557,6 +578,7 @@ static int stu300_init_hw(struct stu300_dev *dev)
 	 */
 	clkrate = clk_get_rate(dev->clk);
 	ret = stu300_set_clk(dev, clkrate);
+
 	if (ret)
 		return ret;
 	/*
@@ -641,7 +663,6 @@ static int stu300_xfer_msg(struct i2c_adapter *adap,
 	int attempts = 0;
 	struct stu300_dev *dev = i2c_get_adapdata(adap);
 
-
 	clk_enable(dev->clk);
 
 	/* Remove this if (0) to trace each and every message. */
@@ -715,14 +736,15 @@ static int stu300_xfer_msg(struct i2c_adapter *adap,
 
 	if (attempts < NUM_ADDR_RESEND_ATTEMPTS && attempts > 0) {
 		dev_dbg(&dev->pdev->dev, "managed to get address "
-		       "through after %d attempts\n", attempts);
+			"through after %d attempts\n", attempts);
 	} else if (attempts == NUM_ADDR_RESEND_ATTEMPTS) {
 		dev_dbg(&dev->pdev->dev, "I give up, tried %d times "
-		       "to resend address.\n",
-		       NUM_ADDR_RESEND_ATTEMPTS);
+			"to resend address.\n",
+			NUM_ADDR_RESEND_ATTEMPTS);
 		goto exit_disable;
 	}
 
+
 	if (msg->flags & I2C_M_RD) {
 		/* READ: we read the actual bytes one at a time */
 		for (i = 0; i < msg->len; i++) {
@@ -804,8 +826,10 @@ static int stu300_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 {
 	int ret = -1;
 	int i;
+
 	struct stu300_dev *dev = i2c_get_adapdata(adap);
 	dev->msg_len = num;
+
 	for (i = 0; i < num; i++) {
 		/*
 		 * Another driver appears to send stop for each message,
@@ -817,6 +841,7 @@ static int stu300_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		dev->msg_index = i;
 
 		ret = stu300_xfer_msg(adap, &msgs[i], (i == (num - 1)));
+
 		if (ret != 0) {
 			num = ret;
 			break;
@@ -845,6 +870,7 @@ stu300_probe(struct platform_device *pdev)
 	struct resource *res;
 	int bus_nr;
 	int ret = 0;
+	char clk_name[] = "I2C0";
 
 	dev = kzalloc(sizeof(struct stu300_dev), GFP_KERNEL);
 	if (!dev) {
@@ -854,7 +880,8 @@ stu300_probe(struct platform_device *pdev)
 	}
 
 	bus_nr = pdev->id;
-	dev->clk = clk_get(&pdev->dev, NULL);
+	clk_name[3] += (char)bus_nr;
+	dev->clk = clk_get(&pdev->dev, clk_name);
 	if (IS_ERR(dev->clk)) {
 		ret = PTR_ERR(dev->clk);
 		dev_err(&pdev->dev, "could not retrieve i2c bus clock\n");
-- 
1.6.2.1
