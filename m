From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] i2c: mv64xxx: remove unreachable signal case handling
Date: Wed, 17 Jun 2015 15:16:11 +0200
Message-ID: <5581731B.10506@free-electrons.com>
References: <1434036453-23336-1-git-send-email-hofrat@osadl.org> <20150617130030.GG13393@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150617130030.GG13393@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram, Nicholas,

On 17/06/2015 15:00, Wolfram Sang wrote:
> On Thu, Jun 11, 2015 at 05:27:33PM +0200, Nicholas Mc Guire wrote:
>> 'commit d295a86eab20 ("i2c: mv64xxx: work around signals causing I2C
>> transactions to be aborted")' removed the wait_event_interruptible_timeout 
>> to prevent half/mixed i2c messages from being sent/received but forgot to
>> drop the signal received cases in the return handling. This just removes
>> this dead code and simplifies the error message as "time_left" only can be 
>> 0 here and thus it conveys no additional information.
>>
>> Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
>> ---
>>
>> Patch was compile tested with multi_v7_defconfig 
>> (implies CONFIG_I2C_MV64XXX=y)
>>
>> Patch is against 4.1-rc7 (localversion-next is -next-20150611)
> 
> Hmm, IMO this patch is too intrusive to be applied without actual
> testing.
> 
>>
>>  drivers/i2c/busses/i2c-mv64xxx.c |   15 +++------------
>>  1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
>> index 30059c1..a4f8ece 100644
>> --- a/drivers/i2c/busses/i2c-mv64xxx.c
>> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
>> @@ -534,7 +534,6 @@ mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_data *drv_data)
>>  {
>>  	long		time_left;
>>  	unsigned long	flags;
>> -	char		abort = 0;
>>  
>>  	time_left = wait_event_timeout(drv_data->waitq,
>>  		!drv_data->block, drv_data->adapter.timeout);
>> @@ -542,25 +541,17 @@ mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_data *drv_data)
>>  	spin_lock_irqsave(&drv_data->lock, flags);
>>  	if (!time_left) { /* Timed out */
>>  		drv_data->rc = -ETIMEDOUT;
>> -		abort = 1;
>> -	} else if (time_left < 0) { /* Interrupted/Error */
>> -		drv_data->rc = time_left; /* errno value */
>> -		abort = 1;
>> -	}
>> -
>> -	if (abort && drv_data->block) {
>>  		drv_data->aborting = 1;
>>  		spin_unlock_irqrestore(&drv_data->lock, flags);
>>  
>>  		time_left = wait_event_timeout(drv_data->waitq,
>>  			!drv_data->block, drv_data->adapter.timeout);
>>  
>> -		if ((time_left <= 0) && drv_data->block) {
> 
> I am especially unsure about the drv_data->block removal. Did you double
> check if we can do this?
> 
>> +		if (time_left == 0) {
>>  			drv_data->state = MV64XXX_I2C_STATE_IDLE;
>>  			dev_err(&drv_data->adapter.dev,
>> -				"mv64xxx: I2C bus locked, block: %d, "
>> -				"time_left: %d\n", drv_data->block,
>> -				(int)time_left);
>> +				"mv64xxx: I2C bus locked, block: %d\n",
>> +				drv_data->block);
> 
> And if so, shouldn't that also be always 1 in the output here?
> 
>>  			mv64xxx_i2c_hw_init(drv_data);
>>  		}
>>  	} else
> 
> Maybe (not sure) it also helps to split the patch into everything
> dealing with time_left as patch 1) and simplifying by drv_data->block
> removal as patch2?

I agree. I would like to see 2 patches. The first one should be not controversial
and could be applied whereas the second one will need a deeper review.

Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
