From: Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v2 2/3] i3c: add i3c_get_device_id helper
Date: Thu,  6 Jun 2019 17:12:03 +0200
Message-ID: <eaa9eb66df6b4c9b577aec46fd440b99d763a5a2.1559831663.git.vitor.soares@synopsys.com>
References: <cover.1559831663.git.vitor.soares@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1559831663.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1559831663.git.vitor.soares@synopsys.com>
References: <cover.1559831663.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, bbrezillon@kernel.org, Joao.Pinto@synopsys.com, lorenzo.bianconi83@gmail.com, Vitor Soares <Vitor.Soares@synopsys.com>
List-Id: linux-i2c@vger.kernel.org

This helper return the i3c_device_id structure in order the client
have access to the driver data.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
Changes in v2:
  move this function to drivers/i3c/device.c

 drivers/i3c/device.c       | 8 ++++++++
 include/linux/i3c/device.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index 69cc040..a6d0796 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -200,6 +200,14 @@ struct i3c_device *dev_to_i3cdev(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_to_i3cdev);
 
+const struct i3c_device_id *i3c_get_device_id(struct i3c_device *i3cdev)
+{
+	const struct i3c_driver *i3cdrv = drv_to_i3cdrv(i3cdev->dev.driver);
+
+	return i3cdrv->id_table;
+}
+EXPORT_SYMBOL_GPL(i3c_get_device_id);
+
 /**
  * i3c_driver_register_with_owner() - register an I3C device driver
  *
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 5ecb055..e0415e1 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -187,6 +187,7 @@ static inline struct i3c_driver *drv_to_i3cdrv(struct device_driver *drv)
 
 struct device *i3cdev_to_dev(struct i3c_device *i3cdev);
 struct i3c_device *dev_to_i3cdev(struct device *dev);
+const struct i3c_device_id *i3c_get_device_id(struct i3c_device *i3cdev);
 
 static inline void i3cdev_set_drvdata(struct i3c_device *i3cdev,
 				      void *data)
-- 
2.7.4
