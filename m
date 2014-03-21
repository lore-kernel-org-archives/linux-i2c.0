From: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH V1 1/1] iio: add Capella cm3218x ambient light sensor
 driver.
Date: Fri, 21 Mar 2014 15:21:53 -0700
Message-ID: <532CBB81.1020402@linux.intel.com>
References: <1395179466-15821-1-git-send-email-ktsai@capellamicro.com> <alpine.DEB.2.01.1403191839450.3673@pmeerw.net> <7D691FFF49054FE789F96385397328D2@GustyD430> <0278b8cc-890e-47c4-9a66-93c9cd2f25c3@email.android.com> <532B7795.9020005@linux.intel.com> <324448b1-e8a5-43e2-a0eb-7fd848de6699@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <324448b1-e8a5-43e2-a0eb-7fd848de6699-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kevin Tsai <ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 03/21/2014 03:05 PM, Jonathan Cameron wrote:
>
> On March 20, 2014 11:19:49 PM GMT+00:00, Srinivas Pandruvada <sriniva=
s.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>> On 03/19/2014 11:54 PM, Jonathan Cameron wrote:
>>> On March 20, 2014 12:58:02 AM GMT+00:00, Kevin Tsai
>> <ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org> wrote:
>>>> Hi Peter,
>>>>
>>>> Thanks for your advise.  I'll update my code.
>>>>
>>>> ACPI is optional.  Most PC manufactory may store the lens factor t=
o
>>>> ACPI
>>>> table.  But, phone customers like to modify the parameters inside
>> code.
>>>> CM3218 have two versions.  The old version need to read SMBus ARA
>>>> register
>>>> to clean interrupt.  That's why I need to change I2C chip address.
>>>> Please
>>>> guid me if you have a better way to access two addresses.
>>> Would the smbus alert infrastructure in drivers/i2=C3=A7/i2c-smbus.=
c help?
>> The smbus alert notification are based on the underlying i2c
>> controller.
>> Not every controller supports. I can see only one controller driver =
in
>> the upstream Linux added this support.
> To my mind adding wider support for the alert functionality will be t=
he way forward.
>
> Wolfram, any idea why so few bus drivers implement the smbus alert st=
uff? I would
>   guess you won't be against wider support of this using existing inf=
rastructure?
SMALRT is a physical pin connection. Most of the i2C controlleron X86=20
will have no option to connect
SMALRT signal. So may be we need a common API to read instead, to read=20
and get status.

Thanks,
Srinivas

