From: Karl Hiramoto <karl-CSx8xFHsqFdg9hUCZPvPmw@public.gmane.org>
Subject: reading i2c eeprom early in boot
Date: Thu, 24 Jun 2010 12:19:07 +0200
Message-ID: <4C23311B.9090803@hiramoto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Hi,

My goal is to assign a MAC address stored in a I2C EEPROM to a ethernet device on an ARM  SOC so I can boot via NFS.  Reading and writing this address  works with the at24 driver after its loaded.

Currently the i2c __init call is after the ethernet devices __init, so this makes using the I2C drivers not possible, as nothing is instantiated.

So to me it looks like i have two options.

1.  Reorder the init calls.   I'd prefer not doing this for fear of  breaking something else.

2.  The I2C bus on my board is just using GPIO pins.     I could bit bang these pins before the i2c drivers are loaded, in the arch initcalls.   Are there any functions in the kernel to do this easily?  Like optimally some libary function in the kernel to do something like:

i2c_gpio_read(int sda_pin, int scl_pin, int i2c_address, int len, void *data)

This library function may need to  have to have a spinlock or mutex to avoid conflicts on these pins.



Is there  a better solution?

--
karl
