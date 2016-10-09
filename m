From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCHv2] hwmon: Add tc654 driver
Date: Sun, 9 Oct 2016 21:21:23 +0000
Message-ID: <1ac8a0ec06864dcf855cfd1db1fa5980@svr-chch-ex1.atlnz.lc>
References: <20161006225702.GA9365@roeck-us.net>
 <20161007013845.10949-1-chris.packham@alliedtelesis.co.nz>
 <20161007182939.GA9031@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50975 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbcJIVVo (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 9 Oct 2016 17:21:44 -0400
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, Masahiko Iwamoto <iwamoto@allied-telesis.co.jp>, Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>, Kevin Tsai <ktsai@capellamicro.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

Hi Gunter,=0A=
=0A=
Thanks for the review. v3 on it's way some responses below.=0A=
=0A=
On 10/08/2016 07:29 AM, Guenter Roeck wrote:=0A=
> On Fri, Oct 07, 2016 at 02:38:44PM +1300, Chris Packham wrote:=0A=
>> Add support for the tc654 and tc655 fan controllers from Microchip.=0A=
>>=0A=
>> http://ww1.microchip.com/downloads/en/DeviceDoc/20001734C.pdf=0A=
>>=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>> ---=0A=
>>=0A=
>> Changes in v2:=0A=
>> - Add Documentation/hwmon/tc654=0A=
>> - Incorporate most of the review comments from Guenter. Additional error=
=0A=
>>   handling is added. Unused/unnecessary code is removed. I decided not=
=0A=
>>   to go down the regmap path yet. I may circle back to it when I look at=
=0A=
>>   using regmap in the adm9240 driver.=0A=
>>=0A=
>>  .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +=0A=
>>  Documentation/hwmon/tc654                          |  26 ++=0A=
>>  drivers/hwmon/Kconfig                              |  11 +=0A=
>>  drivers/hwmon/Makefile                             |   1 +=0A=
>>  drivers/hwmon/tc654.c                              | 513 ++++++++++++++=
+++++++=0A=
>>  5 files changed, 553 insertions(+)=0A=
>>  create mode 100644 Documentation/hwmon/tc654=0A=
>>  create mode 100644 drivers/hwmon/tc654.c=0A=
>>=0A=
>> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b=
/Documentation/devicetree/bindings/i2c/trivial-devices.txt=0A=
>> index 1416c6a0d2cd..833fb9f133d3 100644=0A=
>> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt=0A=
>> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt=0A=
>> @@ -122,6 +122,8 @@ microchip,mcp4662-502	Microchip 8-bit Dual I2C Digit=
al Potentiometer with NV Mem=0A=
>>  microchip,mcp4662-103	Microchip 8-bit Dual I2C Digital Potentiometer wi=
th NV Memory (10k)=0A=
>>  microchip,mcp4662-503	Microchip 8-bit Dual I2C Digital Potentiometer wi=
th NV Memory (50k)=0A=
>>  microchip,mcp4662-104	Microchip 8-bit Dual I2C Digital Potentiometer wi=
th NV Memory (100k)=0A=
>> +microchip,tc654		PWM Fan Speed Controller With Fan Fault Detection=0A=
>> +microchip,tc655		PWM Fan Speed Controller With Fan Fault Detection=0A=
>>  national,lm63		Temperature sensor with integrated fan control=0A=
>>  national,lm75		I2C TEMP SENSOR=0A=
>>  national,lm80		Serial Interface ACPI-Compatible Microprocessor System H=
ardware Monitor=0A=
>> diff --git a/Documentation/hwmon/tc654 b/Documentation/hwmon/tc654=0A=
>> new file mode 100644=0A=
>> index 000000000000..93796c5c7e79=0A=
>> --- /dev/null=0A=
>> +++ b/Documentation/hwmon/tc654=0A=
>> @@ -0,0 +1,26 @@=0A=
>> +Kernel driver tc654=0A=
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
>> +=0A=
>> +Supported chips:=0A=
>> +  * Microship TC654 and TC655=0A=
>> +    Prefix: 'tc654'=0A=
>> +    Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/20001734=
C.pdf=0A=
>> +=0A=
>> +Authors:=0A=
>> +        Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>> +        Masahiko Iwamoto <iwamoto@allied-telesis.co.jp>=0A=
>> +=0A=
>> +Description=0A=
>> +-----------=0A=
>> +This driver implements support for the Microchip TC654 and TC655.=0A=
>> +=0A=
>> +The TC654 used the 2-wire interface compatible with the SMBUS 2.0=0A=
>=0A=
> uses=0A=
>=0A=
=0A=
Done.=0A=
=0A=
>> +specification. The TC654 has two (2) inputs for measuring fan RPM and=
=0A=
>> +one (1) PWM output which can be used for fan control.=0A=
>> +=0A=
>> +Configuration Notes=0A=
>> +-------------------=0A=
>> +Ordinarily the pwm1_mode ABI is used for controlling the pwm output=0A=
>> +mode.  However, for this chip the output is always pwm, and the=0A=
>> +pwm1_mode determines if the pwm output is controlled via the pwm1 value=
=0A=
>> +or via the Vin analog input.=0A=
>=0A=
> Please describe the supported values here.=0A=
>=0A=
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig=0A=
>> index 45cef3d2c75c..8681bc65cde5 100644=0A=
>> --- a/drivers/hwmon/Kconfig=0A=
>> +++ b/drivers/hwmon/Kconfig=0A=
>> @@ -907,6 +907,17 @@ config SENSORS_MCP3021=0A=
>>  	  This driver can also be built as a module.  If so, the module=0A=
>>  	  will be called mcp3021.=0A=
>>=0A=
>> +config SENSORS_TC654=0A=
>> +	tristate "Microchip TC654/TC655 and compatibles"=0A=
>> +	depends on I2C=0A=
>> +	help=0A=
>> +	  If you say yes here you get support for TC654 and TC655.=0A=
>> +	  The TC654 and TC655 are PWM mode fan speed controllers with=0A=
>> +	  FanSense technology for use with brushless DC fans.=0A=
>> +=0A=
>> +	  This driver can also be built as a module.  If so, the module=0A=
>> +	  will be called tc654.=0A=
>> +=0A=
>>  config SENSORS_MENF21BMC_HWMON=0A=
>>  	tristate "MEN 14F021P00 BMC Hardware Monitoring"=0A=
>>  	depends on MFD_MENF21BMC=0A=
>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile=0A=
>> index aecf4ba17460..c651f0f1d047 100644=0A=
>> --- a/drivers/hwmon/Makefile=0A=
>> +++ b/drivers/hwmon/Makefile=0A=
>> @@ -122,6 +122,7 @@ obj-$(CONFIG_SENSORS_MAX6697)	+=3D max6697.o=0A=
>>  obj-$(CONFIG_SENSORS_MAX31790)	+=3D max31790.o=0A=
>>  obj-$(CONFIG_SENSORS_MC13783_ADC)+=3D mc13783-adc.o=0A=
>>  obj-$(CONFIG_SENSORS_MCP3021)	+=3D mcp3021.o=0A=
>> +obj-$(CONFIG_SENSORS_TC654)	+=3D tc654.o=0A=
>>  obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) +=3D menf21bmc_hwmon.o=0A=
>>  obj-$(CONFIG_SENSORS_NCT6683)	+=3D nct6683.o=0A=
>>  obj-$(CONFIG_SENSORS_NCT6775)	+=3D nct6775.o=0A=
>> diff --git a/drivers/hwmon/tc654.c b/drivers/hwmon/tc654.c=0A=
>> new file mode 100644=0A=
>> index 000000000000..cba31cbd3383=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/hwmon/tc654.c=0A=
>> @@ -0,0 +1,513 @@=0A=
>> +/*=0A=
>> + * tc654.c - Linux kernel modules for fan speed controller=0A=
>> + *=0A=
>> + * Copyright (C) 2016 Allied Telesis Labs NZ=0A=
>> + *=0A=
>> + * This program is free software; you can redistribute it and/or modify=
=0A=
>> + * it under the terms of the GNU General Public License as published by=
=0A=
>> + * the Free Software Foundation; either version 2 of the License, or=0A=
>> + * (at your option) any later version.=0A=
>> + *=0A=
>> + * This program is distributed in the hope that it will be useful,=0A=
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
>> + * GNU General Public License for more details.=0A=
>> + */=0A=
>> +=0A=
>=0A=
> #include <linux/bitops.h>=0A=
>=0A=
>> +#include <linux/module.h>=0A=
>> +#include <linux/init.h>=0A=
>> +#include <linux/slab.h>=0A=
>> +#include <linux/i2c.h>=0A=
>> +#include <linux/hwmon.h>=0A=
>> +#include <linux/hwmon-sysfs.h>=0A=
>> +#include <linux/err.h>=0A=
>> +#include <linux/mutex.h>=0A=
>> +#include <linux/jiffies.h>=0A=
>> +#include <linux/util_macros.h>=0A=
>=0A=
> Please order include files alphabetically.=0A=
>=0A=
=0A=
Done.=0A=
=0A=
>> +=0A=
>> +enum tc654_regs {=0A=
>> +	TC654_REG_RPM1 =3D 0x00,	/* RPM Output 1 */=0A=
>> +	TC654_REG_RPM2 =3D 0x01,	/* RPM Output 2 */=0A=
>> +	TC654_REG_FAN_FAULT1 =3D 0x02,	/* Fan Fault 1 Threshold */=0A=
>> +	TC654_REG_FAN_FAULT2 =3D 0x03,	/* Fan Fault 2 Threshold */=0A=
>> +	TC654_REG_CONFIG =3D 0x04,	/* Configuration */=0A=
>> +	TC654_REG_STATUS =3D 0x05,	/* Status */=0A=
>> +	TC654_REG_DUTY_CYCLE =3D 0x06,	/* Fan Speed Duty Cycle */=0A=
>> +	TC654_REG_MFR_ID =3D 0x07,	/* Manufacturer Identification */=0A=
>> +	TC654_REG_VER_ID =3D 0x08,	/* Version Identification */=0A=
>> +};=0A=
>> +=0A=
>> +/* Macros to easily index the registers */=0A=
>> +#define TC654_REG_RPM(idx) (TC654_REG_RPM1 + (idx))=0A=
>> +#define TC654_REG_FAN_FAULT(idx) (TC654_REG_FAN_FAULT1 + (idx))=0A=
>> +=0A=
>> +/* Config register bits */=0A=
>> +#define TC654_REG_CONFIG_RES 0x40	/* Resolution Selection */=0A=
>> +#define TC654_REG_CONFIG_DUTYC 0x20	/* Duty Cycle Control Method */=0A=
>> +#define TC654_REG_CONFIG_SDM 0x01	/* Shutdown Mode */=0A=
>> +=0A=
>> +/* Status register bits */=0A=
>> +#define TC654_REG_STATUS_F2F 0x02	/* Fan 2 Fault */=0A=
>> +#define TC654_REG_STATUS_F1F 0x01	/* Fan 1 Fault */=0A=
>> +=0A=
>=0A=
> Didn't notice earlier ... those are bits, so it would be better to use=0A=
> the BIT() macro.=0A=
>=0A=
>> +/* RPM resolution for RPM Output registers */=0A=
>> +#define TC654_HIGH_RPM_RESOLUTION 25	/* 25 RPM resolution */=0A=
>> +#define TC654_LOW_RPM_RESOLUTION 50	/* 50 RPM resolution */=0A=
>> +=0A=
>> +/* Convert to the fan fault RPM threshold from register value */=0A=
>> +#define TC654_FAN_FAULT_FROM_REG(val) ((val) * 50)	/* 50 RPM resolution=
 */=0A=
