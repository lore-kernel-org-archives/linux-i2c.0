From: Ian Pilcher <arequipeno-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Find i801 i2c_adapter in other module
Date: Thu, 21 Nov 2013 14:43:07 -0600
Message-ID: <l6lr8p$mlr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I have a Thecus N5550 NAS, on which I run CentOS 6.4.  I have created a
"board info" module which sets up the system's GPIOs and LEDs.

  https://github.com/ipilcher/n5550/blob/master/modules/n5550_board.c

Some of the LEDs are driven by a couple of NXP PCA9532 dimmers, which
are connected to the i801 SMBus.  I am currently hardcoding the bus
number, which is fragile.  If the drivers are loaded in a different
order, as they are on Debian, the bus gets a different number, and the
module doesn't work.

#define N5550_PCA9532_I2C_BUS		5

static int __init n5550_pca9532_setup(void)
{
	struct i2c_adapter *adapter;

	adapter = i2c_get_adapter(N5550_PCA9532_I2C_BUS);
	if (adapter == NULL) {
		return -ENOMEM;
	}

	n5550_pca9532_0_client = i2c_new_device(adapter, &n5550_pca9532_0_info);
	if (n5550_pca9532_0_client == NULL) {
		i2c_put_adapter(adapter);
		return -ENOMEM;
	}

	n5550_pca9532_1_client = i2c_new_device(adapter, &n5550_pca9532_1_info);
	if (n5550_pca9532_1_client == NULL) {
		i2c_unregister_device(n5550_pca9532_0_client);
		i2c_put_adapter(adapter);
		return -ENOMEM;
	}

	i2c_put_adapter(adapter);
	return 0;
}

What is the best way to get the correct i2c_adapter, either by driver
name or PCI address?

Thanks!

-- 
========================================================================
Ian Pilcher                                         arequipeno-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
           Sent from the cloud -- where it's already tomorrow
========================================================================
