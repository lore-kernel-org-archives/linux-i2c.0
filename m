From: "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>
Subject: Re: [PATCH v7 2/5] i2c: Add STM32F4 I2C driver
Date: Fri, 23 Dec 2016 13:41:15 +0100
Message-ID: <CAOAejn3sc1F8T_rbSTr6-wBNncNwObeK+c6=_Q0BMahDdHXxQA@mail.gmail.com>
References: <1482413704-17531-1-git-send-email-cedric.madianga@gmail.com>
 <1482413704-17531-3-git-send-email-cedric.madianga@gmail.com> <20161223090019.a3jkhpb3abgjqi55@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34037 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765696AbcLWMlT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 23 Dec 2016 07:41:19 -0500
In-Reply-To: <20161223090019.a3jkhpb3abgjqi55@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Uwe,

Thanks for your comments.
Please see below my answers and one question regarding duty cycle:

2016-12-23 10:00 GMT+01:00 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutron=
ix.de>:
> Hello,
>
> On Thu, Dec 22, 2016 at 02:35:01PM +0100, M'boumba Cedric Madianga wrote:
>> This patch adds support for the STM32F4 I2C controller.
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> ---
>>  drivers/i2c/busses/Kconfig       |  10 +
>>  drivers/i2c/busses/Makefile      |   1 +
>>  drivers/i2c/busses/i2c-stm32f4.c | 896 ++++++++++++++++++++++++++++++++=
+++++++
>>  3 files changed, 907 insertions(+)
>>  create mode 100644 drivers/i2c/busses/i2c-stm32f4.c
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 0cdc844..2719208 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -886,6 +886,16 @@ config I2C_ST
>>         This driver can also be built as module. If so, the module
>>         will be called i2c-st.
>>
>> +config I2C_STM32F4
>> +     tristate "STMicroelectronics STM32F4 I2C support"
>> +     depends on ARCH_STM32 || COMPILE_TEST
>> +     help
>> +       Enable this option to add support for STM32 I2C controller embed=
ded
>> +       in STM32F4 SoCs.
>> +
>> +       This driver can also be built as module. If so, the module
>> +       will be called i2c-stm32f4.
>> +
>>  config I2C_STU300
>>       tristate "ST Microelectronics DDC I2C interface"
>>       depends on MACH_U300
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index 1c1bac8..a2c6ff5 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -85,6 +85,7 @@ obj-$(CONFIG_I2C_SH_MOBILE) +=3D i2c-sh_mobile.o
>>  obj-$(CONFIG_I2C_SIMTEC)     +=3D i2c-simtec.o
>>  obj-$(CONFIG_I2C_SIRF)               +=3D i2c-sirf.o
>>  obj-$(CONFIG_I2C_ST)         +=3D i2c-st.o
>> +obj-$(CONFIG_I2C_STM32F4)    +=3D i2c-stm32f4.o
>>  obj-$(CONFIG_I2C_STU300)     +=3D i2c-stu300.o
>>  obj-$(CONFIG_I2C_SUN6I_P2WI) +=3D i2c-sun6i-p2wi.o
>>  obj-$(CONFIG_I2C_TEGRA)              +=3D i2c-tegra.o
>> diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-s=
tm32f4.c
>> new file mode 100644
>> index 0000000..ca11dee
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-stm32f4.c
>> @@ -0,0 +1,896 @@
>> +/*
>> + * Driver for STMicroelectronics STM32 I2C controller
>> + *
>> + * This I2C controller is described in the STM32F429/439 Soc reference =
manual.
>> + * Please see below a link to the documentation:
>> + * http://www.st.com/resource/en/reference_manual/DM00031020.pdf
>> + *
>> + * Copyright (C) M'boumba Cedric Madianga 2016
>> + * Author: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> + *
>> + * This driver is based on i2c-st.c
>> + *
>> + * License terms:  GNU General Public License (GPL), version 2
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset.h>
>> +
>> +/* STM32F4 I2C offset registers */
>> +#define STM32F4_I2C_CR1                      0x00
>> +#define STM32F4_I2C_CR2                      0x04
>> +#define STM32F4_I2C_DR                       0x10
>> +#define STM32F4_I2C_SR1                      0x14
>> +#define STM32F4_I2C_SR2                      0x18
>> +#define STM32F4_I2C_CCR                      0x1C
>> +#define STM32F4_I2C_TRISE            0x20
>> +#define STM32F4_I2C_FLTR             0x24
>> +
>> +/* STM32F4 I2C control 1*/
>> +#define STM32F4_I2C_CR1_SWRST                BIT(15)
>> +#define STM32F4_I2C_CR1_POS          BIT(11)
>> +#define STM32F4_I2C_CR1_ACK          BIT(10)
>> +#define STM32F4_I2C_CR1_STOP         BIT(9)
>> +#define STM32F4_I2C_CR1_START                BIT(8)
>> +#define STM32F4_I2C_CR1_PE           BIT(0)
>> +
>> +/* STM32F4 I2C control 2 */
>> +#define STM32F4_I2C_CR2_FREQ_MASK    GENMASK(5, 0)
>> +#define STM32F4_I2C_CR2_FREQ(n)              (((n) & STM32F4_I2C_CR2_FR=
EQ_MASK))
>
>                 ((n) & STM32F4_I2C_CR2_FREQ_MASK)
>
> should be enough.
You are right. I will fix it in the V8.

