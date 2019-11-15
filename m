From: Saravana Kannan <saravanak@google.com>
Subject: [PATCH v1] i2c: of: Populate fwnode in of_i2c_get_board_info()
Date: Thu, 14 Nov 2019 20:50:48 -0800
Message-ID: <20191115045049.261104-1-saravanak@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-team@android.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This allows the of_devlink feature to work across i2c devices too. This
avoid unnecessary probe deferrals of i2c devices, defers consumers of
i2c devices till the i2c devices probe, and allows i2c drivers to
implement sync_state() callbacks.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
The of_devlink feature is present in driver-core-next branch. It started
off with [1] but it has been improving since then.

[1] -- https://lore.kernel.org/linux-acpi/20190904211126.47518-1-saravanak@google.com/

 drivers/i2c/i2c-core-of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 6f632d543fcc..4e913c890a7b 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -50,6 +50,7 @@ int of_i2c_get_board_info(struct device *dev, struct device_node *node,
 
 	info->addr = addr;
 	info->of_node = node;
+	info->fwnode = of_fwnode_handle(node);
 
 	if (of_property_read_bool(node, "host-notify"))
 		info->flags |= I2C_CLIENT_HOST_NOTIFY;
-- 
2.24.0.432.g9d3f5f5b63-goog
