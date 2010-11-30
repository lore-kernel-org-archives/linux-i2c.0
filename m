From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv4] i2c: add generic I2C multiplexer using gpio api
Date: Tue, 30 Nov 2010 21:03:07 +0100
Message-ID: <20101130210307.000f98fd@endymion.delvare>
References: <1291125788-9433-1-git-send-email-peter.korsgaard@barco.com>
	<20101130171539.73e8e799@endymion.delvare>
	<871v62y4ts.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <871v62y4ts.fsf-uXGAPMMVk8amE9MCos8gUmSdvHPH+/yF@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

On Tue, 30 Nov 2010 20:44:15 +0100, Peter Korsgaard wrote:
> >>>>> "Jean" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:
>  >> +	for (i = 0; i < pdata->n_gpios; i++) {
>  >> +		ret = gpio_request(pdata->gpios[i], "gpio-i2cmux");
>  >> +		if (ret)
>  >> +			goto err_request_gpio;
>  >> +		gpio_direction_output(pdata->gpios[i], pdata->idle & (1 << i));
> 
>  Jean> This looks wrong if pdata->idle == GPIO_I2CMUX_NO_IDLE. I think we want
>  Jean> something along the lines of:
> 
>  Jean> 	unsigned initial_state;
> 
>  Jean> 	initial_state = pdata->idle == GPIO_I2CMUX_NO_IDLE ?
>  Jean>       pdata->values[0] : pdata->idle;
> 
>  Jean> 		(...)
>  Jean> 		gpio_direction_output(pdata->gpios[i], initial_state & (1 << i));
> 
>  Jean> What do you think? An alternative is to leave the direction
>  Jean> uninitialized and hope it's already OK, but I'm not sure how realistic
>  Jean> this is.
> 
> Yeah, going for values[0] is probably the most sensible thing to do if
> we don't have an idle state. Relying on the firmware to setup the right
> direction in advance is imho not that nice.
> 
> Will you do the change yourself, or should I resend the patch?

I will do it, I was just waiting for you to confirm you agreed with my
analysis and proposal.

>  >> +	if (pdata->idle != GPIO_I2CMUX_NO_IDLE)
>  >> +		deselect = gpiomux_deselect;
> 
> We could probably move this up and add the assignment of init_state to
> this contional, instead of testing against GPIO_I2CMUX_NO_IDLE twice.

Yes of course. The above was kind of pseudo code to express my
proposal, not the definitive code.

I've added your patch to my i2c tree, it's now scheduled for merge in
kernel 2.6.38-rc1:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-add-generic-i2c-multiplexer-using-gpio-api.patch

Thanks for your contribution!

-- 
Jean Delvare
