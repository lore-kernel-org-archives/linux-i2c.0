From: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
Subject: [PATCH 4/7] iio: srf08: add device tree table
Date: Thu, 3 Aug 2017 01:25:04 +0200
Message-ID: <20170802232504.GA15256@arbeit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Added MODULE_DEVICE_TABLE for device tree bindings.

It used to work without it by using the i2c_device_id table, but adding the
table makes everything clear and documented.

Signed-off-by: Andreas Klinger <ak-n176/SwNRljddJNmlsFzeA@public.gmane.org>
---
 drivers/iio/proximity/srf08.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 92e1799c430c..a2913a5bf68e 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -455,6 +455,14 @@ static int srf08_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static const struct of_device_id of_srf08_match[] = {
+	{ .compatible = "devantech,srf08", (void *)SRF08},
+	{ .compatible = "devantech,srf10", (void *)SRF10},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, of_srf08_match);
+
 static const struct i2c_device_id srf08_id[] = {
 	{ "srf08", SRF08 },
 	{ "srf10", SRF10 },
@@ -465,6 +473,7 @@ MODULE_DEVICE_TABLE(i2c, srf08_id);
 static struct i2c_driver srf08_driver = {
 	.driver = {
 		.name	= "srf08",
+		.of_match_table	= of_srf08_match,
 	},
 	.probe = srf08_probe,
 	.id_table = srf08_id,
-- 
2.1.4


-- 
