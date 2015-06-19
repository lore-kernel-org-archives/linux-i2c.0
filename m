From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [RFC] i2c-tools: allow linker and compile flags from command line
Date: Fri, 19 Jun 2015 11:24:32 +0200
Message-ID: <1434705872-2866-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Mainly for debugging, so one can pass stuff like -O0 or -static.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 tools/Module.mk | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/Module.mk b/tools/Module.mk
index 8efddbb..641ac81 100644
--- a/tools/Module.mk
+++ b/tools/Module.mk
@@ -9,13 +9,13 @@
 
 TOOLS_DIR	:= tools
 
-TOOLS_CFLAGS	:= -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual \
+TOOLS_CFLAGS	+= -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual \
 		   -Wcast-align -Wwrite-strings -Wnested-externs -Winline \
 		   -W -Wundef -Wmissing-prototypes -Iinclude
 ifeq ($(USE_STATIC_LIB),1)
-TOOLS_LDFLAGS	:= $(LIB_DIR)/$(LIB_STLIBNAME)
+TOOLS_LDFLAGS	+= $(LIB_DIR)/$(LIB_STLIBNAME)
 else
-TOOLS_LDFLAGS	:= -Llib -li2c
+TOOLS_LDFLAGS	+= -Llib -li2c
 endif
 
 TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget
-- 
2.1.4
