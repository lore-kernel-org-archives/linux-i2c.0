From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH] i2c: taos-evm: replace simple_strtoul by kstrtou8
Date: Thu,  5 Nov 2015 10:32:48 +0100
Message-ID: <1446715969-11727-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36976 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbbKEJdD (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 5 Nov 2015 04:33:03 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.com, wsa@the-dreams.de
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

The simple_strtoul function is marked as obsolete.
This patch replace it by kstrtou8.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/i2c/busses/i2c-taos-evm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses/i2c-taos-evm.c
index 4c7fc2d..9dc6cff 100644
--- a/drivers/i2c/busses/i2c-taos-evm.c
+++ b/drivers/i2c/busses/i2c-taos-evm.c
@@ -70,6 +70,7 @@ static int taos_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 	struct serio *serio = adapter->algo_data;
 	struct taos_data *taos = serio_get_drvdata(serio);
 	char *p;
+	int err;
 
 	/* Encode our transaction. "@" is for the device address, "$" for the
 	   SMBus command and "#" for the data. */
@@ -130,7 +131,9 @@ static int taos_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 			return 0;
 	} else {
 		if (p[0] == 'x') {
-			data->byte = simple_strtol(p + 1, NULL, 16);
+			err = kstrtou8(p + 1, 16, &data->byte);
+			if (err)
+				return err;
 			return 0;
 		}
 	}
-- 
2.4.10
