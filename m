From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 07/15] platform/x86: i2c-multi-instantiate: Get rid of obsolete conditional
Date: Wed, 28 Nov 2018 13:30:16 +0200
Message-ID: <20181128113024.42126-8-andriy.shevchenko@linux.intel.com>
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
 drivers/platform/x86/i2c-multi-instantiate.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
index 16a0eabe1e31..724535673089 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -72,14 +72,10 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 			board_info.irq = ret;
 		}
 		multi->clients[i] = i2c_acpi_new_device(dev, i, &board_info);
-		if (IS_ERR(multi->clients[i]))
+		if (IS_ERR(multi->clients[i])) {
 			ret = PTR_ERR(multi->clients[i]);
-		else if (!multi->clients[i])
-			ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
-		else
-			ret = 0;
-		if (ret) {
-			dev_err(dev, "Error creating i2c-client, idx %d\n", i);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Error creating i2c-client, idx %d\n", i);
 			goto error;
 		}
 	}
-- 
2.19.2
