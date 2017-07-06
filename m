From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] i2c: core: Allow empty id_table in ACPI case as well
Date: Thu,  6 Jul 2017 21:01:40 +0300
Message-ID: <20170706180140.49391-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

For now empty ID table is not allowed with ACPI and prevents driver to be
probed.

Add a check to allow empty ID table.

Fixes: da10c06a044b ("i2c: Make I2C ID tables non-mandatory for DT'ed devices")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/i2c-core-base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index c89dac7fd2e7..45231d2257ad 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -354,9 +354,10 @@ static int i2c_device_probe(struct device *dev)
 
 	/*
 	 * An I2C ID table is not mandatory, if and only if, a suitable Device
-	 * Tree match table entry is supplied for the probing device.
+	 * Tree or ACPI match table entry is supplied for the probing device.
 	 */
 	if (!driver->id_table &&
+	    !acpi_match_device(dev->driver->acpi_match_table, &client->dev) &&
 	    !i2c_of_match_device(dev->driver->of_match_table, client))
 		return -ENODEV;
 
-- 
2.11.0

