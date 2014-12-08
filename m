From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] MAINTAINERS: add I2C dt bindings also to I2C realm
Date: Mon,  8 Dec 2014 10:56:26 +0100
Message-ID: <1418032586-3778-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

So get_maintainer.pl will add us when something gets updated there.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea4d0058fd1b..794a8f0a31f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4561,6 +4561,7 @@ W:	https://i2c.wiki.kernel.org/
 Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
 S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/
 F:	Documentation/i2c/
 F:	drivers/i2c/
 F:	include/linux/i2c.h
-- 
2.1.3
