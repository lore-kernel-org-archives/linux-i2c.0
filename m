From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 3/3] spi: attach/detach SPI device to the ACPI power domain
Date: Thu, 10 Oct 2013 13:28:48 +0300
Message-ID: <1381400928-2689-4-git-send-email-mika.westerberg@linux.intel.com>
References: <1381327461-10562-1-git-send-email-mika.westerberg@linux.intel.com>
 <1381400928-2689-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1381400928-2689-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

If the SPI device is enumerated from ACPI namespace (it has an ACPI handle)
it might have ACPI methods that needs to be called in order to transition
the device to different power states (such as _PSx).

We follow what has been done for platform and I2C buses here and attach the
SPI device to the ACPI power domain if the device has an ACPI handle. This
makes sure that the device is powered on when its ->probe() is called.

For non-ACPI devices this patch is a no-op.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9e039c6..740f9dd 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -240,15 +240,27 @@ EXPORT_SYMBOL_GPL(spi_bus_type);
 static int spi_drv_probe(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
+	struct spi_device		*spi = to_spi_device(dev);
+	int ret;
+
+	acpi_dev_pm_attach(&spi->dev, true);
+	ret = sdrv->probe(spi);
+	if (ret)
+		acpi_dev_pm_detach(&spi->dev, true);
 
-	return sdrv->probe(to_spi_device(dev));
+	return ret;
 }
 
 static int spi_drv_remove(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
+	struct spi_device		*spi = to_spi_device(dev);
+	int ret;
+
+	ret = sdrv->remove(spi);
+	acpi_dev_pm_detach(&spi->dev, true);
 
-	return sdrv->remove(to_spi_device(dev));
+	return ret;
 }
 
 static void spi_drv_shutdown(struct device *dev)
@@ -1025,8 +1037,10 @@ static acpi_status acpi_spi_add_device(acpi_handle handle, u32 level,
 		return AE_OK;
 	}
 
+	adev->power.flags.ignore_parent = true;
 	strlcpy(spi->modalias, dev_name(&adev->dev), sizeof(spi->modalias));
 	if (spi_add_device(spi)) {
+		adev->power.flags.ignore_parent = false;
 		dev_err(&master->dev, "failed to add SPI device %s from ACPI\n",
 			dev_name(&adev->dev));
 		spi_dev_put(spi);
-- 
1.8.4.rc3
