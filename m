From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] MAINTAINERS: remove me as maintainer for I2C host drivers
Date: Tue, 10 Apr 2018 16:11:25 +0200
Message-ID: <20180410141125.4477-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

The number of I2C host controller drivers keeps increasing, and although
I had some success acquiring specific driver maintainers, my bandwidth
is by far not enough to act as a fallback for the rest of the drivers.
To reflect this status-quo in MAINTAINERS, add a seperate entry for I2C
host drivers, let the I2C list (= community) be the contact point, and
mark this section as "Odd fixes".

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Joe: my tests worked fine with the file patterns; yet I'd appreciate if you
had time to double check them. Thanks!

 MAINTAINERS | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d296bdce328..2f7ccdcf76f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6580,15 +6580,23 @@ W:	https://i2c.wiki.kernel.org/
 Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/
+F:	Documentation/devicetree/bindings/i2c/i2c.txt
 F:	Documentation/i2c/
-F:	drivers/i2c/
-F:	drivers/i2c/*/
+F:	drivers/i2c/*
 F:	include/linux/i2c.h
 F:	include/linux/i2c-*.h
 F:	include/uapi/linux/i2c.h
 F:	include/uapi/linux/i2c-*.h
 
+I2C SUBSYSTEM DRIVERS
+L:	linux-i2c@vger.kernel.org
+W:	https://i2c.wiki.kernel.org/
+Q:	https://patchwork.ozlabs.org/project/linux-i2c/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/i2c/
+F:	drivers/i2c/*/
+
 I2C-TAOS-EVM DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
 L:	linux-i2c@vger.kernel.org
-- 
2.11.0
