From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v9 8/8] i2c: octeon: thunderx: Add MAINTAINERS entry
Date: Thu, 12 May 2016 14:22:16 +0200
Message-ID: <1463055736-20025-9-git-send-email-jglauber@cavium.com>
References: <1463055736-20025-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463055736-20025-1-git-send-email-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

The i2c Octeon and ThunderX drivers are maintained by Cavium.
While at it fix the whitespace errors of the next entry.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
Acked-by: David Daney <david.daney@cavium.com>
---
 MAINTAINERS | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09744d2..bc28301 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2826,15 +2826,24 @@ S:	Maintained
 F:	drivers/iio/light/cm*
 F:	Documentation/devicetree/bindings/i2c/trivial-devices.txt
 
+CAVIUM I2C DRIVER
+M:	Jan Glauber <jglauber@cavium.com>
+M:	David Daney <david.daney@cavium.com>
+W:	http://www.cavium.com
+S:	Supported
+F:	drivers/i2c/busses/i2c-cavium*
+F:	drivers/i2c/busses/i2c-octeon*
+F:	drivers/i2c/busses/i2c-thunderx*
+
 CAVIUM LIQUIDIO NETWORK DRIVER
-M:     Derek Chickles <derek.chickles@caviumnetworks.com>
-M:     Satanand Burla <satananda.burla@caviumnetworks.com>
-M:     Felix Manlunas <felix.manlunas@caviumnetworks.com>
-M:     Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>
-L:     netdev@vger.kernel.org
-W:     http://www.cavium.com
-S:     Supported
-F:     drivers/net/ethernet/cavium/liquidio/
+M:	Derek Chickles <derek.chickles@caviumnetworks.com>
+M:	Satanand Burla <satananda.burla@caviumnetworks.com>
+M:	Felix Manlunas <felix.manlunas@caviumnetworks.com>
+M:	Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>
+L:	netdev@vger.kernel.org
+W:	http://www.cavium.com
+S:	Supported
+F:	drivers/net/ethernet/cavium/liquidio/
 
 CC2520 IEEE-802.15.4 RADIO DRIVER
 M:	Varka Bhadram <varkabhadram@gmail.com>
-- 
1.9.1
