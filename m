From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v6 14/19] i2c: octeon: Move read function before write
Date: Mon, 11 Apr 2016 17:28:45 +0200
Message-ID: <b3843453af1c673a8f5f931fea076005638905d3.1460387640.git.jglauber@cavium.com>
References: <cover.1460387640.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1460387640.git.jglauber@cavium.com>
In-Reply-To: <cover.1460387640.git.jglauber@cavium.com>
References: <cover.1460387640.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Just sorting the functions to be consistent with the other
read/write variants.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 78 ++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index bfaee37..6d568f8 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -871,45 +871,6 @@ static void octeon_i2c_stop(struct octeon_i2c *i2c)
 }
 
 /**
- * octeon_i2c_write - send data to the bus via low-level controller
- * @i2c: The struct octeon_i2c
- * @target: Target address
- * @data: Pointer to the data to be sent
- * @length: Length of the data
- *
- * The address is sent over the bus, then the data.
- *
- * Returns 0 on success, otherwise a negative errno.
- */
-static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
-			    const u8 *data, int length)
-{
-	int i, result;
-
-	octeon_i2c_data_write(i2c, target << 1);
-	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
-
-	result = octeon_i2c_wait(i2c);
-	if (result)
-		return result;
-
-	for (i = 0; i < length; i++) {
-		result = octeon_i2c_check_status(i2c, false);
-		if (result)
-			return result;
-
-		octeon_i2c_data_write(i2c, data[i]);
-		octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
-
-		result = octeon_i2c_wait(i2c);
-		if (result)
-			return result;
-	}
-
-	return 0;
-}
-
-/**
  * octeon_i2c_read - receive data from the bus via low-level controller
  * @i2c: The struct octeon_i2c
  * @target: Target address
@@ -974,6 +935,45 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 }
 
 /**
+ * octeon_i2c_write - send data to the bus via low-level controller
+ * @i2c: The struct octeon_i2c
+ * @target: Target address
+ * @data: Pointer to the data to be sent
+ * @length: Length of the data
+ *
+ * The address is sent over the bus, then the data.
+ *
+ * Returns 0 on success, otherwise a negative errno.
+ */
+static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
+			    const u8 *data, int length)
+{
+	int i, result;
+
+	octeon_i2c_data_write(i2c, target << 1);
+	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
+
+	result = octeon_i2c_wait(i2c);
+	if (result)
+		return result;
+
+	for (i = 0; i < length; i++) {
+		result = octeon_i2c_check_status(i2c, false);
+		if (result)
+			return result;
+
+		octeon_i2c_data_write(i2c, data[i]);
+		octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
+
+		result = octeon_i2c_wait(i2c);
+		if (result)
+			return result;
+	}
+
+	return 0;
+}
+
+/**
  * octeon_i2c_xfer - The driver's master_xfer function
  * @adap: Pointer to the i2c_adapter structure
  * @msgs: Pointer to the messages to be processed
-- 
1.9.1
