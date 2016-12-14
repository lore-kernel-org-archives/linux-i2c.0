From: Tin Huynh <tnhuynh@apm.com>
Subject: Re: [PATCH V4] i2c: designware: fix wrong Tx/Rx FIFO for ACPI
Date: Wed, 14 Dec 2016 10:20:04 +0700
Message-ID: <CANQ9TuCuxsMKzfQ=14ppo-5kWnWXc=VK08ca7+dJL2xG_tkd_Q@mail.gmail.com>
References: <1481623414-19220-1-git-send-email-tnhuynh@apm.com> <1481628337.7188.63.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1481628337.7188.63.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>, Thang Nguyen <tqnguyen@apm.com>, Phong Vo <pvo@apm.com>, patches <patches@apm.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 13, 2016 at 6:25 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, 2016-12-13 at 17:03 +0700, Tin Huynh wrote:
>> ACPI always sets Tx/Rx FIFO to 32. This configuration will
>> cause problem if the IP core supports a FIFO size of less than 32.
>> The driver should read the FIFO size from the IP and select the
>> smaller
>> one of the two.
>>
>> Signed-off-by: Tin Huynh <tnhuynh@apm.com>
>>
>
> One comment below, after addressing it
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
>> ---
>>  drivers/i2c/busses/i2c-designware-platdrv.c |   27
>> ++++++++++++++++++++-------
>>  1 files changed, 20 insertions(+), 7 deletions(-)
>>
>> Change from V3:
>>  -Use uppercase of FIFO instead of lowercase.
>>  -Fix the problem  when IP core return 0 of FIFO.
>>
>> Change from V2:
>>  -Add a helper function to set FIFO size.
>>
>> Change from V1:
>>  -Revert the default 32 for FIFO, read parameter from IP core
>>  and pick the smaller one of the two.
>>  -Correct the title to describe new approach.
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index 0b42a12..24032d6 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -150,6 +150,25 @@ static int i2c_dw_plat_prepare_clk(struct
>> dw_i2c_dev *i_dev, bool prepare)
>>       return 0;
>>  }
>>
>> +static void dw_i2c_set_fifo_size(struct dw_i2c_dev *dev, int id)
>> +{
>> +     u32 param, tx_fifo_depth, rx_fifo_depth;
>> +
>>
>
>         /*
>          * Try to detect the FIFO depth if not
> set by interface driver,
>          * the depth could be from 2 to 256 from
> HW spec.
>          */
>
I will add your comment to the driver.
>> +     param = i2c_dw_read_comp_param(dev);
>> +     tx_fifo_depth = ((param >> 16) & 0xff) + 1;
>> +     rx_fifo_depth = ((param >> 8)  & 0xff) + 1;
>> +     if (!dev->tx_fifo_depth) {
>> +             dev->tx_fifo_depth = tx_fifo_depth;
>> +             dev->rx_fifo_depth = rx_fifo_depth;
>> +             dev->adapter.nr = id;
>> +     } else if (tx_fifo_depth > 1) {
>
> This makes sense now, though I would add a comment here and use >= 2 to
> reflect datasheet.
>
>                 /*
>                  * Choose minimum values between HW and interface
>                  * driver provided.
>                  */
>
I will implement as your comment. However , because adding 1 to the
value , can i use > 2  or >=3 ?
>> +             dev->tx_fifo_depth = min_t(u32, dev->tx_fifo_depth,
>> +                             tx_fifo_depth);
>> +             dev->rx_fifo_depth = min_t(u32, dev->rx_fifo_depth,
>> +                             rx_fifo_depth);
>> +     }
>> +}
>> +
>>  static int dw_i2c_plat_probe(struct platform_device *pdev)
>>  {
>>       struct dw_i2c_platform_data *pdata = dev_get_platdata(&pdev-
>> >dev);
>> @@ -246,13 +265,7 @@ static int dw_i2c_plat_probe(struct
>> platform_device *pdev)
>>                               1000000);
>>       }
>>
>> -     if (!dev->tx_fifo_depth) {
>> -             u32 param1 = i2c_dw_read_comp_param(dev);
>> -
>> -             dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
>> -             dev->rx_fifo_depth = ((param1 >> 8)  & 0xff) + 1;
>> -             dev->adapter.nr = pdev->id;
>> -     }
>> +     dw_i2c_set_fifo_size(dev, pdev->id);
>>
>>       adap = &dev->adapter;
>>       adap->owner = THIS_MODULE;
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
Thank you and regards,
Tin
