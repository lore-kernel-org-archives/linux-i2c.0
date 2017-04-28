From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] i2c: add sc18is600 driver
Date: Fri, 28 Apr 2017 13:31:08 +0200
Message-ID: <20170428113108.pxomuylbetn4nsst@earth>
References: <20170329140339.22501-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ymukzv7ond3232le"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52054 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934815AbdD1LbS (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 28 Apr 2017 07:31:18 -0400
Content-Disposition: inline
In-Reply-To: <20170329140339.22501-1-sre@kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--ymukzv7ond3232le
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

ping? This is really useful on RPi, which has only has I2C
controllers with broken clock stretching support.

-- Sebastian

On Wed, Mar 29, 2017 at 04:03:39PM +0200, Sebastian Reichel wrote:
> This adds an I=B2C master driver for SPI -> I=B2C bus bridge chips.
> It currently supports NXP's SC18IS600 and SC18IS601, as well as
> Silicon Labs' CP2120. The driver was only tested on SC18IS600.
>=20
> Signed-off-By: Sebastian Reichel <sre@kernel.org>
> ---
>  .../devicetree/bindings/i2c/i2c-cp2120.txt         |   1 +
>  .../devicetree/bindings/i2c/i2c-sc18is600.txt      |  62 +++
>  drivers/i2c/busses/Kconfig                         |  10 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-sc18is600.c                 | 572 +++++++++++++++=
++++++
>  5 files changed, 646 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-cp2120.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sc18is600.t=
xt
>  create mode 100644 drivers/i2c/busses/i2c-sc18is600.c
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-cp2120.txt b/Docum=
entation/devicetree/bindings/i2c/i2c-cp2120.txt
> new file mode 100644
> index 000000000000..95e06e74f288
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-cp2120.txt
> @@ -0,0 +1 @@
> +Please see binding for i2c-sc18is600
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-sc18is600.txt b/Do=
cumentation/devicetree/bindings/i2c/i2c-sc18is600.txt
> new file mode 100644
> index 000000000000..d0d9e680a5d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-sc18is600.txt
> @@ -0,0 +1,62 @@
> +NXP SC18IS600 and Silabs CP2120 - SPI to I2C bus bridge
> +
> +NXP SC18IS600 is a SPI slave chip, which implements an I=B2C host,
> +also known as SPI to I=B2C bus bridge. SC18IS601 is the same chip,
> +but has an external clock input instead of using a builtin
> +oscillator. CP2120 is a similar chip from Silabs, which implements
> +the same interface as NXP's SC18IS600.
> +
> +Required properties:
> +  - compatible: Should contain one of
> +      * "nxp,sc18is600"
> +      * "nxp,sc18is601"
> +      * "silabs,cp2120"
> +  - reg: address of the chip on SPI bus
> +  - interrupts: Interrupt specifier. Refer to interrupt bindings.
> +  - #address-cells: Should be 1.
> +  - #size-cells: Should be 0.
> +
> +Required properties for sc18is601:
> +  - clkin: Clock specifier for CLKIN pin
> +
> +Optional properties:
> +  - clock-frequency:
> +    Desired I2C bus frequency in Hz, otherwise defaults to 100 KHz
> +  - reset-gpios
> +    GPIO specifier for reset pin, which is active low.
> +  - vdd-supply
> +    Regulator specifier for VDD supply (3.3V).
> +  - Child nodes conforming to i2c bus binding
> +
> +Example:
> +
> +&spi_controller {
> +	sc18is600: i2c@0 {
> +		compatible =3D "nxp,sc18is600";
> +		spi-max-frequency =3D <700000>; /* 700KHz */
> +		spi-cpol;
> +		spi-cpha;
> +		reg =3D <0>;
> +
> +		vdd-supply =3D <&regulator_v33>;
> +
> +		interrupt-parent =3D <&socgpio>;
> +		interrupts =3D <25 0x2>;
> +
> +		reset-gpios =3D <&i2cgpio1 9 GPIO_ACTIVE_LOW>;
> +
> +		clock-frequency =3D <100000>; /* 100KHz */
> +
> +		#address-cells =3D <0x1>;
> +		#size-cells =3D <0x0>;
> +	};
> +};
> +
> +&sc18is600 {
> +	i2c_device@42 {
> +		compatible =3D "some,i2c-device";
> +		reg =3D <0x42>;
> +	};
> +
> +	...
> +};
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 8adc0f1d7ad0..3e6386ff8de3 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -210,6 +210,16 @@ config I2C_NFORCE2_S4985
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-nforce2-s4985.
> =20
> +config I2C_SC18IS600
> +	tristate "NXP SC18IS600"
> +	depends on SPI && REGMAP
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  NXP SC18IS600 SPI to I2C-bus interface.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called i2c-sc18is600.
> +
>  config I2C_SIS5595
>  	tristate "SiS 5595"
>  	depends on PCI
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 30b60855fbcd..29971aebd238 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_I2C_ISMT)		+=3D i2c-ismt.o
>  obj-$(CONFIG_I2C_NFORCE2)	+=3D i2c-nforce2.o
>  obj-$(CONFIG_I2C_NFORCE2_S4985)	+=3D i2c-nforce2-s4985.o
>  obj-$(CONFIG_I2C_PIIX4)		+=3D i2c-piix4.o
> +obj-$(CONFIG_I2C_SC18IS600)	+=3D i2c-sc18is600.o
>  obj-$(CONFIG_I2C_SIS5595)	+=3D i2c-sis5595.o
>  obj-$(CONFIG_I2C_SIS630)	+=3D i2c-sis630.o
>  obj-$(CONFIG_I2C_SIS96X)	+=3D i2c-sis96x.o
> diff --git a/drivers/i2c/busses/i2c-sc18is600.c b/drivers/i2c/busses/i2c-=
sc18is600.c
> new file mode 100644
> index 000000000000..e4d4b3caf3a9
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-sc18is600.c
> @@ -0,0 +1,572 @@
> +/*
> + * NXP SC18IS600 SPI to I2C bus interface driver
> + *
> + * Copyright (C) 2017 Sebastian Reichel <sre@kernel.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * Datasheets:
> + *  - http://www.nxp.com/documents/data_sheet/SC18IS600.pdf
> + *  - https://www.silabs.com/documents/public/data-sheets/CP2120.pdf
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#define SC18IS600_I2C_PM_TIMEOUT 1000 /* ms */
> +#define SC18IS600_DEFAULT_FREQ 100000
> +
> +#define SC18IS600_CMD_WR	0x00 /* write */
> +#define SC18IS600_CMD_RD	0x01 /* read */
> +#define SC18IS600_CMD_WR_RD	0x02 /* read after write */
> +#define SC18IS600_CMD_WR_WR	0x03 /* write after write */
> +#define SC18IS600_CMD_RDBUF	0x06 /* read buffer */
> +#define CP2120_CMD_WRMULTI	0x09 /* write to multiple slaves */
> +#define SC18IS600_CMD_SPICON	0x18 /* spi endianess configuration */
> +#define SC18IS600_CMD_REG_WR	0x20 /* write register */
> +#define SC18IS600_CMD_REG_RD	0x21 /* read register */
> +#define SC18IS600_CMD_PWRDWN	0x30 /* power down */
> +#define CP2120_CMD_REVISION	0x40 /* read revision */
> +
> +#define SC18IS600_REG_IO_CONFIG		0x00
> +#define SC18IS600_REG_IO_STATE		0x01
> +#define SC18IS600_REG_I2C_CLOCK		0x02
> +#define SC18IS600_REG_I2C_TIMEOUT	0x03
> +#define SC18IS600_REG_I2C_STAT		0x04
> +#define SC18IS600_REG_I2C_ADDR		0x05
> +#define SC18IS600_REG_I2C_BUFFER	0x06 /* only cp2120 */
> +#define SC18IS600_REG_IO_CONFIG2	0x07 /* only cp2120 */
> +#define SC18IS600_REG_EDGEINT		0x08 /* only cp2120 */
> +#define SC18IS600_REG_I2C_TIMEOUT2	0x09 /* only cp2120 */
> +
> +#define SC18IS600_STAT_OK		0xF0
> +#define SC18IS600_STAT_NAK_ADDR		0xF1
> +#define SC18IS600_STAT_NAK_DATA		0xF2
> +#define SC18IS600_STAT_BUSY		0xF3
> +#define SC18IS600_STAT_TIMEOUT		0xF8
> +#define SC18IS600_STAT_SIZE		0xF9
> +#define SC18IS600_STAT_TIMEOUT2		0xFA /* only cp2120 */
> +#define SC18IS600_STAT_BLOCKED		0xFB /* only cp2120 */
> +
> +#define CMD_BUFFER_SIZE 5
> +
> +enum chiptype {
> +	SPI2I2C_SC18IS600,
> +	SPI2I2C_SC18IS601,
> +	SPI2I2C_CP2120,
> +};
> +
> +struct chipdesc {
> +	u8  type;
> +	u32 max_spi_speed;
> +	u32 buffer_size;
> +	u32 clock_base;
> +	u32 timeout_base;
> +	const struct regmap_config *regmap_cfg;
> +};
> +
> +static bool sc18is600_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case SC18IS600_REG_I2C_STAT:
> +	case SC18IS600_REG_I2C_BUFFER:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +static const struct regmap_config sc18is600_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +
> +	.max_register =3D 0x05,
> +	.writeable_reg =3D sc18is600_writeable_reg,
> +};
> +
> +static const struct regmap_config cp2120_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +
> +	.max_register =3D 0x09,
> +	.writeable_reg =3D sc18is600_writeable_reg,
> +};
> +
> +/*
> + * Note: The sc18is600's datasheet promises 1.2MHz SPI support, but my c=
hip did
> + * not behave correctly at that speed. It received the bytes correctly, =
but
> + * just sent them back instead of interpreting them correctly. At 800 KH=
z I
> + * still got a few errors (about 1%) and at 700 KHz everything works smo=
othly.
> + */
> +static const struct chipdesc chip_sc18is600 =3D {
> +	.type =3D SPI2I2C_SC18IS600,
> +	.max_spi_speed =3D 700000,
> +	.buffer_size =3D 96,
> +	.clock_base =3D 1843200,
> +	.buffer_size =3D 96,
> +	.clock_base =3D 1843200,
> +	.timeout_base =3D 1125, /* 112.5 Hz */
> +	.regmap_cfg =3D &sc18is600_regmap_config,
> +};
> +
> +static const struct chipdesc chip_sc18is601 =3D {
> +	.type =3D SPI2I2C_SC18IS601,
> +	.max_spi_speed =3D 3000000,
> +	.buffer_size =3D 96,
> +	.clock_base =3D 0,
> +	.timeout_base =3D 1125, /* 112.5 Hz */
> +	.regmap_cfg =3D &sc18is600_regmap_config,
> +};
> +
> +static const struct chipdesc chip_cp2120 =3D {
> +	.type =3D SPI2I2C_CP2120,
> +	.max_spi_speed =3D 1000000,
> +	.buffer_size =3D 255,
> +	.clock_base =3D 2000000,
> +	.timeout_base =3D 1280, /* 128 Hz */
> +	.regmap_cfg =3D &cp2120_regmap_config,
> +};
> +
> +struct sc18is600dev {
> +	struct i2c_adapter adapter;
> +	struct completion completion;
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +	const struct chipdesc *chip;
> +	struct gpio_desc *reset;
> +	struct regulator *vdd;
> +	struct clk *clk;
> +	u32 clock_base;
> +	u32 i2c_clock_frequency;
> +	int state;
> +};
> +
> +static irqreturn_t sc18is600_irq_handler(int this_irq, void *data)
> +{
> +	struct sc18is600dev *dev =3D data;
> +	int err;
> +
> +	err =3D regmap_read(dev->regmap, SC18IS600_REG_I2C_STAT, &dev->state);
> +	if (err)
> +		return IRQ_NONE;
> +
> +	dev_vdbg(&dev->spi->dev, "irq received, stat=3D%08x", dev->state);
> +
> +	/* no irq is generated for busy state, so ignore this irq */
> +	if (dev->state =3D=3D SC18IS600_STAT_BUSY)
> +		return IRQ_NONE;
> +
> +	complete(&dev->completion);
> +	return IRQ_HANDLED;
> +}
> +
> +static int reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct device *dev =3D context;
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	u8 txbuffer[2] =3D { SC18IS600_CMD_REG_RD, reg & 0xff };
> +	u8 rxbuffer[1];
> +	int err;
> +
> +	err =3D spi_write_then_read(spi, txbuffer, sizeof(txbuffer),
> +				       rxbuffer, sizeof(rxbuffer));
> +	if (err)
> +		return err;
> +
> +	*val =3D rxbuffer[0];
> +
> +	return 0;
> +}
> +
> +static int reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct device *dev =3D context;
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	u8 txbuffer[3] =3D { SC18IS600_CMD_REG_WR, reg & 0xff, val & 0xff };
> +
> +	return spi_write(spi, txbuffer, sizeof(txbuffer));
> +}
> +
> +static struct regmap_bus regmap_sc18is600_bus =3D {
> +	.reg_write =3D reg_write,
> +	.reg_read =3D reg_read,
> +	.reg_format_endian_default =3D REGMAP_ENDIAN_BIG,
> +	.val_format_endian_default =3D REGMAP_ENDIAN_BIG,
> +};
> +
> +static void sc18is600_setup_clock_frequency(struct sc18is600dev *dev)
> +{
> +	int reg =3D DIV_ROUND_UP(dev->clock_base, dev->i2c_clock_frequency);
> +
> +	if (reg < 5)
> +		reg =3D 5;
> +	if (reg > 255)
> +		reg =3D 255;
> +
> +	dev_dbg(&dev->spi->dev, "i2c clock frequency: %08x", reg);
> +	regmap_write(dev->regmap, SC18IS600_REG_I2C_CLOCK, reg);
> +}
> +
> +static void sc18is600_setup_timeout(struct sc18is600dev *dev,
> +				    bool enable, int timeout_ms)
> +{
> +	int timeout =3D DIV_ROUND_UP(timeout_ms * dev->chip->timeout_base, 1000=
0);
> +	u8 reg;
> +
> +	if (timeout <=3D 0)
> +		timeout =3D 1;
> +	if (timeout > 255)
> +		timeout =3D 255;
> +
> +	reg =3D (timeout & 0x7F) << 1;
> +	reg |=3D (!!enable);
> +
> +	dev_dbg(&dev->spi->dev, "i2c timeout: %08x", reg);
> +	regmap_write(dev->regmap, SC18IS600_REG_I2C_TIMEOUT, reg);
> +}
> +
> +static void sc18is600_reset(struct sc18is600dev *dev)
> +{
> +	if (dev->reset) {
> +		gpiod_set_value_cansleep(dev->reset, 1);
> +		usleep_range(50, 100);
> +		gpiod_set_value_cansleep(dev->reset, 0);
> +		usleep_range(50, 100);
> +	}
> +
> +	sc18is600_setup_clock_frequency(dev);
> +	sc18is600_setup_timeout(dev, true, 500);
> +}
> +
> +static int sc18is600_read(struct sc18is600dev *dev, struct i2c_msg *msg)
> +{
> +	u8 header[] =3D { SC18IS600_CMD_RD, msg->len, msg->addr << 1 };
> +	struct spi_transfer xfer[1] =3D { 0 };
> +
> +	xfer[0].tx_buf =3D header;
> +	xfer[0].len =3D sizeof(header);
> +
> +	dev_dbg(&dev->spi->dev, "r(addr=3D%x, len=3D%d)", msg->addr, msg->len);
> +	return spi_sync_transfer(dev->spi, xfer, 1);
> +}
> +
> +static int sc18is600_write(struct sc18is600dev *dev, struct i2c_msg *msg)
> +{
> +	u8 header[] =3D { SC18IS600_CMD_WR, msg->len, msg->addr << 1 };
> +	struct spi_transfer xfer[2] =3D { 0 };
> +
> +	xfer[0].tx_buf =3D header;
> +	xfer[0].len =3D sizeof(header);
> +
> +	xfer[1].tx_buf =3D msg->buf;
> +	xfer[1].len =3D msg->len;
> +
> +	dev_dbg(&dev->spi->dev, "w(addr=3D%x, len=3D%d)", msg->addr, msg->len);
> +	return spi_sync_transfer(dev->spi, xfer, 2);
> +}
> +
> +static int sc18is600_read_after_write(struct sc18is600dev *dev,
> +				      struct i2c_msg *msg1,
> +				      struct i2c_msg *msg2)
> +{
> +	u8 header1[] =3D
> +		{ SC18IS600_CMD_WR_RD, msg1->len, msg2->len, msg1->addr << 1 };
> +	u8 header2[] =3D { msg2->addr << 1 };
> +	struct spi_transfer xfer[3] =3D { 0 };
> +
> +	xfer[0].tx_buf =3D header1;
> +	xfer[0].len =3D sizeof(header1);
> +
> +	xfer[1].tx_buf =3D msg1->buf;
> +	xfer[1].len =3D msg1->len;
> +
> +	xfer[2].tx_buf =3D header2;
> +	xfer[2].len =3D sizeof(header2);
> +
> +	dev_dbg(&dev->spi->dev, "w(addr=3D%x, len=3D%d) + r(addr=3D%x, len=3D%d=
)",
> +		msg1->addr, msg1->len, msg2->addr, msg2->len);
> +	return spi_sync_transfer(dev->spi, xfer, 3);
> +}
> +
> +static int sc18is600_write_after_write(struct sc18is600dev *dev,
> +				       struct i2c_msg *msg1,
> +				       struct i2c_msg *msg2)
> +{
> +	u8 header1[] =3D
> +		{ SC18IS600_CMD_WR_WR, msg1->len, msg2->len, msg1->addr << 1 };
> +	u8 header2[] =3D { msg2->addr << 1 };
> +	struct spi_transfer xfer[4] =3D { 0 };
> +
> +	xfer[0].tx_buf =3D header1;
> +	xfer[0].len =3D sizeof(header1);
> +
> +	xfer[1].tx_buf =3D msg1->buf;
> +	xfer[1].len =3D msg1->len;
> +
> +	xfer[2].tx_buf =3D header2;
> +	xfer[2].len =3D sizeof(header2);
> +
> +	xfer[3].tx_buf =3D msg2->buf;
> +	xfer[3].len =3D msg2->len;
> +
> +	dev_dbg(&dev->spi->dev, "w(addr=3D%x, len=3D%d) + w(addr=3D%x, len=3D%d=
)",
> +		msg1->addr, msg1->len, msg2->addr, msg2->len);
> +	return spi_sync_transfer(dev->spi, xfer, 4);
> +}
> +
> +static int sc18is600_read_buffer(struct sc18is600dev *dev, struct i2c_ms=
g *msg)
> +{
> +	static const u8 read_buffer_cmd =3D SC18IS600_REG_I2C_BUFFER;
> +
> +	return spi_write_then_read(dev->spi, &read_buffer_cmd, 1,
> +				   msg->buf, msg->len);
> +}
> +
> +static int sc18is600_xfer(struct i2c_adapter *adapter,
> +			  struct i2c_msg *msgs, int num)
> +{
> +	struct sc18is600dev *dev =3D adapter->algo_data;
> +	int read_operations =3D 0;
> +	int i, err;
> +
> +	for (i =3D 0; i < num; i++) {
> +		if (msgs[i].len > dev->chip->buffer_size)
> +			return -EOPNOTSUPP;
> +
> +		/* chip only support standard read & write */
> +		if (msgs[i].flags & ~I2C_M_RD)
> +			return -EOPNOTSUPP;
> +
> +		if (msgs[i].flags & I2C_M_RD)
> +			read_operations++;
> +	}
> +
> +	reinit_completion(&dev->completion);
> +
> +	if (num =3D=3D 1 && read_operations =3D=3D 1)
> +		err =3D sc18is600_read(dev, &msgs[0]);
> +	else if (num =3D=3D 1)
> +		err =3D sc18is600_write(dev, &msgs[0]);
> +	else if (num =3D=3D 2 && read_operations =3D=3D 1)
> +		err =3D sc18is600_read_after_write(dev, &msgs[0], &msgs[1]);
> +	else if (num =3D=3D 2)
> +		err =3D sc18is600_write_after_write(dev, &msgs[0], &msgs[1]);
> +	else
> +		return -EOPNOTSUPP;
> +
> +	if (err) {
> +		dev_err(&dev->spi->dev, "spi transfer failed: %d", err);
> +		return err;
> +	}
> +
> +	err =3D wait_for_completion_timeout(&dev->completion, adapter->timeout);
> +	if (!err) {
> +		dev_warn(&dev->spi->dev,
> +			 "timeout waiting for irq, poll status register");
> +		dev->state =3D SC18IS600_STAT_BUSY;
> +		regmap_read(dev->regmap, SC18IS600_REG_I2C_STAT, &dev->state);
> +	}
> +
> +	switch (dev->state) {
> +	case SC18IS600_STAT_OK:
> +		break;
> +	case SC18IS600_STAT_NAK_ADDR:
> +		return -EIO;
> +	case SC18IS600_STAT_NAK_DATA:
> +		return -EREMOTEIO;
> +	case SC18IS600_STAT_SIZE:
> +		return -EINVAL;
> +	case SC18IS600_STAT_TIMEOUT:
> +		return -ETIMEDOUT;
> +	case SC18IS600_STAT_TIMEOUT2:
> +		return -ETIMEDOUT;
> +	case SC18IS600_STAT_BLOCKED:
> +		return -ETIMEDOUT;
> +	default:
> +	case SC18IS600_STAT_BUSY:
> +		dev_err(&dev->spi->dev, "device hangup detected, reset!");
> +		sc18is600_reset(dev);
> +		return -EAGAIN;
> +	}
> +
> +	if (!read_operations)
> +		return 0;
> +
> +	err =3D sc18is600_read_buffer(dev, &msgs[num-1]);
> +	if (err)
> +		return err;
> +
> +	return num;
> +}
> +
> +static u32 sc18is600_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static const struct i2c_algorithm sc18is600_algorithm =3D {
> +	.master_xfer	=3D sc18is600_xfer,
> +	.functionality	=3D sc18is600_func,
> +};
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id sc18is600_of_match[] =3D {
> +	{ .compatible =3D "nxp,sc18is600", .data =3D &chip_sc18is600 },
> +	{ .compatible =3D "nxp,sc18is601", .data =3D &chip_sc18is601 },
> +	{ .compatible =3D "silabs,cp2120", .data =3D &chip_cp2120 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sc18is600_of_match);
> +#endif
> +
> +static int sc18is600_probe(struct spi_device *spi)
> +{
> +	const struct of_device_id *of_id;
> +	struct sc18is600dev *dev;
> +	int err;
> +
> +	of_id =3D of_match_device(sc18is600_of_match, &spi->dev);
> +	if (!of_id)
> +		return -ENODEV;
> +
> +	dev =3D devm_kzalloc(&spi->dev, sizeof(*dev), GFP_KERNEL);
> +	if (dev =3D=3D NULL)
> +		return -ENOMEM;
> +	spi_set_drvdata(spi, dev);
> +
> +	init_completion(&dev->completion);
> +
> +	dev->spi =3D spi;
> +	dev->adapter.owner =3D THIS_MODULE;
> +	dev->adapter.class =3D I2C_CLASS_DEPRECATED;
> +	dev->adapter.algo =3D &sc18is600_algorithm;
> +	dev->adapter.algo_data =3D dev;
> +	dev->adapter.dev.parent =3D &spi->dev;
> +	dev->chip =3D of_id->data;
> +
> +	snprintf(dev->adapter.name, sizeof(dev->adapter.name),
> +		 "SC18IS600 at SPI %02d device %02d",
> +		 spi->master->bus_num, spi->chip_select);
> +
> +	spi->bits_per_word =3D 8;
> +	spi->mode =3D SPI_MODE_3;
> +	spi->max_speed_hz =3D dev->chip->max_spi_speed;
> +
> +	err =3D spi_setup(spi);
> +	if (err)
> +		return err;
> +
> +	dev->reset =3D devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LO=
W);
> +	if (IS_ERR(dev->reset)) {
> +		err =3D PTR_ERR(dev->reset);
> +		dev_err(&spi->dev, "Failed to reset gpio, err: %d\n", err);
> +		return err;
> +	}
> +
> +	err =3D devm_request_threaded_irq(&spi->dev, spi->irq, NULL,
> +					sc18is600_irq_handler,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					"sc18is600", dev);
> +	if (err) {
> +		dev_err(&spi->dev, "Failed to request irq, err: %d\n", err);
> +		return err;
> +	}
> +
> +	dev->regmap =3D devm_regmap_init(&dev->spi->dev,
> +			       &regmap_sc18is600_bus, &dev->spi->dev,
> +			       dev->chip->regmap_cfg);
> +	if (IS_ERR(dev->regmap)) {
> +		err =3D PTR_ERR(dev->regmap);
> +		dev_err(&spi->dev, "Failed to init regmap, err: %d\n", err);
> +		return err;
> +	}
> +
> +	err =3D device_property_read_u32(&spi->dev, "clock-frequency",
> +				       &dev->i2c_clock_frequency);
> +	if (err) {
> +		dev->i2c_clock_frequency =3D SC18IS600_DEFAULT_FREQ;
> +		dev_dbg(&spi->dev, "using default frequency %u\n",
> +			dev->i2c_clock_frequency);
> +	}
> +
> +	dev->vdd =3D devm_regulator_get(&spi->dev, "vdd");
> +	if (IS_ERR(dev->vdd)) {
> +		err =3D PTR_ERR(dev->vdd);
> +		dev_err(&spi->dev, "could not acquire vdd: %d\n", err);
> +		return err;
> +	}
> +
> +	if (!dev->chip->clock_base) {
> +		dev->clk =3D devm_clk_get(&spi->dev, "clkin");
> +		if (IS_ERR(dev->clk)) {
> +			err =3D PTR_ERR(dev->clk);
> +			dev_err(&spi->dev, "could not acquire vdd: %d\n", err);
> +			return err;
> +		}
> +
> +		clk_prepare_enable(dev->clk);
> +
> +		dev->clock_base =3D clk_get_rate(dev->clk) / 4;
> +	} else {
> +		dev->clock_base =3D dev->chip->clock_base;
> +	}
> +
> +	err =3D regulator_enable(dev->vdd);
> +	if (err) {
> +		dev_err(&spi->dev, "could not enable vdd: %d\n", err);
> +		return err;
> +	}
> +
> +	sc18is600_reset(dev);
> +
> +	err =3D i2c_add_adapter(&dev->adapter);
> +	if (err)
> +		goto out_disable_regulator;
> +
> +	return 0;
> +
> +out_disable_regulator:
> +	regulator_disable(dev->vdd);
> +	return err;
> +}
> +
> +static int sc18is600_remove(struct spi_device *spi)
> +{
> +	struct sc18is600dev *dev =3D spi_get_drvdata(spi);
> +
> +	i2c_del_adapter(&dev->adapter);
> +
> +	regulator_disable(dev->vdd);
> +
> +	return 0;
> +}
> +
> +static struct spi_driver sc18is600_driver =3D {
> +	.probe		=3D sc18is600_probe,
> +	.remove		=3D sc18is600_remove,
> +	.driver		=3D {
> +		.name	=3D "i2c-sc18is600",
> +		.of_match_table =3D of_match_ptr(sc18is600_of_match),
> +	},
> +};
> +module_spi_driver(sc18is600_driver);
> +
> +MODULE_AUTHOR("Sebastian Reichel <sre@kernel.org>");
> +MODULE_DESCRIPTION("NXP SC18IS600 I2C bus adapter");
> +MODULE_LICENSE("GPL");
> --=20
> 2.11.0
>=20

