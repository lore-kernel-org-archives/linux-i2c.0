From: Daniel Smolik <marvin-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>
Subject: Re: [PATCH] i2c: multi-master lost-arbitration improvement
 for i2c-algo-pcf (take 2)
Date: Thu, 12 Jun 2008 23:39:10 +0200
Message-ID: <4851977E.4080903@mydatex.cz>
References: <ec7cefb0806121410g154b546dx1cb2562898dba4b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <ec7cefb0806121410g154b546dx1cb2562898dba4b6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Eric Brower <ebrower-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Eric Brower napsal(a):
> Attached is a revised patch to provide enhanced multi-master
> arbitration support for i2c-algo-pcf.  The initial patch was
> commented-on about 10 months ago, so I've included the prior mail
> below for reference and interspersed my comments.  I am not a member
> of this list, so please copy me directly on replies.  The attached
> patch has been tested against a fairly recent Linus 2.6 GIT tree.
> 
> Ref: http://lists.lm-sensors.org/pipermail/i2c/2007-August/001690.html
> 
> Commit text:
> Improve lost-arbitration handling of PCF8584.  This is necessary for
> support of a currently out-of-kernel driver for Sun Microsystems E250
> environmental management; perhaps others.
> Signed-off-by: Eric Brower <ebrower at gmail.com>
> 
> Daniel, please ACK if you are comfortable doing so.

I confirm this patch it works well on my E250.

Acked by: Dan Smolik <marvin-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org>

Dan




