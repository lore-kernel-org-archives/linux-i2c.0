From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Subject: Re: [PATCH] i2c: Add support for Xilinx XPS IIC Bus Interface
Date: Wed, 23 Sep 2009 11:08:45 +0200
Message-ID: <4AB9E59D.3070503@mocean-labs.com>
References: <4AB785FB.4020806@mocean-labs.com> <20090923004158.GD24720@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090923004158.GD24720-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
> On Mon, Sep 21, 2009 at 03:56:11PM +0200, Richard R=F6jfors wrote:
>> This patch adds support for the Xilinx XPS IIC Bus Interface.
>>
>> The driver uses the dynamic mode, supporting to put several
>> I2C messages in the FIFO to reduce the number of interrupts.
>>
>> It has the same feature as ocores, it can be passed a list
>> of devices that will be added when the bus is probed.
>>
>> Signed-off-by: Richard R=F6jfors <richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
>> ---
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 8206442..6b291e8 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -433,6 +433,16 @@ config I2C_OCORES
>>  	  This driver can also be built as a module.  If so, the module
>>  	  will be called i2c-ocores.
>>
>> +config I2C_XILINX
>> +	tristate "Xilinx I2C Controller"
>> +	depends on EXPERIMENTAL && HAS_IOMEM
>> +	help
>> +	  If you say yes to this option, support will be included for the
>> +	  Xilinx I2C controller.
>> +
>> +	  This driver can also be built as a module.  If so, the module
>> +	  will be called xilinx_i2c.
>> +
>>  config I2C_OMAP
>>  	tristate "OMAP I2C adapter"
>>  	depends on ARCH_OMAP
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefi=
le
>> index e654263..a2ce5b8 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -40,6 +40,7 @@ obj-$(CONFIG_I2C_IXP2000)	+=3D i2c-ixp2000.o
>>  obj-$(CONFIG_I2C_MPC)		+=3D i2c-mpc.o
>>  obj-$(CONFIG_I2C_MV64XXX)	+=3D i2c-mv64xxx.o
>>  obj-$(CONFIG_I2C_OCORES)	+=3D i2c-ocores.o
>> +obj-$(CONFIG_I2C_XILINX)	+=3D i2c-xiic.o
>>  obj-$(CONFIG_I2C_OMAP)		+=3D i2c-omap.o
>>  obj-$(CONFIG_I2C_PASEMI)	+=3D i2c-pasemi.o
>>  obj-$(CONFIG_I2C_PNX)		+=3D i2c-pnx.o
>> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-=
xiic.c
>> new file mode 100644
>> index 0000000..7b1e618
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-xiic.c
>> @@ -0,0 +1,800 @@
>> +/*
>> + * i2c-xiic.c
>> + * Copyright (c) 2009 Intel Corporation
>=20
> is this the right copyirhgt entity?

Thanks for your feedback. Yes it is the right copyright, it's for Intel=
=2E

I agree with the rest of your comments and will come up with an updated=
 patch.

Thanks
--Richard
