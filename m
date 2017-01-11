From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2] i2c: piix4: Avoid race conditions with IMC
Date: Wed, 11 Jan 2017 10:11:44 +0100
Message-ID: <20170111091144.6881-1-ricardo.ribalda@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36682 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbdAKJLu (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 11 Jan 2017 04:11:50 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

v2: Suggestions by Andy Shevchenko <andy.shevchenko@gmail.com>:
 -Rename timeout to retries
 -Use do {} while(--retries) pattern
 -Group new variables


 drivers/i2c/busses/i2c-piix4.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index f0563f7ce01b..81d06be0a72d 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -585,10 +585,29 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 		 u8 command, int size, union i2c_smbus_data *data)
 {
 	struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
+	unsigned short piix4_smba = adapdata->smba;
+	int retries = MAX_TIMEOUT;
+	int smbslvcnt;
 	u8 smba_en_lo;
 	u8 port;
 	int retval;
 
+	/* Request the SMBUS semaphore, avoid conflicts with the IMC */
+	smbslvcnt  = inb_p(SMBSLVCNT);
+	do {
+		outb_p(smbslvcnt | 0x10, SMBSLVCNT);
+
+		/* Check the semaphore status */
+		smbslvcnt  = inb_p(SMBSLVCNT);
+		if (smbslvcnt & 0x10)
+			break;
+
+		usleep_range(1000, 2000);
+	} while (--retries);
+	/* SMBus is still owned by the IMC, we give up */
+	if (!retries)
+		return -EBUSY;
+
 	mutex_lock(&piix4_mutex_sb800);
 
 	outb_p(piix4_port_sel_sb800, SB800_PIIX4_SMB_IDX);
@@ -606,6 +625,9 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 
 	mutex_unlock(&piix4_mutex_sb800);
 
+	/* Release the semaphore */
+	outb_p(smbslvcnt | 0x20, SMBSLVCNT);
+
 	return retval;
 }
 
-- 
2.11.0
