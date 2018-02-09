From: Ben Gardner <gardner.ben@gmail.com>
Subject: Re: [PATCH] i2c: designware: Fix failure on baytrail
Date: Fri, 9 Feb 2018 09:07:44 -0600
Message-ID: <CAE7DoPbMMMbTV5i-fmfhrzKTVoj8Up8aXRYZU9jMh7hKNkkejQ@mail.gmail.com>
References: <1518113569-19991-1-git-send-email-gardner.ben@gmail.com> <945d4119-5aaf-520f-de2c-a9293f236f13@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:44674 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeBIPHq (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 9 Feb 2018 10:07:46 -0500
Received: by mail-io0-f170.google.com with SMTP id z6so9924282iob.11
        for <linux-i2c@vger.kernel.org>; Fri, 09 Feb 2018 07:07:46 -0800 (PST)
In-Reply-To: <945d4119-5aaf-520f-de2c-a9293f236f13@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi Jarkko,

I'm out of the office until Monday and I don't have access to my
notes, so this is from memory.

My board uses 3 of the i2c buses. Two have only 1 device, the
problematic one has two devices.
All devices are declared via ACPI, so they all load their drivers right away.
The first i2c transaction always worked. I didn't see any issues with
the two i2c buses that only have 1 device.
The second i2c transaction, which immediately followed, would fail.
The bus no longer worked after that.

I bisected the kernel to try to find where this broke, but the answer
I kept on getting didn't make any sense.
I think t was this commit:

4d6d5f1d08d2138dc43b28966eb6200e3db2e623 i2c: designware: fix rx fifo
depth tracking

Of course, reverting that one commit didn't fix anything.
So I added a log to the dw_readl() and dw_writel() functions in both a
working and broken kernel and compared.

In the working kernel, the enable sequence wrote 1 to enable, read
back 0, write 1 again, read back 1.

The non-working kernel just wrote the 1 to then enable register and
then went on.
I assume it ignored some subsequent register writes and ended up with
a broken bus.
I'd see weird stuff like an abort interrupt. I do find it odd that the
bus never recovered.

I suspect that if there was a delay between the two transactions, it
would not have failed.

>> The I2C driver for my Atom E3845 board has been broken since 4.9.
>>
>> These kernel logs show up whenever am I2C transaction is attempted.
>> i2c-designware-pci 0000:00:18.3: timeout in disabling adapter
>> i2c-designware-pci 0000:00:18.3: timeout waiting for bus ready
>>
>> The root issue is that the I2C port takes a while to enable and somewhere
>> along the way, the 'enable-and-wait' approach to enabling the adapter
>> was changed to 'enable'.
>> That caused the driver and hardware to get out of sync and fail.
>>
>> I have tested this patch on 4.14 and 4.15.
>>
>> Signed-off-by: Ben Gardner <gardner.ben@gmail.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-master.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-master.c
>> b/drivers/i2c/busses/i2c-designware-master.c
>> index ae69188..55926ef 100644
>> --- a/drivers/i2c/busses/i2c-designware-master.c
>> +++ b/drivers/i2c/busses/i2c-designware-master.c
>> @@ -209,7 +209,7 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>>         i2c_dw_disable_int(dev);
>>         /* Enable the adapter */
>> -       __i2c_dw_enable(dev, true);
>> +       __i2c_dw_enable_and_wait(dev, true);
>>         /* Clear and enable interrupts */
>>         dw_readl(dev, DW_IC_CLR_INTR);
>
>
> It seems commit 2702ea7dbec5 ("i2c: designware: wait for disable/enable only
> if necessary") is most likely reason for regression. Are you able to test
> some version between v4.9 and v4.12 and revert that commit does it fix the
> issue for you? Can you also test your fix on the same kernel version but
> apply to drivers/i2c/busses/i2c-designware-core.c?

I will test a similar change on 4.9 on Monday.

> i2c-designware-master.c was renamed from i2c-designware-core.c in v4.13 and
> thus we need to have the separate fix for kernels v4.9-v4.12.

I will also create a similar patch for v4.9.

Ben
