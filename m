From: Corey Minyard <minyard@acm.org>
Subject: Re: [v2,05/10] i2c-i801: Consolidate calls to i801_check_post
Date: Fri, 10 Jun 2016 06:09:44 -0500
Message-ID: <575A9FF8.1070706@acm.org>
References: <1464570544-975-6-git-send-email-minyard@acm.org>
 <20160609100329.GG24234@mail.corp.redhat.com>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32935 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbcFJLJx (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 10 Jun 2016 07:09:53 -0400
In-Reply-To: <20160609100329.GG24234@mail.corp.redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

On 06/09/2016 05:03 AM, Benjamin Tissoires wrote:
> On May 29 2016 or thereabouts, Corey Minyard wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> This was almost always called at the end of the transaction.  The
>> only time it wasn't called was when a protocol violation occurred,
>> and the error reporting was inconsistent there.
>>
>> So have the transaction functions return positive status or a
>> negative error if they detect an issue.  If a protocol violation
>> does occur, always do a kill operation on the bus instead of just
>> trying to finish the operation.  If there was a hardware issue,
>> the code that was there to terminate the transaction could loop
>> forever, and the kill seems more appropriate if something goes
>> grossly wrong.
>>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
> I *think* the patch is OK. I have a few comments.
>
>>   drivers/i2c/busses/i2c-i801.c | 51 +++++++++++++++++++++----------------------
>>   1 file changed, 25 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
>> index 8794e70..56db310 100644
>> --- a/drivers/i2c/busses/i2c-i801.c
>> +++ b/drivers/i2c/busses/i2c-i801.c
>> @@ -317,7 +317,13 @@ static int i801_check_post(struct i801_priv *priv, int status)
>>   	 * DEV_ERR.
>>   	 */
>>   	if (unlikely(status < 0)) {
>> -		dev_err(&priv->pci_dev->dev, "Transaction timeout\n");
>> +		result = status;
>> +		if (status == -EPROTO)
>> +			dev_err(&priv->pci_dev->dev,
>> +				"Illegal SMBus block read size %d\n",
>> +				priv->len);
> Not sure this is a good idea to map -EPROTO to "Illegal SMBus block read
> size". True, it looks like it can only happens this way, but I would
> rather see it mapped to "Protocol Error". Given that Protocol Error is
> not very interesting in itself, I'd rather keep the error messages in
> the callers only (except for ETIMEOUT where you can output an error
> message).

That would mean you would have exactly the same error print in
two (well, three if you count a future patch) different locations in the
code.  I moved it here to avoid that issue.  I agree that "Protocol
Error" is not that specific, and I don't see a clean way to communicate
this information.  So I think you are right.

>> +		else
>> +			dev_err(&priv->pci_dev->dev, "Transaction timeout\n");
>>   		/* try to stop the current command */
>>   		dev_dbg(&priv->pci_dev->dev, "Terminating the current operation\n");
>>   		outb_p(inb_p(SMBHSTCNT(priv)) | SMBHSTCNT_KILL,
>> @@ -333,7 +339,7 @@ static int i801_check_post(struct i801_priv *priv, int status)
>>   			dev_err(&priv->pci_dev->dev,
>>   				"Failed terminating the transaction\n");
>>   		outb_p(STATUS_FLAGS, SMBHSTSTS(priv));
>> -		return -ETIMEDOUT;
>> +		return result;
>>   	}
>>   
>>   	if (status & SMBHSTSTS_FAILED) {
>> @@ -414,15 +420,14 @@ static int i801_transaction(struct i801_priv *priv, int xact)
>>   				 "Timeout waiting for interrupt!\n");
> Here, the code already dev_warn the timeout and later i801_check_post
> will dev_err the timeout too. That's one too much IMO :)

Indeed, I didn't notice that.

>
>>   		}
>>   		priv->status = 0;
>> -		return i801_check_post(priv, status);
>> +		return status;
>>   	}
>>   
>>   	/* the current contents of SMBHSTCNT can be overwritten, since PEC,
>>   	 * SMBSCMD are passed in xact */
>>   	outb_p(xact | SMBHSTCNT_START, SMBHSTCNT(priv));
>>   
>> -	status = i801_wait_intr(priv);
>> -	return i801_check_post(priv, status);
>> +	return i801_wait_intr(priv);
>>   }
>>   
>>   static int i801_block_transaction_by_block(struct i801_priv *priv,
>> @@ -444,11 +449,11 @@ static int i801_block_transaction_by_block(struct i801_priv *priv,
>>   
>>   	status = i801_transaction(priv, I801_BLOCK_DATA |
>>   				  (hwpec ? SMBHSTCNT_PEC_EN : 0));
>> -	if (status)
>> +	if (status < 0 || status & STATUS_ERROR_FLAGS)
>>   		return status;
>>   
>>   	if (read_write == I2C_SMBUS_READ) {
>> -		len = inb_p(SMBHSTDAT0(priv));
>> +		len = priv->len = inb_p(SMBHSTDAT0(priv));
>>   		if (len < 1 || len > I2C_SMBUS_BLOCK_MAX)
>>   			return -EPROTO;
>>   
>> @@ -456,7 +461,7 @@ static int i801_block_transaction_by_block(struct i801_priv *priv,
>>   		for (i = 0; i < len; i++)
>>   			data->block[i + 1] = inb_p(SMBBLKDAT(priv));
>>   	}
>> -	return 0;
>> +	return status;
>>   }
>>   
>>   static void i801_isr_byte_done(struct i801_priv *priv)
>> @@ -590,7 +595,7 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
>>   				 "Timeout waiting for interrupt!\n");
>>   		}
>>   		priv->status = 0;
>> -		return i801_check_post(priv, status);
>> +		return status;
>>   	}
>>   
>>   	for (i = 1; i <= len; i++) {
>> @@ -604,24 +609,14 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
>>   
>>   		status = i801_wait_byte_done(priv);
>>   		if (status)
>> -			goto exit;
>> +			return status;
>>   
>>   		if (i == 1 && read_write == I2C_SMBUS_READ
>>   		 && command != I2C_SMBUS_I2C_BLOCK_DATA) {
>> -			len = inb_p(SMBHSTDAT0(priv));
>> -			if (len < 1 || len > I2C_SMBUS_BLOCK_MAX) {
>> -				dev_err(&priv->pci_dev->dev,
>> -					"Illegal SMBus block read size %d\n",
>> -					len);
>> -				/* Recover */
>> -				while (inb_p(SMBHSTSTS(priv)) &
>> -				       SMBHSTSTS_HOST_BUSY)
>> -					outb_p(SMBHSTSTS_BYTE_DONE,
>> -					       SMBHSTSTS(priv));
>> -				outb_p(SMBHSTSTS_INTR, SMBHSTSTS(priv));
>> +			priv->len = inb_p(SMBHSTDAT0(priv));
>> +			if (priv->len < 1 || priv->len > I2C_SMBUS_BLOCK_MAX)
>>   				return -EPROTO;
>> -			}
>> -			data->block[0] = len;
>> +			data->block[0] = len = priv->len;
> Not entirely sure why the priv->len changes are interleaved in this
> patch. I might be missing something, but it looks like it should not be
> there or in a separate patch.

This was so the code reporting the error in the check_post function could
print out the length value.  If I move the logs to where the error is 
detected,
the priv->len setting here will no longer be necessary.

Thanks,

-corey

> Cheers,
> Benjamin
>
>>   		}
>>   
>>   		/* Retrieve/store value in SMBBLKDAT */
>> @@ -634,9 +629,7 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
>>   		outb_p(SMBHSTSTS_BYTE_DONE, SMBHSTSTS(priv));
>>   	}
>>   
>> -	status = i801_wait_intr(priv);
>> -exit:
>> -	return i801_check_post(priv, status);
>> +	return i801_wait_intr(priv);
>>   }
>>   
>>   static int i801_set_block_buffer_mode(struct i801_priv *priv)
>> @@ -791,6 +784,12 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
>>   	else
>>   		ret = i801_transaction(priv, xact);
>>   
>> +	/*
>> +	 * ret can be status if positive or an error if negative.  Let
>> +	 * the post check handle it.
>> +	 */
>> +	ret = i801_check_post(priv, ret);
>> +
>>   	if (hostc >= 0)
>>   		pci_write_config_byte(priv->pci_dev, SMBHSTCFG, hostc);
>>   
