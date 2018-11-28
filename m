From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 12/15] platform/x86: i2c-multi-instantiate: Introduce IOAPIC IRQ support
Date: Wed, 28 Nov 2018 13:30:21 +0200
Message-ID: <20181128113024.42126-13-andriy.shevchenko@linux.intel.com>
References: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128113024.42126-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

If ACPI table provides an Interrupt() resource we may consider to use it
instead of GpioInt() one.

Here we leave an error condition, when getting IRQ resource, to the driver
to decide how to proceed, because some drivers may consider IRQ resource
optional.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/i2c-multi-instantiate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
index 99db3e336718..365457f9c424 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -18,6 +18,7 @@
 #define IRQ_RESOURCE_TYPE	GENMASK(1, 0)
 #define IRQ_RESOURCE_NONE	0
 #define IRQ_RESOURCE_GPIO	1
+#define IRQ_RESOURCE_APIC	2
 
 struct i2c_inst_data {
 	const char *type;
@@ -104,6 +105,14 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
 			}
 			board_info.irq = ret;
 			break;
+		case IRQ_RESOURCE_APIC:
+			ret = platform_get_irq(pdev, inst_data[i].irq_idx);
+			if (ret < 0) {
+				dev_dbg(dev, "Error requesting irq at index %d: %d\n",
+					inst_data[i].irq_idx, ret);
+			}
+			board_info.irq = ret;
+			break;
 		default:
 			board_info.irq = 0;
 			break;
-- 
2.19.2
