From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: Dynamically-allocated i2c_device_id vs MODULE_DEVICE_TABLE
Date: Sat, 24 Jan 2009 01:28:18 +0000
Message-ID: <20090124012817.GA31775@sirena.org.uk>
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

> The problem I'm having is the MODULE_DEVICE_TABLE.  What I really should be
> doing is this:

> 	socdev = kmalloc(...);
> 	struct i2c_driver *cs4270_i2c_driver = kmalloc(...);
> 	struct i2c_device_id *cs4270_id = kmalloc(...);
> 	cs4270_i2c_driver->id_table = cs4270_id;
> 	c24270_id->driver_data = socdev;
> 	i2c_add_driver(cs4270_i2c_driver);

This is because the ASoC core still hasn't quite got the idea of
instantiating the differnet bits of the device separately.  Really what
you're having to do here is fairly nasty and there's no good reason for
it to be supported - if something is being registered dynamically and
passing instantiation specific data around it really should be the
device and not the driver.  The fact that attempting to do this looks
bad is a win on the part of the I2C core.

For now an idiomatic solution for ASoC drivers is to have a single
static variable that you use to get the socdev through.
