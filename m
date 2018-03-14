From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH] i2c: mv64xxx: Apply errata delay only in standard mode
Date: Wed, 14 Mar 2018 18:03:40 +0100
Message-ID: <20180314170340.11951-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org

The errata FE-8471889 description has been updated. There is still a
timing violation for repeated start. But the errata now states that it
was only the case for the Standard mode (100 kHz), in Fast mode (400 kHz)
there is no issue.

This patch limit the errata fix to the Standard mode.

It has been tesed successfully on the clearfog (Aramda 388 based board).

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 440fe4a96e68..a5a95ea5b81a 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -845,12 +845,16 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 	 */
 	if (of_device_is_compatible(np, "marvell,mv78230-i2c")) {
 		drv_data->offload_enabled = true;
-		drv_data->errata_delay = true;
+		/* The delay is only needed in standard mode (100kHz) */
+		if (bus_freq <= 100000)
+			drv_data->errata_delay = true;
 	}
 
 	if (of_device_is_compatible(np, "marvell,mv78230-a0-i2c")) {
 		drv_data->offload_enabled = false;
-		drv_data->errata_delay = true;
+		/* The delay is only needed in standard mode (100kHz) */
+		if (bus_freq <= 100000)
+			drv_data->errata_delay = true;
 	}
 
 	if (of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))
-- 
2.16.1
