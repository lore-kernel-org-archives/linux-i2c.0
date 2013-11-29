From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH 1/4] i2c: pca954x: Sort headers alphabetically
Date: Fri, 29 Nov 2013 01:51:22 +0100
Message-ID: <1385686285-23780-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1385686285-23780-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385686285-23780-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This helps avoiding duplicate includes.

Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index bad5b84..ce740f1 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -35,14 +35,13 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
-
 #include <linux/i2c/pca954x.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
 
 #define PCA954X_MAX_NCHANS 8
 
-- 
1.8.3.2
