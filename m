From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] at24: use timeout also for read
Date: Sun,  8 Nov 2009 21:14:57 +0100
Message-ID: <1257711297-19927-1-git-send-email-w.sang@pengutronix.de>
References: <20091106131524.76ae52b9@hyperion.delvare>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091106131524.76ae52b9-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Writes may take some time on EEPROMs, so for consecutive writes, we already
have a loop waiting for the EEPROM to become ready. Use such a loop for reads,
too, in case somebody wants to immediately read after a write. Detailed bug
report and test case can be found here:

http://article.gmane.org/gmane.linux.drivers.i2c/4660

Reported-by: Aleksandar Ivanov <ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---

I could reproduce the errornous behaviour and this patch fixes it for me.

 drivers/misc/eeprom/at24.c |   78 ++++++++++++++++++++++++++-----------------
 1 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index db39f4a..78aa46c 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -158,6 +158,7 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 	struct i2c_msg msg[2];
 	u8 msgbuf[2];
 	struct i2c_client *client;
+	unsigned long timeout, read_time;
 	int status, i;
 
 	memset(msg, 0, sizeof(msg));
@@ -183,47 +184,62 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 	if (count > io_limit)
 		count = io_limit;
 
-	/* Smaller eeproms can work given some SMBus extension calls */
 	if (at24->use_smbus) {
+		/* Smaller eeproms can work given some SMBus extension calls */
 		if (count > I2C_SMBUS_BLOCK_MAX)
 			count = I2C_SMBUS_BLOCK_MAX;
-		status = i2c_smbus_read_i2c_block_data(client, offset,
-				count, buf);
-		dev_dbg(&client->dev, "smbus read %zu@%d --> %d\n",
-				count, offset, status);
-		return (status < 0) ? -EIO : status;
+	} else {
+		/*
+		 * When we have a better choice than SMBus calls, use a
+		 * combined I2C message. Write address; then read up to
+		 * io_limit data bytes. Note that read page rollover helps us
+		 * here (unlike writes). msgbuf is u8 and will cast to our
+		 * needs.
+		 */
+		i = 0;
+		if (at24->chip.flags & AT24_FLAG_ADDR16)
+			msgbuf[i++] = offset >> 8;
+		msgbuf[i++] = offset;
+
+		msg[0].addr = client->addr;
+		msg[0].buf = msgbuf;
+		msg[0].len = i;
+
+		msg[1].addr = client->addr;
+		msg[1].flags = I2C_M_RD;
+		msg[1].buf = buf;
+		msg[1].len = count;
 	}
 
 	/*
-	 * When we have a better choice than SMBus calls, use a combined
-	 * I2C message. Write address; then read up to io_limit data bytes.
-	 * Note that read page rollover helps us here (unlike writes).
-	 * msgbuf is u8 and will cast to our needs.
+	 * Reads fail if the previous write didn't complete yet. We may
+	 * loop a few times until this one succeeds, waiting at least
+	 * long enough for one entire page write to work.
 	 */
-	i = 0;
-	if (at24->chip.flags & AT24_FLAG_ADDR16)
-		msgbuf[i++] = offset >> 8;
-	msgbuf[i++] = offset;
-
-	msg[0].addr = client->addr;
-	msg[0].buf = msgbuf;
-	msg[0].len = i;
+	timeout = jiffies + msecs_to_jiffies(write_timeout);
+	do {
+		read_time = jiffies;
+		if (at24->use_smbus) {
+			status = i2c_smbus_read_i2c_block_data(client, offset,
+					count, buf);
+			if (status == 0)
+				status = count;
+		} else {
+			status = i2c_transfer(client->adapter, msg, 2);
+			if (status == 2)
+				status = count;
+		}
+		dev_dbg(&client->dev, "read %zu@%d --> %zd (%ld)\n",
+				count, offset, status, jiffies);
 
-	msg[1].addr = client->addr;
-	msg[1].flags = I2C_M_RD;
-	msg[1].buf = buf;
-	msg[1].len = count;
+		if (status == count)
+			return count;
 
-	status = i2c_transfer(client->adapter, msg, 2);
-	dev_dbg(&client->dev, "i2c read %zu@%d --> %d\n",
-			count, offset, status);
+		/* REVISIT: at HZ=100, this is sloooow */
+		msleep(1);
+	} while (time_before(read_time, timeout));
 
-	if (status == 2)
-		return count;
-	else if (status >= 0)
-		return -EIO;
-	else
-		return status;
+	return -ETIMEDOUT;
 }
 
 static ssize_t at24_read(struct at24_data *at24,
-- 
1.6.3.3
