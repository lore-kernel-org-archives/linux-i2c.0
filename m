From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 04/15] platform/x86: i2c-multi-instantiate: Defer probe when no adapter found
Date: Wed, 28 Nov 2018 13:45:24 +0200
Message-ID: <20181128114535.80223-5-andriy.shevchenko@linux.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Likewise the rest of the i2c_acpi_new_device() users, defer the probe
of the i2c-multi-intantiate driver in case adapter is not yet found.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/i2c-multi-instantiate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
index e3345da82c84..16a0eabe1e31 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -75,7 +75,7 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 		if (IS_ERR(multi->clients[i]))
 			ret = PTR_ERR(multi->clients[i]);
 		else if (!multi->clients[i])
-			ret = -ENODEV;
+			ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
 		else
 			ret = 0;
 		if (ret) {
-- 
2.19.2
