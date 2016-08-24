From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v11 8/8] i2c: octeon: thunderx: Add MAINTAINERS entry
Date: Wed, 24 Aug 2016 23:25:49 +0200
Message-ID: <20160824212549.16140-9-jglauber@cavium.com>
References: <20160824212549.16140-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160824212549.16140-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

The i2c Octeon and ThunderX drivers are maintained by Cavium.
While at it fix the whitespace errors of the next entry.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a306795..11cba03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2878,6 +2878,14 @@ S:	Maintained
 F:	drivers/iio/light/cm*
 F:	Documentation/devicetree/bindings/i2c/trivial-devices.txt
 
+CAVIUM I2C DRIVER
+M:	Jan Glauber <jglauber@cavium.com>
+M:	David Daney <david.daney@cavium.com>
+W:	http://www.cavium.com
+S:	Supported
+F:	drivers/i2c/busses/i2c-octeon*
+F:	drivers/i2c/busses/i2c-thunderx*
+
 CAVIUM LIQUIDIO NETWORK DRIVER
 M:     Derek Chickles <derek.chickles@caviumnetworks.com>
 M:     Satanand Burla <satananda.burla@caviumnetworks.com>
-- 
2.9.0.rc0.21.g7777322
