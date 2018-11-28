From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 02/15] platform/x86: intel_cht_int33fe: Remove duplicate NULL check
Date: Wed, 28 Nov 2018 13:30:11 +0200
Message-ID: <20181128113024.42126-3-andriy.shevchenko@linux.intel.com>
References: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Since i2c_unregister_device() became NULL-aware we may remove duplicate
NULL check.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 464fe93657b5..431151d4e611 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -213,8 +213,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	i2c_unregister_device(data->fusb302);
 
 out_unregister_max17047:
-	if (data->max17047)
-		i2c_unregister_device(data->max17047);
+	i2c_unregister_device(data->max17047);
 
 	device_connections_remove(data->connections);
 
@@ -227,8 +226,7 @@ static int cht_int33fe_remove(struct platform_device *pdev)
 
 	i2c_unregister_device(data->pi3usb30532);
 	i2c_unregister_device(data->fusb302);
-	if (data->max17047)
-		i2c_unregister_device(data->max17047);
+	i2c_unregister_device(data->max17047);
 
 	device_connections_remove(data->connections);
 
-- 
2.19.2
