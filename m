From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/2] i2c-dev: Don't block the adapter from unregistering
Date: Wed, 6 Jul 2016 17:04:16 +0200
Message-ID: <a65124df-0d47-41a8-b90f-0d6e3fd9ce4f@axentia.se>
References: <cover.1467772840.git.viresh.kumar@linaro.org>
 <021486be2f5425ce2379219a7ac163ee14ba2aba.1467772840.git.viresh.kumar@linaro.org>
 <415dcaa7-8ad9-492e-5c5c-605173bc4345@axentia.se>
 <20160706143323.GK2671@ubuntu> <577D1907.20002@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0095.outbound.protection.outlook.com ([104.47.2.95]:62867
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932229AbcGFPhG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 6 Jul 2016 11:37:06 -0400
In-Reply-To: <577D1907.20002@metafoo.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, Alex Elder <elder@linaro.org>

On 2016-07-06 16:43, Lars-Peter Clausen wrote:
> On 07/06/2016 04:33 PM, Viresh Kumar wrote:
>> On 06-07-16, 10:22, Peter Rosin wrote:
>>> On 2016-07-06 04:57, Viresh Kumar wrote:
>>>> The i2c-dev calls i2c_get_adapter() from the .open() callback, which
>>>> doesn't let the adapter device unregister unless the .close() callback
>>>> is called.
>>>>
>>>> On some platforms (like Google ARA), this doesn't let the modules
>>>> (hardware attached to the phone) eject from the phone as the cleanup
>>>> path for the module hasn't finished yet (i2c adapter not removed).
>>>>
>>>> We can't let the userspace block the kernel forever in such cases.
>>>>
>>>> Fix this by calling i2c_get_adapter() from all other file operations,
>>>> i.e.  read/write/ioctl, to make sure the adapter doesn't get away while
>>>> we are in the middle of a operation, but not otherwise. In .open() we
>>>> will release the adapter device before returning and so if there is no
>>>> data transfer in progress, then the i2c-dev doesn't block the adapter
>>>> from unregistering.
>>>>
>>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> ---
>>>>  drivers/i2c/i2c-dev.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++-----
>>>>  include/linux/i2c.h   |  1 +
>>>>  2 files changed, 66 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
>>>> index 66f323fd3982..b2562603daa9 100644
>>>> --- a/drivers/i2c/i2c-dev.c
>>>> +++ b/drivers/i2c/i2c-dev.c
>>>> @@ -142,13 +142,25 @@ static ssize_t i2cdev_read(struct file *file, char __user *buf, size_t count,
>>>>  	int ret;
>>>>  
>>>>  	struct i2c_client *client = file->private_data;
>>>> +	struct i2c_adapter *adap;
>>>> +
>>>> +	adap = i2c_get_adapter(client->adapter_nr);
>>>> +	if (!adap)
>>>> +		return -ENODEV;
>>>> +
>>>> +	if (adap != client->adapter) {
>>>> +		ret = -EINVAL;
>>>> +		goto put_adapter;
>>>> +	}
>>>
>>> I don't see how this can work with the i2c-demux-pinctrl driver.
>>> I also wonder if/how other muxes handle this relaxed adapter
>>> lifetime thingy?
>>
>> I would like to mention here that I am no I2C expert and have limited
>> knowledge of it :)
>>
>> I haven't had a look at the muxes implementation earlier, now that I
>> looked at them, I see that they unregister/register the adapter,
>> perhaps while switching functionality.
>>
>> I am not sure though, if this patch will break it or not. And I don't
>> have a way of testing it out.
>>
>>> Out of curiosity, why would client->adapter change anyway?
>>> (that is, if not because of a demux-pinctrl op)
>>
>> I didn't mean that it will change, and perhaps we can add a
>> WARN_ON(adap != client->adapter).
>>
>> But, thinking about it again now, I think it is possible.
>>
>> What about this sequence:
>>
>> - i2c-adap-register (address P1)
>> - .open(), client->adapter = P1;
>> - .read/write/ioctl()..
>> - i2c-adap-unregister (adapter freed)
>> - i2c-adap-register with same adapter_nr (address P2);
>> - .read/write/ioctl().
>>
>> Wouldn't the address differ here ?
> 
> There is no guarantee that the address will be different. While it is
> unlikely the memory allocated might give out the same address for the second
> adapter if the first one has been freed.

Exactly, so the stored address had better be correct, and in
that case there is no need for the new adapter_nr in every
client, you could just go with client->adapter->nr instead.
Which just shows that the whole thing is fishy and that the
adapter has to remain alive. BTW, is there any guarantee that
adapter numbers will not get reused?

Cheers,
Peter
