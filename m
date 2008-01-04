From: "Byron Bradley" <byron.bbradley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] Add support for the S-35390A RTC chip.
Date: Fri, 4 Jan 2008 22:46:15 +0000
Message-ID: <57e2b00801041446l4b515353rc82f56a3846276d2@mail.gmail.com>
References: <1197751376-9767-1-git-send-email-byron.bbradley@gmail.com>
	<1197751376-9767-2-git-send-email-byron.bbradley@gmail.com>
	<20080104210605.05e1a0d4@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080104210605.05e1a0d4-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, repvik-ifZ3rLY3rVnQT0dZR+AlfA@public.gmane.org, hvr-mXXj517/zsQ@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, timtimred-f/KTTADhmRsdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Jan 4, 2008 8:06 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Sat, 15 Dec 2007 20:42:55 +0000, Byron Bradley wrote:
> > This adds basic get/set time support for the Seiko Instruments
> > S-35390A. This chip communicates using I2C and is used on the
> > QNAP TS-109/TS-209 NAS devices.
>
> My review of the i2c side of things (mainly):
>
>
> > Signed-off-by: Byron Bradley <byron.bbradley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Tested-by: Tim Ellis <timtimred-f/KTTADhmRsdnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/rtc/Kconfig       |    9 ++
> >  drivers/rtc/Makefile      |    1 +
> >  drivers/rtc/rtc-s35390a.c |  302 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 312 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/rtc/rtc-s35390a.c
> >
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 1e6715e..6c0fdf9 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -246,6 +246,15 @@ config RTC_DRV_TWL92330
> >         platforms.  The support is integrated with the rest of
> >         the Menelaus driver; it's not separate module.
> >
> > +config RTC_DRV_S35390A
> > +     tristate "Seiko Instruments S-35390A"
> > +     help
> > +       If you say yes here you will get support for the Seiko
> > +       Instruments S-35390A.
> > +
> > +       This driver can also be built as a module. If so the module
> > +       will be called rtc-s35390a.
> > +
> >  endif # I2C
> >
> >  comment "SPI RTC drivers"
> > diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> > index 465db4d..8d6218f 100644
> > --- a/drivers/rtc/Makefile
> > +++ b/drivers/rtc/Makefile
> > @@ -41,6 +41,7 @@ obj-$(CONFIG_RTC_DRV_PL031) += rtc-pl031.o
> >  obj-$(CONFIG_RTC_DRV_RS5C313)        += rtc-rs5c313.o
> >  obj-$(CONFIG_RTC_DRV_RS5C348)        += rtc-rs5c348.o
> >  obj-$(CONFIG_RTC_DRV_RS5C372)        += rtc-rs5c372.o
> > +obj-$(CONFIG_RTC_DRV_S35390A)        += rtc-s35390a.o
> >  obj-$(CONFIG_RTC_DRV_S3C)    += rtc-s3c.o
> >  obj-$(CONFIG_RTC_DRV_SA1100) += rtc-sa1100.o
> >  obj-$(CONFIG_RTC_DRV_SH)     += rtc-sh.o
> > diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> > new file mode 100644
> > index 0000000..29a95b6
> > --- /dev/null
> > +++ b/drivers/rtc/rtc-s35390a.c
> > @@ -0,0 +1,302 @@
> > +/*
> > + * Seiko Instruments S-35390A RTC Driver
> > + *
> > + * Copyright (c) 2007 Byron Bradley
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/rtc.h>
> > +#include <linux/i2c.h>
> > +#include <linux/bcd.h>
>
> You also need to include <linux/slab.h> for kzalloc and kfree.
>
>
> > +
> > +#define S35390A_CMD_STATUS1  0
> > +#define S35390A_CMD_STATUS2  1
> > +#define S35390A_CMD_TIME1    2
> > +
> > +#define S35390A_BYTE_YEAR    0
> > +#define S35390A_BYTE_MONTH   1
> > +#define S35390A_BYTE_DAY     2
> > +#define S35390A_BYTE_WDAY    3
> > +#define S35390A_BYTE_HOURS   4
> > +#define S35390A_BYTE_MINS    5
> > +#define S35390A_BYTE_SECS    6
> > +
> > +#define S35390A_FLAG_POC     0x01
> > +#define S35390A_FLAG_BLD     0x02
> > +#define S35390A_FLAG_24H     0x40
> > +#define S35390A_FLAG_RESET   0x80
> > +#define S35390A_FLAG_TEST    0x01
> > +
> > +struct s35390a {
> > +     struct i2c_client *client;
> > +     struct rtc_device *rtc;
> > +     int twentyfourhour;
> > +};
> > +
> > +static int s35390a_set_reg(struct s35390a *s35390a, int reg, char *buf, int len)
> > +{
> > +     struct i2c_client *client = s35390a->client;
> > +     struct i2c_msg msg[] = {
> > +             { client->addr | reg, 0, len, buf },
> > +     };
> > +
> > +     /* Only write to the writable bits in the status1 register */
> > +     if (reg == S35390A_CMD_STATUS1)
> > +             buf[0] &= 0xf;
>
> This would be more efficiently handled in the caller. After all there's
> only one place where you write to this register.
>
> > +
> > +     if ((i2c_transfer(client->adapter, msg, 1)) != 1)
> > +             return -EIO;
> > +
> > +     return 0;
> > +}
> > +
> > +static int s35390a_get_reg(struct s35390a *s35390a, int reg, char *buf, int len)
> > +{
> > +     struct i2c_client *client = s35390a->client;
> > +     struct i2c_msg msg[] = {
> > +             { client->addr | reg, I2C_M_RD, len, buf },
> > +     };
> > +
> > +     if ((i2c_transfer(client->adapter, msg, 1)) != 1)
> > +             return -EIO;
> > +
> > +     return 0;
> > +}
> > +
> > +static int s35390a_reset(struct s35390a *s35390a)
> > +{
> > +     char buf[1];
> > +
> > +     if (s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, buf, sizeof(buf)) < 0)
> > +             return -EIO;
> > +
> > +     if (!(buf[0] & (S35390A_FLAG_POC | S35390A_FLAG_BLD)))
> > +             return 0;
>
> This will return if _either_ flag is set, is it what you want?

