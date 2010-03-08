From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 1/1] i2c: Add support for Xilinx XPS IIC Bus	Interface
Date: Mon, 08 Mar 2010 13:43:58 -0800
Message-ID: <4B956F9E.8020304@oracle.com>
References: <4B94C951.6050703@pelagicore.com> <20100308150121.GW10014@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100308150121.GW10014-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, xtfeng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 03/08/10 07:01, Ben Dooks wrote:
> On Mon, Mar 08, 2010 at 10:54:25AM +0100, Richard R=F6jfors wrote:
>> Here is an updated patch due to build failure in linux-next.
>>
>> This patch also contains the header file that was missing in v3.
>=20
> Please just send what is missing, now the base is merged it is diffic=
ult
> to get it removed.

and sooner would be better than later since linus-mainline does not bui=
ld cleanly
due to this.

(more below)

>> diff --git a/include/linux/i2c-xiic.h b/include/linux/i2c-xiic.h
>> new file mode 100644
>> index 0000000..4f9f225
>> --- /dev/null
>> +++ b/include/linux/i2c-xiic.h
>> @@ -0,0 +1,43 @@
>> +/*
>> + * i2c-xiic.h
>> + * Copyright (c) 2009 Intel Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> + */
>> +
>> +/* Supports:
>> + * Xilinx IIC
>> + */
>> +
>> +#ifndef _LINUX_I2C_XIIC_H
>> +#define _LINUX_I2C_XIIC_H
>> +
>> +/**
>> + * struct xiic_i2c_platform_data - Platform data of the Xilinx I2C =
driver
>> + * @num_devices:	Number of devices that shall be added when the dri=
ver
>> + *			is probed.
>> + * @devices:		The actuall devices to add.

				    actual

>> + *
>> + * This purpose of this platform data struct is to be able to provi=
de a number
>> + * of devices that should be added to the I2C bus. The reason is th=
at sometimes
>> + * the I2C board info is not enough, a new PCI board can for instan=
ce be
>> + * plugged into a standard PC, and the bus number might be unknown =
at
>> + * early init time.
>> + */
>> +struct xiic_i2c_platform_data {
>> +	u8				num_devices;
>> +	struct i2c_board_info const	*devices;
>> +};
>> +
>> +#endif /* _LINUX_I2C_XIIC_H */


And it still needs this patch that I have sent since Feb. 04-2010:

---

=46rom: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Add header file to fix build error:

drivers/i2c/busses/i2c-xiic.c:493: error: implicit declaration of funct=
ion 'mdelay'

Signed-off-by: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/i2c/busses/i2c-xiic.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20100204.orig/drivers/i2c/busses/i2c-xiic.c
+++ linux-next-20100204/drivers/i2c/busses/i2c-xiic.c
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/errno.h>
+#include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
