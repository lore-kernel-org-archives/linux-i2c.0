From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: Re: [i2c] [RFC PATCH 3/8] Philips PCA9536 4 bit I2C GPIO extender
 driver
Date: Sun, 27 Jan 2008 23:27:41 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801272313060.6715@axis700.grange>
References: <Pine.LNX.4.64.0801231646090.4932@axis700.grange>
	<Pine.LNX.4.64.0801231820060.4932@axis700.grange>
	<20080127224559.4eed7cea@hyperion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <20080127224559.4eed7cea@hyperion.delvare>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: Jean Delvare <khali@linux-fr.org>
Cc: David Brownell <david-b@pacbell.net>, video4linux-list@redhat.com, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 27 Jan 2008, Jean Delvare wrote:

> Hi Guennadi,
> 
> On Wed, 23 Jan 2008 18:41:39 +0100 (CET), Guennadi Liakhovetski wrote:
> > This driver will be used by the mt9m001 and the mt9v022 camera drivers,
> > that can use a pca9536 to switch between 8 and 10 bit modes.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
> > ---
> >  drivers/i2c/chips/Kconfig   |   10 +++
> >  drivers/i2c/chips/Makefile  |    1 +
> >  drivers/i2c/chips/pca9536.c |  153 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 164 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/i2c/chips/pca9536.c
> 
> There is a new GPIO subsystem (under driver/gpio), that's where you
> should add this driver.

Right, thanks, will move there, as well as will fix all your clean up 
suggestions - unneeded headers, dev_dbg, actually, might even remove 
sysfs attributes - they were there only for debugging.

> > +	if (client->dev.platform_data)
> > +		/* This chip is going to be used from the kernel */
> > +		*(struct i2c_client **)client->dev.platform_data = client;
> 
> This doesn't make any sense to me - what are you doing?

This was my way to call 

int pca9536_set_level(struct i2c_client *client, u8 pin, u8 level)
{
...
}
EXPORT_SYMBOL(pca9536_set_level);

from video drivers. But, if I make it a GPIO driver, I'll get a gpio API 
too, so, will not have to export a new function, right (haven't looked at 
gpio API yet)? But, probably, I still will need to somehow pass a handle 
to this gpio-controller to the video driver. The idea is:

in platform file we know, that a specific GPIO controller is attached to a 
specific camera. So, I do

static struct i2c_client *camera_data_bus_switch;

static struct soc_camera_link iclink[] = {
	{
		.bus_id		= 0, /* Must match with the camera ID above */
		.extender	= &camera_data_bus_switch,
	}, {
		.bus_id		= 0, /* Must match with the camera ID above */
	}
};

/* Board I2C devices. */
static struct i2c_board_info __initdata pcm027_i2c_devices[] = {
	{
		/* Must initialize before the camera(s) */
		I2C_BOARD_INFO("pca9536", 0x41),
		.type = "pca9536",
		.platform_data = &camera_data_bus_switch,
	}, {
		I2C_BOARD_INFO("mt9v022", 0x48),
		.type = "mt9v022",
		.platform_data = &iclink[0], /* With extender */
	}, {
		I2C_BOARD_INFO("mt9m001", 0x5d),
		.type = "mt9m001",
		.platform_data = &iclink[0], /* With extender */
	},
};

this way I tell, that the pca9536 extender with i2c address 0x41 is used 
to switch both cameras. And in the pca9536 driver I fill in the 
camera_data_bus_switch variable, so that cameras can later find and use 
the switch.

Well, I haven't find a better way to do this.

Thanks
Guennadi
---
Guennadi Liakhovetski

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
