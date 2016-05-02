From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v8 6/8] i2c: octeon: Sort include files alphabetically
Date: Mon,  2 May 2016 19:35:46 +0200
Message-ID: <1462210548-4648-7-git-send-email-jglauber@cavium.com>
References: <1462210548-4648-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34380 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbcEBRgU (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 2 May 2016 13:36:20 -0400
In-Reply-To: <1462210548-4648-1-git-send-email-jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

Sort include files alphabetically to reduce probability of merge
conflicts.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 038007d..ce535fa 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -12,16 +12,16 @@
  */
 
 #include <linux/atomic.h>
-#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/io.h>
-#include <linux/of.h>
 
 #include <asm/octeon/octeon.h>
 #include "i2c-cavium.h"
-- 
1.9.1
