From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c-tools: fix feature test macros for glibc >= 2.20
Date: Wed,  3 Aug 2016 10:43:56 +0200
Message-ID: <1470213836-2848-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37387 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756294AbcHCIom (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 3 Aug 2016 04:44:42 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>

Since glibc 2.20, the usage of _BSD_SOURCE is deprecated. Fix it like
described here:

https://sourceware.org/glibc/wiki/Release/2.20#Deprecation_of__BSD_SOURCE_and__SVID_SOURCE_feature_macros

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 tools/i2cbusses.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/i2cbusses.c b/tools/i2cbusses.c
index b3093aa..28e3682 100644
--- a/tools/i2cbusses.c
+++ b/tools/i2cbusses.c
@@ -23,7 +23,8 @@
 */
 
 /* For strdup and snprintf */
-#define _BSD_SOURCE 1
+#define _BSD_SOURCE 1 /* for glibc < 2.19 */
+#define _DEFAULT_SOURCE 1 /* for glibc >= 2.20 */
 
 #include <sys/types.h>
 #include <sys/stat.h>
-- 
2.8.1
