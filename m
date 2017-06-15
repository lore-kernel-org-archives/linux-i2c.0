From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: stub: fix build warning regression
Date: Thu, 15 Jun 2017 23:26:01 +0200
Message-ID: <20170615212601.5972-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:38686 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750814AbdFOV0O (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 15 Jun 2017 17:26:14 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

Commit 6c42778780c40c ("i2c: stub: use pr_fmt") changed the DEBUG
handling and caused build warnings. Revert back to the original.

Fixes: 6c42778780c40c ("i2c: stub: use pr_fmt")
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
index 8b0900147f96f1..4a9ad91c5ba3ea 100644
--- a/drivers/i2c/i2c-stub.c
+++ b/drivers/i2c/i2c-stub.c
@@ -15,7 +15,7 @@
     GNU General Public License for more details.
 */
 
-#define DEBUG
+#define DEBUG 1
 #define pr_fmt(fmt) "i2c-stub: " fmt
 
 #include <linux/errno.h>
-- 
2.11.0
