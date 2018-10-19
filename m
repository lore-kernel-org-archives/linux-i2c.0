From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 1/2] i2c: Remove unnecessary call to irq_find_mapping
Date: Fri, 19 Oct 2018 09:59:57 +0100
Message-ID: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

irq_create_mapping calls irq_find_mapping internally and will use the
found mapping if one exists, so there is no need to manually call this
from i2c_smbus_host_notify_to_irq.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/i2c/i2c-core-base.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index dc78aa7369def..656f0a6fe3adf 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -306,10 +306,7 @@ static int i2c_smbus_host_notify_to_irq(const struct i2c_client *client)
 	if (client->flags & I2C_CLIENT_TEN)
 		return -EINVAL;
 
-	irq = irq_find_mapping(adap->host_notify_domain, client->addr);
-	if (!irq)
-		irq = irq_create_mapping(adap->host_notify_domain,
-					 client->addr);
+	irq = irq_create_mapping(adap->host_notify_domain, client->addr);
 
 	return irq > 0 ? irq : -ENXIO;
 }
-- 
2.11.0
