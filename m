From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [i2c-tools][PATCH] honor CROSS_COMPILE
Date: Fri,  7 Jan 2011 13:01:14 -0600
Message-ID: <1294426874-24973-1-git-send-email-nm@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Honor CROSS_COMPILE for builds. useful for folks using
building for platforms like ARM using cross compiler
toolchain. CC could be reused as well, but usage of
CROSS_COMPILE seems more similar to what we have
for u-boot, kernel etc..

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
against svn:
r5894 | khali | 2010-12-12 07:22:29 -0600 (Sun, 12 Dec 2010) | 3 lines

Make value arrays const for block write functions. Patch from Roman
Fietze.

 Makefile |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b98a4c3..49e07fe 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,20 @@ INSTALL_DIR	:= $(INSTALL) -m 755 -d
 INSTALL_PROGRAM	:= $(INSTALL) -m 755
 RM		:= rm -f
 
+# Acknowledge if CROSS_COMPILE is used
+ifeq ($(CROSS_COMPILE),)
 CC	?= gcc
+else
+AS	= $(CROSS_COMPILE)as
+LD	= $(CROSS_COMPILE)ld
+CC	= $(CROSS_COMPILE)gcc
+AR	= $(CROSS_COMPILE)ar
+NM	= $(CROSS_COMPILE)nm
+LDR	= $(CROSS_COMPILE)ldr
+STRIP	= $(CROSS_COMPILE)strip
+OBJCOPY	= $(CROSS_COMPILE)objcopy
+OBJDUMP	= $(CROSS_COMPILE)objdump
+endif
 
 CFLAGS	?= -O2
 # When debugging, use the following instead
-- 
1.6.3.3
