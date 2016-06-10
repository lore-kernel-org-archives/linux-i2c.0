From: Corey Minyard <minyard@acm.org>
Subject: Re: [v2,04/10] i2c-i801: Consolidate calls to i801_check_pre()
Date: Fri, 10 Jun 2016 05:52:02 -0500
Message-ID: <575A9BD2.1070905@acm.org>
References: <1464570544-975-5-git-send-email-minyard@acm.org>
 <20160609094402.GF24234@mail.corp.redhat.com>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32863 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbcFJKwJ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 10 Jun 2016 06:52:09 -0400
In-Reply-To: <20160609094402.GF24234@mail.corp.redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

On 06/09/2016 04:44 AM, Benjamin Tissoires wrote:
> On May 29 2016 or thereabouts, Corey Minyard wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> It was always done before starting the transaction, so do it
>> in common code before the transaction start.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>   drivers/i2c/busses/i2c-i801.c | 12 ++++--------
>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
>> index 222be9c..8794e70 100644
>> --- a/drivers/i2c/busses/i2c-i801.c
>> +++ b/drivers/i2c/busses/i2c-i801.c
>> @@ -402,10 +402,6 @@ static int i801_transaction(struct i801_priv *priv, int xact)
>>   	int result;
>>   	const struct i2c_adapter *adap = &priv->adapter;
>>   
>> -	result = i801_check_pre(priv);
>> -	if (result < 0)
>> -		return result;
>> -
>>   	if (priv->features & FEATURE_IRQ) {
>>   		outb_p(xact | SMBHSTCNT_INTREN | SMBHSTCNT_START,
>>   		       SMBHSTCNT(priv));
>> @@ -562,10 +558,6 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
>>   	int result;
>>   	const struct i2c_adapter *adap = &priv->adapter;
>>   
>> -	result = i801_check_pre(priv);
>> -	if (result < 0)
>> -		return result;
>> -
>>   	len = data->block[0];
>>   
>>   	if (read_write == I2C_SMBUS_WRITE) {
>> @@ -789,6 +781,10 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
>>   		goto out;
>>   	}
>>   
>> +	ret = i801_check_pre(priv);
>> +	if (ret < 0)
>> +		goto out;
>> +
> The calls looks identical (it gets called before each transaction), but
> given that this is a status register, I wonder if this should not be
> checked once the setup has been done, and not at the very early
> beginning.

What I did is not a functional change from what was before, but I
think you may be right, it might be best to move this check this
before the switch statement above.  I'm not sure, though.

Jean, do you have any thoughts on this?

-corey

> Cheers,
> Benjamin
>
>>   	if (block)
>>   		ret = i801_block_transaction(priv, flags, data, read_write,
>>   					     size);
