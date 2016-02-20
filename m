From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/6] i2c: i2c-boardinfo: sort includes
Date: Sat, 20 Feb 2016 23:38:46 +0100
Message-ID: <1456007931-4595-2-git-send-email-wsa@the-dreams.de>
References: <1456007931-4595-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55900 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992809AbcBTWjC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 20 Feb 2016 17:39:02 -0500
In-Reply-To: <1456007931-4595-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

I request this for drivers, so the core should adhere to sorted includes as
well.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-boardinfo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-boardinfo.c b/drivers/i2c/i2c-boardinfo.c
index 90e32295930332..e33022e2d459f1 100644
--- a/drivers/i2c/i2c-boardinfo.c
+++ b/drivers/i2c/i2c-boardinfo.c
@@ -12,11 +12,11 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/kernel.h>
-#include <linux/i2c.h>
-#include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
 #include <linux/rwsem.h>
+#include <linux/slab.h>
 
 #include "i2c-core.h"
 
-- 
2.7.0
