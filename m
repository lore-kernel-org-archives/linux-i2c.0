From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v4 3/3] i2c: mv64xxx: Fix bus hang on A0 version of the Armada XP SoCs
Date: Tue,  7 Jan 2014 17:35:04 +0100
Message-ID: <1389112504-9931-4-git-send-email-gregory.clement@free-electrons.com>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The first variants of Armada XP SoCs (A0 stepping) have issues related
to the i2c controller which prevent to use the offload mechanism and
lead to a kernel hang during boot.

The driver now checks if offload the mechanism is tagged as broken
and enable it in the opposite case.

Cc: stable@vger.kernel.org
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 8be7e42aa4de..de819daa19e6 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -779,8 +779,10 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 	 * Transaction Generator support and the errata fix.
 	 */
 	if (of_device_is_compatible(np, "marvell,mv78230-i2c")) {
-		drv_data->offload_enabled = true;
 		drv_data->errata_delay = true;
+
+		if (!of_find_property(np, "offload-broken", NULL))
+			drv_data->offload_enabled = true;
 	}
 
 out:
-- 
1.8.1.2
