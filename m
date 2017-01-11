From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH] i2c: piix4: Avoid race conditions with IMC
Date: Wed, 11 Jan 2017 10:11:01 +0100
Message-ID: <CAPybu_3Aocq6KmY-W0J4eO0v2j9C-qZXsY4-=bEK+YQqbZhdmA@mail.gmail.com>
References: <20170110121600.30649-1-ricardo.ribalda@gmail.com> <CAHp75VdnoW84sQh-vf57NSC6_tXGqvb_36KCPpi-XFbktWiKfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33851 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756370AbdAKJLY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 11 Jan 2017 04:11:24 -0500
In-Reply-To: <CAHp75VdnoW84sQh-vf57NSC6_tXGqvb_36KCPpi-XFbktWiKfw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Andy

Thanks for your review!

On Wed, Jan 11, 2017 at 2:49 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jan 10, 2017 at 2:16 PM, Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
>> On AMD's SB800 and upwards, the SMBus is shared with the Integrated
>> Micro Controller (IMC).
>>
>> The platform provides a hardware semaphore to avoid race conditions
>> among them. (Check page 288 of the SB800-Series Southbridges Register
>> Reference Guide http://support.amd.com/TechDocs/45482.pdf)
>
> It would be nice to understand what kind of devices are accessing and to where.

On my platform I found out that the IMC is polling address 0x98 and
0x99 every 14 and 177 msec.

Check out:

https://postimg.org/image/bssxhlg9d
https://postimg.org/image/g37ld6lch

But be aware that the firmware on the IMC might be different on other
platforms so the addresses and interval will be different.

>
> Hans seems discovered one pretty nice issue on Intel
> BayTrail/CherryTrail platforms where I2C semaphore is used to prevent
> simultaneous access to P-Unit, but we have two paths there which are
> not synchronized (yet). It brings a set of interesting (and
> unfortunately "famous") bugs.

AFAIK on AMD the smbus is just used on this driver.


>
>>
>> Without this patch, many access to the SMBus end with an invalid
>> transaction or even with the bus stalled.
>>
>
>> Credit-to: Alexandre Desnoyers <alex@qtec.com>
>
> Never saw before. Did he suggested the solution or what?

He is the hardware engineer where I work (qtec), when I showed him the
the logic analyzer output and told him that I was pretty sure that the
kernel/userpace was not doing those transactions he came up with the
theory of the IMC. He found up the semaphore on the documentation
also, so he deserves a lot of credit :).

>
>> --- a/drivers/i2c/busses/i2c-piix4.c
>> +++ b/drivers/i2c/busses/i2c-piix4.c
>> @@ -585,9 +585,28 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
>>                  u8 command, int size, union i2c_smbus_data *data)
>>  {
>>         struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
>> +       unsigned short piix4_smba = adapdata->smba;
>>         u8 smba_en_lo;
>>         u8 port;
>>         int retval;
>> +       int timeout = 0;
>> +       int smbslvcnt;
>
>> while (++timeout < MAX_TIMEOUT) {
>
> Usual pattern is countdown.

I was trying to follow the pattern on the file.

>
>> +       /* SMBus is still owned by the IMC, we give up */
>> +       if (timeout == MAX_TIMEOUT)
>> +               return -EBUSY;
>
> Would caller do it again? Perhaps -EAGAIN?

I think in this case we should return -EBUSY. If after 500 attempts
the bus is still hold by the IMC the bus is stalled or the IMC is
crashed, we should not retry. It is also the same errcode returned by
piix4_transaction().

>
> Since the returned value is not -ETIMEDOUT, I suppose the name of
> counter variable is a bit confusing. Basically it's amount of attempts
> with some gap between them. Though, it's up to you and maintainer.
>
>> +       /* Release the semaphore */
>> +       outb_p(smbslvcnt | 0x20, SMBSLVCNT);
>
> --
> With Best Regards,
> Andy Shevchenko

Thanks again, I will send a v2 with your comments!



-- 
Ricardo Ribalda
