From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH] i2c: fix reference to functionality constants definition
Date: Thu, 19 Feb 2015 12:51:30 +0200
Message-ID: <4496c1554df0c37d12d109604426bd9a3ab1e974.1424343090.git.baruch@tkos.co.il>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Since commit 607ca46e97 ('UAPI: (Scripted) Disintegrate include/linux') the
list of functionality constants moved to include/uapi/linux/i2c.h. Update the
reference accordingly.

Fixes: 607ca46e97 ('UAPI: (Scripted) Disintegrate include/linux')
Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 Documentation/i2c/functionality | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/i2c/functionality b/Documentation/i2c/functionality
index 4556a3eb87c4..4aae8ed15873 100644
--- a/Documentation/i2c/functionality
+++ b/Documentation/i2c/functionality
@@ -12,7 +12,7 @@ FUNCTIONALITY CONSTANTS
 -----------------------
 
 For the most up-to-date list of functionality constants, please check
-<linux/i2c.h>!
+<uapi/linux/i2c.h>!
 
   I2C_FUNC_I2C                    Plain i2c-level commands (Pure SMBus
                                   adapters typically can not do these)
-- 
2.1.4
