From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: core: add device-managed version of i2c_new_dummy
Date: Mon, 21 Aug 2017 23:28:26 +0200
Message-ID: <bcef5bc3-abee-673b-2bd0-4a01baaca572@axentia.se>
References: <de2f844a-9d41-fa0e-cd55-fc7d2cea24d5@gmail.com>
 <4491c6a5-2cd1-1544-22c6-c843845145f4@axentia.se>
 <68a1c44a-62c5-17d6-7295-6606838f8ce4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0134.outbound.protection.outlook.com ([104.47.1.134]:24775
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754058AbdHUV2e (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 21 Aug 2017 17:28:34 -0400
In-Reply-To: <68a1c44a-62c5-17d6-7295-6606838f8ce4@gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On 2017-08-21 21:56, Heiner Kallweit wrote:
> Am 21.08.2017 um 20:42 schrieb Peter Rosin:
>> Hi!
>>
>> On 2017-08-21 20:24, Heiner Kallweit wrote:
>>> i2c_new_dummy is typically called from the probe function of the
>>> driver for the primary i2c client. It requires calls to
>>> i2c_unregister_device in the error path of the probe function and
>>> in the remove function.
>>> This can be simplified by introducing a device-managed version.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/i2c/i2c-core-base.c | 29 +++++++++++++++++++++++++++++
>>>  include/linux/i2c.h         |  3 +++
>>>  2 files changed, 32 insertions(+)
>>
>> You need to update Documentation/driver-model/devres.txt
>>
> Right, thanks for the hint.
> 
>>> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
>>> index 12822a4b..7eb48328 100644
>>> --- a/drivers/i2c/i2c-core-base.c
>>> +++ b/drivers/i2c/i2c-core-base.c
>>> @@ -868,6 +868,35 @@ struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
>>>  }
>>>  EXPORT_SYMBOL_GPL(i2c_new_dummy);
>>>  
>>> +static void devm_i2c_release_dummy(struct device *dev, void *res)
>>> +{
>>> +	i2c_unregister_device(*(struct i2c_client **)res);
>>> +}
>>> +
>>> +/* managed version of i2c_new_dummy */
>>
>> A kernel-doc comment is preferred for public functions. Especially new
>> functions...
>>
> OK
> 
>>> +struct i2c_client *devm_i2c_new_dummy(struct device *dev,
>>> +				      struct i2c_adapter *adapter,
>>> +				      u16 address)
>>> +{
>>> +	struct i2c_client *ret, **dr;
>>> +
>>> +	dr = devres_alloc(devm_i2c_release_dummy, sizeof(*dr), GFP_KERNEL);
>>> +	if (!dr)
>>> +		return NULL;
>>
>> Would it not be splendid if you returned an error pointer
>> instead, preferably you should also change the i2c_new_dummy
>> interface (don't forget to update callers) to return such a
>> thing instead of NULL on error so that -EBUSY etc is
>> propagated? But there are a few dozen callers, I don't know
>> if it's worth it at this point?
>>
> i2c_new_dummy does little more than calling i2c_new_device
> which returns NULL in case of an error. So we would have to
> change i2c_new_device too. This may be a little too ambitious.

Yes and no.

Yes, it is ambitious, but the right thing to do in the end. And
it is mechanical, so it is not really hard. But I already said that
it might not be worth it at this point...

No, we do not have to follow the return value convention from
i2c_new_dummy in devm_i2c_new_dummy. What I meant below was that
for the time being devm_i2c_new_dummy can return ERR_PTR(-Ewhatever)
when i2c_new_dummy returns NULL. Then, when most/all i2c_new_dummy
users have been converted over to devm_i2c_new_dummy (which might
take a while) it will be less daunting to convert i2c_new_dummy to
not return a plain old boring NULL on failure. And then it will be
really easy to change devm_i2c_new_dummy to propagate that value w/o
causing massive churn in all callers at once.

> When talking about changing the interface:
> devm_i2c_new_dummy usually will be called with parameters
> 
> dev = &client->dev and
> adapter = client->adapter
> 
> So we could change and simplify it to
> struct i2c_client *devm_i2c_new_dummy(struct i2c_client *client, u16 address)
> 
> However maintainers usually insist on first parameter of a devm_
> function has to be a struct device *, although there are existing
> devm_ functions like devm_regmap_init_i2c not following this rule.
> 
> I'd appreciate feedback whether it would be acceptable in our case.

It would probably be good to target that question with an audience
a bit wider than the i2c list. Not sure where exactly it fits best
though?

Cheers,
peda

>> Anyway, if we do it right for the managed function from the
>> start, that count of i2c_new_dummy callers might get more
>> manageable in the future?
>>
>> Cheers,
>> peda
>>
>>> +
>>> +	ret = i2c_new_dummy(adapter, address);
>>> +	if (!ret) {
>>> +		devres_free(dr);
>>> +		return NULL;
>>> +	}
>>> +
>>> +	*dr = ret;
>>> +	devres_add(dev, dr);
>>> +
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(devm_i2c_new_dummy);
>>> +
>>>  /**
>>>   * i2c_new_secondary_device - Helper to get the instantiated secondary address
>>>   * and create the associated device
>>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>>> index d501d395..d0c091e6 100644
>>> --- a/include/linux/i2c.h
>>> +++ b/include/linux/i2c.h
>>> @@ -381,6 +381,9 @@ extern int i2c_probe_func_quick_read(struct i2c_adapter *, unsigned short addr);
>>>  extern struct i2c_client *
>>>  i2c_new_dummy(struct i2c_adapter *adap, u16 address);
>>>  
>>> +extern struct i2c_client *
>>> +devm_i2c_new_dummy(struct device *dev, struct i2c_adapter *adap, u16 address);
>>> +
>>>  extern struct i2c_client *
>>>  i2c_new_secondary_device(struct i2c_client *client,
>>>  				const char *name,
>>>
>>
>>
> 
