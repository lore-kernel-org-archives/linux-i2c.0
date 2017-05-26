From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 7/8] i2c: remove unneeded includes from core
Date: Fri, 26 May 2017 10:20:58 +0200
Message-ID: <20170526082101.4746-8-wsa@the-dreams.de>
References: <20170526082101.4746-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170526082101.4746-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

They seem like cruft to me. I couldn't find any evidence that something
included from there is actually used.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core-base.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index ac7b95e4cda75d..78135c1deaab59 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -21,7 +21,6 @@
 #define pr_fmt(fmt) "i2c-core: " fmt
 
 #include <dt-bindings/i2c/i2c.h>
-#include <linux/uaccess.h>
 #include <linux/acpi.h>
 #include <linux/clk/clk-conf.h>
 #include <linux/completion.h>
@@ -29,7 +28,6 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gpio.h>
-#include <linux/hardirq.h>
 #include <linux/i2c.h>
 #include <linux/idr.h>
 #include <linux/init.h>
-- 
2.11.0
