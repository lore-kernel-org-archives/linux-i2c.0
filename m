From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 02/13] platform/x86: intel_cht_int33fe: Accept errors of i2c_acpi_new_device()
Date: Mon, 26 Nov 2018 17:08:47 +0200
Message-ID: <20181126150858.16901-3-andriy.shevchenko@linux.intel.com>
References: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126150858.16901-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

In the future i2c_acpi_new_device() will return error pointer in some cases.
Prepare intel_cht_int33fe driver to support that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 28 +++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 431151d4e611..367d6e304ade 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -168,8 +168,14 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 		board_info.dev_name = "max17047";
 		board_info.properties = max17047_props;
 		data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
-		if (!data->max17047)
-			return -EPROBE_DEFER; /* Wait for i2c-adapter to load */
+		if (IS_ERR(data->max17047))
+			ret = PTR_ERR(data->max17047);
+		else if (!data->max17047)
+			ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
+		else
+			ret = 0;
+		if (ret)
+			return ret;
 	}
 
 	data->connections[0].endpoint[0] = "port0";
@@ -194,7 +200,13 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	board_info.irq = fusb302_irq;
 
 	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
-	if (!data->fusb302)
+	if (IS_ERR(data->fusb302))
+		ret = PTR_ERR(data->fusb302);
+	else if (!data->fusb302)
+		ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
+	else
+		ret = 0;
+	if (ret)
 		goto out_unregister_max17047;
 
 	memset(&board_info, 0, sizeof(board_info));
@@ -202,7 +214,13 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
 
 	data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
-	if (!data->pi3usb30532)
+	if (IS_ERR(data->pi3usb30532))
+		ret = PTR_ERR(data->pi3usb30532);
+	else if (!data->pi3usb30532)
+		ret = -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
+	else
+		ret = 0;
+	if (ret)
 		goto out_unregister_fusb302;
 
 	platform_set_drvdata(pdev, data);
@@ -217,7 +235,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 
 	device_connections_remove(data->connections);
 
-	return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
+	return ret;
 }
 
 static int cht_int33fe_remove(struct platform_device *pdev)
-- 
2.19.1
