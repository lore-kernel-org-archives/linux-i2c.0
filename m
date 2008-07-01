From: "Jon Smirl" <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Aliases and device names for i2c
Date: Tue, 1 Jul 2008 15:07:37 -0400
Message-ID: <9e4733910807011207k4fa74664y31ee65aa3be70410@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Is the problem is stemming from having the i2c drivers support
multiple similar but not exactly the same chips?  These similar chips
are being exposed as aliases which they really aren't; they are
actually different chips.

A solution to this is for the drivers to register themselves multiple
times, one for each different chip. Doing that frees up aliases for
true aliases which is what device trees need.

That also resolve the issue of needing a name attribute in the sysfs
device node. We shouldn't need that attribute. By registering multiple
times, the link from the device to the driver will contain the correct
chip id. Of course we can still make a legacy name attribute until
user space is converted.

With this structure modalias will contain the alias used to load the driver.
The driver link will have pfc856?.name.name
pfc856?.name.name can also be use to create the name attribute.

static const struct i2c_device_id pcf8563_id[] = {
	{ "pcf8563", 0 },
	{ "samsung,pcf8563", 0 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, pcf8563_id);

static struct i2c_driver pcf8563_driver = {
	.driver		= {
		.name	= "pcf8563",
	},
	.probe		= pcf8563_probe,
	.remove		= pcf8563_remove,
	.id_table	= pcf8563_id,
};

static int __init pcf8563_init(void)
{
	return i2c_add_driver(&pcf8563_driver);
}

static void __exit pcf8563_exit(void)
{
	i2c_del_driver(&pcf8563_driver);
}

static const struct i2c_device_id pcf8563_id[] = {
	{ "rtc8564", 0 },
	{ "dallas,rtc8564", 0 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, pcf8563_id);

static struct i2c_driver pcf8563_driver = {
	.driver		= {
		.name	= "pcf8564",
	},
	.probe		= pcf8563_probe,
	.remove		= pcf8563_remove,
	.id_table	= pcf8564_id,
};

static int __init pcf8564_init(void)
{
	return i2c_add_driver(&pcf8564_driver);
}

static void __exit pcf8564_exit(void)
{
	i2c_del_driver(&pcf8564_driver);
}

-- 
Jon Smirl
jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