>> Thanks,
>> Srinivas
>>
>>>> Thanks.
>>>>
>>>> Kevin Tsai
>>>> 03/19/14
>>>>
>>>> ----- Original Message -----
>>>> From: "Peter Meerwald" <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
>>>> To: "Kevin Tsai" <ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org>
>>>> Cc: "Jonathan Cameron" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>;
>> <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>>>> Sent: Wednesday, March 19, 2014 11:07
>>>> Subject: Re: [PATCH V1 1/1] iio: add Capella cm3218x ambient light
>>>> sensor
>>>> driver.
>>>>
>>>>
>>>>>> Add Capella Microsystem CM3218x family Ambient Light Sensor IIO
>>>> driver.
>>>>>> This driver will convert raw data to lux value.  Default
>> parameters
>>>> are
>>>>>> for reference only.  It will detect ACPI table to load per-syste=
m
>>>>>> manufacturing
>>>>>> parameters.
>>>>> nitpicking below
>>>>>
>>>>>> ---
>>>>>>    .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>>>>>>    drivers/iio/light/Kconfig                          |  11 +
>>>>>>    drivers/iio/light/Makefile                         |   1 +
>>>>>>    drivers/iio/light/cm3218x.c                        | 769
>>>>>> +++++++++++++++++++++
>>>>>>    4 files changed, 782 insertions(+)
>>>>>>    create mode 100644 drivers/iio/light/cm3218x.c
>>>>>>
>>>>>> diff --git
>>>> a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>>>>>> b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>>>>>> index 1a1ac2e..29e7eae 100644
>>>>>> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>>>>>> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>>>>>> @@ -17,6 +17,7 @@ at,24c08 i2c serial eeprom  (24cxx)
>>>>>>    atmel,24c02 i2c serial eeprom  (24cxx)
>>>>>>    atmel,at97sc3204t i2c trusted platform module (TPM)
>>>>>>    capella,cm32181 CM32181: Ambient Light Sensor
>>>>>> +capella,cm3218x CM3218x: Ambient Light Sensor
>>>>>>    catalyst,24c32 i2c serial eeprom
>>>>>>    dallas,ds1307 64 x 8, Serial, I2C Real-Time Clock
>>>>>>    dallas,ds1338 I2C RTC with 56-Byte NV RAM
>>>>>> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconf=
ig
>>>>>> index d12b2a0..45a22a6 100644
>>>>>> --- a/drivers/iio/light/Kconfig
>>>>>> +++ b/drivers/iio/light/Kconfig
>>>>>> @@ -38,6 +38,17 @@ config CM32181
>>>>>>    To compile this driver as a module, choose M here:
>>>>>>    the module will be called cm32181.
>>>>>>
>>>>>> +config CM3218X
>>>>>> + depends on I2C
>>>>> is there an ACPI dependency?
>>>>>
>>>>>> + tristate "CM3218x driver"
>>>>>> + help
>>>>>> + Say Y here if you use cm3218x.
>>>>>> + This option enables ambient light sensor using
>>>>>> + Capella cm3218x device driver.
>>>>>> +
>>>>>> + To compile this driver as a module, choose M here:
>>>>>> + the module will be called cm3218x.
>>>>>> +
>>>>>>    config CM36651
>>>>>>    depends on I2C
>>>>>>    tristate "CM36651 driver"
>>>>>> diff --git a/drivers/iio/light/Makefile
>> b/drivers/iio/light/Makefile
>>>>>> index 60e35ac..a506c23 100644
>>>>>> --- a/drivers/iio/light/Makefile
>>>>>> +++ b/drivers/iio/light/Makefile
>>>>>> @@ -6,6 +6,7 @@
>>>>>>    obj-$(CONFIG_ADJD_S311) +=3D adjd_s311.o
>>>>>>    obj-$(CONFIG_APDS9300) +=3D apds9300.o
>>>>>>    obj-$(CONFIG_CM32181) +=3D cm32181.o
>>>>>> +obj-$(CONFIG_CM3218X) +=3D cm3218x.o
>>>>>>    obj-$(CONFIG_CM36651) +=3D cm36651.o
>>>>>>    obj-$(CONFIG_GP2AP020A00F) +=3D gp2ap020a00f.o
>>>>>>    obj-$(CONFIG_HID_SENSOR_ALS) +=3D hid-sensor-als.o
>>>>>> diff --git a/drivers/iio/light/cm3218x.c
>>>> b/drivers/iio/light/cm3218x.c
>>>>>> new file mode 100644
>>>>>> index 0000000..e422f68
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/iio/light/cm3218x.c
>>>>>> @@ -0,0 +1,769 @@
>>>>>> +/*
>>>>>> + * Copyright (C) 2014 Capella Microsystems Inc.
>>>>>> + * Author: Kevin Tsai <ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org>
>>>>>> + *
>>>>>> + * This program is free software; you can redistribute it and/o=
r
>>>> modify
>>>>>> it
>>>>>> + * under the terms of the GNU General Public License version 2,
>> as
>>>>>> published
>>>>>> + * by the Free Software Foundation.
>>>>>> + *
>>>>>> + * Special thanks Srinivas Pandruvada
>>>>>> <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>>>>> + * help to add ACPI support.
>>>>>> + *
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/delay.h>
>>>>>> +#include <linux/err.h>
>>>>>> +#include <linux/i2c.h>
>>>>>> +#include <linux/mutex.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/interrupt.h>
>>>>>> +#include <linux/regulator/consumer.h>
>>>>>> +#include <linux/iio/iio.h>
>>>>>> +#include <linux/iio/sysfs.h>
>>>>>> +#include <linux/iio/events.h>
>>>>>> +#include <linux/init.h>
>>>>>> +#include <linux/acpi.h>
>>>>>> +
>>>>>> +/* Registers Address */
>>>>>> +#define CM3218x_REG_ADDR_CMD 0x00
>>>>>> +#define CM3218x_REG_ADDR_WH 0x01
>>>>>> +#define CM3218x_REG_ADDR_WL 0x02
>>>>>> +#define CM3218x_REG_ADDR_TEST 0x03
>>>>> inconsistent whitespace allover
>>>>>
>>>>>> +#define CM3218x_REG_ADDR_ALS 0x04
>>>>>> +#define CM3218x_REG_ADDR_STATUS 0x06
>>>>>> +#define CM3218x_REG_ADDR_ID 0x07
>>>>>> +
>>>>>> +/* Number of Configurable Registers */
>>>>>> +#define CM3218x_CONF_REG_NUM 16
>>>>>> +
>>>>>> +/* CMD register */
>>>>>> +#define CM3218x_CMD_ALS_DISABLE 0x01
>>>>>> +#define CM3218x_CMD_ALS_INT_EN 0x02
>>>>>> +#define CM3218x_CMD_ALS_THRES_WINDOW 0x04
>>>>>> +
>>>>>> +#define CM3218x_CMD_ALS_PERS_SHIFT 4
>>>>>> +#define CM3218x_CMD_ALS_PERS_MASK (0x03 <<
>>>> CM3218x_CMD_ALS_PERS_SHIFT)
>>>>>> +#define CM3218x_CMD_ALS_PERS_DEFAULT (0x01 <<
>>>>>> CM3218x_CMD_ALS_PERS_SHIFT)
>>>>>> +
>>>>>> +#define CM3218x_CMD_ALS_IT_SHIFT 6
>>>>>> +#define CM3218x_CMD_ALS_IT_MASK (0x0F <<
>> CM3218x_CMD_ALS_IT_SHIFT)
>>>>>> +#define CM3218x_CMD_ALS_IT_DEFAULT (0x01 <<
>>>> CM3218x_CMD_ALS_IT_SHIFT)
>>>>>> +
>>>>>> +#define CM3218x_CMD_ALS_HS_SHIFT 11
>>>>>> +#define CM3218x_CMD_ALS_HS_MASK (0x01 <<
>> CM3218x_CMD_ALS_HS_SHIFT)
>>>>>> +#define CM3218x_CMD_ALS_HS_DEFAULT (0x00 <<
>>>> CM3218x_CMD_ALS_HS_SHIFT)
>>>>>> +
>>>>>> +#define CM3218x_CMD_DEFAULT (CM3218x_CMD_ALS_THRES_WINDOW |\
>>>>>> + CM3218x_CMD_ALS_PERS_DEFAULT |\
>>>>>> + CM3218x_CMD_ALS_IT_DEFAULT |\
>>>>>> + CM3218x_CMD_ALS_HS_DEFAULT)
>>>>>> +
>>>>>> +#define CM3218x_WH_DEFAULT 0xFFFF
>>>>>> +#define CM3218x_WL_DEFAULT 0x0000
>>>>>> +
>>>>>> +#define CM3218x_CALIBSCALE_DEFAULT 100000
>>>>>> +#define CM3218x_CALIBSCALE_RESOLUTION 100000
>>>>>> +#define MLUX_PER_LUX 1000
>>>>> CM3218x prefix missing
>>>>>
>>>>> the lowercase x in macros is a bit weird for my taste
>>>>>
>>>>>> +#define CM3218x_THRESHOLD_PERCENT 10 /* 10 percent */
>>>>>> +
>>>>>> +/* CM3218 Family */
>>>>>> +#define CM3218_MLUX_PER_BIT_DEFAULT 5 /* Depend on system */
>>>>>> +#define CM3218_MLUX_PER_BIT_BASE_IT 800000
>>>>>> +static int CM3218_als_it_bits[] =3D {0, 1, 2, 3};
>>>>>> +static int CM3218_als_it_values[] =3D {100000, 200000, 400000,
>>>> 800000};
>>>>> const missing
>>>>>
>>>>>> +
>>>>>> +/* CM32181 Family */
>>>>>> +#define CM32181_MLUX_PER_BIT_DEFAULT 5
>>>>>> +#define CM32181_MLUX_PER_BIT_BASE_IT 800000
>>>>>> +static int CM32181_als_it_bits[] =3D {12, 8, 0, 1, 2, 3};
>>>>>> +static int CM32181_als_it_values[] =3D {
>>>>>> + 25000, 50000, 100000, 200000, 400000, 800000};
>>>>> const missing
>>>>>
>>>>>> +
>>>>>> +/* CM32182 Family */
>>>>>> +#define CM32182_MLUX_PER_BIT_DEFAULT 5
>>>>>> +#define CM32182_MLUX_PER_BIT_BASE_IT 800000
>>>>>> +static int CM32182_als_it_bits[] =3D {12, 8, 0, 1, 2, 3};
>>>>>> +static int CM32182_als_it_values[] =3D {
>>>>>> + 25000, 50000, 100000, 200000, 400000, 800000};
>>>>> const missing
>>>>>
>>>>> these definitions are largely identical and could be dropped; the=
y
>>>> are
>>>>> only used to fill device-specific tables below; why have a separa=
te
>>>>> define here?
>>>>>
>>>>>> +
>>>>>> +struct cmdev {
>>>>> prefix?
>>>>>
>>>>>> + u32 family_id;
>>>>>> + int int_type;
>>>>>> +#define INT_TYPE_SMBUS 0
>>>>>> +#define INT_TYPE_I2C 1
>>>>> prefix?
>>>>>
>>>>>> + int regs_bmp;
>>>>>> + int calibscale;
>>>>>> + int mlux_per_bit;
>>>>>> + int mlux_per_bit_base_it;
>>>>>> + int *als_it_bits;
>>>>>> + int *als_it_values;
>>>>>> + int num_als_it;
>>>>>> +};
>>>>>> +
>>>>>> +static struct cmdev cm3218 =3D {
>>>>>> + 3218, INT_TYPE_SMBUS, 0x0F, CM3218x_CALIBSCALE_DEFAULT,
>>>>>> + CM3218_MLUX_PER_BIT_DEFAULT, CM3218_MLUX_PER_BIT_BASE_IT,
>>>>>> + CM3218_als_it_bits, CM3218_als_it_values,
>>>>>> + ARRAY_SIZE(CM3218_als_it_bits)};
>>>>>> +
>>>>>> +static struct cmdev cm32181 =3D {
>>>>>> + 32181, INT_TYPE_I2C, 0x0F, CM3218x_CALIBSCALE_DEFAULT,
>>>>>> + CM32181_MLUX_PER_BIT_DEFAULT, CM32181_MLUX_PER_BIT_BASE_IT,
>>>>>> + CM32181_als_it_bits, CM32181_als_it_values,
>>>>>> + ARRAY_SIZE(CM32181_als_it_bits)};
>>>>>> +
>>>>>> +static struct cmdev cm32182 =3D {
>>>>>> + 32182, INT_TYPE_I2C, 0x0F, CM3218x_CALIBSCALE_DEFAULT,
>>>>>> + CM32182_MLUX_PER_BIT_DEFAULT, CM32182_MLUX_PER_BIT_BASE_IT,
>>>>>> + CM32182_als_it_bits, CM32182_als_it_values,
>>>>>> + ARRAY_SIZE(CM32182_als_it_bits)};
>>>>>> +
>>>>>> +struct cm3218x_chip {
>>>>>> + struct i2c_client *client;
>>>>>> + struct cmdev *cmdev;
>>>>>> + struct mutex lock;
>>>>>> + u16 conf_regs[CM3218x_CONF_REG_NUM];
>>>>>> + int als_raw;
>>>>>> +};
>>>>>> +
>>>>>> +static int cm3218x_get_lux(struct cm3218x_chip *chip);
>>>>>> +static int cm3218x_threshold_update(struct cm3218x_chip *chip,
>> int
>>>>>> percent);
>>>>>> +static int cm3218x_read_als_it(struct cm3218x_chip *chip, int
>>>> *val2);
>>>>>> +
>>>>>> +/**
>>>>>> + * cm3218x_read_ara() - Read ARA register
>>>>>> + * @cm3218x: pointer of struct cm3218x.
>>>>> @chip
>>>>>
>>>>>> + *
>>>>>> + * Following SMBus protocol, ARA register is available only whe=
n
>>>>>> interrupt
>>>>>> + * event happened.  Read it to clean interrupt event.  Otherwis=
e,
>>>> other
>>>>>> + * device address/registers will be blocked during interrupt
>> event.
>>>>>> + *
>>>>>> + * Return: 0 for success; otherwise for error code.
>>>>>> + */
>>>>>> +static int cm3218x_read_ara(struct cm3218x_chip *chip)
>>>>>> +{
>>>>>> + struct i2c_client *client =3D chip->client;
>>>>>> + int status;
>>>>>> + unsigned short addr;
>>>>>> +
>>>>> this looks dangerous: temporarily changing the I2C chip address!
>>>>>
>>>>>> + addr =3D client->addr;
>>>>>> + client->addr =3D 0x0C;
>>>>>> + status =3D i2c_smbus_read_byte(client);
>>>>>> + client->addr =3D addr;
>>>>>> +
>>>>>> + if (status < 0)
>>>>>> + return -ENODEV;
>>>>>> +
>>>>>> + return status;
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * cm3218x_interrupt_config() - Enable/Disable CM3218x interrup=
t
>>>>>> + * @cm3218x: pointer of struct cm3218x.
>>>>> @chip: pointer to struct cm3218x_chip
>>>>>
>>>>>> + * @enable: 0 to disable; otherwise to enable
>>>>>> + *
>>>>>> + * Config CM3218x interrupt control bit.
>>>>>> + *
>>>>>> + * Return: 0 for success; otherwise for error code.
>>>>>> + */
>>>>>> +static int cm3218x_interrupt_config(struct cm3218x_chip *chip,
>> int
>>>>>> enable)
>>>>>> +{
>>>>>> + struct i2c_client *client =3D chip->client;
>>>>>> + struct cmdev *cmdev =3D chip->cmdev;
>>>>>> + int status;
>>>>>> +
>>>>>> + if (!cmdev)
>>>>>> + return -ENODEV;
>>>>>> +
>>>>>> + /* Force to clean interrupt */
>>>>>> + if (cmdev->int_type =3D=3D INT_TYPE_I2C) {
>>>>>> + status =3D i2c_smbus_read_word_data(client,
>>>>>> + CM3218x_REG_ADDR_STATUS);
>>>>>> + if (status < 0)
>>>>>> + cmdev->int_type =3D INT_TYPE_SMBUS;
>>>>>> + }
>>>>>> + if (cmdev->int_type =3D=3D INT_TYPE_SMBUS)
>>>>>> + cm3218x_read_ara(chip);
>>>>>> +
>>>>>> + if (enable)
>>>>>> + chip->conf_regs[CM3218x_REG_ADDR_CMD] |=3D
>>>>>> + CM3218x_CMD_ALS_INT_EN;
>>>>>> + else
>>>>>> + chip->conf_regs[CM3218x_REG_ADDR_CMD] &=3D
>>>>>> + ~CM3218x_CMD_ALS_INT_EN;
>>>>>> +
>>>>>> + status =3D i2c_smbus_write_word_data(client, CM3218x_REG_ADDR_=
CMD,
>>>>>> + chip->conf_regs[CM3218x_REG_ADDR_CMD]);
>>>>>> +
>>>>>> + if (status < 0)
>>>>>> + return -ENODEV;
>>>>>> +
>>>>>> + return status;
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * cm3218x_acpi_get_cpm_info() - Get CPM object from ACPI
>>>>>> + * @client pointer of struct i2c_client.
>>>>>> + * @obj_name pointer of ACPI object name.
>>>>>> + * @count maximum size of return array.
>>>>>> + * @vals pointer of array for return elements.
>>>>>> + *
>>>>>> + * Convert ACPI CPM table to array. Special thanks Srinivas
>>>> Pandruvada's
>>>>>> + * help to implement this routine.
>>>>>> + *
>>>>>> + * Return: -ENODEV for fail.  Otherwise is number of elements.
>>>>>> + */
>>>>>> +static int cm3218x_acpi_get_cpm_info(struct i2c_client *client,
>>>> char
>>>>>> *obj_name,
>>>>>> + int count, u64 *vals)
>>>>>> +{
>>>>>> + acpi_handle handle;
>>>>>> + struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
>>>>>> + int i;
>>>>>> + acpi_status status;
>>>>>> + union acpi_object *cpm =3D NULL;
>>>>> no need to initialize cpm
>>>>>
>>>>>> +
>>>>>> + handle =3D ACPI_HANDLE(&client->dev);
>>>>>> + if (!handle)
>>>>>> + return -ENODEV;
>>>>>> +
>>>>>> + status =3D acpi_evaluate_object(handle, obj_name, NULL, &buffe=
r);
>>>>>> + if (ACPI_FAILURE(status)) {
>>>>>> + dev_err(&client->dev, "object %s not found\n", obj_name);
>>>>>> + return -ENODEV;
>>>>>> + }
>>>>>> +
>>>>>> + cpm =3D buffer.pointer;
>>>>>> + for (i =3D 0; i < cpm->package.count && i < count; ++i) {
>>>>>> + union acpi_object *elem;
>>>>>> + elem =3D &(cpm->package.elements[i]);
>>>>>> + vals[i] =3D elem->integer.value;
>>>>>> + }
>>>>>> +
>>>>>> + kfree(buffer.pointer);
>>>>>> +
>>>>>> + return cpm->package.count;
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * cm3218x_reg_init() - Initialize CM3218x registers
>>>>>> + * @cm3218x: pointer of struct cm3218x.
>>>>>> + *
>>>>>> + * Initialize CM3218x ambient light sensor register to default
>>>> values.
>>>>>> + *
>>>>>> +  Return: 0 for success; otherwise for error code.
>>>>>> + */
>>>>>> +static int cm3218x_reg_init(struct cm3218x_chip *chip)
>>>>>> +{
>>>>>> + struct i2c_client *client =3D chip->client;
>>>>>> + int i;
>>>>>> + s32 ret;
>>>>>> + int cpm_elem_count;
>>>>>> + u64 cpm_elems[20];
>>>>>> + struct cmdev *cmdev;
>>>>>> +
>>>>>> + /* Default device */
>>>>>> + chip->cmdev =3D &cm3218;
>>>>>> + chip->conf_regs[CM3218x_REG_ADDR_CMD] =3D CM3218x_CMD_DEFAULT;
>>>>>> + chip->conf_regs[CM3218x_REG_ADDR_WH] =3D CM3218x_WH_DEFAULT;
>>>>>> + chip->conf_regs[CM3218x_REG_ADDR_WL] =3D CM3218x_WL_DEFAULT;
>>>>>> +
>>>>>> + /* Disable interrupt */
>>>>>> + cm3218x_interrupt_config(chip, 0);
>>>>>> +
>>>>>> + /* Disable Test Mode */
>>>>>> + i2c_smbus_write_word_data(client, CM3218x_REG_ADDR_TEST,
>> 0x0000);
>>>>>> +
>>>>>> + /* Disable device */
>>>>>> + i2c_smbus_write_word_data(client, CM3218x_REG_ADDR_CMD,
>>>>>> + CM3218x_CMD_ALS_DISABLE);
>>>>>> +
>>>>>> + /* Identify device */
>>>>>> + ret =3D i2c_smbus_read_word_data(client, CM3218x_REG_ADDR_ID);
>>>>>> + if (ret < 0)
>>>>>> + return ret;
>>>>>> + switch (ret & 0xFF) {
>>>>>> + case 0x18:
>>>>>> + cmdev =3D chip->cmdev =3D &cm3218;
>>>>>> + if (ret & 0x0800)
>>>>>> + cmdev->int_type =3D INT_TYPE_I2C;
>>>>>> + else
>>>>>> + cmdev->int_type =3D INT_TYPE_SMBUS;
>>>>>> + break;
>>>>>> + case 0x81:
>>>>>> + cmdev =3D chip->cmdev =3D &cm32181;
>>>>>> + break;
>>>>>> + case 0x82:
>>>>>> + cmdev =3D chip->cmdev =3D &cm32182;
>>>>>> + break;
>>>>>> + default:
>>>>>> + return -ENODEV;
>>>>>> + }
>>>>>> +
>>>>>> + if (ACPI_HANDLE(&client->dev)) {
>>>>>> + /* Load from ACPI */
>>>>>> + cpm_elem_count =3D cm3218x_acpi_get_cpm_info(client, "CPM0",
>>>>>> + ARRAY_SIZE(cpm_elems),
>>>>>> + cpm_elems);
>>>>>> + if (cpm_elem_count > 0) {
>>>>>> + int header_num =3D 3;
>>>>>> + int reg_num =3D cpm_elem_count - header_num;
>>>>>> +
>>>>>> + cmdev->regs_bmp =3D cpm_elems[2];
>>>>>> + for (i =3D 0; i < reg_num; i++)
>>>>>> + if (cmdev->regs_bmp & (1<<i))
>>>>>> + chip->conf_regs[i] =3D
>>>>>> + cpm_elems[header_num+i];
>>>>>> + }
>>>>>> +
>>>>>> + cpm_elem_count =3D cm3218x_acpi_get_cpm_info(client, "CPM1",
>>>>>> + ARRAY_SIZE(cpm_elems),
>>>>>> + cpm_elems);
>>>>>> + if (cpm_elem_count > 0) {
>>>>>> + cmdev->mlux_per_bit =3D (int)cpm_elems[0] / 100;
>>>>>> + cmdev->calibscale =3D (int)cpm_elems[1];
>>>>>> + }
>>>>>> + }
>>>>>> +
>>>>>> + /* Force to disable interrupt */
>>>>>> + chip->conf_regs[CM3218x_REG_ADDR_CMD] &=3D
>> ~CM3218x_CMD_ALS_INT_EN;
>>>>>> +
>>>>>> + /* Initialize registers*/
>>>>> whitespace
>>>>>
>>>>>> + for (i =3D 0; i < CM3218x_CONF_REG_NUM; i++) {
>>>>>> + if (cmdev->regs_bmp & (1<<i)) {
>>>>>> + ret =3D i2c_smbus_write_word_data(client, i,
>>>>>> + chip->conf_regs[i]);
>>>>>> + if (ret < 0)
>>>>>> + return ret;
>>>>>> + }
>>>>>> + }
>>>>>> +
>>>>>> + return 0;
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + *  cm3218x_read_als_it() - Get sensor integration time (ms)
>>>>>> + *  @cm3218x: pointer of struct cm3218x
>>>>>> + *  @val2: pointer of int to load the als_it value.
>>>>>> + *
>>>>>> + *  Report the current integartion time by millisecond.
>>>>> integration time in milliseconds
>>>>>
>>>>>> + *
>>>>>> + *  Return: IIO_VAL_INT_PLUS_MICRO for success, otherwise
>> -EINVAL.
>>>>>> + */
>>>>>> +static int cm3218x_read_als_it(struct cm3218x_chip *chip, int
>>>> *val2)
>>>>>> +{
>>>>>> + struct cmdev *cmdev =3D chip->cmdev;
>>>>>> + u16 als_it;
>>>>>> + int i;
>>>>>> +
>>>>>> + als_it =3D chip->conf_regs[CM3218x_REG_ADDR_CMD];
>>>>>> + als_it &=3D CM3218x_CMD_ALS_IT_MASK;
>>>>>> + als_it >>=3D CM3218x_CMD_ALS_IT_SHIFT;
>>>>>> + for (i =3D 0; i < cmdev->num_als_it; i++) {
>>>>>> + if (als_it =3D=3D cmdev->als_it_bits[i]) {
>>>>>> + *val2 =3D cmdev->als_it_values[i];
>>>>>> + return IIO_VAL_INT_PLUS_MICRO;
>>>>>> + }
>>>>>> + }
>>>>>> +
>>>>>> + return -EINVAL;
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * cm3218x_write_als_it() - Write sensor integration time
>>>>>> + * @cm3218x: pointer of struct cm3218x.
>>>>>> + * @val: integration time by millisecond.
>>>>>> + *
>>>>>> + * Convert integration time (ms) to sensor value.
>>>>>> + *
>>>>>> + * Return: i2c_smbus_write_word_data command return value.
>>>>>> + */
>>>>>> +static int cm3218x_write_als_it(struct cm3218x_chip *chip, int
>> val)
>>>>>> +{
>>>>>> + struct i2c_client *client =3D chip->client;
>>>>>> + struct cmdev *cmdev =3D chip->cmdev;
>>>>>> + u16 als_it;
>>>>>> + int ret, i;
>>>>>> +
>>>>>> + for (i =3D 0; i < cmdev->num_als_it; i++)
>>>>>> + if (val <=3D cmdev->als_it_values[i])
>>>>>> + break;
>>>>>> + if (i >=3D cmdev->num_als_it)
>>>>>> + i =3D cmdev->num_als_it - 1;
>>>>>> +
>>>>>> + als_it =3D cmdev->als_it_bits[i];
>>>>>> + als_it <<=3D CM3218x_CMD_ALS_IT_SHIFT;
>>>>>> +
>>>>>> + mutex_lock(&chip->lock);
>>>>>> + chip->conf_regs[CM3218x_REG_ADDR_CMD] &=3D
>>>>>> + ~CM3218x_CMD_ALS_IT_MASK;
>>>>>> + chip->conf_regs[CM3218x_REG_ADDR_CMD] |=3D
>>>>>> + als_it;
>>>>>> + ret =3D i2c_smbus_write_word_data(client, CM3218x_REG_ADDR_CMD=
,
>>>>>> + chip->conf_regs[CM3218x_REG_ADDR_CMD]);
>>>>>> + mutex_unlock(&chip->lock);
>>>>>> +
>>>>>> + return ret;
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * cm3218x_get_lux() - report current lux value
>>>>>> + * @cm3218x: pointer of struct cm3218x.
>>>>>> + *
>>>>>> + * Convert sensor raw data to lux.  It depends on integration
>>>>>> + * time and claibscale variable.
>>>>> calibscale
>>>>>
>>>>>> + *
>>>>>> + * Return: Positive value is lux, otherwise is error code.
>>>>>> + */
>>>>>> +static int cm3218x_get_lux(struct cm3218x_chip *chip)
>>>>>> +{
>>>>>> + struct i2c_client *client =3D chip->client;
>>>>>> + struct cmdev *cmdev =3D chip->cmdev;
>>>>>> + int ret;
>>>>>> + int als_it;
>>>>>> + int lux;
>>>>> lux variable is not needed
>>>>>
>>>>>> + u64 tmp;
>>>>>> +
>>>>>> + /* Calculate mlux per bit based on als_it */
>>>>>> + ret =3D cm3218x_read_als_it(chip, &als_it);
>>>>>> + if (ret < 0)
>>>>>> + return -EINVAL;
>>>>>> + tmp =3D (__force u64)cmdev->mlux_per_bit;
>>>>>> + tmp *=3D cmdev->mlux_per_bit_base_it;
>>>>>> + tmp =3D div_u64(tmp, als_it);
>>>>>> +
>>>>>> + /* Get als_raw */
>>>>>> + if (!(chip->conf_regs[CM3218x_REG_ADDR_CMD] &
>>>> CM3218x_CMD_ALS_INT_EN))
>>>>>> + chip->als_raw =3D i2c_smbus_read_word_data(
>>>>>> + client,
>>>>>> + CM3218x_REG_ADDR_ALS);
>>>>>> + if (chip->als_raw < 0)
>>>>>> + return chip->als_raw;
>>>>>> +
>>>>>> + tmp *=3D chip->als_raw;
>>>>>> + tmp *=3D cmdev->calibscale;
>>>>>> + tmp =3D div_u64(tmp, CM3218x_CALIBSCALE_RESOLUTION);
>>>>>> + tmp =3D div_u64(tmp, MLUX_PER_LUX);
>>>>>> +
>>>>>> + if (tmp > 0xFFFF)
>>>>>> + tmp =3D 0xFFFF;
>>>>>> +
>>>>>> + lux =3D (int)tmp;
>>>>>> + return lux;
>>>>>> +}
>>>>>> +
>>>>>> +static int cm3218x_read_raw(struct iio_dev *indio_dev,
>>>>>> + struct iio_chan_spec const *chan,
>>>>>> + int *val, int *val2, long mask)
>>>>>> +{
>>>>>> + struct cm3218x_chip *chip =3D iio_priv(indio_dev);
>>>>>> + struct cmdev *cmdev =3D chip->cmdev;
>>>>>> + int ret;
>>>>>> +
>>>>>> + switch (mask) {
>>>>>> + case IIO_CHAN_INFO_PROCESSED:
>>>>>> + ret =3D cm3218x_get_lux(chip);
>>>>>> + if (ret < 0)
>>>>>> + return ret;
>>>>>> + *val =3D ret;
>>>>>> + return IIO_VAL_INT;
>>>>>> + case IIO_CHAN_INFO_CALIBSCALE:
>>>>>> + *val =3D cmdev->calibscale;
>>>>>> + return IIO_VAL_INT;
>>>>>> + case IIO_CHAN_INFO_INT_TIME:
>>>>>> + *val =3D 0;
>>>>>> + ret =3D cm3218x_read_als_it(chip, val2);
>>>>>> + return ret;
>>>>>> + }
>>>>>> +
>>>>>> + return -EINVAL;
>>>>>> +}
>>>>>> +
>>>>>> +static int cm3218x_write_raw(struct iio_dev *indio_dev,
>>>>>> + struct iio_chan_spec const *chan,
>>>>>> + int val, int val2, long mask)
>>>>>> +{
>>>>>> + struct cm3218x_chip *chip =3D iio_priv(indio_dev);
>>>>>> + struct cmdev *cmdev =3D chip->cmdev;
>>>>>> + int ret;
>>>>> ret not needed
>>>>>
>>>>>> +
>>>>>> + switch (mask) {
>>>>>> + case IIO_CHAN_INFO_CALIBSCALE:
>>>>>> + cmdev->calibscale =3D val;
>>>>>> + return val;
>>>>>> + case IIO_CHAN_INFO_INT_TIME:
>>>>> val=3D=3D0 could be checked here
>>>>>
>>>>>> + ret =3D cm3218x_write_als_it(chip, val2);
>>>>>> + return ret;
>>>>>> + }
>>>>>> +
>>>>>> + return -EINVAL;
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * cm3218x_get_it_available() - Get available ALS IT value
>>>>>> + * @dev: pointer of struct device.
>>>>>> + * @attr: pointer of struct device_attribute.
>>>>>> + * @buf: pointer of return string buffer.
>>>>>> + *
>>>>>> + * Display the available integration time values by millisecond=
=2E
>>>>>> + *
>>>>>> + * Return: string length.
>>>>>> + */
>>>>>> +static ssize_t cm3218x_get_it_available(struct device *dev,
>>>>>> + struct device_attribute *attr, char *buf)
>>>>>> +{
>>>>>> + struct cm3218x_chip *chip =3D iio_priv(dev_to_iio_dev(dev));
>>>>>> + struct cmdev *cmdev =3D chip->cmdev;
>>>>>> + int i, len;
>>>>>> +
>>>>>> + for (i =3D 0, len =3D 0; i < cmdev->num_als_it; i++)
>>>>>> + len +=3D sprintf(buf + len, "0.%06u ", cmdev->als_it_values[i]=
);
>>>>> scnprintf(buf+len, PAGESIZE-len, ...) could be used
>>>>>
>>>>>> + return len + sprintf(buf + len, "\n");
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * cm3218x_threshold_update() - Update the threshold registers.
>>>>>> + * @dev: pointer of struct cm3218x_chip.
>>>>> @chip
>>>>>
>>>>>> + * @percent: +/- percent.
>>>>>> + *
>>>>>> + * Based on the current ALS value, tupdate the hi and low
>> threshold
>>>>>> registers.
>>>>>> + *
>>>>>> + * Return: string length.
>>>>> definitely not the string length
>>>>>
>>>>>> + */
>>>>>> +static int cm3218x_threshold_update(struct cm3218x_chip *chip,
>> int
>>>>>> percent)
>>>>>> +{
>>>>>> + struct i2c_client *client =3D chip->client;
>>>>>> + int ret;
>>>>>> + int wh, wl;
>>>>>> +
>>>>>> + ret =3D chip->als_raw =3D i2c_smbus_read_word_data(client,
>>>>>> + CM3218x_REG_ADDR_ALS);
>>>>>> + if (ret < 0)
>>>>>> + return ret;
>>>>>> +
>>>>>> + wh =3D wl =3D ret;
>>>>>> + ret *=3D percent;
>>>>>> + ret /=3D 100;
>>>>>> + if (ret < 1)
>>>>>> + ret =3D 1;
>>>>>> + wh +=3D ret;
>>>>>> + wl -=3D ret;
>>>>>> + if (wh > 65535)
>>>>>> + wh =3D 65535;
>>>>>> + if (wl < 0)
>>>>>> + wl =3D 0;
>>>>>> +
>>>>>> + chip->conf_regs[CM3218x_REG_ADDR_WH] =3D wh;
>>>>>> + ret =3D i2c_smbus_write_word_data(
>>>>>> + client,
>>>>>> + CM3218x_REG_ADDR_WH,
>>>>>> + chip->conf_regs[CM3218x_REG_ADDR_WH]);
>>>>>> + if (ret < 0)
>>>>>> + return ret;
>>>>>> +
>>>>>> + chip->conf_regs[CM3218x_REG_ADDR_WL] =3D wl;
>>>>>> + ret =3D i2c_smbus_write_word_data(
>>>>>> + client,
>>>>>> + CM3218x_REG_ADDR_WL,
>>>>>> + chip->conf_regs[CM3218x_REG_ADDR_WL]);
>>>>> just
>>>>> return ret;
>>>>>
>>>>>> + if (ret < 0)
>>>>>> + return ret;
>>>>>> +
>>>>>> + return 0;
>>>>>> +}
>>>>>> +
>>>>>> +/**
>>>>>> + * cm3218x_event_handler() - Interrupt handling routine.
>>>>>> + * @irq: irq number.
>>>>>> + * @private: pointer of void.
>>>>>> + *
>>>>>> + * Clean interrupt and reset threshold registers.
>>>>>> + *
>>>>>> + * Return: string length.
>>>>>
>>>>>> + */
>>>>>> +static irqreturn_t cm3218x_event_handler(int irq, void *private=
)
>>>>>> +{
>>>>>> + struct iio_dev *dev_info =3D private;
>>>>>> + struct cm3218x_chip *chip =3D iio_priv(dev_info);
>>>>>> + int ret;
>>>>>> +
>>>>>> + mutex_lock(&chip->lock);
>>>>>> +
>>>>>> + /* Disable interrupt */
>>>>>> + ret =3D cm3218x_interrupt_config(chip, 0);
>>>>>> + if (ret < 0)
>>>>>> + goto error_handler_unlock;
>>>>>> +
>>>>>> + /* Update Hi/Lo windows */
>>>>>> + ret =3D cm3218x_threshold_update(chip, CM3218x_THRESHOLD_PERCE=
NT);
>>>>>> + if (ret < 0)
>>>>>> + goto error_handler_unlock;
>>>>>> +
>>>>>> + /* Enable interrupt */
>>>>>> + ret =3D cm3218x_interrupt_config(chip, 1);
>>>>>> + if (ret < 0)
>>>>>> + goto error_handler_unlock;
>>>>>> +
>>>>>> + mutex_unlock(&chip->lock);
>>>>>> +
>>>>>> + return IRQ_HANDLED;
>>>>>> +
>>>>>> +error_handler_unlock:
>>>>>> + mutex_unlock(&chip->lock);
>>>>>> + return IRQ_NONE;
>>>>> I think it should be IRQ_HANDLED always
>>>>> there is no check if the interrupt indeed stems from this device
>>>>>
>>>>>> +}
>>>>>> +
>>>>>> +static const struct iio_chan_spec cm3218x_channels[] =3D {
>>>>>> + {
>>>>>> + .type =3D IIO_LIGHT,
>>>>>> + .info_mask_separate =3D
>>>>>> + BIT(IIO_CHAN_INFO_PROCESSED) |
>>>>>> + BIT(IIO_CHAN_INFO_CALIBSCALE) |
>>>>>> + BIT(IIO_CHAN_INFO_INT_TIME),
>>>>>> + }
>>>>>> +};
>>>>>> +
>>>>>> +static IIO_DEVICE_ATTR(in_illuminance_integration_time_availabl=
e,
>>>>>> + S_IRUGO, cm3218x_get_it_available, NULL, 0);
>>>>>> +
>>>>>> +static struct attribute *cm3218x_attributes[] =3D {
>>>>>> +
>> &iio_dev_attr_in_illuminance_integration_time_available.dev_attr.att=
r,
>>>>>> + NULL,
>>>>>> +};
>>>>>> +
>>>>>> +static const struct attribute_group cm3218x_attribute_group =3D=
 {
>>>>>> + .attrs =3D cm3218x_attributes
>>>>>> +};
>>>>>> +
>>>>>> +static const struct iio_info cm3218x_info =3D {
>>>>>> + .driver_module =3D THIS_MODULE,
>>>>>> + .read_raw =3D &cm3218x_read_raw,
>>>>>> + .write_raw =3D &cm3218x_write_raw,
>>>>>> + .attrs =3D &cm3218x_attribute_group,
>>>>>> +};
>>>>>> +
>>>>>> +static int cm3218x_probe(struct i2c_client *client,
>>>>>> + const struct i2c_device_id *id)
>>>>>> +{
>>>>>> + struct cm3218x_chip *chip;
>>>>>> + struct iio_dev *indio_dev;
>>>>>> + int ret;
>>>>>> +
>>>>>> + indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*chip=
));
>>>>>> + if (!indio_dev) {
>>>>>> + dev_err(&client->dev, "devm_iio_device_alloc failed\n");
>>>>>> + return -ENOMEM;
>>>>>> + }
>>>>>> +
>>>>>> + chip =3D iio_priv(indio_dev);
>>>>>> + i2c_set_clientdata(client, indio_dev);
>>>>>> + chip->client =3D client;
>>>>>> +
>>>>>> + mutex_init(&chip->lock);
>>>>>> + indio_dev->dev.parent =3D &client->dev;
>>>>>> + indio_dev->channels =3D cm3218x_channels;
>>>>>> + indio_dev->num_channels =3D ARRAY_SIZE(cm3218x_channels);
>>>>>> + indio_dev->info =3D &cm3218x_info;
>>>>>> + if (id && id->name)
>>>>>> + indio_dev->name =3D id->name;
>>>>>> + else
>>>>>> + indio_dev->name =3D (char *)dev_name(&client->dev);
>>>>>> + indio_dev->modes =3D INDIO_DIRECT_MODE;
>>>>>> +
>>>>>> + ret =3D cm3218x_reg_init(chip);
>>>>>> + if (ret) {
>>>>>> + dev_err(&client->dev,
>>>>>> + "%s: register init failed\n",
>>>>>> + __func__);
>>>>>> + return ret;
>>>>>> + }
>>>>>> +
>>>>>> + if (client->irq) {
>>>>>> + ret =3D request_threaded_irq(client->irq,
>>>>>> + NULL,
>>>>>> + cm3218x_event_handler,
>>>>>> + IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>>>>>> + "cm3218x_event",
>>>>>> + indio_dev);
>>>>>> +
>>>>>> + if (ret < 0) {
>>>>>> + dev_err(&client->dev, "irq request error %d\n",
>>>>>> + -ret);
>>>>>> + goto error_disable_int;
>>>>>> + }
>>>>>> + }
>>>>>> +
>>>>>> + ret =3D iio_device_register(indio_dev);
>>>>>> + if (ret < 0) {
>>>>>> + dev_err(&client->dev,
>>>>>> + "%s: regist device failed\n",
>>>>>> + __func__);
>>>>>> + goto error_free_irq;
>>>>>> + }
>>>>>> +
>>>>>> + if (client->irq) {
>>>>>> + ret =3D cm3218x_threshold_update(chip, CM3218x_THRESHOLD_PERCE=
NT);
>>>>>> + if (ret < 0)
>>>>>> + goto error_free_irq;
>>>>>> +
>>>>>> + ret =3D cm3218x_interrupt_config(chip, 1);
>>>>>> + if (ret < 0)
>>>>>> + goto error_free_irq;
>>>>>> + }
>>>>>> +
>>>>>> + return 0;
>>>>>> +
>>>>>> +error_free_irq:
>>>>>> + free_irq(client->irq, indio_dev);
>>>>>> +error_disable_int:
>>>>>> + cm3218x_interrupt_config(chip, 0);
>>>>>> + return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int cm3218x_remove(struct i2c_client *client)
>>>>>> +{
>>>>>> + struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
>>>>>> + struct cm3218x_chip *chip =3D iio_priv(indio_dev);
>>>>>> +
>>>>>> + cm3218x_interrupt_config(chip, 0);
>>>>>> + if (client->irq)
>>>>>> + free_irq(client->irq, indio_dev);
>>>>>> + iio_device_unregister(indio_dev);
>>>>>> + return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static const struct i2c_device_id cm3218x_id[] =3D {
>>>>>> + { "cm3218x", 0},
>>>>>> + { }
>>>>>> +};
>>>>>> +
>>>>>> +MODULE_DEVICE_TABLE(i2c, cm3218x_id);
>>>>>> +
>>>>>> +static const struct of_device_id cm3218x_of_match[] =3D {
>>>>>> + { .compatible =3D "capella,cm3218x" },
>>>>>> + { }
>>>>>> +};
>>>>>> +
>>>>>> +static const struct acpi_device_id cm3218x_acpi_match[] =3D {
>>>>>> + { "CPLM3218", 0},
>>>>>> + {},
>>>>>> +};
>>>>>> +
>>>>>> +MODULE_DEVICE_TABLE(acpi, cm3218x_acpi_match);
>>>>>> +
>>>>>> +static struct i2c_driver cm3218x_driver =3D {
>>>>>> + .driver =3D {
>>>>>> + .name =3D "cm3218x",
>>>>>> + .acpi_match_table =3D ACPI_PTR(cm3218x_acpi_match),
>>>>>> + .of_match_table =3D of_match_ptr(cm3218x_of_match),
>>>>>> + .owner =3D THIS_MODULE,
>>>>>> + },
>>>>>> + .id_table =3D cm3218x_id,
>>>>>> + .probe =3D cm3218x_probe,
>>>>>> + .remove =3D cm3218x_remove,
>>>>>> +};
>>>>>> +
>>>>>> +module_i2c_driver(cm3218x_driver);
>>>>>> +
>>>>>> +MODULE_AUTHOR("Kevin Tsai <ktsai-GubuWUlQtMwciDkP5Hr2oA@public.gmane.org>");
>>>>>> +MODULE_DESCRIPTION("CM3218x ambient light sensor driver");
>>>>>> +MODULE_LICENSE("GPL");
>>>>>>
>>>>> --=20
>>>>>
>>>>> Peter Meerwald
>>>>> +43-664-2444418 (mobile)
