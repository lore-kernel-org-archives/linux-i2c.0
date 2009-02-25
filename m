From: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: timeouts off by 1
Date: Wed, 25 Feb 2009 12:00:52 +0100
Message-ID: <49A524E4.5050108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

with while (timeout++ < MAX_TIMEOUT); timeout reaches MAX_TIMEOUT + 1 after the
loop, so the tests below are off by one.

Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-ali1535.c |    2 +-
 drivers/i2c/busses/i2c-ali15x3.c |    2 +-
 drivers/i2c/busses/i2c-amd756.c  |    4 ++--
 drivers/i2c/busses/i2c-i801.c    |    8 ++++----
 drivers/i2c/busses/i2c-isch.c    |    2 +-
 drivers/i2c/busses/i2c-nforce2.c |    2 +-
 drivers/i2c/busses/i2c-pxa.c     |    4 ++--
 drivers/i2c/busses/i2c-sis5595.c |    2 +-
 drivers/i2c/busses/i2c-sis630.c  |    2 +-
 drivers/i2c/busses/i2c-sis96x.c  |    2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
index 981e080..d108450 100644
--- a/drivers/i2c/busses/i2c-ali1535.c
+++ b/drivers/i2c/busses/i2c-ali1535.c
@@ -284,7 +284,7 @@ static int ali1535_transaction(struct i2c_adapter *adap)
 		 && (timeout++ < MAX_TIMEOUT));
 
 	/* If the SMBus is still busy, we give up */
-	if (timeout >= MAX_TIMEOUT) {
+	if (timeout > MAX_TIMEOUT) {
 		result = -ETIMEDOUT;
 		dev_err(&adap->dev, "SMBus Timeout!\n");
 	}
diff --git a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
index 39066de..d627fce 100644
--- a/drivers/i2c/busses/i2c-ali15x3.c
+++ b/drivers/i2c/busses/i2c-ali15x3.c
@@ -306,7 +306,7 @@ static int ali15x3_transaction(struct i2c_adapter *adap)
 		 && (timeout++ < MAX_TIMEOUT));
 
 	/* If the SMBus is still busy, we give up */
-	if (timeout >= MAX_TIMEOUT) {
+	if (timeout > MAX_TIMEOUT) {
 		result = -ETIMEDOUT;
 		dev_err(&adap->dev, "SMBus Timeout!\n");
 	}
diff --git a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
index 220f4a1..f7d6fe9 100644
--- a/drivers/i2c/busses/i2c-amd756.c
+++ b/drivers/i2c/busses/i2c-amd756.c
@@ -126,7 +126,7 @@ static int amd756_transaction(struct i2c_adapter *adap)
 		} while ((temp & (GS_HST_STS | GS_SMB_STS)) &&
 		         (timeout++ < MAX_TIMEOUT));
 		/* If the SMBus is still busy, we give up */
-		if (timeout >= MAX_TIMEOUT) {
+		if (timeout > MAX_TIMEOUT) {
 			dev_dbg(&adap->dev, "Busy wait timeout (%04x)\n", temp);
 			goto abort;
 		}
@@ -143,7 +143,7 @@ static int amd756_transaction(struct i2c_adapter *adap)
 	} while ((temp & GS_HST_STS) && (timeout++ < MAX_TIMEOUT));
 
 	/* If the SMBus is still busy, we give up */
-	if (timeout >= MAX_TIMEOUT) {
+	if (timeout > MAX_TIMEOUT) {
 		dev_dbg(&adap->dev, "Completion timeout!\n");
 		goto abort;
 	}
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 230238d..79cacd3 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -236,7 +236,7 @@ static int i801_transaction(int xact)
 		status = inb_p(SMBHSTSTS);
 	} while ((status & SMBHSTSTS_HOST_BUSY) && (timeout++ < MAX_TIMEOUT));
 
-	result = i801_check_post(status, timeout >= MAX_TIMEOUT);
+	result = i801_check_post(status, timeout > MAX_TIMEOUT);
 	if (result < 0)
 		return result;
 
@@ -256,9 +256,9 @@ static void i801_wait_hwpec(void)
 	} while ((!(status & SMBHSTSTS_INTR))
 		 && (timeout++ < MAX_TIMEOUT));
 
