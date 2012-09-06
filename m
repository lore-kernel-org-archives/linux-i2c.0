From: "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: multiple slave addresses for single I2C chip
Date: Thu, 6 Sep 2012 03:48:05 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88B93AC9@SHSMSX101.ccr.corp.intel.com>
References: <1AE640813FDE7649BE1B193DEA596E88B9367A@SHSMSX101.ccr.corp.intel.com>
 <20120905084018.464d72c8@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120905084018.464d72c8-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Thanks for your suggestions, I'll read the examples and documentations you mentioned.

Best regards/Lv Zheng

-----Original Message-----
From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Jean Delvare
Sent: Wednesday, September 05, 2012 2:40 PM
To: Zheng, Lv
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: multiple slave addresses for single I2C chip

Hi Lv,

On Wed, 5 Sep 2012 04:50:02 +0000, Zheng, Lv wrote:
> We are trying to drive some sensors on Linux. The sensors are connected to the board as I2C slaves.
> I noticed the i2c_board_info can be used to register i2c slaves for the embedded platforms.
> I noticed there's also "address_list" member in the i2c_driver which can be used to detect the I2C slaves.
> The first question is: Which one shall I use to draft my sensor codes?

Depends. If your sensor device has identification registers such that it can be easily and reliably detected, and it can only use a limited set of slave addresses, you can have its driver implement the detect method for automatic device discovery. I that case, the detection method should also go to the sensors-detect [1] user-space script. See drivers/hwmon/lm63.c for a simple example.

[1] http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

If there are no identification registers, implementing the detect driver method is not possible, and you have to rely on explicit I2C slave instantiation.

I invite you to read Documentation/i2c/instantiating-devices for a complete view of the available options. As a general rule, for sensor devices, we do our best to support auto-detection for devices which are commonly found on PC hardware. For devices which are mostly found on embedded devices, this isn't so useful, as the platform initialization code typically knows exactly what devices it expects.

> If i2c_board_info is used to register platform i2c slaves, there is another issue for me:
> One of the sensors has 2 slave addresses. I noticed only one slave address can be declared in one i2c_board_info.
> The second question is: Shall I register the sensor's resource using 2 i2c_board_info? By doing this, shall I draft a single .c file containing 2 "i2c_driver" for them?

No. You choose one I2C address which you consider the main address for the device, and in the driver's probe function, you request the extra
address(es) using i2c_new_dummy(). Here's a list of drivers doing that, which you can use as examples:
drivers/hwmon/smm665.c
drivers/hwmon/asb100.c
drivers/misc/eeprom/max6875.c
drivers/misc/eeprom/at24.c

--
Jean Delvare
--
To unsubscribe from this list: send the line "unsubscribe linux-i2c" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
