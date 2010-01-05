From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH] pca953x: Minor include cleanup
Date: Tue, 5 Jan 2010 14:10:42 -0600
Message-ID: <20100105201042.GA28367@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

linux/i2c/pca953x.h is a very bare include file. Fix check for multiple
includes of linux/i2c/pca953x.h, and add dependent includes into the
header file.

Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>

diff --git a/include/linux/i2c/pca953x.h b/include/linux/i2c/pca953x.h
index 81736d6..29699f8 100644
--- a/include/linux/i2c/pca953x.h
+++ b/include/linux/i2c/pca953x.h
@@ -1,3 +1,9 @@
+#ifndef _LINUX_PCA953X_H
+#define _LINUX_PCA953X_H
+
+#include <linux/types.h>
+#include <linux/i2c.h>
+
 /* platform data for the PCA9539 16-bit I/O expander driver */
 
 struct pca953x_platform_data {
@@ -17,3 +23,5 @@ struct pca953x_platform_data {
 				void *context);
 	char		**names;
 };
+
+#endif /* _LINUX_PCA953X_H */