>
>> +#define STM32F4_I2C_CR2_ITBUFEN              BIT(10)
>> +#define STM32F4_I2C_CR2_ITEVTEN              BIT(9)
>> +#define STM32F4_I2C_CR2_ITERREN              BIT(8)
>> +#define STM32F4_I2C_CR2_IRQ_MASK     (STM32F4_I2C_CR2_ITBUFEN | \
>> +                                      STM32F4_I2C_CR2_ITEVTEN | \
>> +                                      STM32F4_I2C_CR2_ITERREN)
>> +
>> +/* STM32F4 I2C Status 1 */
>> +#define STM32F4_I2C_SR1_AF           BIT(10)
>> +#define STM32F4_I2C_SR1_ARLO         BIT(9)
>> +#define STM32F4_I2C_SR1_BERR         BIT(8)
>> +#define STM32F4_I2C_SR1_TXE          BIT(7)
>> +#define STM32F4_I2C_SR1_RXNE         BIT(6)
>> +#define STM32F4_I2C_SR1_BTF          BIT(2)
>> +#define STM32F4_I2C_SR1_ADDR         BIT(1)
>> +#define STM32F4_I2C_SR1_SB           BIT(0)
>> +#define STM32F4_I2C_SR1_ITEVTEN_MASK (STM32F4_I2C_SR1_BTF | \
>> +                                      STM32F4_I2C_SR1_ADDR | \
>> +                                      STM32F4_I2C_SR1_SB)
>> +#define STM32F4_I2C_SR1_ITBUFEN_MASK (STM32F4_I2C_SR1_TXE | \
>> +                                      STM32F4_I2C_SR1_RXNE)
>> +#define STM32F4_I2C_SR1_ITERREN_MASK (STM32F4_I2C_SR1_AF | \
>> +                                      STM32F4_I2C_SR1_ARLO | \
>> +                                      STM32F4_I2C_SR1_BERR)
>> +
>> +/* STM32F4 I2C Status 2 */
>> +#define STM32F4_I2C_SR2_BUSY         BIT(1)
>> +
>> +/* STM32F4 I2C Control Clock */
>> +#define STM32F4_I2C_CCR_CCR_MASK     GENMASK(11, 0)
>> +#define STM32F4_I2C_CCR_CCR(n)               (((n) & STM32F4_I2C_CCR_CC=
R_MASK))
>
> ditto
ok

>
>> +#define STM32F4_I2C_CCR_FS           BIT(15)
>> +#define STM32F4_I2C_CCR_DUTY         BIT(14)
>> +
>> +/* STM32F4 I2C Trise */
>> +#define STM32F4_I2C_TRISE_VALUE_MASK GENMASK(5, 0)
>> +#define STM32F4_I2C_TRISE_VALUE(n)   (((n) & STM32F4_I2C_TRISE_VALUE_MA=
SK))
>> +
>> +/* STM32F4 I2C Filter */
>> +#define STM32F4_I2C_FLTR_DNF_MASK    GENMASK(3, 0)
>> +#define STM32F4_I2C_FLTR_DNF(n)              (((n) & STM32F4_I2C_FLTR_D=
NF_MASK))
>> +#define STM32F4_I2C_FLTR_ANOFF               BIT(4)
>> +
>> +#define STM32F4_I2C_MIN_FREQ         2U
>> +#define STM32F4_I2C_MAX_FREQ         42U
>> +#define HZ_TO_MHZ                    1000000
>> +
>> +enum stm32f4_i2c_speed {
>> +     STM32F4_I2C_SPEED_STANDARD, /* 100 kHz */
>> +     STM32F4_I2C_SPEED_FAST, /* 400 kHz */
>> +     STM32F4_I2C_SPEED_END,
>> +};
>> +
>> +/**
>> + * struct stm32f4_i2c_timings - per-Mode tuning parameters
>> + * @duty: Fast mode duty cycle
>> + * @scl_period: SCL low/high period in microsecond
>> + * @mul_ccr: Value to be multiplied to CCR to reach 100Khz/400Khz SCL f=
requency
>> + * @min_ccr: Minimum clock ctrl reg value to reach 100Khz/400Khz SCL fr=
equency
>
> s/Khz/ kHz/
Good point. Thanks

>
>> + */
>> +struct stm32f4_i2c_timings {
>> +     u32 duty;
>> +     u32 scl_period;
>> +     u32 mul_ccr;
>> +     u32 min_ccr;
>> +};
>> +
>> +/**
>> + * struct stm32f4_i2c_msg - client specific data
>> + * @addr: 8-bit slave addr, including r/w bit
>> + * @count: number of bytes to be transferred
>> + * @buf: data buffer
>> + * @result: result of the transfer
>> + * @stop: last I2C msg to be sent, i.e. STOP to be generated
>> + */
>> +struct stm32f4_i2c_msg {
>> +     u8      addr;
>> +     u32     count;
>> +     u8      *buf;
>> +     int     result;
>> +     bool    stop;
>
> You bought the argument about alignment of =3D in stm32f4_i2c_driver. The
> same logic applies here.
ok

>
>> +};
>> +
>> +/**
>> + * struct stm32f4_i2c_dev - private data of the controller
>> + * @adap: I2C adapter for this controller
>> + * @dev: device for this controller
>> + * @base: virtual memory area
>> + * @complete: completion of I2C message
>> + * @clk: hw i2c clock
>> + * speed: I2C clock frequency of the controller. Standard or Fast only =
supported
>> + * @msg: I2C transfer information
>> + */
>> +struct stm32f4_i2c_dev {
>> +     struct i2c_adapter              adap;
>> +     struct device                   *dev;
>> +     void __iomem                    *base;
>> +     struct completion               complete;
>> +     struct clk                      *clk;
>> +     int                             speed;
>> +     struct stm32f4_i2c_msg          msg;
>> +};
>
> ditto
ok

