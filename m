From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH v3 1/1] i2c: taos-evm: replace simple_strtoul by kstrtou8
Date: Wed, 18 Nov 2015 13:55:56 +0100
Message-ID: <1447851356-6248-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1447851356-6248-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34105 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714AbbKRM4b (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 18 Nov 2015 07:56:31 -0500
In-Reply-To: <1447851356-6248-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jdelvare@suse.com, wsa@the-dreams.de
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

The simple_strtoul function is marked as obsolete.
This patch replace it by kstrtou8.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/i2c/busses/i2c-taos-evm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-taos-evm.c b/drivers/i2c/busses/i2c-taos-evm.c
index 4c7fc2d..f673f5d 100644
--- a/drivers/i2c/busses/i2c-taos-evm.c
+++ b/drivers/i2c/busses/i2c-taos-evm.c
@@ -130,7 +130,13 @@ static int taos_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 			return 0;
 	} else {
 		if (p[0] == 'x') {
-			data->byte = simple_strtol(p + 1, NULL, 16);
+			/*
+			 * voluntarily dropping error code of kstrtou8 since all
+			 * error code that it could return are invalid according
+			 * to Documentation/i2c/fault-codes
+			 */
+			if (kstrtou8(p + 1, 16, &data->byte))
+				return -EPROTO;
 			return 0;
 		}
 	}
-- 
2.4.10
