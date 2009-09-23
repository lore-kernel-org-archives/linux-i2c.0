From: =?ISO-8859-15?Q?Richard_R=F6jfors?=
	<richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Subject: Re: [PATCH v2] i2c: Add support for Xilinx XPS IIC Bus Interface
Date: Wed, 23 Sep 2009 14:40:28 +0200
Message-ID: <4ABA173C.90108@mocean-labs.com>
References: <4ABA07F4.5090108@mocean-labs.com> <20090923143132.7962dd62@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090923143132.7962dd62-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
>>  config I2C_OMAP
>>  	tristate "OMAP I2C adapter"
>>  	depends on ARCH_OMAP
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index e654263..a2ce5b8 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -40,6 +40,7 @@ obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
>>  obj-$(CONFIG_I2C_MPC)		+= i2c-mpc.o
>>  obj-$(CONFIG_I2C_MV64XXX)	+= i2c-mv64xxx.o
>>  obj-$(CONFIG_I2C_OCORES)	+= i2c-ocores.o
>> +obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
>>  obj-$(CONFIG_I2C_OMAP)		+= i2c-omap.o
>>  obj-$(CONFIG_I2C_PASEMI)	+= i2c-pasemi.o
>>  obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
> 
> You have an interesting notion of alphabetical order.

:-)

New patch on its way...

--Richard
