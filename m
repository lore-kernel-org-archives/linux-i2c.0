From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 07/12] i2c: meson: improve interrupt handler and detect
 spurious interrupts
Date: Thu, 9 Mar 2017 21:16:07 +0100
Message-ID: <583d53b2-3a8e-572f-8ca2-efb8fc29593a@gmail.com>
References: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
 <c772d1d8-eaae-43c2-c206-7c349c134db8@gmail.com>
 <1488966636.2514.16.camel@baylibre.com>
 <c45aaa91-e903-0d2d-70c4-0fd815c5fb69@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33002 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbdCIUQY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 9 Mar 2017 15:16:24 -0500
Received: by mail-wm0-f65.google.com with SMTP id n11so12691202wma.0
        for <linux-i2c@vger.kernel.org>; Thu, 09 Mar 2017 12:16:22 -0800 (PST)
In-Reply-To: <c45aaa91-e903-0d2d-70c4-0fd815c5fb69@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-amlogic@lists.infradead.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Am 08.03.2017 um 22:02 schrieb Heiner Kallweit:
> Am 08.03.2017 um 10:50 schrieb Jerome Brunet:
>> On Wed, 2017-03-08 at 07:47 +0100, Heiner Kallweit wrote:
>>> If state is STATE_IDLE no interrupt should occur. Detect this case and
>>> warn.
>>> In addition move resetting REG_CTRL_START bit to the start of the
>>> interrupt handler and remove a unneeded REG_CTRL_START bit reset
>>> in meson_i2c_xfer_msg.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/i2c/busses/i2c-meson.c | 16 +++++++++-------
>>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
>>> index 81304840..b3b881f9 100644
>>> --- a/drivers/i2c/busses/i2c-meson.c
>>> +++ b/drivers/i2c/busses/i2c-meson.c
>>> @@ -233,7 +233,15 @@ static irqreturn_t meson_i2c_irq(int irqno, void *dev_id)
>>>  	dev_dbg(i2c->dev, "irq: state %d, pos %d, count %d, ctrl %08x\n",
>>>  		i2c->state, i2c->pos, i2c->count, ctrl);
>>>  
>>> -	if (ctrl & REG_CTRL_ERROR && i2c->state != STATE_IDLE) {
>>> +	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START, 0);
>>> +
>>> +	if (i2c->state == STATE_IDLE) {
>>> +		dev_notice(i2c->dev, "spurious interrupt detected\n");
>>> +		spin_unlock(&i2c->lock);
>>> +		return IRQ_NONE;
>>> +	}
>>
>> Does it really happen ? Did you see any specific issue you'd like to share ?
>> If not, I'm not a big fan of this change.
>>
> No,it did not happen. It's just that in few parts of the interrupt handler
> we deal with this situation that should never happen.
> And if it would happen on some system, we wouldn't know because it's
> silently ignored.
> 
> I'm fine with dropping the error message. Still I would prefer to at least
> return IRQ_NONE instead of IRQ_HANDLED in this potential error case.
> 
> It's like other drivers checking in the interrupt handler whether any
> interrupt source is enabled and returning IRQ_NONE if not.
> 
>> In any case, if it can be handled gracefully, I'd drop the trace in the
>> interrupt handler.
>>
>>
>>> +
>>> +	if (ctrl & REG_CTRL_ERROR) {
>>>  		/*
>>>  		 * The bit is set when the IGNORE_NAK bit is cleared
>>>  		 * and the device didn't respond. In this case, the
>>> @@ -276,15 +284,12 @@ static irqreturn_t meson_i2c_irq(int irqno, void
>>> *dev_id)
>>>  		i2c->state = STATE_IDLE;
>>>  		complete(&i2c->done);
>>>  		break;
>>> -	case STATE_IDLE:
>>> -		break;
>>>  	}
>>>  
>>>  out:
>>>  	if (i2c->state != STATE_IDLE) {
>>>  		/* Restart the processing */
>>>  		meson_i2c_write_tokens(i2c);
>>> -		meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START, 0);
>>>  		meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START,
>>>  				   REG_CTRL_START);
>>>  	}
>>> @@ -344,9 +349,6 @@ static int meson_i2c_xfer_msg(struct meson_i2c *i2c,
>>> struct i2c_msg *msg,
>>>  	 */
>>>  	spin_lock_irqsave(&i2c->lock, flags);
>>>  
>>> -	/* Abort any active operation */
>>> -	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_START, 0);
>>> -
Just recognized that we need to keep this statement to properly handle
the timeout case. So I'll make this part of a v3 together with potential
changes based on further review feedback.

>>>  	if (!time_left) {
>>>  		i2c->state = STATE_IDLE;
>>>  		ret = -ETIMEDOUT;
>>
> 
