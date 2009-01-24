From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: Dynamically-allocated i2c_device_id vs MODULE_DEVICE_TABLE
Date: Sat, 24 Jan 2009 16:50:40 +0000
Message-ID: <20090124165040.GL8032@fluff.org.uk>
References: <497A3097.1030808@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <497A3097.1030808-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 23, 2009 at 03:03:19PM -0600, Timur Tabi wrote:
> I currently have this in my code:
> 
> static const struct i2c_device_id cs4270_id[] = {
> 	{"cs4270", 0},
> 	{}
> };
> MODULE_DEVICE_TABLE(i2c, cs4270_id);
> 
> static struct i2c_driver cs4270_i2c_driver = {
> 	.driver = {
> 		.name = "cs4270",
> 		.owner = THIS_MODULE,
> 	},
> 	.id_table = cs4270_id,
> 	.probe = cs4270_i2c_probe,
> 	.remove = cs4270_i2c_remove,
> };
> 
> ret = i2c_add_driver(&cs4270_i2c_driver);
> 
> I would like to use the i2c_device_id.driver_data variable to pass private data
> to my cs4270_i2c_probe() function.  So it will look like this:
> 
> 	socdev = kmalloc(...);
> 	c24270_id.driver_data = socdev;
> 	i2c_add_driver(&cs4270_i2c_driver);

you seem to have managed to short-circuit part of the device
creation process. You do not need to pass the data via the device
driver, you should pass it when creating the device. 

If you look at i2c_board_info which can be passed into i2c_new_device
or similar functions, there is a platform_data field you can fill out
and this is passed in to your probe routine in the i2c device.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
