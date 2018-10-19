From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
Date: Fri, 19 Oct 2018 09:59:58 +0100
Message-ID: <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

The IRQ will be mapped in i2c_device_probe only if client->irq is zero and
i2c_device_remove does not clear this. When rebinding an I2C device,
whos IRQ provider has also been rebound this means that an IRQ mapping
will never be created, causing the I2C device to fail to acquire its
IRQ. Fix this issue by clearing client->irq in i2c_device_remove,
forcing i2c_device_probe to lookup the mapping again.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/i2c/i2c-core-base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 656f0a6fe3adf..28460f6a60cc1 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -430,6 +430,8 @@ static int i2c_device_remove(struct device *dev)
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
 
+	client->irq = 0;
+
 	return status;
 }
 
-- 
2.11.0
