From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH] i2c: imx: use usleep_range(50,100) instead of udelay(50)
Date: Tue, 26 Apr 2016 14:22:08 +0200
Message-ID: <571F5D70.9010808@de.bosch.com>
References: <1461652066-16456-1-git-send-email-dirk.behme@de.bosch.com>
 <571F4AE1.7020207@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <571F4AE1.7020207@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>
List-Id: linux-i2c@vger.kernel.org

On 26.04.2016 13:02, Vladimir Zapolskiy wrote:
> Hi Dirk,
>
> On 26.04.2016 09:27, Dirk Behme wrote:
>> From: Oleksij Rempel <linux@rempel-privat.de>
>>
>> Documentation/timers/timers-howto.txt recommends to use
>> usleep_range on delays > 10usec. According to my test results
>> with Neonode zForce touchscreen driver, usleep_range indeed
>> reduces CPU load.
>>
>> Stats collected with "./perf record -a -g -F 1000 sleep 10"
>>
>> i2c-imx with udelay(50):
>> 34.19% 0.00% irq/220-Neonode [kernel.kallsyms] [k] irq_thread
>>      ---irq_thread
>>         |--33.75%--irq_thread_fn
>>         |    |--19.27%--0x7f08a878
>>         |    |     i2c_master_recv
>>         |    |     i2c_transfer
>>         |    |     __i2c_transfer
>>         |    |     i2c_imx_xfer
>>         |    |     |--11.71%--i2c_imx_trx_complete
>>         |    |     |--5.70%--i2c_imx_start <<<<----------------
>>         |    |     |     |--5.38%--__timer_const_udelay
>>         |    |     |     |      __timer_delay
>>         |    |     |     |      --5.07%--read_current_timer
>>
>> i2c-imx with usleep_range(50,100)
>> 29.08% 0.00% irq/220-Neonode  [kernel.kallsyms] [k] irq_thread
>>      ---irq_thread
>>         |--28.89%--irq_thread_fn
>>         |    |--17.21%--0x7f08a878
>>         |    |     i2c_master_recv
>>         |    |     |--17.14%--i2c_transfer
>>         |    |     |     __i2c_transfer
>>         |    |     |     i2c_imx_xfer
>>         |    |     |     |--14.29%--i2c_imx_trx_complete
>>         |    |     |     |--1.42%--i2c_imx_start <<<<----------
>>         |    |     |     |      |--0.71%--usleep_range
>>         |    |     |     |      |--0.53%--i2c_imx_bus_busy
>>
>> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>


Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>


> missing your Signed-off-by.
>
> Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>
>> ---
>>   drivers/i2c/busses/i2c-imx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>> index 1ca7ef2..1844bc9 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -525,7 +525,7 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
>>   	imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode, i2c_imx, IMX_I2C_I2CR);
>>
>>   	/* Wait controller to be stable */
>> -	udelay(50);
>> +	usleep_range(50, 150);
>>
>>   	/* Start I2C transaction */
>>   	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
>>
