From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] i2c-core: One function call less in acpi_i2c_space_handler()
 after error detection
Date: Sat, 26 Dec 2015 07:34:57 +0100
Message-ID: <567E3511.6010606@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-i2c@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 26 Dec 2015 07:30:35 +0100

The kfree() function was called in one case by the
acpi_i2c_space_handler() function during error handling
even if the passed variable "client" contained a null pointer.

Implementation details could be improved by the adjustment of jump targets.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/i2c-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 7349b00..a24e06c 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -313,18 +313,18 @@ acpi_i2c_space_handler(u32 function, acpi_physical_address command,
 	client = kzalloc(sizeof(*client), GFP_KERNEL);
 	if (!client) {
 		ret = AE_NO_MEMORY;
-		goto err;
+		goto free_ares;
 	}
 
 	if (!value64 || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS) {
 		ret = AE_BAD_PARAMETER;
-		goto err;
+		goto free_client;
 	}
 
 	sb = &ares->data.i2c_serial_bus;
 	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C) {
 		ret = AE_BAD_PARAMETER;
-		goto err;
+		goto free_client;
 	}
 
 	client->adapter = adapter;
@@ -405,9 +405,9 @@ acpi_i2c_space_handler(u32 function, acpi_physical_address command,
 	}
 
 	gsb->status = status;
-
- err:
+free_client:
 	kfree(client);
+free_ares:
 	ACPI_FREE(ares);
 	return ret;
 }
-- 
2.6.3

