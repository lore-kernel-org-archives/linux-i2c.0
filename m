From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCHv1] hwmon: Add tc654 driver
Date: Thu, 6 Oct 2016 15:57:02 -0700
Message-ID: <20161006225702.GA9365@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Cc: linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iwamoto-sK/J6oeM9AhgKrQr38906+qrae++aQT8@public.gmane.org, Joshua.Scott-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org, Kevin Tsai <ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 07, 2016 at 10:36:47AM +1300, Chris Packham wrote:
> Add support for the tc654 and tc655 fan controllers from Microchip.
> 
> http://ww1.microchip.com/downloads/en/DeviceDoc/20001734C.pdf
> 
> Signed-off-by: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
> ---
> 
> Hi Gunter,
>     
> I realise this isn't using the new hwmon registration API. This is
> essentially a forward port from an older kernel. I can attempt a
> conversion as a follow up patch but I loose the ability to actually test
> the driver.
> 
No problem.

Can you send me a register dump for this chip ?

>  .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +
>  drivers/hwmon/Kconfig                              |  11 +
>  drivers/hwmon/Makefile                             |   1 +
>  drivers/hwmon/tc654.c                              | 532 +++++++++++++++++++++

Please also add Documentation/hwmon/tc654.

>  4 files changed, 546 insertions(+)
>  create mode 100644 drivers/hwmon/tc654.c
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 1416c6a0d2cd..833fb9f133d3 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -122,6 +122,8 @@ microchip,mcp4662-502	Microchip 8-bit Dual I2C Digital Potentiometer with NV Mem
>  microchip,mcp4662-103	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (10k)
>  microchip,mcp4662-503	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (50k)
>  microchip,mcp4662-104	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
> +microchip,tc654		PWM Fan Speed Controller With Fan Fault Detection
> +microchip,tc655		PWM Fan Speed Controller With Fan Fault Detection
>  national,lm63		Temperature sensor with integrated fan control
>  national,lm75		I2C TEMP SENSOR
>  national,lm80		Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 45cef3d2c75c..8681bc65cde5 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -907,6 +907,17 @@ config SENSORS_MCP3021
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called mcp3021.
>  
> +config SENSORS_TC654
> +	tristate "Microchip TC654/TC655 and compatibles"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for TC654 and TC655.
> +	  The TC654 and TC655 are PWM mode fan speed controllers with
> +	  FanSense technology for use with brushless DC fans.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called tc654.
> +
>  config SENSORS_MENF21BMC_HWMON
>  	tristate "MEN 14F021P00 BMC Hardware Monitoring"
>  	depends on MFD_MENF21BMC
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index aecf4ba17460..c651f0f1d047 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -122,6 +122,7 @@ obj-$(CONFIG_SENSORS_MAX6697)	+= max6697.o
>  obj-$(CONFIG_SENSORS_MAX31790)	+= max31790.o
>  obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
>  obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
> +obj-$(CONFIG_SENSORS_TC654)	+= tc654.o
>  obj-$(CONFIG_SENSORS_MENF21BMC_HWMON) += menf21bmc_hwmon.o
>  obj-$(CONFIG_SENSORS_NCT6683)	+= nct6683.o
>  obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
> diff --git a/drivers/hwmon/tc654.c b/drivers/hwmon/tc654.c
> new file mode 100644
> index 000000000000..31e5f065183f
> --- /dev/null
> +++ b/drivers/hwmon/tc654.c
> @@ -0,0 +1,532 @@
> +/*
> + * tc654.c - Linux kernel modules for fan speed controller
> + *
> + * Copyright (C) 2016 Allied Telesis Labs NZ
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/jiffies.h>
> +#include <linux/util_macros.h>
> +
> +enum tc654_regs {
> +	TC654_REG_RPM1 = 0x00,	/* RPM Output 1 */
> +	TC654_REG_RPM2 = 0x01,	/* RPM Output 2 */
> +	TC654_REG_FAN_FAULT1 = 0x02,	/* Fan Fault 1 Threshold */
> +	TC654_REG_FAN_FAULT2 = 0x03,	/* Fan Fault 2 Threshold */
> +	TC654_REG_CONFIG = 0x04,	/* Configuration */
> +	TC654_REG_STATUS = 0x05,	/* Status */
> +	TC654_REG_DUTY_CYCLE = 0x06,	/* Fan Speed Duty Cycle */
> +	TC654_REG_MFR_ID = 0x07,	/* Manufacturer Identification */
> +	TC654_REG_VER_ID = 0x08,	/* Version Identification */
> +};
> +
> +/* Macros to easily index the registers */
> +#define TC654_REG_RPM(idx) (TC654_REG_RPM1 + (idx))
> +#define TC654_REG_FAN_FAULT(idx) (TC654_REG_FAN_FAULT1 + (idx))
> +
> +/* Config register bits */
> +#define TC654_REG_CONFIG_FFCLR 0x80	/* Fan Fault Clear */
> +#define TC654_REG_CONFIG_RES 0x40	/* Resolution Selection */
> +#define TC654_REG_CONFIG_DUTYC 0x20	/* Duty Cycle Control Method */
> +#define TC654_REG_CONFIG_F2PPR 0x18	/* Fan 2 Pulses Per Rotation */
> +#define TC654_REG_CONFIG_F1PPR 0x06	/* Fan 1 Pulses Per Rotation */
> +#define TC654_REG_CONFIG_SDM 0x01	/* Shutdown Mode */
> +
> +/* Status register bits */
> +#define TC654_REG_STATUS_OTF 0x20	/* Over-Temperature Fault Condition */
> +#define TC654_REG_STATUS_R2CO 0x10	/* RPM2 Counter Overflow */
> +#define TC654_REG_STATUS_R1CO 0x08	/* RPM1 Counter Overflow */
> +#define TC654_REG_STATUS_VSTAT 0x04	/* V IN Input Status */
> +#define TC654_REG_STATUS_F2F 0x02	/* Fan 2 Fault */
> +#define TC654_REG_STATUS_F1F 0x01	/* Fan 1 Fault */
> +

