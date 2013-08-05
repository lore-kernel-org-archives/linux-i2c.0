From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: add sanity check to i2c_put_adapter
Date: Mon, 05 Aug 2013 11:31:42 +0200
Message-ID: <51FF70FE.1090804@gmail.com>
References: <1375359046-17472-1-git-send-email-sebastian.hesselbarth@gmail.com> <20130805090030.GC2980@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130805090030.GC2980@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/05/13 11:00, Wolfram Sang wrote:
> On Thu, Aug 01, 2013 at 02:10:46PM +0200, Sebastian Hesselbarth wrote:
>> i2c_put_adapter dereferences i2c_adapter pointer passed without check
>> for NULL. This adds a check for non-NULL pointer to allow i2c_put_adapter
>> called with NULL and behave the same way i2c_release_client does already.
>
> What about using WARN for the NULL case to point out the ref-counting
> imbalance?

Wolfram,

I was just adding this to (a) make it consistent with i2c_release_client
and (b) it allows to simplify drivers where you need to release the
adapter during probe failures. But that patch is so small, feel free to
squash in anything you like.

For a more sophisticated (WARN_ON) approach, I suggest to also put one
into i2c_release_client then.

Sebastian

>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> ---
>>   drivers/i2c/i2c-core.c |    3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index f32ca29..d075df6 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -1825,7 +1825,8 @@ EXPORT_SYMBOL(i2c_get_adapter);
>>
>>   void i2c_put_adapter(struct i2c_adapter *adap)
>>   {
>> -	module_put(adap->owner);
>> +	if (adap)
>> +		module_put(adap->owner);
>>   }
>>   EXPORT_SYMBOL(i2c_put_adapter);
>>
>> --
>> 1.7.10.4
>>
