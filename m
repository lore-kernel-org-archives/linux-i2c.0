From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] i2c: designware-slave: constify i2c_algorithm structure
Date: Sun, 16 Jul 2017 23:08:19 -0500
Message-ID: <4bcd6609-963b-e64c-8c77-8badde089e6e@embeddedor.com>
References: <20170709213517.GA31846@embeddedgus>
 <1499682392.22624.320.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499682392.22624.320.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Andy,


On 07/10/2017 05:26 AM, Andy Shevchenko wrote:
> On Sun, 2017-07-09 at 16:35 -0500, Gustavo A. R. Silva wrote:
>> Check for i2c_algorithm structures that are only stored in
>> the algo field of an i2c_adapter structure. This field is
>> declared const, so i2c_algorithm structures that have this
>> property can be declared as const also.
>>
>> This issue was identified using Coccinelle and the following
>> semantic patch:
>>
>> @r disable optional_qualifier@
>> identifier i;
>> position p;
>> @@
>> static struct i2c_algorithm i@p = { ... };
>>
>> @ok@
>> identifier r.i;
>> struct i2c_adapter e;
>> position p;
>> @@
>> e.algo = &i@p;
>>
>> @bad@
>> position p != {r.p,ok.p};
>> identifier r.i;
>> @@
>> i@p
>>
>> @depends on !bad disable optional_qualifier@
>> identifier r.i;
>> @@
>> static
>> +const
>>   struct i2c_algorithm i = { ... };
> I don't think it's a good idea to copy'n'paste patch to each change
> where you fixing the issue. Can you create a github repository of the
> coccinelle recipes and give just a link?

I will take note of that, thanks for the suggestion.

> Other than that, I'm fine with the change as long as it compiles without
> troubles (had seen recently similar patch that has been sent without
> actual testing).
>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you

>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>>   drivers/i2c/busses/i2c-designware-slave.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-slave.c
>> b/drivers/i2c/busses/i2c-designware-slave.c
>> index 4012c74..e62799e 100644
>> --- a/drivers/i2c/busses/i2c-designware-slave.c
>> +++ b/drivers/i2c/busses/i2c-designware-slave.c
>> @@ -344,7 +344,7 @@ static irqreturn_t i2c_dw_isr_slave(int this_irq,
>> void *dev_id)
>>   	return IRQ_RETVAL(ret);
>>   }
>>   
>> -static struct i2c_algorithm i2c_dw_algo = {
>> +static const struct i2c_algorithm i2c_dw_algo = {
>>   	.functionality = i2c_dw_func,
>>   	.reg_slave = i2c_dw_reg_slave,
>>   	.unreg_slave = i2c_dw_unreg_slave,

-- 
Gustavo A. R. Silva
