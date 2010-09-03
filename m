From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
Date: Fri, 3 Sep 2010 16:16:23 -0700
Message-ID: <20100903161623.26ab9c76.akpm@linux-foundation.org>
References: <1283470837-18210-1-git-send-email-achew@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283470837-18210-1-git-send-email-achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu,  2 Sep 2010 16:40:37 -0700
achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org wrote:

> This is for the Asahi Kasei AK8975 3-axis magnetometer.  It resides within
> the magnetometer section of the IIO subsystem, and implements the raw
> magn_x,y,z attributes, as well as x,y,z factory calibration attributes.
> 
> Signed-off-by: Andrew Chew <achew-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/staging/iio/magnetometer/Kconfig  |   11 +
>  drivers/staging/iio/magnetometer/Makefile |    1 +
>  drivers/staging/iio/magnetometer/ak8975.c |  521 +++++++++++++++++++++++++++++
>  3 files changed, 533 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/magnetometer/ak8975.c

This is version 2, yes?

It would be nice to provide some accounting of how it differs from
version 1, for those who already reviewed version 1.  The v1->v2 diff
is below.

--- a/drivers/staging/iio/magnetometer/ak8975.c~a
+++ a/drivers/staging/iio/magnetometer/ak8975.c
@@ -192,14 +192,14 @@ static int ak8975_setup(struct i2c_clien
 				   AK8975_REG_CNTL_MODE_SHIFT);
 	if (!status) {
 		dev_err(&client->dev, "Error in setting fuse access mode\n");
-		return false;
+		return -EINVAL;
 	}
 
 	/* Get asa data and store in the device data. */
 	status = ak8975_read_data(client, AK8975_REG_ASAX, 3, buffer);
 	if (!status) {
 		dev_err(&client->dev, "Not able to read asa data\n");
-		return -ENODEV;
+		return -EINVAL;
 	}
 
 	data->asa[0] = buffer[0] & 0xFF;
@@ -236,10 +236,10 @@ static ssize_t store_mode(struct device 
 
 	/* Convert mode string and do some basic sanity checking on it.
 	   only 0 or 1 are valid. */
-	if (strict_strtol(buf, 10, &oval))
+	if (strict_strtoul(buf, 10, &oval))
 		return -EINVAL;
 
-	if ((oval < 0) || (oval > 1)) {
+	if (oval > 1) {
 		dev_err(dev, "mode value is not supported\n");
 		return -EINVAL;
 	}
@@ -320,7 +320,7 @@ static ssize_t show_raw(struct device *d
 				   AK8975_REG_CNTL_MODE_SHIFT);
 	if (!status) {
 		dev_err(&client->dev, "Error in setting operating mode\n");
-		return false;
+		return -EINVAL;
 	}
 
 	/* Wait for the conversion to complete. */
@@ -333,13 +333,13 @@ static ssize_t show_raw(struct device *d
 	}
 	if (!timeout_ms) {
 		dev_err(&client->dev, "Conversion timeout happend\n");
-		return false;
+		return -EINVAL;
 	}
 
 	status = ak8975_read_data(client, AK8975_REG_ST1, 1, &read_status);
 	if (!status) {
 		dev_err(&client->dev, "Error in reading ST1\n");
-		return false;
+		return -EINVAL;
 	}
 
 	if (read_status & AK8975_REG_ST1_DRDY_MASK) {
@@ -347,13 +347,13 @@ static ssize_t show_raw(struct device *d
 					  1, &read_status);
 		if (!status) {
 			dev_err(&client->dev, "Error in reading ST2\n");
-			return false;
+			return -EINVAL;
 		}
 		if (read_status & (AK8975_REG_ST2_DERR_MASK |
 				   AK8975_REG_ST2_HOFL_MASK)) {
 			dev_err(&client->dev, "ST2 status error 0x%x\n",
 				read_status);
-			return false;
+			return -EINVAL;
 		}
 	}
 
@@ -363,7 +363,7 @@ static ssize_t show_raw(struct device *d
 				  (u8 *)&meas_reg);
 	if (!status) {
 		dev_err(&client->dev, "Read axis data fails\n");
-		return false;
+		return -EINVAL;
 	}
 
 	/* Endian conversion of the measured values */
@@ -418,6 +418,11 @@ static int ak8975_probe(struct i2c_clien
 	data->eoc_irq = client->irq;
 	data->eoc_gpio = irq_to_gpio(client->irq);
 
+	if (!data->eoc_gpio) {
+		dev_err(&client->dev, "failed, no valid GPIO\n");
+		goto exit_free;
+	}
+
 	err = gpio_request(data->eoc_gpio, "ak_8975");
 	if (err < 0) {
 		dev_err(&client->dev, "failed to request GPIO %d, error %d\n",
@@ -429,7 +434,6 @@ static int ak8975_probe(struct i2c_clien
 	if (err < 0) {
 		dev_err(&client->dev, "Failed to configure input direction for"
 			" GPIO %d, error %d\n", data->eoc_gpio, err);
-		gpio_free(data->eoc_gpio);
 		goto exit_gpio;
 	}
 
_
