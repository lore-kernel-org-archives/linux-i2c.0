From: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: RE: [PATCH] i2c: Support for Netlogic XLR/XLS I2C controller.
Date: Thu, 19 Jan 2012 14:33:35 +0000
Message-ID: <1EDB558E5F5FA14BB548E8397D4DD80901E07F@hqmbx01.netlogicmicro.com>
References: <1326900802-27831-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1326900802-27831-2-git-send-email-jayachandranc@netlogicmicro.com>,<20120118212702.GA21576@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120118212702.GA21576-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ganesan R <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang [w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org] wrote:
>> +config I2C_XLR
>> +     tristate "XLR I2C support"
>> +     depends on CPU_XLR
>> +     help
>> +       This driver enables support for the on-chip I2C interface of
>> +       the Netlogic XLR/XLS MIPS processors.
>> +
>> +       Say yes to this option if you have a Netlogic XLR/XLS based
>> +       board and you need to access the I2C devices (typically the
>> +       RTC, sensors, EEPROM) connected to this interface.
>
> Do you insist on this paragraph?

Not really :)
I did not see what is wrong here, but taken out anyway.

>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -68,6 +68,7 @@ obj-$(CONFIG_I2C_TEGRA)             += i2c-tegra.o
>>  obj-$(CONFIG_I2C_VERSATILE)  += i2c-versatile.o
>>  obj-$(CONFIG_I2C_OCTEON)     += i2c-octeon.o
>>  obj-$(CONFIG_I2C_XILINX)     += i2c-xiic.o
>> +obj-$(CONFIG_I2C_XLR)           += i2c-xlr.o
>
> Use tabs here.

Done, BTW, CONFIG_I2C_EG20T is also un-sorted and uses spaces.

>> +     retries = 0;
>> +retry:
>> +     pos = 1;
>> +     if (len == 1) {
>> +             xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
>> +                             XLR_I2C_STARTXFR_ND);
>> +     } else {
>> +             xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, buf[pos]);
>> +             xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
>> +                             XLR_I2C_STARTXFR_WR);
>> +     }
>> +
>> +     while (1) {
>> +             if (retries++ > MAX_RETRIES) {
>> +                     dev_err(&adap->dev, "I2C transmit timeout\n");
>> +                     return -ETIMEDOUT;
>> +             }
>
> Still no. A device usually fails after trying for a specific period of time,
> not after a number of retries. You need to work with jiffies here and
> time_after/time_before. Check drivers/misc/eeprom/at24.c for an example.
> Or check the second part of my talk from Prague :)
> http://free-electrons.com/blog/elce-2011-videos/

The timeout is only for the case where there is a serious issue, all the
normal cases including errors are handled in the code already. The retries
was just a mechanism not to hang the CPU when the hardware is dead. 

The normal transaction take about hundreds of microseconds and the
timeout is 10 times that, which will workout to about a jiffy...

Anyway, I have replaced it with jiffies based timeout.

>> +
>> +             i2c_status = xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
>> +
>> +             if (i2c_status & XLR_I2C_SDOEMPTY) {
>> +                     pos++;
>> +                     retries = 0;
>> +                     nb = (pos < len) ? buf[pos] : 0;
>> +                     xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, nb);
>> +             }
>> +
>> +             if (i2c_status & XLR_I2C_ARB_STARTERR)
>> +                     goto retry;
>
> This will be an endless loop if the STARTERR condition remains? Also this goto
> jumping out of the while loop is not nice. It might help to rearrange the
> loops.

No, the retry count is only reset when there is a successful byte transfer, so the
logic is okay.

[...]
>> +             i2c_status = xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
>> +             if (i2c_status & XLR_I2C_RXRDY) {
>> +                     buf[pos++] = (u8)xlr_i2c_rdreg(priv->iobase,
>> +                                     XLR_I2C_DATAIN);
>> +                     retries = 0;
>> +             }
>
> comments from above also here.

This was okay, but I have fixed up an unrelated issue in the code,
i.e. buf[len] could be written in some cases.

[...]
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (!res)
>> +             return -ENXIO;
>
> You don't have to check res, devm_request_and_ioremap() will do it for you.

Fixed. Thanks.

>> +     devm_release_mem_region(&pdev->dev, res->start, resource_size(res));
>> +     devm_iounmap(&pdev->dev, priv->iobase);
>
>You don't need to free devm_* resources. That's the main point of it :)

Thanks, fixed this here and in xlr_i2c_remove.  I will follow-up with the
updated patch.

JC.
