From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH] i2c: piix4: Avoid race conditions with IMC
Date: Tue, 10 Jan 2017 13:16:00 +0100
Message-ID: <20170110121600.30649-1-ricardo.ribalda@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33789 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761015AbdAJMQG (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 10 Jan 2017 07:16:06 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

On AMD's SB800 and upwards, the SMBus is shared with the Integrated
Micro Controller (IMC).

The platform provides a hardware semaphore to avoid race conditions
among them. (Check page 288 of the SB800-Series Southbridges Register
Reference Guide http://support.amd.com/TechDocs/45482.pdf)

Without this patch, many access to the SMBus end with an invalid
transaction or even with the bus stalled.

Credit-to: Alexandre Desnoyers <alex@qtec.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index f0563f7ce01b..0286cfee6d36 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -585,9 +585,28 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 		 u8 command, int size, union i2c_smbus_data *data)
 {
 	struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
+	unsigned short piix4_smba = adapdata->smba;
 	u8 smba_en_lo;
 	u8 port;
 	int retval;
+	int timeout = 0;
+	int smbslvcnt;
+
+	/* Request the SMBUS semaphore, avoid conflicts with the IMC */
+	smbslvcnt  = inb_p(SMBSLVCNT);
+	while (++timeout < MAX_TIMEOUT) {
+		outb_p(smbslvcnt | 0x10, SMBSLVCNT);
+
+		/* Check the semaphore status */
+		smbslvcnt  = inb_p(SMBSLVCNT);
+		if (smbslvcnt & 0x10)
+			break;
+
+		usleep_range(1000, 2000);
+	}
+	/* SMBus is still owned by the IMC, we give up */
+	if (timeout == MAX_TIMEOUT)
+		return -EBUSY;
 
 	mutex_lock(&piix4_mutex_sb800);
 
@@ -606,6 +625,9 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 
 	mutex_unlock(&piix4_mutex_sb800);
 
+	/* Release the semaphore */
+	outb_p(smbslvcnt | 0x20, SMBSLVCNT);
+
 	return retval;
 }
 
-- 
2.11.0
