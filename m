From: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] i2c: ocores: Add missing wake_up() call upon state change
 to STATE_DONE
Date: Fri, 16 Jun 2017 15:04:14 +0200
Message-ID: <7319c512-4301-8a33-5fc3-62486557a883@denx.de>
References: <20170616092317.584-1-sr@denx.de>
 <87a858hz71.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:53971 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752822AbdFPNE2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 16 Jun 2017 09:04:28 -0400
In-Reply-To: <87a858hz71.fsf@dell.be.48ers.dk>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

Hi Peter,

On 16.06.2017 14:52, Peter Korsgaard wrote:
>>>>>> "Stefan" == Stefan Roese <sr@denx.de> writes:
> 
>   > I've noticed that this driver adds a timeout pause of 1 second after
>   > each xfer. This is due to the wait_event_timeout() call in ocores_xfer()
>   > using a "HZ" timeout value and a missing call to wake_up() in
>   > ocores_process() called by the interrupt handler when the state changes
>   > to STATE_DONE at the end of the frame.
> 
>   > This patch adds the missing call resulting in the removal of this 1
>   > second timeout delay after each xfer.
> 
>   > Signed-off-by: Stefan Roese <sr@denx.de>
>   > Cc: Wolfram Sang <wsa@the-dreams.de>
>   > ---
>   >  drivers/i2c/busses/i2c-ocores.c | 1 +
>   >  1 file changed, 1 insertion(+)
> 
>   > diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
>   > index 34f1889a4073..5f8395ea0106 100644
>   > --- a/drivers/i2c/busses/i2c-ocores.c
>   > +++ b/drivers/i2c/busses/i2c-ocores.c
>   > @@ -191,6 +191,7 @@ static void ocores_process(struct ocores_i2c *i2c)
>   >  		} else {
>>                        i2c-> state = STATE_DONE;
>   >  			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
>   > +			wake_up(&i2c->wait);
>   >  			return;
> 
> It is close to 10 years ago since I last had access to any boards with
> the ocores controller, but the logic in ocores_process() indicates that
> the controller would generate another interrupt once the stop condition
> has been sent:
> 
> 	if ((i2c->state == STATE_DONE) || (i2c->state == STATE_ERROR)) {
> 		/* stop has been sent */
> 		oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_IACK);
> 		wake_up(&i2c->wait);
> 		return;
> 	}
> 
> Do you not see this interrupt?

No. It took me quite some time last week, to notice this misbehavior
in this I2C driver. As the client (Goodix I2C touchscreen) always
returned only after more than 1 second from reading one I2C frame.

Thanks,
Stefan