>
>> +
>> +/*
>> + * In standard mode:
>> + * SCL high period =3D SCL low period =3D CCR * I2C CLK period
>> + * So, CCR =3D SCL period * I2C CLK frequency
>
> is "SCL period" the same as "SCL low period"? I2C CLK frequency is the
> input clk? If so, it's confusing that it has I2C in its name. The
> reference manual calls it PCLK1 (parent clock?).
SCL high period =3D SCL low period
I2C CLK frequency =3D I2C parent clock frequency so I will add this
precision in the V8

>
>> + * In fast mode:
>> + * DUTY =3D 0: Fast mode tlow/thigh =3D 2
>> + * DUTY =3D 1: Fast mode tlow/thigh =3D 16/9
>> + * If Duty =3D 0; SCL high period =3D 1  * CCR * I2C CLK period
>> + *           SCL low period  =3D 2  * CCR * I2C CLK period
>> + * If Duty =3D 1; SCL high period =3D 9  * CCR * I2C CLK period
>> + *           SCL low period  =3D 16 * CCR * I2C CLK period
>
> I'd drop the first two lines about the proportions
>
>> + *
>> + * Note that Duty has to bet set to reach 400khz in Fast mode
>
> s/khz/ kHz/
Ok. Thanks.

>
> I don't understand why DUTY is required to reach 400 kHz. Given a parent
> freq of 30 MHz, with CCR =3D 25 and DUTY =3D 0 we have:
>
>         t_high =3D 25 * 33.333 ns =3D 833.333 ns
>         t_low =3D 2 * 25 * 33.333 ns =3D 1666.667 ns
>
> then t_high and t_low satisfy the i2c bus specification
> (t_low > 1300 ns, t_high > 600 ns) and we have t_low + t_high =3D 2500 ns
> =3D 1 / 400 kHz.
>
> Where is the error?
Hum ok you are right. I was a bad interpretation of the datasheet.
So now it is clearer. Thanks for that.
I will correct and improve my comments in the V8.

>
>> + * So, in order to cover both SCL high/low with Duty =3D 1,
>> + * CCR =3D 16 * SCL period * I2C CLK frequency
>
> I don't get that. Actually you need to use low + high, so
> CCR =3D parentrate / (25 * 400 kHz), right?
With your new inputs above, I think I could use a simpler implementation:
CCR =3D scl_high_period * parent_rate
with scl_high_period =3D 5 =C2=B5s in standard mode to reach 100khz
and scl_high_period =3D 1 =C2=B5s in fast mode to reach 400khz with 1/2 or
16/9 duty cycle.
So, I am wondering if I have to let the customer setting the duty
cycle in the DT for example with "st,duty=3D0" or "st,duty=3D1" property
(0 for 1/2 and 1 for 16/9).
Or perhaps the best option it to use a default value. What is your
feeling regarding this point ?

>
>> + *
>> + * Please note that the minimum allowed value is 0x04, except in FAST D=
UTY mode
>> + * where the minimum allowed value is 0x01
>> + */
>> +static struct stm32f4_i2c_timings i2c_timings[] =3D {
>> +     [STM32F4_I2C_SPEED_STANDARD] =3D {
>> +             .mul_ccr                =3D 1,
>> +             .min_ccr                =3D 4,
>> +             .duty                   =3D 0,
>> +             .scl_period             =3D 5,
>> +     },
>> +     [STM32F4_I2C_SPEED_FAST] =3D {
>> +             .mul_ccr                =3D 16,
>> +             .min_ccr                =3D 1,
>> +             .duty                   =3D 1,
>> +             .scl_period             =3D 2,
>> +     },
>> +};
>> +
>> +static inline void stm32f4_i2c_set_bits(void __iomem *reg, u32 mask)
>> +{
>> +     writel_relaxed(readl_relaxed(reg) | mask, reg);
>> +}
>> +
>> +static inline void stm32f4_i2c_clr_bits(void __iomem *reg, u32 mask)
>> +{
>> +     writel_relaxed(readl_relaxed(reg) & ~mask, reg);
>> +}
>> +
>> +static void stm32f4_i2c_soft_reset(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR1;
>> +     u32 val;
>> +
>> +     val =3D readl_relaxed(reg);
>> +     writel_relaxed(val | STM32F4_I2C_CR1_SWRST, reg);
>> +     writel_relaxed(val, reg);
>> +}
>> +
>> +static void stm32f4_i2c_disable_irq(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR2;
>> +
>> +     stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_IRQ_MASK);
>> +}
>> +
>> +static void stm32f4_i2c_set_periph_clk_freq(struct stm32f4_i2c_dev *i2c=
_dev)
>> +{
>> +     u32 clk_rate, cr2, freq;
>> +
>> +     /*
>> +      * The minimum allowed frequency is 2 MHz, the maximum frequency i=
s
>> +      * limited by the maximum APB frequency 42 MHz
>> +      */
>> +     cr2 =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
>> +     cr2 &=3D ~STM32F4_I2C_CR2_FREQ_MASK;
>> +     clk_rate =3D clk_get_rate(i2c_dev->clk);
>> +     freq =3D DIV_ROUND_UP(clk_rate, HZ_TO_MHZ);
>> +     freq =3D clamp(freq, STM32F4_I2C_MIN_FREQ, STM32F4_I2C_MAX_FREQ);
>> +     cr2 |=3D STM32F4_I2C_CR2_FREQ(freq);
>> +     writel_relaxed(cr2, i2c_dev->base + STM32F4_I2C_CR2);
>
> Last round I suggested error checking here instead of silent clamping.
Ok

>
>> +}
>> +
>> +static void stm32f4_i2c_set_rise_time(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     u32 trise, freq, cr2;
>> +
>> +     /*
>> +      * These bits must be programmed with the maximum SCL rise time gi=
ven in
>> +      * the I2C bus specification, incremented by 1.
>> +      *
>> +      * In standard mode, the maximum allowed SCL rise time is 1000 ns.
>> +      * If, in the I2C_CR2 register, the value of FREQ[5:0] bits is equ=
al to
>> +      * 0x08 so period =3D 125 ns therefore the TRISE[5:0] bits must be
>> +      * programmed with 09h.(1000 ns / 125 ns =3D 8 + 1)
>> +      * So, for I2C standard mode TRISE =3D FREQ[5:0] + 1
>> +      *
>> +      * In fast mode, the maximum allowed SCL rise time is 300 ns.
>> +      * If, in the I2C_CR2 register, the value of FREQ[5:0] bits is equ=
al to
>> +      * 0x08 so period =3D 125 ns therefore the TRISE[5:0] bits must be
>> +      * programmed with 03h.(300 ns / 125 ns =3D 2 + 1)
>> +      * So, for I2C fast mode TRISE =3D FREQ[5:0] * 300 / 1000 + 1
>> +      */
>> +
>> +     cr2 =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
>> +     freq =3D cr2 & STM32F4_I2C_CR2_FREQ_MASK;
>> +
>> +     if (i2c_dev->speed =3D=3D STM32F4_I2C_SPEED_STANDARD)
>> +             trise =3D freq + 1;
>> +     else
>> +             trise =3D freq * 300 / 1000 + 1;
>
> if freq is big such that freq * 300 overflows does this result in a
> wrong result, or does the compiler optimize correctly?
For sure the compiler will never exceeds u32 max value

>
>> +     writel_relaxed(STM32F4_I2C_TRISE_VALUE(trise),
>> +                    i2c_dev->base + STM32F4_I2C_TRISE);
>> +}
>> +
>> +static void stm32f4_i2c_set_speed_mode(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     struct stm32f4_i2c_timings *t =3D &i2c_timings[i2c_dev->speed];
>> +     u32 cr2, ccr, freq, val;
>> +
>> +     ccr =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_CCR);
>> +     ccr &=3D ~(STM32F4_I2C_CCR_FS | STM32F4_I2C_CCR_DUTY |
>> +              STM32F4_I2C_CCR_CCR_MASK);
>> +
>> +     /*
>> +      * Please see the comments above regarding i2c_timings[] declarati=
on
>> +      * to understand the below calculation
>> +      */
>> +     cr2 =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
>> +     freq =3D cr2 & STM32F4_I2C_CR2_FREQ_MASK;
>> +     val =3D freq * t->scl_period * t->mul_ccr;
>> +     if (val < t->min_ccr)
>> +             val =3D t->min_ccr;
>> +     ccr |=3D STM32F4_I2C_CCR_CCR(val);
>> +
>> +     if (t->duty)
>> +             ccr |=3D STM32F4_I2C_CCR_FS | STM32F4_I2C_CCR_DUTY;
>> +
>> +     writel_relaxed(ccr, i2c_dev->base + STM32F4_I2C_CCR);
>> +}
>> +
>> +static void stm32f4_i2c_set_filter(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     u32 filter;
>> +
>> +     /* Enable analog noise filter and disable digital noise filter */
>> +     filter =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_FLTR);
>> +     filter &=3D ~(STM32F4_I2C_FLTR_ANOFF | STM32F4_I2C_FLTR_DNF_MASK);
>> +     writel_relaxed(filter, i2c_dev->base + STM32F4_I2C_FLTR);
>> +}
>> +
>> +/**
>> + * stm32f4_i2c_hw_config() - Prepare I2C block
>> + * @i2c_dev: Controller's private data
>> + */
>> +static void stm32f4_i2c_hw_config(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR1;
>> +
>> +     /* Disable I2C */
>> +     stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_PE);
>> +
>> +     stm32f4_i2c_set_periph_clk_freq(i2c_dev);
>> +
>> +     stm32f4_i2c_set_rise_time(i2c_dev);
>> +
>> +     stm32f4_i2c_set_speed_mode(i2c_dev);
>> +
>> +     stm32f4_i2c_set_filter(i2c_dev);
>> +
>> +     /* Enable I2C */
>> +     stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_PE);
>
> This is the first write to STM32F4_I2C_CR1, right? So the state from the
> bootloader leaks here. This probably works most of the time, but if it
> makes problems later, that's hard to debug. Also, what if the bootloader
> already did some i2c transfers and kept the PE bit 1? I read in the
> manual that PE must be 0 for some things. So this only works most of the
> time.
The first thing I do before configuring I2C device is to clear PE bit
in order to disable I2C.
In that way, all previous config will be erased by the new one.

