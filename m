From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] Drivers: i2c: busses: Use max macro instead of ternary operator
Date: Sun, 11 Sep 2016 00:38:10 +0530
Message-ID: <1473534490-16592-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Replace ternary operators with macro 'max' as it is shorter
and thus increases code readability. Macro max returns
the  maximum of the two compared values.
Done using coccinelle:

@@
type T;
T x;
T y;
@@
(
- x < y ? x : y
+ min(x,y)
|
- x > y ? x : y
+ max(x,y)
)

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/i2c/busses/i2c-jz4780.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-jz4780.c b/drivers/i2c/busses/i2c-jz4780.c
index cd98725..b6c6f90 100644
--- a/drivers/i2c/busses/i2c-jz4780.c
+++ b/drivers/i2c/busses/i2c-jz4780.c
@@ -133,10 +133,10 @@ static const char * const jz4780_i2c_abrt_src[] = {
 
 #define JZ4780_I2C_ENB_I2C		BIT(0)
 
-#define JZ4780_I2CSHCNT_ADJUST(n)	(((n) - 8) < 6 ? 6 : ((n) - 8))
-#define JZ4780_I2CSLCNT_ADJUST(n)	(((n) - 1) < 8 ? 8 : ((n) - 1))
-#define JZ4780_I2CFHCNT_ADJUST(n)	(((n) - 8) < 6 ? 6 : ((n) - 8))
-#define JZ4780_I2CFLCNT_ADJUST(n)	(((n) - 1) < 8 ? 8 : ((n) - 1))
+#define JZ4780_I2CSHCNT_ADJUST(n)	(max(6, (n) - 8))
+#define JZ4780_I2CSLCNT_ADJUST(n)	(max(8, (n) - 1))
+#define JZ4780_I2CFHCNT_ADJUST(n)	(max(6, (n) - 8))
+#define JZ4780_I2CFLCNT_ADJUST(n)	(max(8, (n) - 1))
 
 #define JZ4780_I2C_FIFO_LEN	16
 #define TX_LEVEL		3
-- 
1.9.1
