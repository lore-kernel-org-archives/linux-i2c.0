From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2] i2c-tools: fix feature test macros for glibc >= 2.20
Date: Tue,  9 Aug 2016 22:53:01 +0200
Message-ID: <1470775982-16231-1-git-send-email-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60139 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449AbcHIUxM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 9 Aug 2016 16:53:12 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Since glibc 2.20, the usage of _BSD_SOURCE is deprecated. Fix it like
described here:

https://sourceware.org/glibc/wiki/Release/2.20#Deprecation_of__BSD_SOURCE_and__SVID_SOURCE_feature_macros

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 tools/i2cbusses.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/i2cbusses.c b/tools/i2cbusses.c
index b3093aa..dad22ea 100644
--- a/tools/i2cbusses.c
+++ b/tools/i2cbusses.c
@@ -23,7 +23,8 @@
 */
 
 /* For strdup and snprintf */
-#define _BSD_SOURCE 1
+#define _BSD_SOURCE 1 /* for glibc <= 2.19 */
+#define _DEFAULT_SOURCE 1 /* for glibc >= 2.19 */
 
 #include <sys/types.h>
 #include <sys/stat.h>
-- 
2.8.1
