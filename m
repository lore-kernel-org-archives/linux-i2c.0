From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: acpi: remove unneeded variable initialization
Date: Tue, 18 Nov 2014 15:12:43 +0100
Message-ID: <1416319963-28946-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

No need to initialize 'ret' if it gets assigned directly after that.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index cf830915713b..3105bd273f70 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -260,7 +260,7 @@ acpi_i2c_space_handler(u32 function, acpi_physical_address command,
 	struct acpi_resource *ares;
 	u32 accessor_type = function >> 16;
 	u8 action = function & ACPI_IO_MASK;
-	acpi_status ret = AE_OK;
+	acpi_status ret;
 	int status;
 
 	ret = acpi_buffer_to_resource(info->connection, info->length, &ares);
-- 
2.1.1