Many of those defines are not used. Please drop the unused ones
(or use them).

> +/* RPM resolution for RPM Output registers */
> +#define TC654_HIGH_RPM_RESOLUTION 25	/* 25 RPM resolution */
> +#define TC654_LOW_RPM_RESOLUTION 50	/* 50 RPM resolution */
> +
> +/* Convert to the fan fault RPM threshold from register value */
> +#define TC654_FAN_FAULT_FROM_REG(val) ((val) * 50)	/* 50 RPM resolution */
> +
> +/* Convert to register value from the fan fault RPM threshold */
> +#define TC654_FAN_FAULT_TO_REG(val) (((val) / 50) & 0xff)
> +
> +/* Register data is read (and cached) at most once per second. */
> +#define TC654_UPDATE_INTERVAL	HZ
> +
Another possibility would be to use regmap and let it cache the
static registers.

> +struct tc654_data {
> +	struct i2c_client *client;
> +	struct device *hwmon_dev;
> +
> +	/* update mutex */
> +	struct mutex update_lock;
> +
> +	/* tc654 register cache */
> +	bool valid;
> +	unsigned long last_updated;	/* in jiffies */
> +
> +	u8 rpm_output[2];	/* The fan RPM data for fans 1 and 2 is then
> +				 * written to registers RPM1 and RPM2
> +				 */
> +	u8 fan_fault[2];	/* The Fan Fault Threshold Registers are used to
> +				 * set the fan fault threshold levels for fan 1
> +				 * and fan 2
> +				 */
> +	u8 config;	/* The Configuration Register is an 8-bit read/
> +			 * writable multi-function control register
> +			 *   7: Fan Fault Clear
> +			 *      1 = Clear Fan Fault
> +			 *      0 = Normal Operation (default)
> +			 *   6: Resolution Selection for RPM Output Registers
> +			 *      RPM Output Registers (RPM1 and RPM2) will be
> +			 *      set for
> +			 *      1 = 25 RPM (9-bit) resolution
> +			 *      0 = 50 RPM (8-bit) resolution (default)
> +			 *   5: Duty Cycle Control Method
> +			 *      The V OUT duty cycle will be controlled via
> +			 *      1 = the SMBus interface.
> +			 *      0 = via the V IN analog input pin. (default)
> +			 * 4,3: Fan 2 Pulses Per Rotation
> +			 *      00 = 1
> +			 *      01 = 2 (default)
> +			 *      10 = 4
> +			 *      11 = 8
> +			 * 2,1: Fan 1 Pulses Per Rotation
> +			 *      00 = 1
> +			 *      01 = 2 (default)
> +			 *      10 = 4
> +			 *      11 = 8
> +			 *   0: Shutdown Mode
> +			 *      1 = Shutdown mode.
> +			 *      0 = Normal operation. (default)
> +			 */
> +	u8 status;	/* The Status register provides all the information
> +			 * about what is going on within the TC654/TC655
> +			 * devices.
> +			 * 7,6: Unimplemented, Read as '0'
> +			 *   5: Over-Temperature Fault Condition
> +			 *      1 = Over-Temperature condition has occurred
> +			 *      0 = Normal operation. V IN is less than 2.6V
> +			 *   4: RPM2 Counter Overflow
> +			 *      1 = Fault condition
> +			 *      0 = Normal operation
> +			 *   3: RPM1 Counter Overflow
> +			 *      1 = Fault condition
> +			 *      0 = Normal operation
> +			 *   2: V IN Input Status
> +			 *      1 = V IN is open
> +			 *      0 = Normal operation. voltage present at V IN
> +			 *   1: Fan 2 Fault
> +			 *      1 = Fault condition
> +			 *      0 = Normal operation
> +			 *   0: Fan 1 Fault
> +			 *      1 = Fault condition
> +			 *      0 = Normal operation
> +			 */
> +	u8 duty_cycle;	/* The DUTY_CYCLE register is a 4-bit read/
> +			 * writable register used to control the duty
> +			 * cycle of the V OUT output.
> +			 */
> +};
> +
> +/* helper to grab and cache data, at most one time per second */
> +static struct tc654_data *tc654_update_client(struct device *dev)
> +{
> +	struct tc654_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
> +	int ret = 0;
> +
> +	mutex_lock(&data->update_lock);
> +	if (time_before(jiffies, data->last_updated + TC654_UPDATE_INTERVAL) &&
> +	    likely(data->valid))
> +		goto out;
> +
> +	ret = i2c_smbus_read_byte_data(client, TC654_REG_RPM(0));
> +	if (ret < 0)
> +		goto out;
> +	data->rpm_output[0] = ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, TC654_REG_RPM(1));
> +	if (ret < 0)
> +		goto out;
> +	data->rpm_output[1] = ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, TC654_REG_FAN_FAULT(0));
> +	if (ret < 0)
> +		goto out;
> +	data->fan_fault[0] = ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, TC654_REG_FAN_FAULT(1));
> +	if (ret < 0)
> +		goto out;
> +	data->fan_fault[1] = ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, TC654_REG_CONFIG);
> +	if (ret < 0)
> +		goto out;
> +	data->config = ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, TC654_REG_STATUS);
> +	if (ret < 0)
> +		goto out;
> +	data->status = ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, TC654_REG_DUTY_CYCLE);
> +	if (ret < 0)
> +		goto out;
> +	data->duty_cycle = ret;
> +
> +	data->last_updated = jiffies;
> +	data->valid = true;
> +out:
> +	mutex_unlock(&data->update_lock);
> +
> +	if (ret < 0)		/* upon error, encode it in return value */
> +		data = ERR_PTR(ret);
> +
> +	return data;
> +}
> +
> +/*
> + * sysfs attributes
> + */
> +
> +static ssize_t show_fan(struct device *dev, struct device_attribute *da,
> +			char *buf)
> +{
> +	int nr = to_sensor_dev_attr(da)->index;
> +	struct tc654_data *data = tc654_update_client(dev);
> +	int val;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	if (data->config & TC654_REG_CONFIG_RES)
> +		val = data->rpm_output[nr] * TC654_HIGH_RPM_RESOLUTION;
> +	else
> +		val = data->rpm_output[nr] * TC654_LOW_RPM_RESOLUTION;
> +
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t show_fan_min(struct device *dev, struct device_attribute *da,
> +			    char *buf)
> +{
> +	int nr = to_sensor_dev_attr(da)->index;
> +	struct tc654_data *data = tc654_update_client(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	return sprintf(buf, "%d\n",
> +		       TC654_FAN_FAULT_FROM_REG(data->fan_fault[nr]));
> +}
> +
> +static ssize_t set_fan_min(struct device *dev, struct device_attribute *da,
> +			   const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(da)->index;
> +	struct tc654_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
> +	long val;
> +
> +	if (kstrtol(buf, 10, &val))
> +		return -EINVAL;
kstrtoul ?

> +	if (val < 0 || val > 255)

It would be better to use clamp_val() here.

Is that really the speed in rpm (0 .. 255) ? Seems unlikely.
Looking into the code, the limit should probably be 255 * 50.

> +		return -EINVAL;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	data->fan_fault[nr] = TC654_FAN_FAULT_TO_REG(val);
> +	i2c_smbus_write_byte_data(client, TC654_REG_FAN_FAULT(nr),
> +				  data->fan_fault[nr]);
> +

Error check (here and elsewhere) ?

> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t show_fan_alarm(struct device *dev, struct device_attribute *da,
> +			      char *buf)
> +{
> +	int nr = to_sensor_dev_attr(da)->index;
> +	struct tc654_data *data = tc654_update_client(dev);
> +	int val;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	if (nr == 0)
> +		val = (data->status & TC654_REG_STATUS_F1F) ? 1 : 0;

		val = !!(data->status & TC654_REG_STATUS_F1F);

> +	else
> +		val = (data->status & TC654_REG_STATUS_F2F) ? 1 : 0;
> +
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static const u8 TC654_FAN_PULSE_SHIFT[] = { 1, 3 };
> +
> +static ssize_t show_fan_pulses(struct device *dev, struct device_attribute *da,
> +			      char *buf)
> +{
> +	int nr = to_sensor_dev_attr(da)->index;
> +	struct tc654_data *data = tc654_update_client(dev);
> +	u8 val;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	val = (1 << ((data->config >> TC654_FAN_PULSE_SHIFT[nr]) & 0x03));

Extra ( ). Also, you could use BIT() here.

> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t set_fan_pulses(struct device *dev, struct device_attribute *da,
> +			     const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(da)->index;
> +	struct tc654_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
> +	u8 config;
> +	long val;
> +
> +	if (kstrtol(buf, 10, &val))
> +		return -EINVAL;
> +
> +	switch (val) {
> +	case 1:
> +		config = 0;
> +		break;
> +	case 2:
> +		config = 1;
> +		break;
> +	case 4:
> +		config = 2;
> +		break;
> +	case 8:
> +		config = 3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&data->update_lock);
> +
> +	data->config &= ~(0x03 << TC654_FAN_PULSE_SHIFT[nr]);
> +	data->config |= (config << TC654_FAN_PULSE_SHIFT[nr]);
> +	i2c_smbus_write_byte_data(client, TC654_REG_CONFIG, data->config);
> +
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t show_pwm_mode(struct device *dev,
> +				       struct device_attribute *da, char *buf)

Please align continuation lines with '('.

> +{
> +	struct tc654_data *data = tc654_update_client(dev);
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	return sprintf(buf, "%d\n", data->config & TC654_REG_CONFIG_DUTYC);
> +}
> +
> +static ssize_t set_pwm_mode(struct device *dev,
> +				      struct device_attribute *da,
> +				      const char *buf, size_t count)
> +{
> +	struct tc654_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
> +	long val;
> +
> +	if (kstrtol(buf, 10, &val))

kstrtoul ?

> +		return -EINVAL;
> +
> +	if (val != 0 && val != 1)
> +
The error return is missing here.

> +	mutex_lock(&data->update_lock);
> +
> +	if (val)
> +		data->config |= TC654_REG_CONFIG_DUTYC;
> +	else
> +		data->config &= ~TC654_REG_CONFIG_DUTYC;
> +
This is different to the intended ABI. The ABI expects the _output_ to be
configured with this attribute. However, for this chip the output is always
pwm, and the bit determines if the pwm output is controlled via register
or via the Vin analog input.

It is ok with me, but it should be documented.

> +	i2c_smbus_write_byte_data(client, TC654_REG_CONFIG, data->config);
> +
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +static const int tc654_pwm_map[16] = { 76, 88, 100, 112, 124, 141, 147, 171,
> +		183, 195, 207, 219, 231, 243, 255 };
> +
> +static ssize_t show_pwm(struct device *dev, struct device_attribute *da,
> +			       char *buf)
> +{
> +	struct tc654_data *data = tc654_update_client(dev);
> +	int pwm;
> +
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	if (data->config & TC654_REG_CONFIG_SDM)
> +		pwm = 0;
> +	else
> +		pwm = tc654_pwm_map[data->duty_cycle];
> +
> +	return sprintf(buf, "%d\n", pwm);
> +}
> +
> +static ssize_t set_pwm(struct device *dev, struct device_attribute *da,
> +			      const char *buf, size_t count)
> +{
> +	struct tc654_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
> +	long val;
> +
> +	if (kstrtol(buf, 10, &val))

kstrtoul ?

> +		return -EINVAL;
> +
> +	val = clamp_val(val, 0, 255);

Please use strict value checking here. pwm value range is well defined.

> +
> +	if (val == 0)
> +		data->config |= TC654_REG_CONFIG_SDM;
> +	else
> +		data->config &= ~TC654_REG_CONFIG_SDM;
> +
> +	data->duty_cycle = find_closest(val, tc654_pwm_map,
> +					ARRAY_SIZE(tc654_pwm_map));
> +
> +	mutex_lock(&data->update_lock);
> +
> +	i2c_smbus_write_byte_data(client, TC654_REG_CONFIG, data->config);
> +
> +	i2c_smbus_write_byte_data(client, TC654_REG_DUTY_CYCLE,
> +				  data->duty_cycle);
> +
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
> +static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
> +static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min,
> +			  set_fan_min, 0);
> +static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min,
> +			  set_fan_min, 1);
> +static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0);
> +static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 1);
> +static SENSOR_DEVICE_ATTR(fan1_pulses, S_IWUSR | S_IRUGO, show_fan_pulses,
> +			  set_fan_pulses, 0);
> +static SENSOR_DEVICE_ATTR(fan2_pulses, S_IWUSR | S_IRUGO, show_fan_pulses,
> +			  set_fan_pulses, 1);
> +static SENSOR_DEVICE_ATTR(pwm1_mode, S_IWUSR | S_IRUGO,
> +			  show_pwm_mode, set_pwm_mode, 0);
> +static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm,
> +			  set_pwm, 0);
> +
> +/* Driver data */
> +static struct attribute *tc654_attrs[] = {
> +	&sensor_dev_attr_fan1_input.dev_attr.attr,
> +	&sensor_dev_attr_fan2_input.dev_attr.attr,
> +	&sensor_dev_attr_fan1_min.dev_attr.attr,
> +	&sensor_dev_attr_fan2_min.dev_attr.attr,
> +	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
> +	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
> +	&sensor_dev_attr_fan1_pulses.dev_attr.attr,
> +	&sensor_dev_attr_fan2_pulses.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_mode.dev_attr.attr,
> +	&sensor_dev_attr_pwm1.dev_attr.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(tc654);
> +
> +/*
> + * device probe and removal
> + */
> +
> +static int tc654_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct tc654_data *data;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -ENODEV;
> +
> +	data = devm_kzalloc(dev, sizeof(struct tc654_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->client = client;
> +	i2c_set_clientdata(client, data);
> +	mutex_init(&data->update_lock);
> +
> +	data->hwmon_dev =
> +	    hwmon_device_register_with_groups(dev, client->name, data,
> +					      tc654_groups);

Please use the devm_ function (and you can drop the remove function).

> +	if (IS_ERR(data->hwmon_dev))
> +		return PTR_ERR(data->hwmon_dev);
> +
> +	dev_info(dev, "%s: sensor '%s'\n",
> +		 dev_name(data->hwmon_dev), client->name);

dev_info() already displays the device name.

> +
> +	return 0;
> +}
> +
> +static int tc654_remove(struct i2c_client *client)
> +{
> +	struct tc654_data *data = i2c_get_clientdata(client);
> +
> +	hwmon_device_unregister(data->hwmon_dev);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id tc654_dt_match[] = {
> +	{.compatible = "microchip,tc654"},
> +	{.compatible = "microchip,tc655"},
> +	{},
> +};
> +#endif
> +
Not needed.

> +static const struct i2c_device_id tc654_id[] = {
> +	{"tc654", 0},
> +	{"tc655", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, tc654_id);
> +
> +static struct i2c_driver tc654_driver = {
> +	.driver = {
> +		   .name = "tc654",
> +		   .owner = THIS_MODULE,
> +		   .of_match_table = of_match_ptr(tc654_dt_match),

Not needed.

> +		   },
> +	.probe = tc654_probe,
> +	.remove = tc654_remove,
> +	.id_table = tc654_id,
> +};
> +
> +module_i2c_driver(tc654_driver);
> +
> +MODULE_AUTHOR("Allied Telesis Labs");
> +MODULE_DESCRIPTION("Microchip TC654/TC655 driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.10.0.479.g7c56b16
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