--ymukzv7ond3232le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkDJ/oACgkQ2O7X88g7
+prVEQ/7BEt3eBNZfZh4VnqcTDnQX2wZNK5c/7JWtQGnyNvyyqai3GrXzHQ9R00G
cFLflNf9Pi1NBZcViG+NFvl9N5Y81xtYh6PihTB/FmQpEumvQPEQEsMFRtg+7vn2
A8D4iGUMog0DLjg9rzPHOW2CC5Xba6SMpRhXIPciPDQA+zgl9BFx0cFlJsJtzXnq
vStBJ8IFRfB4DfoYNPnBx0tpToY7Iahy7YaIJ4RRVau9bXO/vZF0i6hXKcXuBgwT
2hoH8OmFfPnHXSTbQqACSOw2LBkI3lVc1BCkqLpx70n/LhrE10XgxexbzreQiorC
Rk9PHc53b/t/roS17D7BDWWRJ5oetFj16qiuMbkxLBHx7LAQcL94ZcpGzG0ExYdC
eS00dBhFrIiKI+m2muS8oNq0Nfa9rfYk663e5rYK/jDFmPlBUkEyk17dXCn89wqX
gWKZwkA0ACAQ+HBG3IRaBV9UHOHXBXSpzAQC6y9c75SPzCICa/RCz/x4XsadzAbT
sEU15AmMH2C5CLcpRlCmHxbif02E5KpnVmT4/h6K9Bbiq3L9ZnuOFpOOgfeovUkq
gb9XwXJT4Zhp+xnQrIUXFU7s3If/59qwmWjnlD7o0Gqv4w6a3O18QMVErd/sUiOe
1YEPg2NoDLXvCH/KwIpUg5TZkM/GXCwDjIC2eCW33hSoQ1ClyFo=
=suys
-----END PGP SIGNATURE-----

--ymukzv7ond3232le--