>
>> +}
>> +
>> +static int stm32f4_i2c_wait_free_bus(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     u32 status;
>> +     int ret;
>> +
>> +     ret =3D readl_relaxed_poll_timeout(i2c_dev->base + STM32F4_I2C_SR2=
,
>> +                                      status,
>> +                                      !(status & STM32F4_I2C_SR2_BUSY),
>> +                                      10, 1000);
>> +     if (ret) {
>> +             dev_err(i2c_dev->dev, "bus not free\n");
>
> drop error message please or degrade to dev_debug
ok I will use a dev_dbg message

>
>> +             ret =3D -EBUSY;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +/**
>> + * stm32f4_i2c_write_ byte() - Write a byte in the data register
>> + * @i2c_dev: Controller's private data
>> + * @byte: Data to write in the register
>> + */
>> +static void stm32f4_i2c_write_byte(struct stm32f4_i2c_dev *i2c_dev, u8 =
byte)
>> +{
>> +     writel_relaxed(byte, i2c_dev->base + STM32F4_I2C_DR);
>> +}
>> +
>> +/**
>> + * stm32f4_i2c_write_msg() - Fill the data register in write mode
>> + * @i2c_dev: Controller's private data
>> + *
>> + * This function fills the data register with I2C transfer buffer
>> + */
>> +static void stm32f4_i2c_write_msg(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     struct stm32f4_i2c_msg *msg =3D &i2c_dev->msg;
>> +
>> +     stm32f4_i2c_write_byte(i2c_dev, *msg->buf++);
>> +     msg->count--;
>> +}
>> +
>> +static void stm32f4_i2c_read_msg(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     struct stm32f4_i2c_msg *msg =3D &i2c_dev->msg;
>> +     u32 rbuf;
>> +
>> +     rbuf =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_DR);
>> +     *msg->buf++ =3D rbuf & 0xff;
>> +     msg->count--;
>> +}
>> +
>> +static void stm32f4_i2c_terminate_xfer(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     struct stm32f4_i2c_msg *msg =3D &i2c_dev->msg;
>> +     void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR2;
>> +
>> +     stm32f4_i2c_disable_irq(i2c_dev);
>> +
>> +     reg =3D i2c_dev->base + STM32F4_I2C_CR1;
>> +     if (msg->stop)
>> +             stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
>> +     else
>> +             stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
>> +
>> +     complete(&i2c_dev->complete);
>> +}
>> +
>> +/**
>> + * stm32f4_i2c_handle_write() - Handle FIFO empty interrupt in case of =
write
>> + * @i2c_dev: Controller's private data
>> + */
>> +static void stm32f4_i2c_handle_write(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     struct stm32f4_i2c_msg *msg =3D &i2c_dev->msg;
>> +     void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR2;
>> +
>> +     if (msg->count) {
>> +             stm32f4_i2c_write_msg(i2c_dev);
>> +             if (!msg->count) {
>> +                     /* Disable buffer interrupts for RXNE/TXE events *=
/
>> +                     stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_ITBUFEN)=
;
>> +             }
>> +     } else {
>> +             stm32f4_i2c_terminate_xfer(i2c_dev);
>> +     }
>> +}
>> +
>> +/**
>> + * stm32f4_i2c_handle_read() - Handle FIFO empty interrupt in case of r=
ead
>> + * @i2c_dev: Controller's private data
>> + */
>> +static void stm32f4_i2c_handle_read(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     struct stm32f4_i2c_msg *msg =3D &i2c_dev->msg;
>> +     void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR2;
>> +
>> +     switch (msg->count) {
>> +     case 1:
>> +             stm32f4_i2c_disable_irq(i2c_dev);
>> +             stm32f4_i2c_read_msg(i2c_dev);
>> +             complete(&i2c_dev->complete);
>> +             break;
>> +     case 2:
>> +     case 3:
>> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR2_ITBUFEN);
>> +             break;
>> +     default:
>> +             stm32f4_i2c_read_msg(i2c_dev);
>> +     }
>> +}
>> +
>> +/**
>> + * stm32f4_i2c_handle_rx_btf() - Handle byte transfer finished interrup=
t
>> + * in case of read
>> + * @i2c_dev: Controller's private data
>> + */
>> +static void stm32f4_i2c_handle_rx_btf(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     struct stm32f4_i2c_msg *msg =3D &i2c_dev->msg;
>> +     void __iomem *reg;
>> +     u32 mask;
>> +     int i;
>> +
>> +     switch (msg->count) {
>> +     case 2:
>> +             reg =3D i2c_dev->base + STM32F4_I2C_CR1;
>> +             /* Generate STOP or repeated Start */
>> +             if (msg->stop)
>> +                     stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
>> +             else
>> +                     stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
>> +
>> +             /* Read two last data bytes */
>> +             for (i =3D 2; i > 0; i--)
>> +                     stm32f4_i2c_read_msg(i2c_dev);
>> +
>> +             /* Disable events and error interrupts */
>> +             reg =3D i2c_dev->base + STM32F4_I2C_CR2;
>> +             mask =3D STM32F4_I2C_CR2_ITEVTEN | STM32F4_I2C_CR2_ITERREN=
;
>> +             stm32f4_i2c_clr_bits(reg, mask);
>> +
>> +             complete(&i2c_dev->complete);
>> +             break;
>> +     case 3:
>> +             /* Enable ACK and read data */
>> +             reg =3D i2c_dev->base + STM32F4_I2C_CR1;
>> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
>> +             stm32f4_i2c_read_msg(i2c_dev);
>> +             break;
>> +     default:
>> +             stm32f4_i2c_read_msg(i2c_dev);
>> +     }
>> +}
>> +
>> +/**
>> + * stm32f4_i2c_handle_rx_addr() - Handle address matched interrupt in c=
ase of
>> + * master receiver
>> + * @i2c_dev: Controller's private data
>> + */
>> +static void stm32f4_i2c_handle_rx_addr(struct stm32f4_i2c_dev *i2c_dev)
>> +{
>> +     struct stm32f4_i2c_msg *msg =3D &i2c_dev->msg;
>> +     void __iomem *reg;
>> +
>> +     switch (msg->count) {
>> +     case 0:
>> +             stm32f4_i2c_terminate_xfer(i2c_dev);
>> +             /* Clear ADDR flag */
>> +             readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
>> +             break;
>> +     case 1:
>> +             /*
>> +              * Single byte reception:
>> +              * Enable NACK, clear ADDR flag and generate STOP or RepST=
ART
>> +              */
>> +             reg =3D i2c_dev->base + STM32F4_I2C_CR1;
>> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
>> +             readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
>> +             if (msg->stop)
>> +                     stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
>> +             else
>> +                     stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
>> +             break;
>> +     case 2:
>> +             /*
>> +              * 2-byte reception:
>> +              * Enable NACK and set POS
>> +              */
>> +             reg =3D i2c_dev->base + STM32F4_I2C_CR1;
>> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_ACK);
>> +             stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_POS);
>> +             readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
>> +             break;
>> +
>> +     default:
>> +             /* N-byte reception: Enable ACK */
>> +             reg =3D i2c_dev->base + STM32F4_I2C_CR1;
>> +             stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_ACK);
>> +             readl_relaxed(i2c_dev->base + STM32F4_I2C_SR2);
>> +             break;
>> +     }
>> +}
>
> This is still not really understandable.
I have already added some comments from datasheet to explain the
different cases.
I don't see how I could be more understandable as it is clearly the
hardware way of working...

