From: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 2/4] i2c: add support for Diolan DLN-2 USB-I2C adapter
Date: Fri, 3 Oct 2014 15:30:28 +0300
Message-ID: <CAE1zotLmY-UMVCGgJB=1X2MuMgERjdD2f7TsXVonZxE-cWb+kA@mail.gmail.com>
References: <1411661254-5204-1-git-send-email-octavian.purdila@intel.com>
	<1411661254-5204-3-git-send-email-octavian.purdila@intel.com>
	<20141003011433.GG1323@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141003011433.GG1323@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Baluta <daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 3, 2014 at 4:14 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> Hi,
>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index 2ac87fa..6afc17e 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -1021,4 +1021,14 @@ config SCx200_ACB
>>         This support is also available as a module.  If so, the module
>>         will be called scx200_acb.
>>
>> +config I2C_DLN2
>> +       tristate "Diolan DLN-2 USB I2C adapter"
>> +       depends on MFD_DLN2
>> +       help
>> +         If you say yes to this option, support will be included for Diolan
>> +         DLN2, a USB to I2C interface.
>> +
>> +         This driver can also be built as a module.  If so, the module
>> +         will be called i2c-dln2.
>> +
>
> Please keep to the existing sorting.
>
>
>>  endmenu
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index 49bf07e..3118fea 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -100,5 +100,6 @@ obj-$(CONFIG_I2C_ELEKTOR) += i2c-elektor.o
>>  obj-$(CONFIG_I2C_PCA_ISA)    += i2c-pca-isa.o
>>  obj-$(CONFIG_I2C_SIBYTE)     += i2c-sibyte.o
>>  obj-$(CONFIG_SCx200_ACB)     += scx200_acb.o
>> +obj-$(CONFIG_I2C_DLN2)               += i2c-dln2.o
>
> Ditto!
>
>> +static int dln2_i2c_enable(struct dln2_i2c *dln2, bool enable)
>> +{
>> +     int ret;
>> +     u16 cmd;
>> +
>> +     if (enable)
>> +             cmd = DLN2_I2C_ENABLE;
>> +     else
>> +             cmd = DLN2_I2C_DISABLE;
>
> Ternary operator?
>

In the first versions of the patch it was used, but Johan suggested to avoid it.

I have addressed the rest of you comments, thanks for the review.
