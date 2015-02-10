From: Nicholas Mc Guire <der.herr-kA1LtwSENNE@public.gmane.org>
Subject: Re: [PATCH v2] i2c: cadence: fixup of wait_for_completion_timeout
	return handling
Date: Tue, 10 Feb 2015 15:55:26 +0100
Message-ID: <20150210145526.GA30328@opentech.at>
References: <1423494232-24747-1-git-send-email-hofrat@osadl.org> <54DA12F4.3080203@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54DA12F4.3080203-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 10 Feb 2015, Sergei Shtylyov wrote:

> Hello.
>
> On 2/9/2015 6:03 PM, Nicholas Mc Guire wrote:
>
>> return type of wait_for_completion_timeout is unsigned long not int. The
>> return variable is renamed to reflect its use and the type adjusted to
>> unsigned long.
>
>> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
>> ---
>
>> v2: int ret is an idiom not only a declaration - thus rather than just
>>      changing the type, rename the variable, as suggested by Wolfram Sang
>>      <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>.
>
>> Patch was only compile tested with multi_v7_defconfig
>> (implies CONFIG_I2C_CADENCE=y)
>
>> Patch is against 3.19.0-rc7 (localversion-next is -next-20150209)
>
>>   drivers/i2c/busses/i2c-cadence.c |    6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>
>> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
>> index 7d7a14c..8f92732f 100644
>> --- a/drivers/i2c/busses/i2c-cadence.c
>> +++ b/drivers/i2c/busses/i2c-cadence.c
>> @@ -475,7 +475,7 @@ static void cdns_i2c_master_reset(struct i2c_adapter *adap)
>>   static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
>>   		struct i2c_adapter *adap)
>>   {
>> -	int ret;
>> +	unsigned long timeout;
>>   	u32 reg;
>>
>>   	id->p_msg = msg;
>> @@ -501,8 +501,8 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
>>   		cdns_i2c_msend(id);
>>
>>   	/* Wait for the signal of completion */
>> -	ret = wait_for_completion_timeout(&id->xfer_done, adap->timeout);
>> -	if (!ret) {
>> +	timeout = wait_for_completion_timeout(&id->xfer_done, adap->timeout);
>> +	if (!timeout) {
>
>    Which means that timeout *did* expire, contrary to what one may think. 
> I don't think this is a good name for the variable, I'd suggest something 
> like 'time_left' instead...
>

thanks for that review - yes it (time_left == 0) would clearly read as
timeout.

Will fix that up and repost.

thx!
hofrat