-	if (timeout >= MAX_TIMEOUT) {
+	if (timeout > MAX_TIMEOUT)
 		dev_dbg(&I801_dev->dev, "PEC Timeout!\n");
-	}
+
 	outb_p(status, SMBHSTSTS);
 }
 
@@ -343,7 +343,7 @@ static int i801_block_transaction_byte_by_byte(union i2c_smbus_data *data,
 		while ((!(status & SMBHSTSTS_BYTE_DONE))
 		       && (timeout++ < MAX_TIMEOUT));
 
-		result = i801_check_post(status, timeout >= MAX_TIMEOUT);
+		result = i801_check_post(status, timeout > MAX_TIMEOUT);
 		if (result < 0)
 			return result;
 
diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index b9c01aa..9f6b8e0 100644
--- a/drivers/i2c/busses/i2c-isch.c
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -112,7 +112,7 @@ static int sch_transaction(void)
 	} while ((temp & 0x08) && (timeout++ < MAX_TIMEOUT));
 
 	/* If the SMBus is still busy, we give up */
-	if (timeout >= MAX_TIMEOUT) {
+	if (timeout > MAX_TIMEOUT) {
 		dev_err(&sch_adapter.dev, "SMBus Timeout!\n");
 		result = -ETIMEDOUT;
 	}
diff --git a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
index 05af6cd..d3da45c 100644
--- a/drivers/i2c/busses/i2c-nforce2.c
+++ b/drivers/i2c/busses/i2c-nforce2.c
@@ -169,7 +169,7 @@ static int nforce2_check_status(struct i2c_adapter *adap)
 		temp = inb_p(NVIDIA_SMB_STS);
 	} while ((!temp) && (timeout++ < MAX_TIMEOUT));
 
-	if (timeout >= MAX_TIMEOUT) {
+	if (timeout > MAX_TIMEOUT) {
 		dev_dbg(&adap->dev, "SMBus Timeout!\n");
 		if (smbus->can_abort)
 			nforce2_abort(adap);
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index bdb1f75..8a95642 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -264,10 +264,10 @@ static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
 		show_state(i2c);
 	}
 
-	if (timeout <= 0)
+	if (timeout < 0)
 		show_state(i2c);
 
-	return timeout <= 0 ? I2C_RETRY : 0;
+	return timeout < 0 ? I2C_RETRY : 0;
 }
 
 static int i2c_pxa_wait_master(struct pxa_i2c *i2c)
diff --git a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
index f320ab2..139f0c7 100644
--- a/drivers/i2c/busses/i2c-sis5595.c
+++ b/drivers/i2c/busses/i2c-sis5595.c
@@ -256,7 +256,7 @@ static int sis5595_transaction(struct i2c_adapter *adap)
 	} while (!(temp & 0x40) && (timeout++ < MAX_TIMEOUT));
 
 	/* If the SMBus is still busy, we give up */
-	if (timeout >= MAX_TIMEOUT) {
+	if (timeout > MAX_TIMEOUT) {
 		dev_dbg(&adap->dev, "SMBus Timeout!\n");
 		result = -ETIMEDOUT;
 	}
diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
index 50c3610..70ca41e 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -173,7 +173,7 @@ static int sis630_transaction_wait(struct i2c_adapter *adap, int size)
 	} while (!(temp & 0x0e) && (timeout++ < MAX_TIMEOUT));
 
 	/* If the SMBus is still busy, we give up */
-	if (timeout >= MAX_TIMEOUT) {
+	if (timeout > MAX_TIMEOUT) {
 		dev_dbg(&adap->dev, "SMBus Timeout!\n");
 		result = -ETIMEDOUT;
 	}
diff --git a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
index 7e1594b..8295885 100644
--- a/drivers/i2c/busses/i2c-sis96x.c
+++ b/drivers/i2c/busses/i2c-sis96x.c
@@ -132,7 +132,7 @@ static int sis96x_transaction(int size)
 	} while (!(temp & 0x0e) && (timeout++ < MAX_TIMEOUT));
 
 	/* If the SMBus is still busy, we give up */
-	if (timeout >= MAX_TIMEOUT) {
+	if (timeout > MAX_TIMEOUT) {
 		dev_dbg(&sis96x_adapter.dev, "SMBus Timeout! (0x%02x)\n", temp);
 		result = -ETIMEDOUT;
 	}
