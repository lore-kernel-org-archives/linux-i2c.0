From: Ayman KHAMOUMA <ayman.khamouma-qxv4g6HH51o@public.gmane.org>
Subject: I2c message at init time
Date: Tue, 24 Mar 2009 11:27:59 +0100
Message-ID: <000201c9ac6b$34a95300$2d3f81a4@par.st.com>
References: <20090311122257.7c7805f0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090311122257.7c7805f0-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi everybody,

I'm coming back here for a new problem...
I can't find out how to send i2c messages at init time (setup.c)
I need to send some commands via i2c in order to make my hdd work
I tried to write it as an i2c driver at init time, but it doesn't seem to
work (smbus_write_byte_data returns -1... But it works in my "normal"
modules)

Any idea ?
Here is what I'm doing:

static int __init device_init(void)
{
    unsigned        sysconf;
    int         ret;
    struct stpio_pin *pin;

    stx7100_configure_sata();
    stx7100_configure_pwm(&pwm_private_info);
    stx7100_configure_ssc(&ssc_private_info);
    stx7100_configure_usb();
    stx7100_configure_lirc(&lirc_scd);
    stx7100_configure_pata(3, 1, IRL0_IRQ);



    //vpp_pio = stpio_request_set_pin(2, 7, "flash_VPP", STPIO_OUT, 0);

    phy_reset_pin = stpio_request_set_pin(3, 7, "ste100p_reset",
                          STPIO_OUT, 1);
    stx7100_configure_ethernet(0, 0, 0);

    ret = platform_add_devices(mtv7109_devices,
ARRAY_SIZE(mtv7109_devices));

	//this is the driver I added:
    i2c_add_driver(&i2c_MTV7109PioExp_driver);
    
    
    pin = stpio_request_pin(2,5, "ATAPWR", STPIO_OUT);
    
/* reset ATAPI pin */

    stpio_set_pin(pin, 1);
    udelay(10);
    stpio_set_pin(pin, 0);
    udelay(10);
    stpio_set_pin(pin, 1);
    udelay(10);
    stpio_free_pin(pin);

    //ret = platform_add_devices(mtv7109_devices,
ARRAY_SIZE(mtv7109_devices));

    //i2c_add_driver(&i2c_MTV7109PioExp_driver);
    return ret;
}

device_initcall(device_init);
