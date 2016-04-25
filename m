From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v7 03/15] i2c: octeon: Remove I2C_FUNC_SMBUS_QUICK support
Date: Mon, 25 Apr 2016 15:28:25 -0700
Message-ID: <571E9A09.60409@caviumnetworks.com>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com> <1461594824-7215-4-git-send-email-jglauber@cavium.com> <20160425221621.GI1550@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0076.outbound.protection.outlook.com ([65.55.169.76]:31472
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750816AbcDYWnN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Apr 2016 18:43:13 -0400
In-Reply-To: <20160425221621.GI1550@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jan Glauber <jglauber@cavium.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

On 04/25/2016 03:16 PM, Wolfram Sang wrote:
> On Mon, Apr 25, 2016 at 04:33:32PM +0200, Jan Glauber wrote:
>> SMBUS QUICK never worked for the read case, because EINVAL was returned
>> for a zero length message. The hardware does not support SMBUS QUICK
>> messages so disable the support and remove the zero length check.
>>
>> Signed-off-by: Jan Glauber <jglauber@cavium.com>
>
> I see better now and I think we need to drop this patch. It looks like
> the driver supports only SMBUS_QUICK_WRITE which can be used for
> scanning devices. The driver probably works with 'i2cdetect -q'. This
> will regress if I apply the patch.
>
> It seems it can't do SMBUS_QUICK_READ thus the extra check in the code.
>
> I2C_FUNC_SMBUS_QUICK should have been split up in READ and WRITE to
> support this scenario.
>
> Are my assumptions correct?

I think you may be reading too much into the intent of the code.

I don't know that anyone has ever run "i2cdetect -q" on these buses, I 
know that I haven't.  Since I2C is inherently unprobable, we specify the 
presence of all devices from the device tree passed by system firmware. 
  Runtime scanning for devices is not necessary.

That said, it is not a big deal one way or the other with respect to 
this patch.  If someone verifies that "i2cdetect -q" does something 
sensible, then there is probably no harm in dropping this patch.


>
>
>> ---
>>   drivers/i2c/busses/i2c-octeon.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
>> index 0f536a1..ad563cf 100644
>> --- a/drivers/i2c/busses/i2c-octeon.c
>> +++ b/drivers/i2c/busses/i2c-octeon.c
>> @@ -459,9 +459,6 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
>>   	int i, result, length = *rlength;
>>   	bool final_read = false;
>>
>> -	if (length < 1)
>> -		return -EINVAL;
>> -
>>   	octeon_i2c_data_write(i2c, (target << 1) | 1);
>>   	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
>>
>> @@ -597,7 +594,7 @@ static struct i2c_bus_recovery_info octeon_i2c_recovery_info = {
>>
>>   static u32 octeon_i2c_functionality(struct i2c_adapter *adap)
>>   {
>> -	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
>> +	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK) |
>>   	       I2C_FUNC_SMBUS_READ_BLOCK_DATA | I2C_SMBUS_BLOCK_PROC_CALL;
>>   }
>>
>> --
>> 1.9.1
>>
