From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 6/7] i2c: print more info when acpi_i2c_space_handler() fails
Date: Sat,  9 Jul 2016 13:35:03 +0900
Message-ID: <1468038904-2571-7-git-send-email-wsa@the-dreams.de>
References: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37721 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931AbcGIEf4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 9 Jul 2016 00:35:56 -0400
In-Reply-To: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lan Tianyu <tianyu.lan@intel.com>

Use a warning loglevel instead of info and switch to dev_* for device
info. Also print which client was accessed.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/i2c/i2c-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 57fe66cc855163..7f376e9b007ba7 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -400,7 +400,8 @@ acpi_i2c_space_handler(u32 function, acpi_physical_address command,
 		break;
 
 	default:
-		pr_info("protocol(0x%02x) is not supported.\n", accessor_type);
+		dev_warn(&adapter->dev, "protocol 0x%02x not supported for client 0x%02x\n",
+			 accessor_type, client->addr);
 		ret = AE_BAD_PARAMETER;
 		goto err;
 	}
-- 
2.8.1