>
>> +
>> +/**
>> + * stm32f4_i2c_isr_event() - Interrupt routine for I2C bus event
>> + * @irq: interrupt number
>> + * @data: Controller's private data
>> + */
>> +static irqreturn_t stm32f4_i2c_isr_event(int irq, void *data)
>> +{
>> +     struct stm32f4_i2c_dev *i2c_dev =3D data;
>> +     struct stm32f4_i2c_msg *msg =3D &i2c_dev->msg;
>> +     void __iomem *reg;
>> +     u32 status, possible_status, ien;
>> +     int flag;
>> +
>> +     ien =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
>> +     ien &=3D STM32F4_I2C_CR2_IRQ_MASK;
>> +     possible_status =3D 0;
>
> This can already be done when declaring possible_status.
Ok.

>
>> +
>> +     /* Check possible status combinations */
>> +     if (ien & STM32F4_I2C_CR2_ITEVTEN) {
>> +             possible_status =3D STM32F4_I2C_SR1_ITEVTEN_MASK;
>> +             if (ien & STM32F4_I2C_CR2_ITBUFEN)
>> +                     possible_status |=3D STM32F4_I2C_SR1_ITBUFEN_MASK;
>> +     }
>> +
>> +     status =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_SR1);
>> +
>> +     if (!(status & possible_status)) {
>> +             dev_dbg(i2c_dev->dev,
>> +                     "spurious evt irq (status=3D0x%08x, ien=3D0x%08x)\=
n",
>> +                     status, ien);
>> +             return IRQ_NONE;
>> +     }
>> +
>> +     while (status & possible_status) {
>> +             /* Use __fls() to check error bits first */
>> +             flag =3D __fls(status & possible_status);
>> +
>> +             switch (1 << flag) {
>> +             case STM32F4_I2C_SR1_SB:
>> +                     stm32f4_i2c_write_byte(i2c_dev, msg->addr);
>> +                     break;
>> +
>> +             case STM32F4_I2C_SR1_ADDR:
>> +                     if (msg->addr & I2C_M_RD)
>> +                             stm32f4_i2c_handle_rx_addr(i2c_dev);
>> +                     else
>> +                             readl_relaxed(i2c_dev->base + STM32F4_I2C_=
SR2);
>> +
>> +                     /* Enable buffer interrupts for RXNE/TXE events */
>> +                     reg =3D i2c_dev->base + STM32F4_I2C_CR2;
>> +                     stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR2_ITBUFEN)=
;
>> +                     possible_status |=3D STM32F4_I2C_SR1_ITBUFEN_MASK;
>> +                     break;
>> +
>> +             case STM32F4_I2C_SR1_BTF:
>> +                     if (msg->addr & I2C_M_RD)
>> +                             stm32f4_i2c_handle_rx_btf(i2c_dev);
>> +                     else
>> +                             stm32f4_i2c_handle_write(i2c_dev);
>> +                     break;
>> +
>> +             case STM32F4_I2C_SR1_TXE:
>> +                     stm32f4_i2c_handle_write(i2c_dev);
>> +                     break;
>> +
>> +             case STM32F4_I2C_SR1_RXNE:
>> +                     stm32f4_i2c_handle_read(i2c_dev);
>> +                     break;
>> +
>> +             default:
>> +                     dev_err(i2c_dev->dev,
>> +                             "evt irq unhandled: status=3D0x%08x)\n",
>> +                             status);
>> +                     return IRQ_NONE;
>> +             }
>> +             status &=3D ~(1 << flag);
>> +     }
>
> I wouldn't do this in a loop. Just do:
>
>         if (status & STM32F4_I2C_SR1_SB) {
>                 ...
>         }
>
>         if (status & ...) {
>
>         }
ok but I would prefer something like that:
flag =3D status & possible_status
if (flag & STM32F4_I2C_SR1_SB) {
...
}

