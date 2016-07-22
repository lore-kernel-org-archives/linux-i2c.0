From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 2/5] i2c: Add STM32F4 I2C driver
Date: Fri, 22 Jul 2016 09:02:20 +0200
Message-ID: <20160722070219.GB1605@katana>
References: <1466439771-2741-1-git-send-email-cedric.madianga@gmail.com>
 <1466439771-2741-3-git-send-email-cedric.madianga@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466439771-2741-3-git-send-email-cedric.madianga@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Cc: patrice.chotard@st.com, mcoquelin.stm32@gmail.com, robh+dt@kernel.org, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for this contribution! Looks mostly good, some comments, though.

On Mon, Jun 20, 2016 at 06:22:48PM +0200, M'boumba Cedric Madianga wrote:
> This patch adds support for the STM32F4 I2C controller.
>=20
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> ---
>  drivers/i2c/busses/Kconfig       |  10 +
>  drivers/i2c/busses/Makefile      |   1 +
>  drivers/i2c/busses/i2c-stm32f4.c | 863 +++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 874 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-stm32f4.c
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index faa8e68..805acf6 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -873,6 +873,16 @@ config I2C_ST
>  	  This driver can also be built as module. If so, the module
>  	  will be called i2c-st.
> =20
> +config I2C_STM32F4
> +	tristate "STMicroelectronics STM32F4 I2C support"
> +	depends on ARCH_STM32

|| COMPILE_TEST?

