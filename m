From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v7 5/6] i2c: core: Move ACPI gpio IRQ handling into i2c_acpi_get_irq
Date: Wed, 26 Jun 2019 16:03:01 +0100
Message-ID: <20190626150302.22703-6-ckeepax@opensource.cirrus.com>
References: <20190626150302.22703-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190626150302.22703-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, mika.westerberg@linux.intel.com
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

It makes sense to contain all the ACPI IRQ handling in a single helper
function.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No change since v6.

Thanks,
Charles

 drivers/i2c/i2c-core-acpi.c | 3 +++
 drivers/i2c/i2c-core-base.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index e7559b3853062..99f22a93c059f 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -169,6 +169,9 @@ int i2c_acpi_get_irq(struct i2c_client *client)
 
 	acpi_dev_free_resource_list(&resource_list);
 
+	if (irq == -ENOENT)
+		irq = acpi_dev_gpio_irq_get(adev, 0);
+
 	return irq;
 }
 
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index c848b325969e9..1bf7d8748de14 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -328,9 +328,6 @@ static int i2c_device_probe(struct device *dev)
 				irq = of_irq_get(dev->of_node, 0);
 		} else if (ACPI_COMPANION(dev)) {
 			irq = i2c_acpi_get_irq(client);
-
-			if (irq == -ENOENT)
-				irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
 		}
 		if (irq == -EPROBE_DEFER)
 			return irq;
-- 
2.11.0
