From: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>
Subject: i2c gpio expander on hotplug i2c-adapter
Date: Tue, 07 Jun 2011 23:59:17 +0200
Message-ID: <4DEE9F35.9020606@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi there,
I'm a bit puzzled. My desired setup is something like this: Linux
station => usb i2c-adapter (i2c tiny usb) => i2c switch (pca9548) => i2c
gpio expander (pca9555)
So far, instantiation works for the i2c switch using the sysfs method
(echo pca9548 0x70 > /sys/bus/i2c....). What's really causing me
troubles is instantiating the pca9555. What I found so far indicates
that it has to be defined in the machine specific file. So that is what
I already added:

static struct pca953x_platform_data pca9555_0 = {
    .gpio_base = 32,
};

static struct i2c_board_info __initdata i2c_tiny_board_info[] = {
  {
    I2C_BOARD_INFO("pca9555",0x21),
    .platform_data = &pca9555_0,
  }
};

Now I'm struggling how to declare my i2c tiny usb adapter to be the bus
where the pca9555 should live on (leaving out the i2c switch for the
moment). What I tried so far did not work (obviously):

static struct platform_device i2c_tiny_usb_device = {
  .name    = "i2c-tiny-usb",
  .id    = 0,
};
static void __devinit i2c_tiny_usb_init(void)
{
 i2c_register_board_info(0,i2c_tiny_board_info,
ARRAY_SIZE(i2c_tiny_board_info));
 platform_device_register(&i2c_tiny_usb_device);
};

The i2c_tiny_usb_init() funciton gets called in the init section. It
compiles without errors, but with this kernel, the i2c-adapter now gets
registered as i2c-1. How would a proper declaration of that i2c-adapter
look like? Or would there even be a chance to do that instantiation from
a userspace program? I saw that the symbol "pca9555_0" is listed in the
system.map file of that kernel. So, would there even be a chance to just
declare the gpio platform data in the kernel and do the instantiation in
userspace?
Thanks in advance,

Hartmut
