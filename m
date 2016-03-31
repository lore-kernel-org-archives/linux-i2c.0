From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v5 10/14] i2c: octeon: Move read function before write
Date: Thu, 31 Mar 2016 12:28:23 +0200
Message-ID: <b00158f108b8ff15cc90d647e03deb52a4b41b92.1459352583.git.jglauber@cavium.com>
References: <cover.1459327368.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459327368.git.jglauber@cavium.com>
In-Reply-To: <cover.1459352583.git.jglauber@cavium.com>
References: <cover.1459352583.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Just sorting the functions to be consistent with the other
read/write variants.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 94 ++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 9621b66..95cd301 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -928,53 +928,6 @@ static int octeon_i2c_start(struct octeon_i2c *i2c, int first)
 }
 
 /**
- * octeon_i2c_write - send data to the bus via low-level controller
- * @i2c: The struct octeon_i2c
- * @target: Target address
- * @data: Pointer to the data to be sent
- * @length: Length of the data
- * @last: is last msg in combined operation?
- *
- * The address is sent over the bus, then the data.
- *
- * Returns 0 on success, otherwise a negative errno.
- */
-static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
-			    const u8 *data, int length, int first, int last)
-{
-	int i, result;
-
-	result = octeon_i2c_start(i2c, first);
-	if (result)
-		return result;
-
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, target << 1);
-	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
-
-	result = octeon_i2c_wait(i2c);
-	if (result)
-		return result;
-
-	for (i = 0; i < length; i++) {
-		result = check_arb(i2c, false);
-		if (result)
-			return result;
-
-		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, data[i]);
-		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
-
-		result = octeon_i2c_wait(i2c);
-		if (result)
-			return result;
-		result = check_arb(i2c, false);
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
@@ -1040,6 +993,53 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target, u8 *data,
 }
 
 /**
+ * octeon_i2c_write - send data to the bus via low-level controller
+ * @i2c: The struct octeon_i2c
+ * @target: Target address
+ * @data: Pointer to the data to be sent
+ * @length: Length of the data
+ * @last: is last msg in combined operation?
+ *
+ * The address is sent over the bus, then the data.
+ *
+ * Returns 0 on success, otherwise a negative errno.
+ */
+static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
+			    const u8 *data, int length, int first, int last)
+{
+	int i, result;
+
+	result = octeon_i2c_start(i2c, first);
+	if (result)
+		return result;
+
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, target << 1);
+	octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
+
+	result = octeon_i2c_wait(i2c);
+	if (result)
+		return result;
+
+	for (i = 0; i < length; i++) {
+		result = check_arb(i2c, false);
+		if (result)
+			return result;
+
+		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_DATA, data[i]);
+		octeon_i2c_write_sw(i2c, SW_TWSI_EOP_TWSI_CTL, TWSI_CTL_ENAB);
+
+		result = octeon_i2c_wait(i2c);
+		if (result)
+			return result;
+		result = check_arb(i2c, false);
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
