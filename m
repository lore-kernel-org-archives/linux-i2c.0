From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: PCA9564: "bus is not idle" issue
Date: Wed, 17 Mar 2010 13:59:03 +0100
Message-ID: <f69abfc31003170559y3c0a5a6fi91c1ae7692700c66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I'm using PCA9564 attached to a ks8695 SoC. During my efforts to get
2.6.33/34 running on my system I noticed sporadic problems with RTC:

rtc-ds1307 0-0068: read error -11
RTC_RD_TIME: Input/output error
ioctl() to /dev/rtc to read the time failed.

After turning debug messages in i2c subsystem I got following info:

i2c i2c-0: master_xfer[0] W, addr=0x68, len=1
i2c i2c-0: master_xfer[1] R, addr=0x68, len=7
i2c i2c-0: bus is not idle. status is 0x28 (sometimes it is 0x50 or 0x58)

This is the way I configure RTC and I2C:

/*****************************************************************************
 * RTC DS1337 on I2C bus
 ****************************************************************************/
static struct i2c_board_info __initdata vsopenrisc_i2c_rtc = {
		I2C_BOARD_INFO("ds1337", 0x68),
};
static struct i2c_pca9564_pf_platform_data  __initdata pca_data ={
	    .gpio = -1,
	    .i2c_clock_speed = 59000,
	    .timeout = 1,
};

static struct resource pca_resources[] = {
	[0] = {
		 .start	= VSOPENRISC_PA_I2C_BASE,
		 .end	= VSOPENRISC_PA_I2C_BASE + 0x400 - 1,
		 .flags	= IORESOURCE_MEM | IORESOURCE_MEM_32BIT,
   	},
	[1] = {
		.start	= 0,
		.end	= 0,
		.flags	= IORESOURCE_IRQ,
	},
};

static struct platform_device vsopenrisc_pca_device = {
	.name		= "i2c-pca-platform",
	.id		= -1,
	.dev		= {
			    .platform_data	= &pca_data,
			},
	.resource	= pca_resources,
	.num_resources	= ARRAY_SIZE(pca_resources),
};

With the older kernel 2.6.26 I have never encountered such problems
before. Diffing i2c-algo-pca.c between 2.6.26 and 2.6.33 showed that
there were some minor changes regarding waiting policy in pca_xfer().
Could this be the reason for such behavior? Any idea?

Regards,
Yegor
