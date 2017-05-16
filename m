From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/2] i2c: stub: move module_init/exit annotations to the proper place
Date: Tue, 16 May 2017 13:21:04 +0200
Message-ID: <20170516112105.2793-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-stub.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
index 06af583d510150..0aa4d646f8fb26 100644
--- a/drivers/i2c/i2c-stub.c
+++ b/drivers/i2c/i2c-stub.c
@@ -406,16 +406,15 @@ static int __init i2c_stub_init(void)
 	i2c_stub_free();
 	return ret;
 }
+module_init(i2c_stub_init);
 
 static void __exit i2c_stub_exit(void)
 {
 	i2c_del_adapter(&stub_adapter);
 	i2c_stub_free();
 }
+module_exit(i2c_stub_exit);
 
 MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>");
 MODULE_DESCRIPTION("I2C stub driver");
 MODULE_LICENSE("GPL");
-
-module_init(i2c_stub_init);
-module_exit(i2c_stub_exit);
-- 
2.11.0
