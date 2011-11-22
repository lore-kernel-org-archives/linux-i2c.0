From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Waiting until probe of i2c driver is done
Date: Tue, 22 Nov 2011 11:32:06 +0100
Message-ID: <CAH9NwWdLH32zMqzr8qsEb-HaW9sBAGHxHiBVdpTdhGsnjzwQZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi ml,

I run into a little problem, which I don't know how to solve it.
I am using the eg20t i2c bus and a custom platform init
driver, which gets started after eg20t is ready.

And there I do the following:

/* buzzer and relay */
static struct gpio_led _gpio[] = {
	{
		.name = "relay",
		.gpio = 0,
		.active_low = 0,
		.default_state = LEDS_GPIO_DEFSTATE_OFF,
		.default_trigger = "timer",
	}
};

static struct gpio_led_platform_data _gpio_data = {
	.num_leds = ARRAY_SIZE(_gpio),
	.leds = _gpio,
};

static struct platform_device _gpio_hw = {
	.name = "leds-gpio",
	.dev.platform_data = &_gpio_data,
};

static struct platform_device *devices_tc[] = {
	&ot1300_gpio_hw,
};


int tunnelcreek_init(void)
{
	struct i2c_adapter *i2c_adap;

	/* we use the integrated i2c adapter */
	i2c_adap = i2c_get_adapter(0);

	if (!i2c_adap)
		return -EIO;

	eeprom =  i2c_new_device(i2c_adap, &i2c_eeprom);
	pca953x = i2c_new_device(i2c_adap, &pca9555_info);
	lm75 = i2c_new_device(i2c_adap, &lm75_info);

	platform_add_devices(devices_tc, ARRAY_SIZE(devices_tc));

	return 0;
}

If I run this code I get following messages:

[    1.552122] i2c 0-0050: uevent
[    1.552307] at24 0-0050: probe
[    1.552361] i2c 0-0051: uevent
[    1.552530] dummy 0-0051: probe
[    1.552544] i2c i2c-0: client [dummy] registered with bus id 0-0051
[    1.552559] at24 0-0050: 512 byte 24c04 EEPROM, writable, 16 bytes/write
[    1.552644] i2c i2c-0: master_xfer[0] W, addr=0x50, len=1
[    1.552655] i2c i2c-0: master_xfer[1] R, addr=0x50, len=24
[    1.557235] i2c i2c-0: master_xfer[0] W, addr=0x51, len=1
[    1.557248] i2c i2c-0: master_xfer[1] R, addr=0x51, len=20
[    1.560820] i2c i2c-0: client [24c04] registered with bus id 0-0050
[    1.560944] i2c 0-0021: uevent
[    1.561136] i2c i2c-0: client [pca9555] registered with bus id 0-0021
[    1.561197] i2c 0-0048: uevent
[    1.561357] i2c i2c-0: client [lm75] registered with bus id 0-0048
[    1.561638] leds-gpio: probe of leds-gpio.0 failed with error -22
[    1.568354] VFS: Mounted root (ext2 filesystem) readonly on device 8:2.
[    1.569161] devtmpfs: mounted
[    1.569307] Freeing unused kernel memory: 284k freed
[    1.569725] Write protecting the kernel text: 2096k
[    1.569880] Write protecting the kernel read-only data: 1008k
[    1.577121] hub 1-1:1.0: USB hub found
[    1.579246] hub 1-1:1.0: 3 ports detected
[    1.795723] udev[1136]: starting version 164
[    1.951100] usb 5-1: new low speed USB device number 2 using ohci_hcd
[    1.968166] i2c 0-0021: uevent
[    1.968284] i2c 0-0048: uevent
[    1.968400] at24 0-0050: uevent
[    1.968510] dummy 0-0051: uevent
[    2.206885] i2c 0-0021: uevent
[    2.208069] i2c 0-0048: uevent
[    2.209305] at24 0-0050: uevent
[    2.209928] at24 0-0050: uevent
[    2.210459] dummy 0-0051: uevent
[    2.211089] dummy 0-0051: uevent
[    2.245582] pca953x 0-0021: probe
[    2.245607] i2c i2c-0: master_xfer[0] W, addr=0x21, len=1
[    2.245624] i2c i2c-0: master_xfer[1] R, addr=0x21, len=2
[    2.250589] i2c i2c-0: master_xfer[0] W, addr=0x21, len=1
[    2.250607] i2c i2c-0: master_xfer[1] R, addr=0x21, len=2
[    2.251338] i2c i2c-0: master_xfer[0] W, addr=0x21, len=3
[    2.251900] pca953x 0-0021: interrupt support not compiled in
[    2.252236] i2c-core: driver [pca953x] registered
[

The problem is that leds-gpio gets loaded before pca953x driver
is ready. So no gpio's are available. Whats the best way to fix this?

Thanks
--
Christian Gmeiner, MSc
