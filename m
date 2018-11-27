From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 03/13] platform/x86: i2c-multi-instantiate: Accept errors of i2c_acpi_new_device()
Date: Tue, 27 Nov 2018 17:37:18 +0200
Message-ID: <20181127153728.47866-4-andriy.shevchenko@linux.intel.com>
References: <20181127153728.47866-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127153728.47866-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

In the future i2c_acpi_new_device() will return error pointer in some cases.
Prepare i2c-multi-instantiate driver to support that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/i2c-multi-instantiate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
index 5456581b473c..bab79bdeebc7 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -72,9 +72,14 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 			board_info.irq = ret;
 		}
 		multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
-		if (!multi->clients[i]) {
-			dev_err(dev, "Error creating i2c-client, idx %d\n", i);
+		if (!multi->clients[i])
 			ret = -ENODEV;
+		else if (IS_ERR(multi->clients[i]))
+			ret = PTR_ERR(multi->clients[i]);
+		else
+			ret = 0;
+		if (ret) {
+			dev_err(dev, "Error creating i2c-client, idx %d\n", i);
 			goto error;
 		}
 	}
-- 
2.19.2
