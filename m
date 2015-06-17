From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH v2] i2c-tools: enable static use of libi2c
Date: Wed, 17 Jun 2015 21:26:45 +0200
Message-ID: <1434569205-30635-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

When debugging embedded systems, it is often nice to simply TFTP the
desired i2ctool to the target without the hazzle of dealing with shared
libs. Using -static is overkill, too, so let's add a switch which will
only link functions from libi2c statically.

Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
---
 Makefile        | 4 ++++
 tools/Module.mk | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 252a126..3b49bd4 100644
--- a/Makefile
+++ b/Makefile
@@ -32,7 +32,11 @@ CFLAGS		?= -O2
 CFLAGS		+= -Wall
 SOCFLAGS	:= -fpic -D_REENTRANT $(CFLAGS)
 
+USE_STATIC_LIB ?= 0
 BUILD_STATIC_LIB ?= 1
+ifeq ($(USE_STATIC_LIB),1)
+BUILD_STATIC_LIB := 1
+endif
 
 KERNELVERSION	:= $(shell uname -r)
 
diff --git a/tools/Module.mk b/tools/Module.mk
index d14bb0c..8efddbb 100644
--- a/tools/Module.mk
+++ b/tools/Module.mk
@@ -12,7 +12,11 @@ TOOLS_DIR	:= tools
 TOOLS_CFLAGS	:= -Wstrict-prototypes -Wshadow -Wpointer-arith -Wcast-qual \
 		   -Wcast-align -Wwrite-strings -Wnested-externs -Winline \
 		   -W -Wundef -Wmissing-prototypes -Iinclude
+ifeq ($(USE_STATIC_LIB),1)
+TOOLS_LDFLAGS	:= $(LIB_DIR)/$(LIB_STLIBNAME)
+else
 TOOLS_LDFLAGS	:= -Llib -li2c
+endif
 
 TOOLS_TARGETS	:= i2cdetect i2cdump i2cset i2cget
 
-- 
2.1.4
