From: "George G. Davis" <ggdavisiv@gmail.com>
Subject: [PATCH] i2c: core: squelch error: uninitialized symbol 'ret'
Date: Fri,  5 Oct 2018 12:18:25 -0400
Message-ID: <20181005161826.2455-1-george_davis@mentor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: "George G. Davis" <george_davis@mentor.com>
List-Id: linux-i2c@vger.kernel.org

The following smatch error was introduced by commit 7ca5f6be7900 ("i2c:
recovery: add get_bus_free callback"):

drivers/i2c/i2c-core-base.c:228 i2c_generic_scl_recovery() error: uninitialized symbol 'ret'.

Analysis of the code appears to show that the smatch error is a false
positive since 'ret' will in fact be initialized after exiting the
'while()' loop.

Squelch the smatch error since it is a false positive.

Fixes: 7ca5f6be7900 ("i2c: recovery: add get_bus_free callback")
Signed-off-by: George G. Davis <george_davis@mentor.com>
---
 drivers/i2c/i2c-core-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9ee9a15e7134..7b25ecb6b616 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -185,7 +185,7 @@ static int i2c_generic_bus_free(struct i2c_adapter *adap)
 int i2c_generic_scl_recovery(struct i2c_adapter *adap)
 {
 	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
-	int i = 0, scl = 1, ret;
+	int i = 0, scl = 1, uninitialized_var(ret);
 
 	if (bri->prepare_recovery)
 		bri->prepare_recovery(adap);
-- 
2.14.4
