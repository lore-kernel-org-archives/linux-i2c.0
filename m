From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 06/15] platform/x86: intel_cht_int33fe: Get rid of obsolete conditional
Date: Wed, 28 Nov 2018 13:30:15 +0200
Message-ID: <20181128113024.42126-7-andriy.shevchenko@linux.intel.com>
References: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Now, when i2c_acpi_new_device() never returns NULL, there is no point to check
for it. Besides that, i2c_acpi_new_device() returns -EPROBE_DEFER directly and
caller doesn't need to guess is better.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 367d6e304ade..616b8853a91f 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -169,13 +169,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 		board_info.properties = max17047_props;
 		data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
 		if (IS_ERR(data->max17047))
-			ret = PTR_ERR(data->max17047);
-		else if (!data->max17047)
-			ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
-		else
-			ret = 0;
-		if (ret)
-			return ret;
+			return PTR_ERR(data->max17047);
 	}
 
 	data->connections[0].endpoint[0] = "port0";
@@ -200,28 +194,20 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	board_info.irq = fusb302_irq;
 
 	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
-	if (IS_ERR(data->fusb302))
+	if (IS_ERR(data->fusb302)) {
 		ret = PTR_ERR(data->fusb302);
-	else if (!data->fusb302)
-		ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
-	else
-		ret = 0;
-	if (ret)
 		goto out_unregister_max17047;
+	}
 
 	memset(&board_info, 0, sizeof(board_info));
 	board_info.dev_name = "pi3usb30532";
 	strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
 
 	data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
-	if (IS_ERR(data->pi3usb30532))
+	if (IS_ERR(data->pi3usb30532)) {
 		ret = PTR_ERR(data->pi3usb30532);
-	else if (!data->pi3usb30532)
-		ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
-	else
-		ret = 0;
-	if (ret)
 		goto out_unregister_fusb302;
+	}
 
 	platform_set_drvdata(pdev, data);
 
-- 
2.19.2
