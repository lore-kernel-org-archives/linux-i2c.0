From: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Dynamically-allocated i2c_device_id vs MODULE_DEVICE_TABLE
Date: Fri, 23 Jan 2009 15:03:19 -0600
Message-ID: <497A3097.1030808@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I currently have this in my code:

static const struct i2c_device_id cs4270_id[] = {
	{"cs4270", 0},
	{}
};
MODULE_DEVICE_TABLE(i2c, cs4270_id);

static struct i2c_driver cs4270_i2c_driver = {
	.driver = {
		.name = "cs4270",
		.owner = THIS_MODULE,
	},
	.id_table = cs4270_id,
	.probe = cs4270_i2c_probe,
	.remove = cs4270_i2c_remove,
};

ret = i2c_add_driver(&cs4270_i2c_driver);

I would like to use the i2c_device_id.driver_data variable to pass private data
to my cs4270_i2c_probe() function.  So it will look like this:

	socdev = kmalloc(...);
	c24270_id.driver_data = socdev;
	i2c_add_driver(&cs4270_i2c_driver);

And then in my cs4270_i2c_probe(), I would do this:

static int cs4270_i2c_probe(struct i2c_client *i2c_client,
	const struct i2c_device_id *id)
{
	struct X *socdev = (struct X *) id->driver_data.

The problem I'm having is the MODULE_DEVICE_TABLE.  What I really should be
doing is this:

	socdev = kmalloc(...);
	struct i2c_driver *cs4270_i2c_driver = kmalloc(...);
	struct i2c_device_id *cs4270_id = kmalloc(...);
	cs4270_i2c_driver->id_table = cs4270_id;
	c24270_id->driver_data = socdev;
	i2c_add_driver(cs4270_i2c_driver);

But if I do this, then I can't use MODULE_DEVICE_TABLE.  So I have two questions:

1) What happens if I don't use MODULE_DEVICE_TABLE to identify my I2C ID table?

2) Is there a way to mimic the behavior of MODULE_DEVICE_TABLE on a
dynamically-created ID table?

-- 
Timur Tabi
Linux kernel developer at Freescale
