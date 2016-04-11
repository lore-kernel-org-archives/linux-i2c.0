From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v6 06/19] i2c: octeon: Improve error status checking
Date: Mon, 11 Apr 2016 17:28:37 +0200
Message-ID: <dded382de33f6a4b64c87d8ca2e016871403784d.1460387640.git.jglauber@cavium.com>
References: <cover.1460387640.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1460387640.git.jglauber@cavium.com>
In-Reply-To: <cover.1460387640.git.jglauber@cavium.com>
References: <cover.1460387640.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Introduce a function that checks for valid status codes depending
on the phase of a transmit or receive. Also add all existing status
codes and improve error handling for various states.

The Octeon TWSI has "assert acknowledge" bit (TWSI_CTL_AAK) that is
required to be set in master receive mode until the last byte is
requested. The state check needs to consider if this bit was set.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 125 +++++++++++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 4275007..483c8a3 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -55,13 +55,35 @@
 #define TWSI_CTL_IFLG		0x08	/* HW event, SW writes 0 to ACK */
 #define TWSI_CTL_AAK		0x04	/* Assert ACK */
 
-/* Some status values */
+/* Status values */
+#define STAT_ERROR		0x00
 #define STAT_START		0x08
-#define STAT_RSTART		0x10
+#define STAT_REP_START		0x10
 #define STAT_TXADDR_ACK		0x18
+#define STAT_TXADDR_NAK		0x20
 #define STAT_TXDATA_ACK		0x28
+#define STAT_TXDATA_NAK		0x30
+#define STAT_LOST_ARB_38	0x38
 #define STAT_RXADDR_ACK		0x40
+#define STAT_RXADDR_NAK		0x48
 #define STAT_RXDATA_ACK		0x50
+#define STAT_RXDATA_NAK		0x58
+#define STAT_SLAVE_60		0x60
+#define STAT_LOST_ARB_68	0x68
+#define STAT_SLAVE_70		0x70
+#define STAT_LOST_ARB_78	0x78
+#define STAT_SLAVE_80		0x80
+#define STAT_SLAVE_88		0x88
+#define STAT_GENDATA_ACK	0x90
+#define STAT_GENDATA_NAK	0x98
+#define STAT_SLAVE_A0		0xA0
+#define STAT_SLAVE_A8		0xA8
+#define STAT_LOST_ARB_B0	0xB0
+#define STAT_SLAVE_LOST		0xB8
+#define STAT_SLAVE_NAK		0xC0
+#define STAT_SLAVE_ACK		0xC8
+#define STAT_AD2W_ACK		0xD0
+#define STAT_AD2W_NAK		0xD8
 #define STAT_IDLE		0xF8
 
 /* TWSI_INT values */
@@ -225,6 +247,65 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 	return 0;
 }
 
+static int octeon_i2c_check_status(struct octeon_i2c *i2c, int final_read)
+{
+	u8 stat = octeon_i2c_stat_read(i2c);
+
+	switch (stat) {
+	/* Everything is fine */
+	case STAT_AD2W_ACK:
+	case STAT_RXADDR_ACK:
+	case STAT_TXADDR_ACK:
+	case STAT_TXDATA_ACK:
+		return 0;
+
+	/* ACK allowed on pre-terminal bytes only */
+	case STAT_RXDATA_ACK:
+		if (!final_read)
+			return 0;
+		return -EAGAIN;
+
+	/* NAK allowed on terminal byte only */
+	case STAT_RXDATA_NAK:
+		if (final_read)
+			return 0;
+		return -EAGAIN;
+
+	/* Arbitration lost */
+	case STAT_LOST_ARB_38:
+	case STAT_LOST_ARB_68:
+	case STAT_LOST_ARB_78:
+	case STAT_LOST_ARB_B0:
+		return -EAGAIN;
+
+	/* Being addressed as slave, should back off & listen */
+	case STAT_SLAVE_60:
+	case STAT_SLAVE_70:
+	case STAT_GENDATA_ACK:
+	case STAT_GENDATA_NAK:
+		return -EIO;
+
+	/* Core busy as slave */
+	case STAT_SLAVE_80:
+	case STAT_SLAVE_88:
+	case STAT_SLAVE_A0:
+	case STAT_SLAVE_A8:
+	case STAT_SLAVE_LOST:
+	case STAT_SLAVE_NAK:
+	case STAT_SLAVE_ACK:
+		return -EIO;
+
+	case STAT_TXDATA_NAK:
+	case STAT_TXADDR_NAK:
+	case STAT_RXADDR_NAK:
+	case STAT_AD2W_NAK:
+		return -EAGAIN;
+	default:
+		dev_err(i2c->dev, "unhandled state: %d\n", stat);
+		return -EIO;
+	}
+}
+
 /* calculate and set clock divisors */
 static void octeon_i2c_set_clock(struct octeon_i2c *i2c)
 {
@@ -347,7 +428,6 @@ static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
 			    const u8 *data, int length)
 {
 	int i, result;
-	u8 tmp;
 
 	result = octeon_i2c_start(i2c);
 	if (result)
@@ -361,14 +441,9 @@ static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
 		return result;
 
 	for (i = 0; i < length; i++) {
-		tmp = octeon_i2c_stat_read(i2c);
-
-		if ((tmp != STAT_TXADDR_ACK) && (tmp != STAT_TXDATA_ACK)) {
-			dev_err(i2c->dev,
-				"%s: bad status before write (0x%x)\n",
-				__func__, tmp);
-			return -EIO;
-		}
+		result = octeon_i2c_check_status(i2c, false);
+		if (result)
+			return result;
 
 		octeon_i2c_data_write(i2c, data[i]);
 		octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
@@ -397,7 +472,7 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 			   u8 *data, u16 *rlength, bool recv_len)
 {
 	int i, result, length = *rlength;
-	u8 tmp;
+	bool final_read = false;
 
 	if (length < 1)
 		return -EINVAL;
@@ -413,19 +488,21 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 	if (result)
 		return result;
 
+	/* address OK ? */
+	result = octeon_i2c_check_status(i2c, false);
+	if (result)
+		return result;
+
 	for (i = 0; i < length; i++) {
-		tmp = octeon_i2c_stat_read(i2c);
-		if ((tmp != STAT_RXDATA_ACK) && (tmp != STAT_RXADDR_ACK)) {
-			dev_err(i2c->dev,
-				"%s: bad status before read (0x%x)\n",
-				__func__, tmp);
-			return -EIO;
-		}
+		/* for the last byte TWSI_CTL_AAK must not be set */
+		if (i + 1 == length)
+			final_read = true;
 
-		if (i + 1 < length)
-			octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB | TWSI_CTL_AAK);
-		else
+		/* clear iflg to allow next event */
+		if (final_read)
 			octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
+		else
+			octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB | TWSI_CTL_AAK);
 
 		result = octeon_i2c_wait(i2c);
 		if (result)
@@ -441,6 +518,10 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 			}
 			length += data[i];
 		}
+
+		result = octeon_i2c_check_status(i2c, final_read);
+		if (result)
+			return result;
 	}
 	*rlength = length;
 	return 0;
-- 
1.9.1