> +	help
> +	  Enable this option to add support for STM32 I2C controller embedded
> +	  in STM32F4 SoCs.
> +
> +	  This driver can also be built as module. If so, the module
> +	  will be called i2c-stm32f4.
> +
>  config I2C_STU300
>  	tristate "ST Microelectronics DDC I2C interface"
>  	depends on MACH_U300
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 37f2819..2ac0eb2 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_I2C_SH_MOBILE)	+=3D i2c-sh_mobile.o
>  obj-$(CONFIG_I2C_SIMTEC)	+=3D i2c-simtec.o
>  obj-$(CONFIG_I2C_SIRF)		+=3D i2c-sirf.o
>  obj-$(CONFIG_I2C_ST)		+=3D i2c-st.o
> +obj-$(CONFIG_I2C_STM32F4)	+=3D i2c-stm32f4.o
>  obj-$(CONFIG_I2C_STU300)	+=3D i2c-stu300.o
>  obj-$(CONFIG_I2C_SUN6I_P2WI)	+=3D i2c-sun6i-p2wi.o
>  obj-$(CONFIG_I2C_TEGRA)		+=3D i2c-tegra.o
> diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-st=
m32f4.c
> new file mode 100644
> index 0000000..652d4bf
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-stm32f4.c
> @@ -0,0 +1,863 @@
> +/*
> + * Driver for STMicroelectronics STM32 I2C controller
> + *
> + * Copyright (C) M'boumba Cedric Madianga 2015
> + * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> + *
> + * This driver is based on st-i2c.c

i2c-st.c ?

> + *
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +/* STM32F4 I2C offset registers */
> +#define STM32F4_I2C_CR1			0x00
> +#define STM32F4_I2C_CR2			0x04
> +#define STM32F4_I2C_DR			0x10
> +#define STM32F4_I2C_SR1			0x14
> +#define STM32F4_I2C_SR2			0x18
> +#define STM32F4_I2C_CCR			0x1C
> +#define STM32F4_I2C_TRISE		0x20
> +#define STM32F4_I2C_FLTR		0x24
> +
> +/* STM32F4 I2C control 1*/
> +#define STM32F4_I2C_CR1_SWRST		BIT(15)
> +#define STM32F4_I2C_CR1_POS		BIT(11)
> +#define STM32F4_I2C_CR1_ACK		BIT(10)
> +#define STM32F4_I2C_CR1_STOP		BIT(9)
> +#define STM32F4_I2C_CR1_START		BIT(8)
> +#define STM32F4_I2C_CR1_PE		BIT(0)
> +
> +/* STM32F4 I2C control 2 */
> +#define STM32F4_I2C_CR2_FREQ_MASK	GENMASK(5, 0)
> +#define STM32F4_I2C_CR2_FREQ(n)		((n & STM32F4_I2C_CR2_FREQ_MASK))
> +#define STM32F4_I2C_CR2_ITBUFEN		BIT(10)
> +#define STM32F4_I2C_CR2_ITEVTEN		BIT(9)
> +#define STM32F4_I2C_CR2_ITERREN		BIT(8)
> +#define STM32F4_I2C_CR2_IRQ_MASK	(STM32F4_I2C_CR2_ITBUFEN \
> +					| STM32F4_I2C_CR2_ITEVTEN \
> +					| STM32F4_I2C_CR2_ITERREN)
> +
> +/* STM32F4 I2C Status 1 */
> +#define STM32F4_I2C_SR1_AF		BIT(10)
> +#define STM32F4_I2C_SR1_ARLO		BIT(9)
> +#define STM32F4_I2C_SR1_BERR		BIT(8)
> +#define STM32F4_I2C_SR1_TXE		BIT(7)
> +#define STM32F4_I2C_SR1_RXNE		BIT(6)
> +#define STM32F4_I2C_SR1_BTF		BIT(2)
> +#define STM32F4_I2C_SR1_ADDR		BIT(1)
> +#define STM32F4_I2C_SR1_SB		BIT(0)
> +#define STM32F4_I2C_SR1_ITEVTEN_MASK	(STM32F4_I2C_SR1_BTF \
> +					| STM32F4_I2C_SR1_ADDR \
> +					| STM32F4_I2C_SR1_SB)
> +#define STM32F4_I2C_SR1_ITBUFEN_MASK	(STM32F4_I2C_SR1_TXE \
> +					| STM32F4_I2C_SR1_RXNE)
> +#define STM32F4_I2C_SR1_ITERREN_MASK	(STM32F4_I2C_SR1_AF \
> +					| STM32F4_I2C_SR1_ARLO \
> +					| STM32F4_I2C_SR1_BERR)
> +
> +/* STM32F4 I2C Status 2 */
> +#define STM32F4_I2C_SR2_BUSY		BIT(1)
> +
> +/* STM32F4 I2C Control Clock */
> +#define STM32F4_I2C_CCR_CCR_MASK	GENMASK(11, 0)
> +#define STM32F4_I2C_CCR_CCR(n)		((n & STM32F4_I2C_CCR_CCR_MASK))
> +#define STM32F4_I2C_CCR_FS		BIT(15)
> +#define STM32F4_I2C_CCR_DUTY		BIT(14)
> +
> +/* STM32F4 I2C Trise */
> +#define STM32F4_I2C_TRISE_VALUE_MASK	GENMASK(5, 0)
> +#define STM32F4_I2C_TRISE_VALUE(n)	((n & STM32F4_I2C_TRISE_VALUE_MASK))
> +
> +/* STM32F4 I2C Filter */
> +#define STM32F4_I2C_FLTR_DNF_MASK	GENMASK(3, 0)
> +#define STM32F4_I2C_FLTR_DNF(n)		((n & STM32F4_I2C_FLTR_DNF_MASK))
> +#define STM32F4_I2C_FLTR_ANOFF		BIT(4)
> +
> +#define STM32F4_I2C_MIN_FREQ		2
> +#define STM32F4_I2C_MAX_FREQ		42
> +#define FAST_MODE_MAX_RISE_TIME		1000
> +#define STD_MODE_MAX_RISE_TIME		300
> +#define MHZ_TO_HZ			1000000
> +
> +enum stm32f4_i2c_speed {
> +	STM32F4_I2C_SPEED_STANDARD, /* 100 kHz */
> +	STM32F4_I2C_SPEED_FAST, /* 400 kHz */
> +	STM32F4_I2C_SPEED_END,
> +};
> +
> +/**
> + * struct stm32f4_i2c_timings - per-Mode tuning parameters
> + * @duty: Fast mode duty cycle
> + * @mul_ccr: Value to be multiplied to CCR to reach 100Khz/400Khz SCL fr=
equency
> + * @min_ccr: Minimum clock ctrl reg value to reach 100Khz/400Khz SCL fre=
quency
> + */
> +struct stm32f4_i2c_timings {
> +	u32 rate;
> +	u32 duty;
> +	u32 mul_ccr;
> +	u32 min_ccr;
> +};
> +
> +/**
> + * struct stm32f4_i2c_client - client specific data
> + * @addr: 8-bit slave addr, including r/w bit
> + * @count: number of bytes to be transferred
> + * @buf: data buffer
> + * @result: result of the transfer
> + * @stop: last I2C msg to be sent, i.e. STOP to be generated
> + */
> +struct stm32f4_i2c_client {

I think the name is a little misleading. Check 'struct i2c_client' as a
comparison. A more comprehensible name might be stm32f4_i2c_msg...

> +	u8	addr;
> +	u32	count;
> +	u8	*buf;
> +	int	result;
> +	bool	stop;
> +};
> +
> +/**
> + * struct stm32f4_i2c_dev - private data of the controller
> + * @adap: I2C adapter for this controller
> + * @dev: device for this controller
> + * @base: virtual memory area
> + * @complete: completion of I2C message
> + * @irq_event: interrupt event line for the controller
> + * @irq_error: interrupt error line for the controller
> + * @clk: hw i2c clock
> + * speed: I2C clock frequency of the controller. Standard or Fast only s=
upported
> + * @client: I2C transfer information
> + * @rst: I2C reset line
> + */
> +struct stm32f4_i2c_dev {
> +	struct i2c_adapter		adap;
> +	struct device			*dev;
> +	void __iomem			*base;
> +	struct completion		complete;
> +	int				irq_event;
> +	int				irq_error;
> +	struct clk			*clk;
> +	int				speed;
> +	struct stm32f4_i2c_client	client;
> +	struct reset_control		*rst;

No need to store reset_control. You just use it in probe.

> +};
> +
> +static struct stm32f4_i2c_timings i2c_timings[] =3D {
> +	[STM32F4_I2C_SPEED_STANDARD] =3D {
> +		.mul_ccr		=3D 1,
> +		.min_ccr		=3D 4,
> +		.duty			=3D 0,
> +	},
> +	[STM32F4_I2C_SPEED_FAST] =3D {
> +		.mul_ccr		=3D 16,
> +		.min_ccr		=3D 1,
> +		.duty			=3D 1,
> +	},
> +};
> +
> +static inline void stm32f4_i2c_set_bits(void __iomem *reg, u32 mask)
> +{
> +	writel_relaxed(readl_relaxed(reg) | mask, reg);
> +}
> +
> +static inline void stm32f4_i2c_clr_bits(void __iomem *reg, u32 mask)
> +{
> +	writel_relaxed(readl_relaxed(reg) & ~mask, reg);
> +}
> +
> +static void stm32f4_i2c_soft_reset(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR1;
> +
> +	stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_SWRST);
> +	stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_SWRST);
> +}
> +
> +static void stm32f4_i2c_disable_it(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR2;
> +
> +	stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_IRQ_MASK);
> +}
> +
> +static void stm32f4_i2c_set_periph_clk_freq(struct stm32f4_i2c_dev *i2c_=
dev)
> +{
> +	u32 clk_rate, cr2, freq;
> +
> +	cr2 =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
> +	cr2 &=3D ~STM32F4_I2C_CR2_FREQ_MASK;
> +
> +	clk_rate =3D clk_get_rate(i2c_dev->clk);
> +	freq =3D clk_rate / MHZ_TO_HZ;
> +
> +	if (freq > STM32F4_I2C_MAX_FREQ)
> +		freq =3D STM32F4_I2C_MAX_FREQ;
> +	if (freq < STM32F4_I2C_MIN_FREQ)
> +		freq =3D STM32F4_I2C_MIN_FREQ;

clamp() to enforce the range?

> +
> +	cr2 |=3D STM32F4_I2C_CR2_FREQ(freq);
> +	writel_relaxed(cr2, i2c_dev->base + STM32F4_I2C_CR2);
> +}
> +
> +static void stm32f4_i2c_set_rise_time(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	u32 trise, freq, cr2, val;
> +
> +	cr2 =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
> +	freq =3D cr2 & STM32F4_I2C_CR2_FREQ_MASK;
> +
> +	trise =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_TRISE);
> +	trise &=3D ~STM32F4_I2C_TRISE_VALUE_MASK;
> +
> +	/* Maximum rise time computation */
> +	if (i2c_dev->speed =3D=3D STM32F4_I2C_SPEED_STANDARD) {
> +		trise |=3D STM32F4_I2C_TRISE_VALUE((freq + 1));
> +	} else {
> +		val =3D freq * FAST_MODE_MAX_RISE_TIME / STD_MODE_MAX_RISE_TIME;
> +		trise |=3D STM32F4_I2C_TRISE_VALUE((val + 1));
> +	}
> +
> +	writel_relaxed(trise, i2c_dev->base + STM32F4_I2C_TRISE);
> +}
> +
> +static void stm32f4_i2c_set_speed_mode(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	struct stm32f4_i2c_timings *t =3D &i2c_timings[i2c_dev->speed];
> +	u32 ccr, clk_rate;
> +	int val;
> +
> +	ccr =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_CCR);
> +	ccr &=3D ~(STM32F4_I2C_CCR_FS | STM32F4_I2C_CCR_DUTY |
> +		 STM32F4_I2C_CCR_CCR_MASK);
> +
> +	clk_rate =3D clk_get_rate(i2c_dev->clk);
> +	val =3D clk_rate / MHZ_TO_HZ * t->mul_ccr;
> +	if (val < t->min_ccr)
> +		val =3D t->min_ccr;
> +	ccr |=3D STM32F4_I2C_CCR_CCR(val);
> +
> +	if (t->duty)
> +		ccr |=3D STM32F4_I2C_CCR_FS | STM32F4_I2C_CCR_DUTY;
> +
> +	writel_relaxed(ccr, i2c_dev->base + STM32F4_I2C_CCR);
> +}
> +
> +static void stm32f4_i2c_set_filter(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	u32 filter;
> +
> +	/* Enable analog noise filter and disable digital noise filter */
> +	filter =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_FLTR);
> +	filter &=3D ~(STM32F4_I2C_FLTR_ANOFF | STM32F4_I2C_FLTR_DNF_MASK);
> +	writel_relaxed(filter, i2c_dev->base + STM32F4_I2C_FLTR);
> +}
> +
> +/**
> + * stm32f4_i2c_hw_config() - Prepare I2C block
> + * @i2c_dev: Controller's private data
> + */
> +static void stm32f4_i2c_hw_config(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR1;
> +
> +	/* Disable I2C */
> +	stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_PE);
> +
> +	stm32f4_i2c_set_periph_clk_freq(i2c_dev);
> +
> +	stm32f4_i2c_set_rise_time(i2c_dev);
> +
> +	stm32f4_i2c_set_speed_mode(i2c_dev);
> +
> +	stm32f4_i2c_set_filter(i2c_dev);
> +
> +	/* Enable I2C */
> +	stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_PE);
> +}
> +
> +static int stm32f4_i2c_wait_free_bus(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	u32 status;
> +	int ret;
> +
> +	ret =3D readl_relaxed_poll_timeout(i2c_dev->base + STM32F4_I2C_SR2,
> +					 status,
> +					 !(status & STM32F4_I2C_SR2_BUSY),
> +					 10, 1000);
> +	if (ret) {
> +		dev_err(i2c_dev->dev, "bus not free\n");
> +		ret =3D -EBUSY;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * stm32f4_i2c_write_ byte() - Write a byte in the data register
> + * @i2c_dev: Controller's private data
> + * @byte: Data to write in the register
> + */
> +static void stm32f4_i2c_write_byte(struct stm32f4_i2c_dev *i2c_dev, u8 b=
yte)
> +{
> +	writel_relaxed(byte, i2c_dev->base + STM32F4_I2C_DR);
> +}
> +
> +/**
> + * stm32f4_i2c_write_msg() - Fill the data register in write mode
> + * @i2c_dev: Controller's private data
> + *
> + * This function fills the data register with I2C transfer buffer
> + */
> +static void stm32f4_i2c_write_msg(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	struct stm32f4_i2c_client *c =3D &i2c_dev->client;
> +
> +	stm32f4_i2c_write_byte(i2c_dev, *c->buf++);
> +	c->count--;
> +}
> +
> +static void stm32f4_i2c_read_msg(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	struct stm32f4_i2c_client *c =3D &i2c_dev->client;
> +	u32 rbuf;
> +
> +	rbuf =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_DR);
> +	*c->buf++ =3D (u8)rbuf & 0xff;
> +	c->count--;
> +}
> +
> +static void stm32f4_i2c_terminate_xfer(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	struct stm32f4_i2c_client *c =3D &i2c_dev->client;
> +	void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR2;
> +
> +	stm32f4_i2c_disable_it(i2c_dev);
> +
> +	reg =3D i2c_dev->base + STM32F4_I2C_CR1;
> +	if (c->stop)
> +		stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
> +	else
> +		stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
> +
> +	complete(&i2c_dev->complete);
> +}
> +
> +/**
> + * stm32f4_i2c_handle_write() - Handle FIFO empty interrupt in case of w=
rite
> + * @i2c_dev: Controller's private data
> + */
> +static void stm32f4_i2c_handle_write(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	struct stm32f4_i2c_client *c =3D &i2c_dev->client;
> +	void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR2;
> +
> +	if (c->count) {
> +		stm32f4_i2c_write_msg(i2c_dev);
> +		if (!c->count) {
> +			/* Disable BUF interrupt */
> +			stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_ITBUFEN);
> +		}
> +	} else {
> +		stm32f4_i2c_terminate_xfer(i2c_dev);
> +	}
> +}
> +
> +/**
> + * stm32f4_i2c_handle_read() - Handle FIFO empty interrupt in case of re=
ad
> + * @i2c_dev: Controller's private data
> + */
> +static void stm32f4_i2c_handle_read(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	struct stm32f4_i2c_client *c =3D &i2c_dev->client;
> +	void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR2;
> +
> +	switch (c->count) {
> +	case 1:
> +		stm32f4_i2c_disable_it(i2c_dev);
> +		stm32f4_i2c_read_msg(i2c_dev);
> +		complete(&i2c_dev->complete);
> +		break;
> +	case 2:
> +	case 3:
> +		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_ITBUFEN);
> +		break;
> +	default:
> +		stm32f4_i2c_read_msg(i2c_dev);
> +	}
> +}
> +
> +/**
> + * stm32f4_i2c_handle_rx_btf() - Handle byte transfer finished interrupt
> + * in case of read
> + * @i2c_dev: Controller's private data
> + */
> +static void stm32f4_i2c_handle_rx_btf(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	struct stm32f4_i2c_client *c =3D &i2c_dev->client;
> +	void __iomem *reg;
> +	u32 mask;
> +	int i;
> +
> +	switch (c->count) {
> +	case 2:
> +		reg =3D i2c_dev->base + STM32F4_I2C_CR1;
> +		/* Generate STOP or REPSTART */
> +		if (c->stop)
> +			stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
> +		else
> +			stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
> +
> +		/* Read two last data bytes */
> +		for (i =3D 2; i > 0; i--)
> +			stm32f4_i2c_read_msg(i2c_dev);
> +
> +		/* Disable EVT and ERR interrupt */
> +		reg =3D i2c_dev->base + STM32F4_I2C_CR2;
> +		mask =3D STM32F4_I2C_CR2_ITEVTEN | STM32F4_I2C_CR2_ITERREN;
> +		stm32f4_i2c_clr_bits(reg, mask);
> +
> +		complete(&i2c_dev->complete);
> +		break;
> +	case 3:
> +		/* Enable ACK and read data */
> +		reg =3D i2c_dev->base + STM32F4_I2C_CR1;
> +		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
> +		stm32f4_i2c_read_msg(i2c_dev);
> +		break;
> +	default:
> +		stm32f4_i2c_read_msg(i2c_dev);
> +	}
> +}
> +
> +/**
> + * stm32f4_i2c_handle_rx_addr() - Handle address matched interrupt in ca=
se of
> + * master receiver
> + * @i2c_dev: Controller's private data
> + */
> +static void stm32f4_i2c_handle_rx_addr(struct stm32f4_i2c_dev *i2c_dev)
> +{
> +	struct stm32f4_i2c_client *c =3D &i2c_dev->client;
> +	void __iomem *reg;
> +	u32 sr2;
> +
> +	switch (c->count) {
> +	case 0:
> +		stm32f4_i2c_terminate_xfer(i2c_dev);
> +		/* Clear ADDR flag */
> +		sr2 =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
> +		break;
> +	case 1:
> +		/*
> +		 * Single byte reception:
> +		 * Enable NACK, clear ADDR flag and generate STOP or RepSTART
> +		 */
> +		reg =3D i2c_dev->base + STM32F4_I2C_CR1;
> +		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
> +		sr2 =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
> +		if (c->stop)
> +			stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
> +		else
> +			stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
> +		break;
> +	case 2:
> +		/*
> +		 * 2-byte reception:
> +		 * Enable NACK and PEC Position Ack and clear ADDR flag
> +		 */
> +		reg =3D i2c_dev->base + STM32F4_I2C_CR1;
> +		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
> +		stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_POS);
> +		sr2 =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
> +		break;
> +
> +	default:
> +		/* N-byte reception: Enable ACK and clear ADDR flag */
> +		reg =3D i2c_dev->base + STM32F4_I2C_CR1;
> +		stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_ACK);
> +		sr2 =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
> +		break;
> +	}
> +}
> +
> +/**
> + * stm32f4_i2c_isr_event() - Interrupt routine for I2C bus event
> + * @irq: interrupt number
> + * @data: Controller's private data
> + */
> +static irqreturn_t stm32f4_i2c_isr_event(int irq, void *data)
> +{
> +	struct stm32f4_i2c_dev *i2c_dev =3D data;
> +	struct stm32f4_i2c_client *c =3D &i2c_dev->client;
> +	void __iomem *reg;
> +	u32 real_status, possible_status, ien, sr2;
> +	int flag;
> +
> +	ien =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
> +	ien &=3D STM32F4_I2C_CR2_IRQ_MASK;
> +	possible_status =3D 0;
> +
> +	/* Check possible status combinations */
> +	if (ien & STM32F4_I2C_CR2_ITEVTEN) {
> +		possible_status =3D STM32F4_I2C_SR1_ITEVTEN_MASK;
> +		if (ien & STM32F4_I2C_CR2_ITBUFEN)
> +			possible_status |=3D STM32F4_I2C_SR1_ITBUFEN_MASK;
> +	}
> +
> +	real_status =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_SR1);
> +
> +	if (!(real_status & possible_status)) {
> +		dev_dbg(i2c_dev->dev,
> +			"spurious evt it (status=3D0x%08x, ien=3D0x%08x)\n",
> +			real_status, ien);
> +		return IRQ_NONE;
> +	}
> +
> +	/* Use __fls() to check error bits first */
> +	flag =3D __fls(real_status & possible_status);
> +
> +	switch (1 << flag) {
> +	case STM32F4_I2C_SR1_SB:
> +		stm32f4_i2c_write_byte(i2c_dev, c->addr);
> +		break;
> +
> +	case STM32F4_I2C_SR1_ADDR:
> +		if (c->addr & I2C_M_RD)
> +			stm32f4_i2c_handle_rx_addr(i2c_dev);
> +		else
> +			sr2 =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
> +
> +		/* Enable ITBUF interrupts */
> +		reg =3D i2c_dev->base + STM32F4_I2C_CR2;
> +		stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR2_ITBUFEN);
> +		break;
> +
> +	case STM32F4_I2C_SR1_BTF:
> +		if (c->addr & I2C_M_RD)
> +			stm32f4_i2c_handle_rx_btf(i2c_dev);
> +		else
> +			stm32f4_i2c_handle_write(i2c_dev);
> +		break;
> +
> +	case STM32F4_I2C_SR1_TXE:
> +		stm32f4_i2c_handle_write(i2c_dev);
> +		break;
> +
> +	case STM32F4_I2C_SR1_RXNE:
> +		stm32f4_i2c_handle_read(i2c_dev);
> +		break;
> +
> +	default:
> +		dev_err(i2c_dev->dev,
> +			"evt it unhandled: status=3D0x%08x)\n", real_status);
> +		return IRQ_NONE;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * stm32f4_i2c_isr_error() - Interrupt routine for I2C bus error
> + * @irq: interrupt number
> + * @data: Controller's private data
> + */
> +static irqreturn_t stm32f4_i2c_isr_error(int irq, void *data)
> +{
> +	struct stm32f4_i2c_dev *i2c_dev =3D data;
> +	struct stm32f4_i2c_client *c =3D &i2c_dev->client;
> +	void __iomem *reg;
> +	u32 real_status, possible_status, ien;
> +	int flag;
> +
> +	ien =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
> +	ien &=3D STM32F4_I2C_CR2_IRQ_MASK;
> +	possible_status =3D 0;
> +
> +	/* Check possible status combinations */
> +	if (ien & STM32F4_I2C_CR2_ITERREN)
> +		possible_status =3D STM32F4_I2C_SR1_ITERREN_MASK;
> +
> +	real_status =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_SR1);
> +
> +	if (!(real_status & possible_status)) {
> +		dev_dbg(i2c_dev->dev,
> +			"spurious err it (status=3D0x%08x, ien=3D0x%08x)\n",
> +			real_status, ien);
> +		return IRQ_NONE;
> +	}
> +
> +	/* Use __fls() to check error bits first */
> +	flag =3D __fls(real_status & possible_status);
> +
> +	switch (1 << flag) {
> +	case STM32F4_I2C_SR1_BERR:
> +		reg =3D i2c_dev->base + STM32F4_I2C_SR1;
> +		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_SR1_BERR);
> +		c->result =3D -EIO;
> +		break;
> +
> +	case STM32F4_I2C_SR1_ARLO:
> +		reg =3D i2c_dev->base + STM32F4_I2C_SR1;
> +		stm32f4_i2c_clr_bits(reg, STM32F4_I2C_SR1_ARLO);
> +		c->result =3D -EAGAIN;
> +		break;
> +
> +	case STM32F4_I2C_SR1_AF:
> +		reg =3D i2c_dev->base + STM32F4_I2C_CR1;
> +		stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
> +		c->result =3D -EIO;
> +		break;
> +
> +	default:
> +		dev_err(i2c_dev->dev,
> +			"err it unhandled: status=3D0x%08x)\n", real_status);
> +		return IRQ_NONE;
> +	}
> +
> +	stm32f4_i2c_soft_reset(i2c_dev);
> +	stm32f4_i2c_disable_it(i2c_dev);
> +	complete(&i2c_dev->complete);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * stm32f4_i2c_xfer_msg() - Transfer a single I2C message
> + * @i2c_dev: Controller's private data
> + * @msg: I2C message to transfer
> + * @is_first: first message of the sequence
> + * @is_last: last message of the sequence
> + */
> +static int stm32f4_i2c_xfer_msg(struct stm32f4_i2c_dev *i2c_dev,
> +				struct i2c_msg *msg, bool is_first,
> +				bool is_last)
> +{
> +	struct stm32f4_i2c_client *c =3D &i2c_dev->client;
> +	void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR1;
> +	unsigned long timeout;
> +	u32 mask;
> +	int ret;
> +
> +	c->addr =3D (u8)(msg->addr << 1);
> +	c->addr	|=3D (msg->flags & I2C_M_RD);

Use the shiny new "i2c_8bit_addr_from_msg()" for the last two lines.

> +	c->buf =3D msg->buf;
> +	c->count =3D msg->len;
> +	c->result =3D 0;
> +	c->stop	=3D is_last;
> +
> +	reinit_completion(&i2c_dev->complete);
> +
> +	/* Enable ITEVT and ITERR interrupts */
> +	mask =3D STM32F4_I2C_CR2_ITEVTEN | STM32F4_I2C_CR2_ITERREN;
> +	stm32f4_i2c_set_bits(i2c_dev->base + STM32F4_I2C_CR2, mask);
> +
> +	if (is_first) {
> +		ret =3D stm32f4_i2c_wait_free_bus(i2c_dev);
> +		if (ret)
> +			return ret;
> +
> +		/* START generation */
> +		stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
> +	}
> +
> +	timeout =3D wait_for_completion_timeout(&i2c_dev->complete,
> +					      i2c_dev->adap.timeout);
> +	ret =3D c->result;
> +
> +	/* Disable PEC position Ack */
> +	stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_POS);
> +
> +	if (!timeout) {
> +		dev_err(i2c_dev->dev, "Access to slave 0x%x timed out\n",
> +			c->addr >> 1);

I don't recommend writing err messages for timeouts. They regularly
happen, e.g. when an eeprom is doing a page write cycle.

> +		ret =3D -ETIMEDOUT;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * stm32f4_i2c_xfer() - Transfer combined I2C message
> + * @i2c_adap: Adapter pointer to the controller
> + * @msgs: Pointer to data to be written.
> + * @num: Number of messages to be executed
> + */
> +static int stm32f4_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg=
 msgs[],
> +			    int num)
> +{
> +	struct stm32f4_i2c_dev *i2c_dev =3D i2c_get_adapdata(i2c_adap);
> +	int ret, i;
> +
> +	ret =3D clk_enable(i2c_dev->clk);
> +	if (ret) {
> +		dev_err(i2c_dev->dev, "Failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	stm32f4_i2c_hw_config(i2c_dev);
> +
> +	for (i =3D 0; i < num && !ret; i++)
> +		ret =3D stm32f4_i2c_xfer_msg(i2c_dev, &msgs[i], i =3D=3D 0,
> +					   i =3D=3D num - 1);
> +
> +	clk_disable(i2c_dev->clk);
> +
> +	return (ret < 0) ? ret : i;
> +}
> +
> +static u32 stm32f4_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static struct i2c_algorithm stm32f4_i2c_algo =3D {
> +	.master_xfer =3D stm32f4_i2c_xfer,
> +	.functionality =3D stm32f4_i2c_func,
> +};
> +
> +static int stm32f4_i2c_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct stm32f4_i2c_dev *i2c_dev;
> +	struct resource *res;
> +	u32 clk_rate;
> +	struct i2c_adapter *adap;
> +	int ret;
> +
> +	i2c_dev =3D devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
> +	if (!i2c_dev)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	i2c_dev->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(i2c_dev->base))
> +		return PTR_ERR(i2c_dev->base);
> +
> +	i2c_dev->irq_event =3D irq_of_parse_and_map(np, 0);
> +	if (!i2c_dev->irq_event) {
> +		dev_err(&pdev->dev, "IRQ missing or invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	i2c_dev->irq_error =3D irq_of_parse_and_map(np, 1);
> +	if (!i2c_dev->irq_error) {
> +		dev_err(&pdev->dev, "IRQ missing or invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	i2c_dev->clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(i2c_dev->clk)) {
> +		dev_err(&pdev->dev, "Error: Missing controller clock\n");
> +		return PTR_ERR(i2c_dev->clk);
> +	}
> +	ret =3D clk_prepare(i2c_dev->clk);
> +	if (ret) {
> +		dev_err(i2c_dev->dev, "Failed to prepare clock\n");
> +		return ret;
> +	}
> +
> +	i2c_dev->rst =3D devm_reset_control_get(&pdev->dev, NULL);
> +	if (IS_ERR(i2c_dev->rst)) {
> +		dev_err(&pdev->dev, "Error: Missing controller reset\n");
> +		return PTR_ERR(i2c_dev->rst);
> +	}
> +	reset_control_assert(i2c_dev->rst);
> +	udelay(2);
> +	reset_control_deassert(i2c_dev->rst);
> +
> +	i2c_dev->speed =3D STM32F4_I2C_SPEED_STANDARD;
> +	ret =3D of_property_read_u32(np, "clock-frequency", &clk_rate);
> +	if ((!ret) && (clk_rate =3D=3D 400000))
> +		i2c_dev->speed =3D STM32F4_I2C_SPEED_FAST;
> +
> +	i2c_dev->dev =3D &pdev->dev;
> +
> +	ret =3D devm_request_threaded_irq(&pdev->dev, i2c_dev->irq_event,
> +					NULL, stm32f4_i2c_isr_event,
> +					IRQF_ONESHOT, pdev->name, i2c_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request irq %i\n",
> +			i2c_dev->irq_error);
> +		goto clk_free;
> +	}
> +
> +	ret =3D devm_request_threaded_irq(&pdev->dev, i2c_dev->irq_error,
> +					NULL, stm32f4_i2c_isr_error,
> +					IRQF_ONESHOT, pdev->name, i2c_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request irq %i\n",
> +			i2c_dev->irq_error);
> +		goto clk_free;
> +	}
> +
> +	adap =3D &i2c_dev->adap;
> +	i2c_set_adapdata(adap, i2c_dev);
> +	snprintf(adap->name, sizeof(adap->name), "STM32 I2C(%pa)", &res->start);
> +	adap->owner =3D THIS_MODULE;
> +	adap->timeout =3D 2 * HZ;
> +	adap->retries =3D 0;
> +	adap->algo =3D &stm32f4_i2c_algo;
> +	adap->dev.parent =3D &pdev->dev;
> +	adap->dev.of_node =3D pdev->dev.of_node;
> +
> +	init_completion(&i2c_dev->complete);
> +
> +	ret =3D i2c_add_adapter(adap);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to add adapter\n");

Please drop this messages. We have patches in i2c/for-next where the
core will report all errors.

> +		goto clk_free;
> +	}
> +
> +	platform_set_drvdata(pdev, i2c_dev);
> +
> +	dev_info(i2c_dev->dev, "STM32F4 I2C driver initialized\n");
> +
> +	return 0;
> +
> +clk_free:
> +	clk_unprepare(i2c_dev->clk);
> +	return ret;
> +}
> +
> +static int stm32f4_i2c_remove(struct platform_device *pdev)
> +{
> +	struct stm32f4_i2c_dev *i2c_dev =3D platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(&i2c_dev->adap);
> +
> +	clk_unprepare(i2c_dev->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id stm32f4_i2c_match[] =3D {
> +	{ .compatible =3D "st,stm32f4-i2c", },
^> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, stm32f4_i2c_match);
> +
> +static struct platform_driver stm32f4_i2c_driver =3D {
> +	.driver =3D {
> +		.name =3D "stm32f4-i2c",
> +		.of_match_table =3D stm32f4_i2c_match,
> +	},
> +	.probe =3D stm32f4_i2c_probe,
> +	.remove =3D stm32f4_i2c_remove,
> +};
> +
> +module_platform_driver(stm32f4_i2c_driver);
> +
> +MODULE_AUTHOR("M'boumba Cedric Madianga <cedric.madianga@gmail.com>");
> +MODULE_DESCRIPTION("STMicroelectronics STM32F4 I2C driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 1.9.1
>=20

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkcT7AAoJEBQN5MwUoCm2I4cQAImVMAnFegIQBUuiI4oqHjoh
TZ7VyoFWRki1bdieJMBkWtSrvpNNNhigKpWUyjaB5gLNDVdTMzcvRb4GMyD6X7Fn
cQQiAQsciRgXeUQM/6lLDbwa3O3JVOWFydInlb6S/36MjMGqrrRfQE3NxeHDj8MT
eFylit32EGzmT8wbin0DdBTR8OfGOSVSZfeu1wVSgA2BrN/YGSRVU/s1cL6svwsk
akxON2+OE94SdhZkTpj72yY1f5I8NagdKVGuWsTbD21SuobyR0Zpr3ENwpc7ddAh
P4vGH+A+rj24ixypdblIUQvsqup89OTMOhf4aDuEiqW6VqmGEVxmsuKHab8ykBgK
gVFAXdHkdKETOc88no7YCA18K0QYL426H9oworQzhyTB0RD6dix6Q6I5qamaLd7F
IwHFVpJ4faV444oV5uWQqROJiPk+6tBTjLmSZPS7gGf4pJFZ5PexJIdVB3c/hKl8
HHwN0ZkL4h0OPlZyrE8BIY8HI2MWge4gmRusPkxvp9U0Ack/9wPYv7IAUyJhVnw+
e17hBKeJIElTXhTBkEP8YFbp9qHYFF/phxogO1wRjfeDx4WNHxKJT0hLKZm0bk8/
Y4jQtfNPaCXF/DwVV5MqD6zkwhn23Gn1JI2GWWXUPx/2YnT7CEg2QYxKmp6oCoYE
AtbVfdXNKm+8Q+tWpLYi
=HqPY
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
