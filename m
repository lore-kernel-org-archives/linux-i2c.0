From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-taos-evm: Switch echo off to improve performance
Date: Tue, 14 Jul 2009 20:34:39 +0200
Message-ID: <20090714203439.3a753f4a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

When echo is on, we waste time reading back our orders. Switching echo
off makes performance much better: SMBus byte data transactions are 47%
faster and byte transactions are 24% faster.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
If anyone else is using a TAOS EVM on serial port, please let me know
if this patch cause any trouble for you.

 drivers/i2c/busses/i2c-taos-evm.c |   45 +++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

--- linux-2.6.31-rc3.orig/drivers/i2c/busses/i2c-taos-evm.c	2009-07-14 09:40:38.000000000 +0200
+++ linux-2.6.31-rc3/drivers/i2c/busses/i2c-taos-evm.c	2009-07-14 10:27:48.000000000 +0200
@@ -32,10 +32,12 @@
 
 #define TAOS_STATE_INIT		0
 #define TAOS_STATE_IDLE		1
-#define TAOS_STATE_SEND		2
+#define TAOS_STATE_EOFF		2
 #define TAOS_STATE_RECV		3
 
 #define TAOS_CMD_RESET		0x12
+#define TAOS_CMD_ECHO_ON	'+'
+#define TAOS_CMD_ECHO_OFF	'-'
 
 static DECLARE_WAIT_QUEUE_HEAD(wq);
 
@@ -102,17 +104,9 @@ static int taos_smbus_xfer(struct i2c_ad
 
 	/* Send the transaction to the TAOS EVM */
 	dev_dbg(&adapter->dev, "Command buffer: %s\n", taos->buffer);
-	taos->pos = 0;
-	taos->state = TAOS_STATE_SEND;
-	serio_write(serio, taos->buffer[0]);
-	wait_event_interruptible_timeout(wq, taos->state == TAOS_STATE_IDLE,
-					 msecs_to_jiffies(250));
-	if (taos->state != TAOS_STATE_IDLE) {
-		dev_err(&adapter->dev, "Transaction failed "
-			"(state=%d, pos=%d)\n", taos->state, taos->pos);
-		taos->addr = 0;
-		return -EIO;
-	}
+	for (p = taos->buffer; *p; p++)
+		serio_write(serio, *p);
+
 	taos->addr = addr;
 
 	/* Start the transaction and read the answer */
@@ -122,7 +116,7 @@ static int taos_smbus_xfer(struct i2c_ad
 	wait_event_interruptible_timeout(wq, taos->state == TAOS_STATE_IDLE,
 					 msecs_to_jiffies(150));
 	if (taos->state != TAOS_STATE_IDLE
-	 || taos->pos != 6) {
+	 || taos->pos != 5) {
 		dev_err(&adapter->dev, "Transaction timeout (pos=%d)\n",
 			taos->pos);
 		return -EIO;
@@ -130,7 +124,7 @@ static int taos_smbus_xfer(struct i2c_ad
 	dev_dbg(&adapter->dev, "Answer buffer: %s\n", taos->buffer);
 
 	/* Interpret the returned string */
-	p = taos->buffer + 2;
+	p = taos->buffer + 1;
 	p[3] = '\0';
 	if (!strcmp(p, "NAK"))
 		return -ENODEV;
@@ -173,13 +167,9 @@ static irqreturn_t taos_interrupt(struct
 			wake_up_interruptible(&wq);
 		}
 		break;
-	case TAOS_STATE_SEND:
-		if (taos->buffer[++taos->pos])
-			serio_write(serio, taos->buffer[taos->pos]);
-		else {
-			taos->state = TAOS_STATE_IDLE;
-			wake_up_interruptible(&wq);
-		}
+	case TAOS_STATE_EOFF:
+		taos->state = TAOS_STATE_IDLE;
+		wake_up_interruptible(&wq);
 		break;
 	case TAOS_STATE_RECV:
 		taos->buffer[taos->pos++] = data;
@@ -257,6 +247,19 @@ static int taos_connect(struct serio *se
 	}
 	strlcpy(adapter->name, name, sizeof(adapter->name));
 
+	/* Turn echo off for better performance */
+	taos->state = TAOS_STATE_EOFF;
+	serio_write(serio, TAOS_CMD_ECHO_OFF);
+
+	wait_event_interruptible_timeout(wq, taos->state == TAOS_STATE_IDLE,
+					 msecs_to_jiffies(250));
+	if (taos->state != TAOS_STATE_IDLE) {
+		err = -ENODEV;
+		dev_err(&adapter->dev, "Echo off failed "
+			"(state=%d)\n", taos->state);
+		goto exit_close;
+	}
+
 	err = i2c_add_adapter(adapter);
 	if (err)
 		goto exit_close;


-- 
Jean Delvare