>> +=0A=
>> +/* Convert to register value from the fan fault RPM threshold */=0A=
>> +#define TC654_FAN_FAULT_TO_REG(val) (((val) / 50) & 0xff)=0A=
>> +=0A=
>> +/* Register data is read (and cached) at most once per second. */=0A=
>> +#define TC654_UPDATE_INTERVAL	HZ=0A=
>> +=0A=
>> +struct tc654_data {=0A=
>> +	struct i2c_client *client;=0A=
>> +	struct device *hwmon_dev;=0A=
>=0A=
> No longer needed. Just keep the variable local in the probe function.=0A=
>=0A=
>> +=0A=
>> +	/* update mutex */=0A=
>> +	struct mutex update_lock;=0A=
>> +=0A=
>> +	/* tc654 register cache */=0A=
>> +	bool valid;=0A=
>> +	unsigned long last_updated;	/* in jiffies */=0A=
>> +=0A=
>> +	u8 rpm_output[2];	/* The fan RPM data for fans 1 and 2 is then=0A=
>> +				 * written to registers RPM1 and RPM2=0A=
>> +				 */=0A=
>> +	u8 fan_fault[2];	/* The Fan Fault Threshold Registers are used to=0A=
>> +				 * set the fan fault threshold levels for fan 1=0A=
>> +				 * and fan 2=0A=
>> +				 */=0A=
>> +	u8 config;	/* The Configuration Register is an 8-bit read/=0A=
>> +			 * writable multi-function control register=0A=
>> +			 *   7: Fan Fault Clear=0A=
>> +			 *      1 =3D Clear Fan Fault=0A=
>> +			 *      0 =3D Normal Operation (default)=0A=
>> +			 *   6: Resolution Selection for RPM Output Registers=0A=
>> +			 *      RPM Output Registers (RPM1 and RPM2) will be=0A=
>> +			 *      set for=0A=
>> +			 *      1 =3D 25 RPM (9-bit) resolution=0A=
>> +			 *      0 =3D 50 RPM (8-bit) resolution (default)=0A=
>> +			 *   5: Duty Cycle Control Method=0A=
>> +			 *      The V OUT duty cycle will be controlled via=0A=
>> +			 *      1 =3D the SMBus interface.=0A=
>> +			 *      0 =3D via the V IN analog input pin. (default)=0A=
>> +			 * 4,3: Fan 2 Pulses Per Rotation=0A=
>> +			 *      00 =3D 1=0A=
>> +			 *      01 =3D 2 (default)=0A=
>> +			 *      10 =3D 4=0A=
>> +			 *      11 =3D 8=0A=
>> +			 * 2,1: Fan 1 Pulses Per Rotation=0A=
>> +			 *      00 =3D 1=0A=
>> +			 *      01 =3D 2 (default)=0A=
>> +			 *      10 =3D 4=0A=
>> +			 *      11 =3D 8=0A=
>> +			 *   0: Shutdown Mode=0A=
>> +			 *      1 =3D Shutdown mode.=0A=
>> +			 *      0 =3D Normal operation. (default)=0A=
>> +			 */=0A=
>> +	u8 status;	/* The Status register provides all the information=0A=
>> +			 * about what is going on within the TC654/TC655=0A=
>> +			 * devices.=0A=
>> +			 * 7,6: Unimplemented, Read as '0'=0A=
>> +			 *   5: Over-Temperature Fault Condition=0A=
>> +			 *      1 =3D Over-Temperature condition has occurred=0A=
>> +			 *      0 =3D Normal operation. V IN is less than 2.6V=0A=
>> +			 *   4: RPM2 Counter Overflow=0A=
>> +			 *      1 =3D Fault condition=0A=
>> +			 *      0 =3D Normal operation=0A=
>> +			 *   3: RPM1 Counter Overflow=0A=
>> +			 *      1 =3D Fault condition=0A=
>> +			 *      0 =3D Normal operation=0A=
>> +			 *   2: V IN Input Status=0A=
>> +			 *      1 =3D V IN is open=0A=
>> +			 *      0 =3D Normal operation. voltage present at V IN=0A=
>> +			 *   1: Fan 2 Fault=0A=
>> +			 *      1 =3D Fault condition=0A=
>> +			 *      0 =3D Normal operation=0A=
>> +			 *   0: Fan 1 Fault=0A=
>> +			 *      1 =3D Fault condition=0A=
>> +			 *      0 =3D Normal operation=0A=
>> +			 */=0A=
>> +	u8 duty_cycle;	/* The DUTY_CYCLE register is a 4-bit read/=0A=
>> +			 * writable register used to control the duty=0A=
>> +			 * cycle of the V OUT output.=0A=
>> +			 */=0A=
>> +};=0A=
>> +=0A=
>> +/* helper to grab and cache data, at most one time per second */=0A=
>> +static struct tc654_data *tc654_update_client(struct device *dev)=0A=
>> +{=0A=
>> +	struct tc654_data *data =3D dev_get_drvdata(dev);=0A=
>> +	struct i2c_client *client =3D data->client;=0A=
>> +	int ret =3D 0;=0A=
>> +=0A=
>> +	mutex_lock(&data->update_lock);=0A=
>> +	if (time_before(jiffies, data->last_updated + TC654_UPDATE_INTERVAL) &=
&=0A=
>> +	    likely(data->valid))=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	ret =3D i2c_smbus_read_byte_data(client, TC654_REG_RPM(0));=0A=
>> +	if (ret < 0)=0A=
>> +		goto out;=0A=
>> +	data->rpm_output[0] =3D ret;=0A=
>> +=0A=
>> +	ret =3D i2c_smbus_read_byte_data(client, TC654_REG_RPM(1));=0A=
>> +	if (ret < 0)=0A=
>> +		goto out;=0A=
>> +	data->rpm_output[1] =3D ret;=0A=
>> +=0A=
>> +	ret =3D i2c_smbus_read_byte_data(client, TC654_REG_FAN_FAULT(0));=0A=
>> +	if (ret < 0)=0A=
>> +		goto out;=0A=
>> +	data->fan_fault[0] =3D ret;=0A=
>> +=0A=
>> +	ret =3D i2c_smbus_read_byte_data(client, TC654_REG_FAN_FAULT(1));=0A=
>> +	if (ret < 0)=0A=
>> +		goto out;=0A=
>> +	data->fan_fault[1] =3D ret;=0A=
>> +=0A=
>> +	ret =3D i2c_smbus_read_byte_data(client, TC654_REG_CONFIG);=0A=
>> +	if (ret < 0)=0A=
>> +		goto out;=0A=
>> +	data->config =3D ret;=0A=
>> +=0A=
>> +	ret =3D i2c_smbus_read_byte_data(client, TC654_REG_STATUS);=0A=
>> +	if (ret < 0)=0A=
>> +		goto out;=0A=
>> +	data->status =3D ret;=0A=
>> +=0A=
>> +	ret =3D i2c_smbus_read_byte_data(client, TC654_REG_DUTY_CYCLE);=0A=
>> +	if (ret < 0)=0A=
>> +		goto out;=0A=
>> +	data->duty_cycle =3D ret;=0A=
>=0A=
> Maybe make it=0A=
> 	data->duty_cycle =3D ret & 0x0f;=0A=
>=0A=
> While that should not be necessary, it doesn't hurt, and the datasheet is=
n't=0A=
> entirely clear if the upper bits are guaranteed to be 0.=0A=
>=0A=
=0A=
Done.=0A=
=0A=
>> +=0A=
>> +	data->last_updated =3D jiffies;=0A=
>> +	data->valid =3D true;=0A=
>> +out:=0A=
>> +	mutex_unlock(&data->update_lock);=0A=
>> +=0A=
>> +	if (ret < 0)		/* upon error, encode it in return value */=0A=
>> +		data =3D ERR_PTR(ret);=0A=
>> +=0A=
>> +	return data;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * sysfs attributes=0A=
>> + */=0A=
>> +=0A=
>> +static ssize_t show_fan(struct device *dev, struct device_attribute *da=
,=0A=
>> +			char *buf)=0A=
>> +{=0A=
>> +	int nr =3D to_sensor_dev_attr(da)->index;=0A=
>> +	struct tc654_data *data =3D tc654_update_client(dev);=0A=
>> +	int val;=0A=
>> +=0A=
>> +	if (IS_ERR(data))=0A=
>> +		return PTR_ERR(data);=0A=
>> +=0A=
>> +	if (data->config & TC654_REG_CONFIG_RES)=0A=
>> +		val =3D data->rpm_output[nr] * TC654_HIGH_RPM_RESOLUTION;=0A=
>> +	else=0A=
>> +		val =3D data->rpm_output[nr] * TC654_LOW_RPM_RESOLUTION;=0A=
>> +=0A=
>> +	return sprintf(buf, "%d\n", val);=0A=
>> +}=0A=
>> +=0A=
>> +static ssize_t show_fan_min(struct device *dev, struct device_attribute=
 *da,=0A=
>> +			    char *buf)=0A=
>> +{=0A=
>> +	int nr =3D to_sensor_dev_attr(da)->index;=0A=
>> +	struct tc654_data *data =3D tc654_update_client(dev);=0A=
>> +=0A=
>> +	if (IS_ERR(data))=0A=
>> +		return PTR_ERR(data);=0A=
>> +=0A=
>> +	return sprintf(buf, "%d\n",=0A=
>> +		       TC654_FAN_FAULT_FROM_REG(data->fan_fault[nr]));=0A=
>> +}=0A=
>> +=0A=
>> +static ssize_t set_fan_min(struct device *dev, struct device_attribute =
*da,=0A=
>> +			   const char *buf, size_t count)=0A=
>> +{=0A=
>> +	int nr =3D to_sensor_dev_attr(da)->index;=0A=
>> +	struct tc654_data *data =3D dev_get_drvdata(dev);=0A=
>> +	struct i2c_client *client =3D data->client;=0A=
>> +	unsigned long val;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (kstrtoul(buf, 10, &val))=0A=
>> +		return -EINVAL;=0A=
>> +=0A=
>> +	clamp_val(val, 0, 12750);=0A=
>=0A=
> 	val =3D clamp_val(val, 0, 12750);=0A=
>> +=0A=
>> +	mutex_lock(&data->update_lock);=0A=
>> +=0A=
>> +	data->fan_fault[nr] =3D TC654_FAN_FAULT_TO_REG(val);=0A=
>> +	ret =3D i2c_smbus_write_byte_data(client, TC654_REG_FAN_FAULT(nr),=0A=
>> +				  data->fan_fault[nr]);=0A=
>=0A=
> Hmmm ... the reason for asking you to align continuation lines with '('=
=0A=
> is that it makes the code more uniform and helps me review it. I understa=
nd=0A=
> that people sometimes don't like it, but please keep in mind that it help=
s=0A=
> with the code review.=0A=
>=0A=
=0A=
Sorry about that. Didn't re-align when I added the 'ret =3D'.=0A=
=0A=
>> +=0A=
>> +	mutex_unlock(&data->update_lock);=0A=
>> +	return ret < 0 ? ret : count;=0A=
>> +}=0A=
>> +=0A=
>> +static ssize_t show_fan_alarm(struct device *dev, struct device_attribu=
te *da,=0A=
>> +			      char *buf)=0A=
>> +{=0A=
>> +	int nr =3D to_sensor_dev_attr(da)->index;=0A=
>> +	struct tc654_data *data =3D tc654_update_client(dev);=0A=
>> +	int val;=0A=
>> +=0A=
>> +	if (IS_ERR(data))=0A=
>> +		return PTR_ERR(data);=0A=
>> +=0A=
>> +	if (nr =3D=3D 0)=0A=
>> +		val =3D !!(data->status & TC654_REG_STATUS_F1F);=0A=
>> +	else=0A=
>> +		val =3D !!(data->status & TC654_REG_STATUS_F2F);=0A=
>> +=0A=
>> +	return sprintf(buf, "%d\n", val);=0A=
>> +}=0A=
>> +=0A=
>> +static const u8 TC654_FAN_PULSE_SHIFT[] =3D { 1, 3 };=0A=
>> +=0A=
>> +static ssize_t show_fan_pulses(struct device *dev, struct device_attrib=
ute *da,=0A=
>> +			      char *buf)=0A=
>> +{=0A=
>> +	int nr =3D to_sensor_dev_attr(da)->index;=0A=
>> +	struct tc654_data *data =3D tc654_update_client(dev);=0A=
>> +	u8 val;=0A=
>> +=0A=
>> +	if (IS_ERR(data))=0A=
>> +		return PTR_ERR(data);=0A=
>> +=0A=
>> +	val =3D BIT((data->config >> TC654_FAN_PULSE_SHIFT[nr]) & 0x03);=0A=
>> +	return sprintf(buf, "%d\n", val);=0A=
>> +}=0A=
>> +=0A=
>> +static ssize_t set_fan_pulses(struct device *dev, struct device_attribu=
te *da,=0A=
>> +			     const char *buf, size_t count)=0A=
>> +{=0A=
>> +	int nr =3D to_sensor_dev_attr(da)->index;=0A=
>> +	struct tc654_data *data =3D dev_get_drvdata(dev);=0A=
>> +	struct i2c_client *client =3D data->client;=0A=
>> +	u8 config;=0A=
>> +	unsigned long val;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (kstrtoul(buf, 10, &val))=0A=
>> +		return -EINVAL;=0A=
>> +=0A=
>> +	switch (val) {=0A=
>> +	case 1:=0A=
>> +		config =3D 0;=0A=
>> +		break;=0A=
>> +	case 2:=0A=
>> +		config =3D 1;=0A=
>> +		break;=0A=
>> +	case 4:=0A=
>> +		config =3D 2;=0A=
>> +		break;=0A=
>> +	case 8:=0A=
>> +		config =3D 3;=0A=
>> +		break;=0A=
>> +	default:=0A=
>> +		return -EINVAL;=0A=
>> +	}=0A=
>> +=0A=
>> +	mutex_lock(&data->update_lock);=0A=
>> +=0A=
>> +	data->config &=3D ~(0x03 << TC654_FAN_PULSE_SHIFT[nr]);=0A=
>> +	data->config |=3D (config << TC654_FAN_PULSE_SHIFT[nr]);=0A=
>> +	ret =3D i2c_smbus_write_byte_data(client, TC654_REG_CONFIG, data->conf=
ig);=0A=
>> +=0A=
>> +	mutex_unlock(&data->update_lock);=0A=
>> +	return ret < 0 ? ret : count;=0A=
>> +}=0A=
>> +=0A=
>> +static ssize_t show_pwm_mode(struct device *dev,=0A=
>> +			     struct device_attribute *da, char *buf)=0A=
>> +{=0A=
>> +	struct tc654_data *data =3D tc654_update_client(dev);=0A=
>> +=0A=
>> +	if (IS_ERR(data))=0A=
>> +		return PTR_ERR(data);=0A=
>> +=0A=
>> +	return sprintf(buf, "%d\n", data->config & TC654_REG_CONFIG_DUTYC);=0A=
>=0A=
> Should be=0A=
> 				!!(data->config & TC654_REG_CONFIG_DUTYC)=0A=
> otherwise it displays 0 or 32.=0A=
>=0A=
=0A=
Done.=0A=
=0A=
>> +}=0A=
>> +=0A=
>> +static ssize_t set_pwm_mode(struct device *dev,=0A=
>> +			    struct device_attribute *da,=0A=
>> +			    const char *buf, size_t count)=0A=
>> +{=0A=
>> +	struct tc654_data *data =3D dev_get_drvdata(dev);=0A=
>> +	struct i2c_client *client =3D data->client;=0A=
>> +	unsigned long val;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (kstrtoul(buf, 10, &val))=0A=
>> +		return -EINVAL;=0A=
>> +=0A=
>> +	if (val !=3D 0 && val !=3D 1)=0A=
>> +		return -EINVAL;=0A=
>> +=0A=
>> +	mutex_lock(&data->update_lock);=0A=
>> +=0A=
>> +	if (val)=0A=
>> +		data->config |=3D TC654_REG_CONFIG_DUTYC;=0A=
>> +	else=0A=
>> +		data->config &=3D ~TC654_REG_CONFIG_DUTYC;=0A=
>> +=0A=
>> +	ret =3D i2c_smbus_write_byte_data(client, TC654_REG_CONFIG, data->conf=
ig);=0A=
>> +=0A=
>> +	mutex_unlock(&data->update_lock);=0A=
>> +	return ret < 0 ? ret : count;=0A=
>> +}=0A=
>> +=0A=
>> +static const int tc654_pwm_map[16] =3D { 76, 88, 100, 112, 124, 141, 14=
7, 171,=0A=
>> +		183, 195, 207, 219, 231, 243, 255 };=0A=
>> +=0A=
>=0A=
> This lists 15 entries for an array of size 16, leaving the last entry=0A=
> at 0. Is there an entry missing ?=0A=
>=0A=
> Also, 141 yields 55.29%, which doesn't match the datasheet.=0A=
>=0A=
> I ended up spending some time to match the numbers:=0A=
>=0A=
> map	%	datasheet=0A=
> 76	29.8	30.0=0A=
> 88	34.5	34.67=0A=
> 100	39.21	39.33=0A=
> 112	43.92	44.0=0A=
> 124	48.62	48.67=0A=
> 141	55.29	53.33	off (136 would be 53.33%)=0A=
> 147	57.64	58.0	148 would be 58.03%=0A=
> ??	??	62.67	missing (160 would be 62.67%)=0A=
> 171	67.05	67.33	172 would be 67.45%=0A=
> 183	71.76	72.0	184 would be 72.15%=0A=
> 195	76.47	76.67=0A=
> 207	81.17	81.33=0A=
> 219	85.88	86.0=0A=
> 231	90.58	90.67=0A=
> 243	95.29	95.33=0A=
> 255	100	100=0A=
>=0A=
=0A=
Thanks for (re-)doing my math. I initially did these by hand so I'm not =0A=
surprised I missed one. I've put all the values through a spreadsheet =0A=
and used rounding to come up with the following=0A=
=0A=
map	%	datasheet=0A=
77	30.20%	30.00%=0A=
88	34.51%	34.67%=0A=
102	40.00%	39.93%=0A=
112	43.92%	44.00%=0A=
124	48.63%	48.67%=0A=
136	53.33%	53.33%=0A=
148	58.04%	58.00%=0A=
160	62.75%	62.67%=0A=
172	67.45%	67.33%=0A=
184	72.16%	72.00%=0A=
196	76.86%	76.67%=0A=
207	81.18%	81.33%=0A=
219	85.88%	86.00%=0A=
231	90.59%	90.67%=0A=
243	95.29%	95.33%=0A=
255	100.00%	100.00%=0A=
=0A=
Differences are due to rounding.=0A=
=0A=
>> +static ssize_t show_pwm(struct device *dev, struct device_attribute *da=
,=0A=
>> +			       char *buf)=0A=
>> +{=0A=
>> +	struct tc654_data *data =3D tc654_update_client(dev);=0A=
>> +	int pwm;=0A=
>> +=0A=
>> +	if (IS_ERR(data))=0A=
>> +		return PTR_ERR(data);=0A=
>> +=0A=
>> +	if (data->config & TC654_REG_CONFIG_SDM)=0A=
>> +		pwm =3D 0;=0A=
>> +	else=0A=
>> +		pwm =3D tc654_pwm_map[data->duty_cycle];=0A=
>> +=0A=
>> +	return sprintf(buf, "%d\n", pwm);=0A=
>> +}=0A=
>> +=0A=
>> +static ssize_t set_pwm(struct device *dev, struct device_attribute *da,=
=0A=
>> +			      const char *buf, size_t count)=0A=
>> +{=0A=
>> +	struct tc654_data *data =3D dev_get_drvdata(dev);=0A=
>> +	struct i2c_client *client =3D data->client;=0A=
>> +	unsigned long val;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (kstrtoul(buf, 10, &val))=0A=
>> +		return -EINVAL;=0A=
>> +	if (val > 255)=0A=
>> +		return -EINVAL;=0A=
>> +=0A=
>> +	if (val =3D=3D 0)=0A=
>> +		data->config |=3D TC654_REG_CONFIG_SDM;=0A=
>> +	else=0A=
>> +		data->config &=3D ~TC654_REG_CONFIG_SDM;=0A=
>> +=0A=
>> +	data->duty_cycle =3D find_closest(val, tc654_pwm_map,=0A=
>> +					ARRAY_SIZE(tc654_pwm_map));=0A=
>> +=0A=
>> +	mutex_lock(&data->update_lock);=0A=
>> +=0A=
>> +	ret =3D i2c_smbus_write_byte_data(client, TC654_REG_CONFIG, data->conf=
ig);=0A=
>> +	if (ret < 0)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	ret =3D i2c_smbus_write_byte_data(client, TC654_REG_DUTY_CYCLE,=0A=
>> +				  data->duty_cycle);=0A=
>> +	if (ret < 0)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +out:=0A=
>> +	mutex_unlock(&data->update_lock);=0A=
>> +	return ret < 0 ? ret : count;=0A=
>> +}=0A=
>> +=0A=
>> +static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);=0A=
>> +static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);=0A=
>> +static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min,=0A=
>> +			  set_fan_min, 0);=0A=
>> +static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min,=0A=
>> +			  set_fan_min, 1);=0A=
>> +static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0)=
;=0A=
>> +static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 1)=
;=0A=
>> +static SENSOR_DEVICE_ATTR(fan1_pulses, S_IWUSR | S_IRUGO, show_fan_puls=
es,=0A=
>> +			  set_fan_pulses, 0);=0A=
>> +static SENSOR_DEVICE_ATTR(fan2_pulses, S_IWUSR | S_IRUGO, show_fan_puls=
es,=0A=
>> +			  set_fan_pulses, 1);=0A=
>> +static SENSOR_DEVICE_ATTR(pwm1_mode, S_IWUSR | S_IRUGO,=0A=
>> +			  show_pwm_mode, set_pwm_mode, 0);=0A=
>> +static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm,=0A=
>> +			  set_pwm, 0);=0A=
>> +=0A=
>> +/* Driver data */=0A=
>> +static struct attribute *tc654_attrs[] =3D {=0A=
>> +	&sensor_dev_attr_fan1_input.dev_attr.attr,=0A=
>> +	&sensor_dev_attr_fan2_input.dev_attr.attr,=0A=
>> +	&sensor_dev_attr_fan1_min.dev_attr.attr,=0A=
>> +	&sensor_dev_attr_fan2_min.dev_attr.attr,=0A=
>> +	&sensor_dev_attr_fan1_alarm.dev_attr.attr,=0A=
>> +	&sensor_dev_attr_fan2_alarm.dev_attr.attr,=0A=
>> +	&sensor_dev_attr_fan1_pulses.dev_attr.attr,=0A=
>> +	&sensor_dev_attr_fan2_pulses.dev_attr.attr,=0A=
>> +	&sensor_dev_attr_pwm1_mode.dev_attr.attr,=0A=
>> +	&sensor_dev_attr_pwm1.dev_attr.attr,=0A=
>> +	NULL=0A=
>> +};=0A=
>> +=0A=
>> +ATTRIBUTE_GROUPS(tc654);=0A=
>> +=0A=
>> +/*=0A=
>> + * device probe and removal=0A=
>> + */=0A=
>> +=0A=
>> +static int tc654_probe(struct i2c_client *client,=0A=
>> +		       const struct i2c_device_id *id)=0A=
>> +{=0A=
>> +	struct device *dev =3D &client->dev;=0A=
>> +	struct tc654_data *data;=0A=
>> +=0A=
>> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA=
))=0A=
>> +		return -ENODEV;=0A=
>> +=0A=
>> +	data =3D devm_kzalloc(dev, sizeof(struct tc654_data), GFP_KERNEL);=0A=
>> +	if (!data)=0A=
>> +		return -ENOMEM;=0A=
>> +=0A=
>> +	data->client =3D client;=0A=
>> +	i2c_set_clientdata(client, data);=0A=
>=0A=
> No longer needed.=0A=
=0A=
Done.=0A=
=0A=
>=0A=
>> +	mutex_init(&data->update_lock);=0A=
>> +=0A=
>> +	data->hwmon_dev =3D=0A=
>> +	    devm_hwmon_device_register_with_groups(dev, client->name, data,=0A=
>> +						   tc654_groups);=0A=
>> +	if (IS_ERR(data->hwmon_dev))=0A=
>> +		return PTR_ERR(data->hwmon_dev);=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static const struct i2c_device_id tc654_id[] =3D {=0A=
>> +	{"tc654", 0},=0A=
>> +	{"tc655", 0},=0A=
>> +	{}=0A=
>> +};=0A=
>> +=0A=
>> +MODULE_DEVICE_TABLE(i2c, tc654_id);=0A=
>> +=0A=
>> +static struct i2c_driver tc654_driver =3D {=0A=
>> +	.driver =3D {=0A=
>> +		   .name =3D "tc654",=0A=
>> +		   .owner =3D THIS_MODULE,=0A=
>=0A=
> Not needed (see Julia's patch)=0A=
>=0A=
=0A=
Will incorporate those changes too.=0A=
=0A=
>> +		   },=0A=
>> +	.probe =3D tc654_probe,=0A=
>> +	.id_table =3D tc654_id,=0A=
>> +};=0A=
>> +=0A=
>> +module_i2c_driver(tc654_driver);=0A=
>> +=0A=
>> +MODULE_AUTHOR("Allied Telesis Labs");=0A=
>> +MODULE_DESCRIPTION("Microchip TC654/TC655 driver");=0A=
>> +MODULE_LICENSE("GPL");=0A=
>> --=0A=
>> 2.10.0.479.g7c56b16=0A=
>>=0A=
>=0A=
=0A=
