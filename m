From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 6/6] i2c: i2c-stub: sort includes
Date: Sat, 20 Feb 2016 23:38:51 +0100
Message-ID: <1456007931-4595-7-git-send-email-wsa@the-dreams.de>
References: <1456007931-4595-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55911 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992834AbcBTWjF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 20 Feb 2016 17:39:05 -0500
In-Reply-To: <1456007931-4595-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

I request this for drivers, so the core should adhere to sorted includes as
well.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-stub.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
index af2a94e1140ba0..06af583d510150 100644
--- a/drivers/i2c/i2c-stub.c
+++ b/drivers/i2c/i2c-stub.c
@@ -17,13 +17,13 @@
 
 #define DEBUG 1
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/module.h>
+#include <linux/slab.h>
 
 #define MAX_CHIPS 10
 
-- 
2.7.0
