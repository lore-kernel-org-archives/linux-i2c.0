From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/2] i2c: core: Remove needless structure member zero initialization
Date: Wed, 29 Apr 2015 15:44:36 +0300
Message-ID: <1430311477-21759-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

No need to clear one struct i2c_client member variable since memset has
already cleared all of them. Remove also one space intendation from err
label.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 987c124432c5..051aa3a811a8 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -283,7 +283,6 @@ acpi_i2c_space_handler(u32 function, acpi_physical_address command,
 	memset(&client, 0, sizeof(client));
 	client.adapter = adapter;
 	client.addr = sb->slave_address;
-	client.flags = 0;
 
 	if (sb->access_mode == ACPI_I2C_10BIT_MODE)
 		client.flags |= I2C_CLIENT_TEN;
@@ -361,7 +360,7 @@ acpi_i2c_space_handler(u32 function, acpi_physical_address command,
 
 	gsb->status = status;
 
- err:
+err:
 	ACPI_FREE(ares);
 	return ret;
 }
-- 
2.1.4