The ! means that this will return if neither flag is set right? POC
means that the device is newly powered and the register state may be
invalid. BLD is set when the power drops below minimum so again the
registers could be invalid. In either case the device should be reset

> > +
> > +     buf[0] |= S35390A_FLAG_RESET;
> > +     return s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, buf, sizeof(buf));
>
> There's something wrong here. You set S35390A_FLAG_RESET which is 0x80,
> but then in s35390a_set_reg() you mask the value with 0xf, which resets
> the RESET bit to 0, before you write it to the chip.

Yes, the mask should be 0xf0, it was written before I realised the
bit-order was reversed.

> > +}
> > +
> > +static int s35390a_disable_test_mode(struct s35390a *s35390a)
> > +{
> > +     char buf[1];
> > +
> > +     if (s35390a_get_reg(s35390a, S35390A_CMD_STATUS2, buf, sizeof(buf)) < 0)
> > +             return -EIO;
> > +
> > +     if (!(buf[0] & S35390A_FLAG_TEST))
> > +             return 0;
> > +
> > +     buf[0] &= ~S35390A_FLAG_TEST;
> > +     return s35390a_set_reg(s35390a, S35390A_CMD_STATUS2, buf, sizeof(buf));
> > +}
> > +
> > +static char s35390a_hr2reg(struct s35390a *s35390a, int hour)
> > +{
> > +     if (s35390a->twentyfourhour)
> > +             return BIN2BCD(hour);
> > +
> > +     if (hour < 12)
> > +             return BIN2BCD(hour);
> > +
> > +     return 0x40 | BIN2BCD(hour - 12);
> > +}
> > +
> > +static int s35390a_reg2hr(struct s35390a *s35390a, char reg)
> > +{
> > +     unsigned hour;
> > +
> > +     if (s35390a->twentyfourhour)
> > +             return BCD2BIN(reg & 0x3f);
> > +
> > +     hour = BCD2BIN(reg & 0x3f);
> > +     if (reg & 0x40)
> > +             hour += 12;
> > +
> > +     return hour;
> > +}
> > +
> > +static inline char reverse(char x)
> > +{
> > +     x = ((x >> 1) & 0x55) | ((x << 1) & 0xaa);
> > +     x = ((x >> 2) & 0x33) | ((x << 2) & 0xcc);
> > +     return (x >> 4) | (x << 4);
> > +}
> > +
> > +static int s35390a_set_datetime(struct i2c_client *client, struct rtc_time *tm)
> > +{
> > +     struct s35390a  *s35390a = i2c_get_clientdata(client);
> > +     int i, err;
> > +     char buf[7];
> > +
> > +     dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d mday=%d, "
> > +             "mon=%d, year=%d, wday=%d\n", __FUNCTION__, tm->tm_sec,
> > +             tm->tm_min, tm->tm_hour, tm->tm_mday, tm->tm_mon, tm->tm_year,
> > +             tm->tm_wday);
> > +
> > +     buf[S35390A_BYTE_YEAR] = BIN2BCD(tm->tm_year - 100);
> > +     buf[S35390A_BYTE_MONTH] = BIN2BCD(tm->tm_mon + 1);
> > +     buf[S35390A_BYTE_DAY] = BIN2BCD(tm->tm_mday);
> > +     buf[S35390A_BYTE_WDAY] = BIN2BCD(tm->tm_wday);
> > +     buf[S35390A_BYTE_HOURS] = s35390a_hr2reg(s35390a, tm->tm_hour);
> > +     buf[S35390A_BYTE_MINS] = BIN2BCD(tm->tm_min);
> > +     buf[S35390A_BYTE_SECS] = BIN2BCD(tm->tm_sec);
> > +
> > +     /* This chip expects the bits of each byte to be in reverse order */
> > +     for (i = 0; i < 7; ++i)
> > +             buf[i] = reverse(buf[i]);
> > +
> > +     err = s35390a_set_reg(s35390a, S35390A_CMD_TIME1, buf, sizeof(buf));
> > +
> > +     return err;
> > +}
> > +
> > +static int s35390a_get_datetime(struct i2c_client *client, struct rtc_time *tm)
> > +{
> > +     struct s35390a *s35390a = i2c_get_clientdata(client);
> > +     char buf[7];
> > +     int i, err;
> > +
> > +     err = s35390a_get_reg(s35390a, S35390A_CMD_TIME1, buf, sizeof(buf));
> > +     if (err < 0)
> > +             return err;
> > +
> > +     /* This chip returns the bits of each byte in reverse order */
> > +     for (i = 0; i < 7; ++i)
> > +             buf[i] = reverse(buf[i]);
> > +
> > +     tm->tm_sec = BCD2BIN(buf[S35390A_BYTE_SECS]);
> > +     tm->tm_min = BCD2BIN(buf[S35390A_BYTE_MINS]);
> > +     tm->tm_hour = s35390a_reg2hr(s35390a, buf[S35390A_BYTE_HOURS]);
> > +     tm->tm_wday = BCD2BIN(buf[S35390A_BYTE_WDAY]);
> > +     tm->tm_mday = BCD2BIN(buf[S35390A_BYTE_DAY]);
> > +     tm->tm_mon = BCD2BIN(buf[S35390A_BYTE_MONTH]) - 1;
> > +     tm->tm_year = BCD2BIN(buf[S35390A_BYTE_YEAR]) + 100;
> > +
> > +     dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d, mday=%d, "
> > +             "mon=%d, year=%d, wday=%d\n", __FUNCTION__, tm->tm_sec,
> > +             tm->tm_min, tm->tm_hour, tm->tm_mday, tm->tm_mon, tm->tm_year,
> > +             tm->tm_wday);
> > +
> > +     return rtc_valid_tm(tm);
> > +}
> > +
> > +static int s35390a_rtc_read_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +     return s35390a_get_datetime(to_i2c_client(dev), tm);
> > +}
> > +
> > +static int s35390a_rtc_set_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +     return s35390a_set_datetime(to_i2c_client(dev), tm);
> > +}
> > +
> > +static const struct rtc_class_ops s35390a_rtc_ops = {
> > +     .read_time      = s35390a_rtc_read_time,
> > +     .set_time       = s35390a_rtc_set_time,
> > +};
> > +
> > +static struct i2c_driver s35390a_driver;
> > +
> > +static int s35390a_probe(struct i2c_client *client)
> > +{
> > +     int err = 0;
>
> Useless initialization.
>
>
> > +     struct s35390a *s35390a;
> > +     struct rtc_time tm;
> > +     char buf[1];
> > +
> > +     if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> > +             err = -ENODEV;
> > +             goto exit;
> > +     }
> > +
> > +     s35390a = kzalloc(sizeof(struct s35390a), GFP_KERNEL);
> > +     if (!s35390a) {
> > +             err = -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     s35390a->client = client;
> > +     i2c_set_clientdata(client, s35390a);
> > +
> > +     err = s35390a_disable_test_mode(s35390a);
> > +     if (err < 0) {
> > +             dev_err(&client->dev, "error disabling test mode\n");
> > +             goto exit_kfree;
> > +     }
> > +
> > +     err = s35390a_reset(s35390a);
> > +     if (err < 0) {
> > +             dev_err(&client->dev, "error resetting chip\n");
> > +             goto exit_kfree;
> > +     }
> > +
> > +     err = s35390a_get_reg(s35390a, S35390A_CMD_STATUS1, buf, sizeof(buf));
> > +     if (err < 0) {
> > +             dev_err(&client->dev, "error checking 12/24 hour mode\n");
> > +             goto exit_kfree;
> > +     }
> > +     if (buf[0] & S35390A_FLAG_24H)
> > +             s35390a->twentyfourhour = 1;
> > +     else
> > +             s35390a->twentyfourhour = 0;
>
> Wouldn't it be more efficient to just force 24h mode here?

I did think about this but of the RTC drivers I was looking at they
all supported both modes. As David Brownell has already pointed out
changing this value is difficult because the time data would become
invalid. I could however switch to 24 hour mode whenever the chip is
reset, this would simplify the runtime a little.

> > +
> > +     if (s35390a_get_datetime(client, &tm) < 0)
> > +             dev_warn(&client->dev, "clock needs to be set\n");
> > +
> > +     dev_info(&client->dev, "S35390A found\n");
>
> rtc_device_register already prints a message so this is somewhat
> redundant.
>
> > +
> > +     s35390a->rtc = rtc_device_register(s35390a_driver.driver.name,
> > +                             &client->dev, &s35390a_rtc_ops, THIS_MODULE);
> > +
> > +     if (IS_ERR(s35390a->rtc)) {
> > +             err = PTR_ERR(s35390a->rtc);
> > +             goto exit_kfree;
> > +     }
> > +     return 0;
> > +
> > +exit_kfree:
>
> I suggest adding:
>         i2c_set_clientdata(client, NULL);
> so as to not leave a dangling pointer behind.
>
> > +     kfree(s35390a);
> > +
> > +exit:
> > +     return err;
> > +}
> > +
> > +static int s35390a_remove(struct i2c_client *client)
> > +{
> > +     struct s35390a *s35390a = i2c_get_clientdata(client);
> > +
> > +     rtc_device_unregister(s35390a->rtc);
>
> Same here.
>
> > +     kfree(s35390a);
> > +     return 0;
> > +}
> > +
> > +static struct i2c_driver s35390a_driver = {
> > +     .driver         = {
> > +             .name   = "rtc-s35390a",
> > +     },
> > +     .probe          = s35390a_probe,
> > +     .remove         = s35390a_remove,
> > +};
> > +
> > +static int __init s35390a_rtc_init(void)
> > +{
> > +     return i2c_add_driver(&s35390a_driver);
> > +}
> > +
> > +static void __exit s35390a_rtc_exit(void)
> > +{
> > +     i2c_del_driver(&s35390a_driver);
> > +}
> > +
> > +MODULE_AUTHOR("Byron Bradley <byron.bbradley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
> > +MODULE_DESCRIPTION("S35390A RTC driver");
> > +MODULE_LICENSE("GPL");
> > +
> > +module_init(s35390a_rtc_init);
> > +module_exit(s35390a_rtc_exit);
>
> No other comment, that's pretty clean code overall.

Thanks for the comments, I'll resend as a single patch with the
changes and i2c_new_dummy() functionality.

> Note: due to the particular way this device is accessed, I don't think
> that we want to use SMBus-level functions (as had been suggested in a
> different thread) unless we really have to for compatibility purposes.
> Your code is quite nice the way it is and I suspect that using
> SMBus-level functions would make it much more complex.

Yes I started trying to change to the smbus functions but this is
difficult because it doesn't use the command part so when writing
multiple bytes the first data byte would have to be the command. I
never tried it but I'm not sure if the block read command would work
either because it requires a command and I don't think the chip would
like the extra data. I've noticed in testing it can be quite fussy, if
you try to write to a read only register it will lock up even though
the data sheet says it will ignore it.

-- 
Byron Bradley
