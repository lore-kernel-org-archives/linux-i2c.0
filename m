From: Denis Efremov <efremov@linux.com>
Subject: [PATCH] MAINTAINERS: i2c mv64xxx: Update documentation path
Date: Tue, 13 Aug 2019 09:09:13 +0300
Message-ID: <20190813060913.14722-1-efremov@linux.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denis Efremov <efremov@linux.com>, joe@perches.com, Maxime Ripard <maxime.ripard@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Update MAINTAINERS record to reflect the file move
from i2c-mv64xxx.txt to marvell,mv64xxx-i2c.yaml.

Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: linux-i2c@vger.kernel.org
Fixes: f8bbde72ef44 ("dt-bindings: i2c: mv64xxx: Add YAML schemas")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 87ac0378186c..590dcebe627f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7505,7 +7505,7 @@ I2C MV64XXX MARVELL AND ALLWINNER DRIVER
 M:	Gregory CLEMENT <gregory.clement@bootlin.com>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+F:	Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
 F:	drivers/i2c/busses/i2c-mv64xxx.c
 
 I2C OVER PARALLEL PORT
-- 
2.21.0
