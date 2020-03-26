From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2] macintosh: convert to i2c_new_scanned_device
Date: Thu, 26 Mar 2020 12:38:19 +0100
Message-ID: <20200326113819.7761-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49318 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbgCZLi3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 26 Mar 2020 07:38:29 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Michael Ellerman <mpe@ellerman.id.au>

Move from the deprecated i2c_new_probed_device() to the new
i2c_new_scanned_device(). No functional change for this driver because
it doesn't check the return code anyhow.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---

Change since v1: rebased on top of v5.6-rc7

 drivers/macintosh/therm_windtunnel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index a0d87ed9da69..f55f6adf5e5f 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -323,7 +323,7 @@ static void do_attach(struct i2c_adapter *adapter)
 		of_node_put(np);
 	} else {
 		strlcpy(info.type, "MAC,ds1775", I2C_NAME_SIZE);
-		i2c_new_probed_device(adapter, &info, scan_ds1775, NULL);
+		i2c_new_scanned_device(adapter, &info, scan_ds1775, NULL);
 	}
 
 	np = of_find_compatible_node(adapter->dev.of_node, NULL, "MAC,adm1030");
@@ -331,7 +331,7 @@ static void do_attach(struct i2c_adapter *adapter)
 		of_node_put(np);
 	} else {
 		strlcpy(info.type, "MAC,adm1030", I2C_NAME_SIZE);
-		i2c_new_probed_device(adapter, &info, scan_adm1030, NULL);
+		i2c_new_scanned_device(adapter, &info, scan_adm1030, NULL);
 	}
 }
 
-- 
2.20.1