> 
> 
>> Hi Eric,
>>
>> When sending a patch, please set the attachment type to something more
>> friendly than "application/octet-stream".
> 
> Will do.  I've tried to fool gmail with a .txt extension, rather than .patch.
> 
>> On Thu, 19 Jul 2007 22:26:08 -0700, Eric Brower wrote:
>>> Attached is a patch that improves multi-master support for PCF8584.
>>> The current implementation of multi-master support (mine) in
>>> i2c-algo-pcf does not properly handle a collision detected during wait_for_bb()
>>> and thus causes an error that is only recoverable by reloading the
>>> relevant device drivers.  I'd appreciate your consideration of this
>>> patch.
>>>
>>> The only affected driver is i2c-envctrl.c-- currently out-of-kernel,
>>> in development; you
>>> can find it here if you are interested:
>>>
>>>    http://www.david-web.co.uk/index.php?p=envctrl
>>>
>>> This change has been tested by a few individuals (on Sun Microsystems
>>> E250 servers) over the course of several months, and rectifies
>>> occasional errors seen without the patch applied.
>>>
>>> I'll be happy to provide further clarification if you are interested.
>>> Please cc me on responses-- I am not a member of this list.
>> Note that I can't test your patch, as I don't have supported hardware.
>>
>>> Commit text:
>>>
>>> Improve lost-arbitration handling of PCF8584
>>> Signed-off-by: Eric Brower <ebrower at gmail.com>
>> Review:
>>
>>> diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
>>> index ecb2c2d..2cc0302 100644
>>> --- a/drivers/i2c/algos/i2c-algo-pcf.c
>>> +++ b/drivers/i2c/algos/i2c-algo-pcf.c
>>> @@ -78,6 +78,31 @@ static void i2c_stop(struct i2c_algo_pcf
>>>  	set_pcf(adap, 1, I2C_PCF_STOP);
>>>  }
>>>
>>> +static inline void handle_lab(struct i2c_algo_pcf_data *adap, const int *status)
>>> +{
>>> +	DEB2(printk(KERN_INFO
>>> +		"i2c-algo-pcf.o: lost arbitration (CSR 0x%02x)\n",
>>> +		 *status));
>>> +	/* Cleanup from LAB-- reset and enable ESO.
>>> +	 * This resets the PCF8584; since we've lost the bus, no
>>> +	 * further attempts should be made by callers to clean up
>>> +	 * (no i2c_stop() etc.)
>>> +	 */
>>> +	set_pcf(adap, 1, I2C_PCF_PIN);
>>> +	set_pcf(adap, 1, I2C_PCF_ESO);
>>> +	/* We pause for a time period sufficient for any running
>>> +	 * I2C transaction to complete-- the arbitration logic won't
>>> +	 * work properly until the next START is seen.
>>> +	 * It is assumed the bus driver or client has set a proper value.
>>> +	 */
>>> +	if (adap->lab_mdelay) {
>>> +		mdelay(adap->lab_mdelay);
>>> +	}
>> Out of curiosity: on what basis will the value of lab_mdelay be chosen
>> by the driver author? This seems to be pretty arbitrary, as you don't
>> know what kind of transactions the other master is doing. The
>> underlying question being: is it worth having a per-adapter parameter
>> for this, as opposed to a hard-coded value?
> 
> The driver (bus adapter) author shall select a value that is longer
> than the longest start/stop bus transaction possible by either master.
>  This is not entirely arbitrary, and can be determined by snooping the
> i2c bus.  Unfortunately, for proper lost-arbitration functionality
> with PCF8584 you must determine a sufficient value.  This is described
> in the Philips/NXP AN96040 document:
> 
> "Attention ! In both cases, the PCF8584 is not able to recognise that
> there is still an ongoing
> transmission. In order to prevent another arbitration problem the
> controlling software should
> wait for a time, longer than the longest message which can be sent
> over the bus, before trying
> to access the bus again."
> 
> The parameter should be per-adapter, not hard-coded, for the above reason.
> 
> Here's an example of a bus driver (i2c-envctrl) setting a desired value:
> 
> static struct i2c_algo_pcf_data pcf_envctrl_data = {
>         .setpcf     = pcf_envctrl_setbyte,
>         .getpcf     = pcf_envctrl_getbyte,
>         .getown     = pcf_envctrl_getown,
>         .getclock   = pcf_envctrl_getclock,
>         .waitforpin = pcf_envctrl_waitforpin,
>         .udelay     = 10,
>         .timeout    = 100,
>         /*
>          * This could be made dynamic based upon get_clock(), but
>          * we know clock does not change within this implementation, so:
>          * 10,000 uSec per bit (@100kHz) * 9 bits/byte * 3 trans
>          */
>         .lab_mdelay = 270,
>  };
> 
> 
>> Also, it seems to me that you could sleep here. If you sleep a bit
>> longer than expected, it shouldn't be a problem, right?
> 
> Not a problem.  The pause is only intended to ensure at least
> "lab_mdelay" msecs prior to the next attempt to use the bus.  This
> gives the internal state machine of PCF8584 sufficient time to see a
> stop or start sequence on the bus.
> 
>>> +	DEB2(printk(KERN_INFO
>>> +		"i2c-algo-pcf.o: reset LAB condition (CSR 0x%02x)\n",
>>> +		get_pcf(adap,1)));
>> Coding style: space after comma.
> 
> Done.  Thanks.
> 
>>> +}
>> This function is too big to be inlined, especially given that it should
>> rarely be called, so speeding it up isn't very interesting.
> 
> Understood-- inline removed.
> 
>>> +
>>>  static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
>>>
>>>  	int timeout = DEF_TIMEOUT;
>>> @@ -86,6 +111,10 @@ static int wait_for_bb(struct i2c_algo_p
>>>  	status = get_pcf(adap, 1);
>>>  #ifndef STUB_I2C
>>>  	while (timeout-- && !(status & I2C_PCF_BB)) {
>>> +		if (status & I2C_PCF_LAB) {
>>> +			handle_lab(adap, &status);
>>> +			return -EINTR;
>>> +		}
>> How can this happen? We check for busy bus before we start
>> transmitting, and arbitration can't be lost until we at least try to
>> transmit.
> 
> This is a side-effect that occurs when the lab_mdelay value is not
> long enough to ensure a stop or start sequence is seen by the master.
> The internal state machine of the PCF8584 can trigger LAB at an
> unexpected time.  In fact, you are correct that we should not see it
> here; given the current structure of the driver, however, we do see it
> here and the driver otherwise makes no attempt to resolve the issue.
> This state requires a driver reload to rectify.  Future work on this
> driver could perhaps resolve the issue of this (and other unexpected
> conditions) via a reset.
> 
> However, if we assume the bus driver author has selected a proper
> value, we should not expect this to occur.  So, I've removed this
> section and it could be added back in the future as "insurance"
> against unexpected behavior if necessary.
> 
>>>  		udelay(100); /* wait for 100 us */
>>>  		status = get_pcf(adap, 1);
>>>  	}
>>> @@ -109,23 +139,7 @@ static int wait_for_pin(struct i2c_algo_
>>>  		*status = get_pcf(adap, 1);
>>>  	}
>>>  	if (*status & I2C_PCF_LAB) {
>>> -		DEB2(printk(KERN_INFO
>>> -			"i2c-algo-pcf.o: lost arbitration (CSR 0x%02x)\n",
>>> -			 *status));
>>> -		/* Cleanup from LAB-- reset and enable ESO.
>>> -		 * This resets the PCF8584; since we've lost the bus, no
>>> -		 * further attempts should be made by callers to clean up
>>> -		 * (no i2c_stop() etc.)
>>> -		 */
>>> -		set_pcf(adap, 1, I2C_PCF_PIN);
>>> -		set_pcf(adap, 1, I2C_PCF_ESO);
>>> -		/* TODO: we should pause for a time period sufficient for any
>>> -		 * running I2C transaction to complete-- the arbitration
>>> -		 * logic won't work properly until the next START is seen.
>>> -		 */
>>> -		DEB2(printk(KERN_INFO
>>> -			"i2c-algo-pcf.o: reset LAB condition (CSR 0x%02x)\n",
>>> -			get_pcf(adap,1)));
>>> +		handle_lab(adap, status);
>>>  		return(-EINTR);
>>>  	}
>>>  #endif
>>> @@ -218,9 +232,8 @@ static inline int try_address(struct i2c
>>>  				break;	/* success! */
>>>  			}
>>>  		}
>>> -		if (wfp == -EINTR) {
>>> +		else if (wfp == -EINTR) {
>>>  			/* arbitration lost */
>>> -			udelay(adap->udelay);
>>>  			return -EINTR;
>>>  		}
>>>  		i2c_stop(adap);
>>> @@ -378,6 +393,10 @@ static int pcf_xfer(struct i2c_adapter *
>>>  	/* Check for bus busy */
>>>  	timeout = wait_for_bb(adap);
>>>  	if (timeout) {
>>> +		if (timeout == -EINTR) {
>>> +			/* arbitration lost */
>>> +			return -EINTR;
>>> +		}
>>>  		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: "
>>>  		            "Timeout waiting for BB in pcf_xfer\n");)
>>>  		return -EIO;
>>> diff --git a/include/linux/i2c-algo-pcf.h b/include/linux/i2c-algo-pcf.h
>>> index 994eb86..d11c141 100644
>>> --- a/include/linux/i2c-algo-pcf.h
>>> +++ b/include/linux/i2c-algo-pcf.h
>>> @@ -36,6 +36,12 @@ struct i2c_algo_pcf_data {
>>>  	/* local settings */
>>>  	int udelay;
>>>  	int timeout;
>>> +
>>> +	/* Multi-master lost arbitration back-off delay (msecs)
>>> +	 * This should be set by the bus adapter or knowledgable client
>>> +	 * if bus is multi-mastered, else zero
>>> +	 */
>>> +	unsigned long lab_mdelay;
>>>  };
>>>
>>>  int i2c_pcf_add_bus(struct i2c_adapter *);
>> As a side question, shouldn't i2c-algo-pcf retry, rather than fail, on
>> arbitration lost?
> 
> It is not a safe assumption that a command (or series of commands) can
> be re-tried after arbitration is lost.  A convenience function or
> setting in the driver may be worthwhile for cases where the consumer
> knows the action to be safe, but I would divorce such an enhancement
> from this proposed patch.
> 
>> --
>> Jean Delvare
> 
> Thank you again for your consideration.  Apologies for the tardiness of a reply.
> 
> 
> ------------------------------------------------------------------------
> 
> diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
> index ecb2c2d..5b8e686 100644
> --- a/drivers/i2c/algos/i2c-algo-pcf.c
> +++ b/drivers/i2c/algos/i2c-algo-pcf.c
> @@ -78,6 +78,31 @@ static void i2c_stop(struct i2c_algo_pcf
>  	set_pcf(adap, 1, I2C_PCF_STOP);
>  }
>  
> +static void handle_lab(struct i2c_algo_pcf_data *adap, const int *status)
> +{
> +	DEB2(printk(KERN_INFO 
> +		"i2c-algo-pcf.o: lost arbitration (CSR 0x%02x)\n",
> +		 *status));
> +	/* Cleanup from LAB-- reset and enable ESO.
> +	 * This resets the PCF8584; since we've lost the bus, no
> +	 * further attempts should be made by callers to clean up 
> +	 * (no i2c_stop() etc.)
> +	 */
> +	set_pcf(adap, 1, I2C_PCF_PIN);
> +	set_pcf(adap, 1, I2C_PCF_ESO);
> +	/* We pause for a time period sufficient for any running 
> +	 * I2C transaction to complete-- the arbitration logic won't 
> +	 * work properly until the next START is seen.
> +	 * It is assumed the bus driver or client has set a proper value.
> +	 */
> +	if (adap->lab_mdelay) {
> +		mdelay(adap->lab_mdelay);
> +	}
> +	DEB2(printk(KERN_INFO 
> +		"i2c-algo-pcf.o: reset LAB condition (CSR 0x%02x)\n", 
> +		get_pcf(adap, 1)));
> +}
> +
>  static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
>  
>  	int timeout = DEF_TIMEOUT;
> @@ -109,23 +134,7 @@ static int wait_for_pin(struct i2c_algo_
>  		*status = get_pcf(adap, 1);
>  	}
>  	if (*status & I2C_PCF_LAB) {
> -		DEB2(printk(KERN_INFO 
> -			"i2c-algo-pcf.o: lost arbitration (CSR 0x%02x)\n",
> -			 *status));
> -		/* Cleanup from LAB-- reset and enable ESO.
> -		 * This resets the PCF8584; since we've lost the bus, no
> -		 * further attempts should be made by callers to clean up 
> -		 * (no i2c_stop() etc.)
> -		 */
> -		set_pcf(adap, 1, I2C_PCF_PIN);
> -		set_pcf(adap, 1, I2C_PCF_ESO);
> -		/* TODO: we should pause for a time period sufficient for any
> -		 * running I2C transaction to complete-- the arbitration
> -		 * logic won't work properly until the next START is seen.
> -		 */
> -		DEB2(printk(KERN_INFO 
> -			"i2c-algo-pcf.o: reset LAB condition (CSR 0x%02x)\n", 
> -			get_pcf(adap,1)));
> +		handle_lab(adap, status);
>  		return(-EINTR);
>  	}
>  #endif
> diff --git a/include/linux/i2c-algo-pcf.h b/include/linux/i2c-algo-pcf.h
> index 994eb86..d11c141 100644
> --- a/include/linux/i2c-algo-pcf.h
> +++ b/include/linux/i2c-algo-pcf.h
> @@ -36,6 +36,12 @@ struct i2c_algo_pcf_data {
>  	/* local settings */
>  	int udelay;
>  	int timeout;
> +
> +	/* Multi-master lost arbitration back-off delay (msecs)
> +	 * This should be set by the bus adapter or knowledgable client 
> +	 * if bus is multi-mastered, else zero
> +	 */
> +	unsigned long lab_mdelay;
>  };
>  
>  int i2c_pcf_add_bus(struct i2c_adapter *);


-- 
Mydatex s r.o.
http://www.mydatex.cz
email: smolik-0pWKB23IDFjrBKCeMvbIDA@public.gmane.org
mob: 604200362
tel: 226210085

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
