From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: Re: [PATCHv7 10/11] mfd: as3722: Rid driver of superfluous I2C device
 ID structure
Date: Mon, 7 Nov 2016 22:05:42 +0000
Message-ID: <fee215fd-bdd4-9657-92db-1f77794b1abf@bingham.xyz>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
 <1478522866-29620-11-git-send-email-kieran@bingham.xyz>
 <1ac3a33e-a85c-e781-81b6-c39f3d533da8@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1ac3a33e-a85c-e781-81b6-c39f3d533da8@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

Thanks for your reviews again Javier,

On 07/11/16 19:20, Javier Martinez Canillas wrote:
> Hello Kieran,
> 
> On 11/07/2016 09:47 AM, Kieran Bingham wrote:
>> From: Lee Jones <lee.jones@linaro.org>
>>
>> Also remove unused second probe() parameter 'i2c_device_id'.
>>
>> Acked-by: Grant Likely <grant.likely@linaro.org>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>
>>
>> ---
>> Changes since v4
>>  - Rename .probe2 to probe_new
>>
>>  drivers/mfd/as3722.c | 12 ++----------
>>  1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
>> index f87342c211bc..7d8c5e4136e2 100644
>> --- a/drivers/mfd/as3722.c
>> +++ b/drivers/mfd/as3722.c
>> @@ -354,8 +354,7 @@ static int as3722_i2c_of_probe(struct i2c_client *i2c,
>>  	return 0;
>>  }
>>  
>> -static int as3722_i2c_probe(struct i2c_client *i2c,
>> -			const struct i2c_device_id *id)
>> +static int as3722_i2c_probe(struct i2c_client *i2c)
>>  {
> 
> This is OK...
> 
>>  	struct as3722 *as3722;
>>  	unsigned long irq_flags;
>> @@ -441,12 +440,6 @@ static const struct of_device_id as3722_of_match[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, as3722_of_match);
>>  
>> -static const struct i2c_device_id as3722_i2c_id[] = {
>> -	{ "as3722", 0 },
>> -	{},
>> -};
>> -MODULE_DEVICE_TABLE(i2c, as3722_i2c_id);
>> -
> 
> ... but I don't think this is correct. Otherwise you will break module
> autoload for this driver since modpost needs the I2C device ID table
> info to fill the i2c modalias in the drivers' module.
> 
> Remember that i2c_device_uevent() always reports modalias of the form
> MODALIAS=i2c:<foo> even when your series allows to match without a I2C
> device ID table.
> 

Ok - Thanks for the reminder. I'll try to bear this in mind when we
start updating drivers.

For now we can consider this patch dropped from the series I think.

> Best regards,
> 

-- 
Regards

Kieran Bingham