if (flag & ...) {
}

>
> Then it's obvious by reading the code in which order they are handled
> without the need to check the definitions. Do you really need to jugle
> with possible_status?
I think I have to use possible_status as some events could occur
whereas the corresponding interrupt is disabled.
For example, for a 2 byte-reception, we don't have to take into accout
RXNE event so the corresponding interrupt is disabled.
If I don't check possible_status, I will call
stm32f4_i2c_handle_read() for nothing and generates unneeded registers
accesses.

>
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +/**
>> + * stm32f4_i2c_isr_error() - Interrupt routine for I2C bus error
>> + * @irq: interrupt number
>> + * @data: Controller's private data
>> + */
>> +static irqreturn_t stm32f4_i2c_isr_error(int irq, void *data)
>> +{
>> +     struct stm32f4_i2c_dev *i2c_dev =3D data;
>> +     struct stm32f4_i2c_msg *msg =3D &i2c_dev->msg;
>> +     void __iomem *reg;
>> +     u32 status, possible_status, ien;
>> +     int flag;
>> +
>> +     ien =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_CR2);
>> +     ien &=3D STM32F4_I2C_CR2_IRQ_MASK;
>> +     possible_status =3D 0;
>> +
>> +     /* Check possible status combinations */
>> +     if (ien & STM32F4_I2C_CR2_ITERREN)
>> +             possible_status =3D STM32F4_I2C_SR1_ITERREN_MASK;
>> +
>> +     status =3D readl_relaxed(i2c_dev->base + STM32F4_I2C_SR1);
>> +
>> +     if (!(status & possible_status)) {
>> +             dev_dbg(i2c_dev->dev,
>> +                     "spurious err it (status=3D0x%08x, ien=3D0x%08x)\n=
",
>> +                     status, ien);
>> +             return IRQ_NONE;
>> +     }
>> +
>> +     /* Use __fls() to check error bits first */
>> +     flag =3D __fls(status & possible_status);
>> +
>> +     switch (1 << flag) {
>> +     case STM32F4_I2C_SR1_BERR:
>> +             reg =3D i2c_dev->base + STM32F4_I2C_SR1;
>> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_SR1_BERR);
>> +             msg->result =3D -EIO;
>> +             break;
>> +
>> +     case STM32F4_I2C_SR1_ARLO:
>> +             reg =3D i2c_dev->base + STM32F4_I2C_SR1;
>> +             stm32f4_i2c_clr_bits(reg, STM32F4_I2C_SR1_ARLO);
>> +             msg->result =3D -EAGAIN;
>> +             break;
>> +
>> +     case STM32F4_I2C_SR1_AF:
>> +             reg =3D i2c_dev->base + STM32F4_I2C_CR1;
>> +             stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_STOP);
>> +             msg->result =3D -EIO;
>> +             break;
>> +
>> +     default:
>> +             dev_err(i2c_dev->dev,
>> +                     "err it unhandled: status=3D0x%08x)\n", status);
>> +             return IRQ_NONE;
>> +     }
>
> You only check a single irq flag here.
Yes only the first error could be reported to the i2c clients via
msg->result that's why I don't check all errors.
Moreover, as soon as an error occurs, the I2C device is reset.

