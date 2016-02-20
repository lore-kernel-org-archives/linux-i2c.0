From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4/6] i2c: i2c-mux: sort includes
Date: Sat, 20 Feb 2016 23:38:49 +0100
Message-ID: <1456007931-4595-5-git-send-email-wsa@the-dreams.de>
References: <1456007931-4595-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55908 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992827AbcBTWjE (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 20 Feb 2016 17:39:04 -0500
In-Reply-To: <1456007931-4595-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

I request this for drivers, so the core should adhere to sorted includes as
well.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-mux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 00fc5b1c7b66bb..d4022878b2f0b6 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -19,13 +19,13 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
-#include <linux/acpi.h>
+#include <linux/slab.h>
 
 /* multiplexer per channel data */
 struct i2c_mux_priv {
-- 
2.7.0
