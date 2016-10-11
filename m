From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH 2/5] i2c: i2c-piix4: coding style fix - assignment in if condition
Date: Tue, 11 Oct 2016 18:24:38 +0100
Message-ID: <20161011172441.7422-3-palminha@synopsys.com>
References: <20161011172441.7422-1-palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:43155 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753645AbcJKSUz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 11 Oct 2016 14:20:55 -0400
In-Reply-To: <20161011172441.7422-1-palminha@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jdelvare@suse.com, wsa@the-dreams.de, CARLOS.PALMINHA@synopsys.com

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
---
 drivers/i2c/busses/i2c-piix4.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 6b55a8e..5d6f637 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -419,11 +419,13 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
 		inb_p(SMBHSTDAT1));
 
 	/* Make sure the SMBus host is ready to start transmitting */
-	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+	temp = inb_p(SMBHSTSTS);
+	if (temp != 0x00) {
 		dev_dbg(&piix4_adapter->dev, "SMBus busy (%02x). "
 			"Resetting...\n", temp);
 		outb_p(temp, SMBHSTSTS);
-		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+		temp = inb_p(SMBHSTSTS);
+		if (temp != 0x00) {
 			dev_err(&piix4_adapter->dev, "Failed! (%02x)\n", temp);
 			return -EBUSY;
 		} else {
@@ -470,7 +472,8 @@ static int piix4_transaction(struct i2c_adapter *piix4_adapter)
 	if (inb_p(SMBHSTSTS) != 0x00)
 		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
 
-	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+	temp = inb_p(SMBHSTSTS);
+	if (temp != 0x00) {
 		dev_err(&piix4_adapter->dev, "Failed reset at end of "
 			"transaction (%02x)\n", temp);
 	}
-- 
2.9.3