>
>> +
>> +     stm32f4_i2c_soft_reset(i2c_dev);
>> +     stm32f4_i2c_disable_irq(i2c_dev);
>> +     complete(&i2c_dev->complete);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +/**
>> + * stm32f4_i2c_xfer_msg() - Transfer a single I2C message
>> + * @i2c_dev: Controller's private data
>> + * @msg: I2C message to transfer
>> + * @is_first: first message of the sequence
>> + * @is_last: last message of the sequence
>> + */
>> +static int stm32f4_i2c_xfer_msg(struct stm32f4_i2c_dev *i2c_dev,
>> +                             struct i2c_msg *msg, bool is_first,
>> +                             bool is_last)
>> +{
>> +     struct stm32f4_i2c_msg *f4_msg =3D &i2c_dev->msg;
>> +     void __iomem *reg =3D i2c_dev->base + STM32F4_I2C_CR1;
>> +     unsigned long timeout;
>> +     u32 mask;
>> +     int ret;
>> +
>> +     f4_msg->addr =3D i2c_8bit_addr_from_msg(msg);
>> +     f4_msg->buf =3D msg->buf;
>> +     f4_msg->count =3D msg->len;
>> +     f4_msg->result =3D 0;
>> +     f4_msg->stop =3D is_last;
>> +
>> +     reinit_completion(&i2c_dev->complete);
>> +
>> +     /* Enable events and errors interrupts */
>> +     mask =3D STM32F4_I2C_CR2_ITEVTEN | STM32F4_I2C_CR2_ITERREN;
>> +     stm32f4_i2c_set_bits(i2c_dev->base + STM32F4_I2C_CR2, mask);
>> +
>> +     if (is_first) {
>> +             ret =3D stm32f4_i2c_wait_free_bus(i2c_dev);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             /* START generation */
>> +             stm32f4_i2c_set_bits(reg, STM32F4_I2C_CR1_START);
>> +     }
>> +
>> +     timeout =3D wait_for_completion_timeout(&i2c_dev->complete,
>> +                                           i2c_dev->adap.timeout);
>> +     ret =3D f4_msg->result;
>> +
>> +     /* Disable PEC position Ack */
>> +     stm32f4_i2c_clr_bits(reg, STM32F4_I2C_CR1_POS);
>
> This is the only place mentioning PEC. Should this be about POS instead?
Yes you are right. Thanks

>
>> +
>> +     if (!timeout)
>> +             ret =3D -ETIMEDOUT;
>> +
>> +     return ret;
>> +}
>> +
>> +/**
>> + * stm32f4_i2c_xfer() - Transfer combined I2C message
>> + * @i2c_adap: Adapter pointer to the controller
>> + * @msgs: Pointer to data to be written.
>> + * @num: Number of messages to be executed
>> + */
>> +static int stm32f4_i2c_xfer(struct i2c_adapter *i2c_adap, struct i2c_ms=
g msgs[],
>> +                         int num)
>> +{
>> +     struct stm32f4_i2c_dev *i2c_dev =3D i2c_get_adapdata(i2c_adap);
>> +     int ret, i;
>> +
>> +     ret =3D clk_enable(i2c_dev->clk);
>> +     if (ret) {
>> +             dev_err(i2c_dev->dev, "Failed to enable clock\n");
>> +             return ret;
>> +     }
>> +
>> +     stm32f4_i2c_hw_config(i2c_dev);
>> +
>> +     for (i =3D 0; i < num && !ret; i++)
>> +             ret =3D stm32f4_i2c_xfer_msg(i2c_dev, &msgs[i], i =3D=3D 0=
,
>> +                                        i =3D=3D num - 1);
>> +
>> +     clk_disable(i2c_dev->clk);
>> +
>> +     return (ret < 0) ? ret : num;
>> +}
>> +
>> +static u32 stm32f4_i2c_func(struct i2c_adapter *adap)
>> +{
>> +     return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>> +}
>> +
>> +static struct i2c_algorithm stm32f4_i2c_algo =3D {
>> +     .master_xfer =3D stm32f4_i2c_xfer,
>> +     .functionality =3D stm32f4_i2c_func,
>> +};
>> +
>> +static int stm32f4_i2c_probe(struct platform_device *pdev)
>> +{
>> +     struct device_node *np =3D pdev->dev.of_node;
>> +     struct stm32f4_i2c_dev *i2c_dev;
>> +     struct resource *res;
>> +     u32 irq_event, irq_error, clk_rate;
>> +     struct i2c_adapter *adap;
>> +     struct reset_control *rst;
>> +     int ret;
>> +
>> +     i2c_dev =3D devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL)=
;
>> +     if (!i2c_dev)
>> +             return -ENOMEM;
>> +
>> +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     i2c_dev->base =3D devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(i2c_dev->base))
>> +             return PTR_ERR(i2c_dev->base);
>> +
>> +     irq_event =3D irq_of_parse_and_map(np, 0);
>> +     if (!irq_event) {
>> +             dev_err(&pdev->dev, "IRQ event missing or invalid\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     irq_error =3D irq_of_parse_and_map(np, 1);
>> +     if (!irq_error) {
>> +             dev_err(&pdev->dev, "IRQ error missing or invalid\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     i2c_dev->clk =3D devm_clk_get(&pdev->dev, NULL);
>> +     if (IS_ERR(i2c_dev->clk)) {
>> +             dev_err(&pdev->dev, "Error: Missing controller clock\n");
>> +             return PTR_ERR(i2c_dev->clk);
>> +     }
>> +     ret =3D clk_prepare(i2c_dev->clk);
>> +     if (ret) {
>> +             dev_err(i2c_dev->dev, "Failed to prepare clock\n");
>> +             return ret;
>> +     }
>> +
>> +     rst =3D devm_reset_control_get(&pdev->dev, NULL);
>> +     if (IS_ERR(rst)) {
>> +             dev_err(&pdev->dev, "Error: Missing controller reset\n");
>> +             ret =3D PTR_ERR(rst);
>> +             goto clk_free;
>> +     }
>> +     reset_control_assert(rst);
>> +     udelay(2);
>> +     reset_control_deassert(rst);
>> +
>> +     i2c_dev->speed =3D STM32F4_I2C_SPEED_STANDARD;
>> +     ret =3D of_property_read_u32(np, "clock-frequency", &clk_rate);
>> +     if (!ret && clk_rate >=3D 40000)
>> +             i2c_dev->speed =3D STM32F4_I2C_SPEED_FAST;
>> +
>> +     i2c_dev->dev =3D &pdev->dev;
>> +
>> +     ret =3D devm_request_irq(&pdev->dev, irq_event, stm32f4_i2c_isr_ev=
ent, 0,
>> +                            pdev->name, i2c_dev);
>
> Starting here this irq might trigger. Can this happen? If so,
> stm32f4_i2c_isr_event is called without the adapter being registered.
> Probably not an issue as the controller was just reset.
No irq could be triggered as after resett, the I2C is not enable as PE bit =
=3D 0.

>
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "Failed to request irq event %i\n",
>> +                     irq_event);
>> +             goto clk_free;
>> +     }
>> +
>> +     ret =3D devm_request_irq(&pdev->dev, irq_error, stm32f4_i2c_isr_er=
ror, 0,
>> +                            pdev->name, i2c_dev);
>> +     if (ret) {
>> +             dev_err(&pdev->dev, "Failed to request irq error %i\n",
>> +                     irq_error);
>> +             goto clk_free;
>> +     }
>> +
>> +     adap =3D &i2c_dev->adap;
>> +     i2c_set_adapdata(adap, i2c_dev);
>> +     snprintf(adap->name, sizeof(adap->name), "STM32 I2C(%pa)", &res->s=
tart);
>> +     adap->owner =3D THIS_MODULE;
>> +     adap->timeout =3D 2 * HZ;
>> +     adap->retries =3D 0;
>> +     adap->algo =3D &stm32f4_i2c_algo;
>> +     adap->dev.parent =3D &pdev->dev;
>> +     adap->dev.of_node =3D pdev->dev.of_node;
>> +
>> +     init_completion(&i2c_dev->complete);
>> +
>> +     ret =3D i2c_add_adapter(adap);
>> +     if (ret)
>> +             goto clk_free;
>> +
>> +     platform_set_drvdata(pdev, i2c_dev);
>> +
>> +     dev_info(i2c_dev->dev, "STM32F4 I2C driver registered\n");
>> +
>> +     return 0;
>> +
>> +clk_free:
>> +     clk_unprepare(i2c_dev->clk);
>> +     return ret;
>> +}
>> +
>> +static int stm32f4_i2c_remove(struct platform_device *pdev)
>> +{
>> +     struct stm32f4_i2c_dev *i2c_dev =3D platform_get_drvdata(pdev);
>> +
>> +     i2c_del_adapter(&i2c_dev->adap);
>> +
>> +     clk_unprepare(i2c_dev->clk);
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct of_device_id stm32f4_i2c_match[] =3D {
>> +     { .compatible =3D "st,stm32f4-i2c", },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, stm32f4_i2c_match);
>> +
>> +static struct platform_driver stm32f4_i2c_driver =3D {
>> +     .driver =3D {
>> +             .name =3D "stm32f4-i2c",
>> +             .of_match_table =3D stm32f4_i2c_match,
>> +     },
>> +     .probe =3D stm32f4_i2c_probe,
>> +     .remove =3D stm32f4_i2c_remove,
>> +};
>> +
>> +module_platform_driver(stm32f4_i2c_driver);
>> +
>> +MODULE_AUTHOR("M'boumba Cedric Madianga <cedric.madianga@gmail.com>");
>> +MODULE_DESCRIPTION("STMicroelectronics STM32F4 I2C driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
