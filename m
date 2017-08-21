From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] i2c: core: add device-managed version of i2c_new_dummy
Date: Mon, 21 Aug 2017 21:56:42 +0200
Message-ID: <68a1c44a-62c5-17d6-7295-6606838f8ce4@gmail.com>
References: <de2f844a-9d41-fa0e-cd55-fc7d2cea24d5@gmail.com>
 <4491c6a5-2cd1-1544-22c6-c843845145f4@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37093 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753492AbdHUUDJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 21 Aug 2017 16:03:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id z91so19567418wrc.4
        for <linux-i2c@vger.kernel.org>; Mon, 21 Aug 2017 13:03:08 -0700 (PDT)
In-Reply-To: <4491c6a5-2cd1-1544-22c6-c843845145f4@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Am 21.08.2017 um 20:42 schrieb Peter Rosin:
> Hi!
> 
> On 2017-08-21 20:24, Heiner Kallweit wrote:
>> i2c_new_dummy is typically called from the probe function of the
>> driver for the primary i2c client. It requires calls to
>> i2c_unregister_device in the error path of the probe function and
>> in the remove function.
>> This can be simplified by introducing a device-managed version.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/i2c/i2c-core-base.c | 29 +++++++++++++++++++++++++++++
>>  include/linux/i2c.h         |  3 +++
>>  2 files changed, 32 insertions(+)
> 
> You need to update Documentation/driver-model/devres.txt
> 
Right, thanks for the hint.

>> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
>> index 12822a4b..7eb48328 100644
>> --- a/drivers/i2c/i2c-core-base.c
>> +++ b/drivers/i2c/i2c-core-base.c
>> @@ -868,6 +868,35 @@ struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
>>  }
>>  EXPORT_SYMBOL_GPL(i2c_new_dummy);
>>  
>> +static void devm_i2c_release_dummy(struct device *dev, void *res)
>> +{
>> +	i2c_unregister_device(*(struct i2c_client **)res);
>> +}
>> +
>> +/* managed version of i2c_new_dummy */
> 
> A kernel-doc comment is preferred for public functions. Especially new
> functions...
> 
OK

>> +struct i2c_client *devm_i2c_new_dummy(struct device *dev,
>> +				      struct i2c_adapter *adapter,
>> +				      u16 address)
>> +{
>> +	struct i2c_client *ret, **dr;
>> +
>> +	dr = devres_alloc(devm_i2c_release_dummy, sizeof(*dr), GFP_KERNEL);
>> +	if (!dr)
>> +		return NULL;
> 
> Would it not be splendid if you returned an error pointer
> instead, preferably you should also change the i2c_new_dummy
> interface (don't forget to update callers) to return such a
> thing instead of NULL on error so that -EBUSY etc is
> propagated? But there are a few dozen callers, I don't know
> if it's worth it at this point?
> 
i2c_new_dummy does little more than calling i2c_new_device
which returns NULL in case of an error. So we would have to
change i2c_new_device too. This may be a little too ambitious.

When talking about changing the interface:
devm_i2c_new_dummy usually will be called with parameters

dev = &client->dev and
adapter = client->adapter

So we could change and simplify it to
struct i2c_client *devm_i2c_new_dummy(struct i2c_client *client, u16 address)

However maintainers usually insist on first parameter of a devm_
function has to be a struct device *, although there are existing
devm_ functions like devm_regmap_init_i2c not following this rule.

I'd appreciate feedback whether it would be acceptable in our case.

> Anyway, if we do it right for the managed function from the
> start, that count of i2c_new_dummy callers might get more
> manageable in the future?
> 
> Cheers,
> peda
> 
>> +
>> +	ret = i2c_new_dummy(adapter, address);
>> +	if (!ret) {
>> +		devres_free(dr);
>> +		return NULL;
>> +	}
>> +
>> +	*dr = ret;
>> +	devres_add(dev, dr);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_i2c_new_dummy);
>> +
>>  /**
>>   * i2c_new_secondary_device - Helper to get the instantiated secondary address
>>   * and create the associated device
>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>> index d501d395..d0c091e6 100644
>> --- a/include/linux/i2c.h
>> +++ b/include/linux/i2c.h
>> @@ -381,6 +381,9 @@ extern int i2c_probe_func_quick_read(struct i2c_adapter *, unsigned short addr);
>>  extern struct i2c_client *
>>  i2c_new_dummy(struct i2c_adapter *adap, u16 address);
>>  
>> +extern struct i2c_client *
>> +devm_i2c_new_dummy(struct device *dev, struct i2c_adapter *adap, u16 address);
>> +
>>  extern struct i2c_client *
>>  i2c_new_secondary_device(struct i2c_client *client,
>>  				const char *name,
>>
> 
> 
