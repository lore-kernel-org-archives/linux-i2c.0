From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 10/12] i2c: pxa: Update debug function to dump more info
 on error
Date: Sat, 30 May 2015 03:15:27 +0530
Message-ID: <5568DDF7.5010506@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>	<1432818224-17070-11-git-send-email-vaibhav.hiremath@linaro.org> <87fv6fxdqu.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87fv6fxdqu.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Saturday 30 May 2015 03:12 AM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>
>> Update i2c_pxa_scream_blue_murder() fn to print more information
>> in case of error.
>>
>> Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>> [vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org: Split patches into logical changes
>> and update the Changelog]
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>   drivers/i2c/busses/i2c-pxa.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
>> index cf6c383..065e647 100644
>> --- a/drivers/i2c/busses/i2c-pxa.c
>> +++ b/drivers/i2c/busses/i2c-pxa.c
>> @@ -147,6 +147,7 @@ struct pxa_i2c {
>>   	unsigned int		msg_idx;
>>   	unsigned int		msg_ptr;
>>   	unsigned int		slave_addr;
>> +	unsigned int		req_slave_addr;
>>
>>   	struct i2c_adapter	adap;
>>   	struct clk		*clk;
>> @@ -335,11 +336,13 @@ err_out:
>>   static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
>>   {
>>   	unsigned int i;
>> -	printk(KERN_ERR "i2c: error: %s\n", why);
>> +	printk(KERN_ERR"i2c: <%s> slave_0x%x error: %s\n", i2c->adap.name,
>> +		i2c->req_slave_addr >> 1, why);
> Why not simply use dev_err(....) instead of adding manually i2c->adap.name ?
>

Actually I missed this. Thought of fixing this, but somehow forgot :)
Will fix it in next version.

Thanks,
Vaibhav
