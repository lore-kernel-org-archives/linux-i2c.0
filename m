From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH] i2c: iproc: Change driver to use 'BIT' macro
Date: Thu, 18 Apr 2019 10:25:40 -0700
Message-ID: <477ebe18-68e0-f5c8-e7a0-5476b6a886db@broadcom.com>
References: <20190403210535.32236-1-ray.jui@broadcom.com>
 <f28f604a-55a4-7542-0e13-a92a83ab2144@axentia.se>
 <c47c6ec2-6d6f-8885-932c-35390783f55b@axentia.se>
 <bd0c7b0f-1936-dd1e-b8f3-ebafebdea252@broadcom.com>
 <497d0668-3065-a357-72ca-a7e79fc9cfb0@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <497d0668-3065-a357-72ca-a7e79fc9cfb0@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
List-Id: linux-i2c@vger.kernel.org



On 4/17/2019 11:21 PM, Peter Rosin wrote:
> On 2019-04-18 01:48, Ray Jui wrote:
>>
>>
>> On 4/14/2019 11:56 PM, Peter Rosin wrote:
>>> On 2019-04-13 00:59, Peter Rosin wrote:
>>>> On 2019-04-03 23:05, Ray Jui wrote:
>>>>> Change the iProc I2C driver to use the 'BIT' macro from all '1 << XXX'
>>>>> bit operations to get rid of compiler warning and improve readability of
>>>>> the code
>>>>
>>>> All? I see lots more '1 << XXX_SHIFT' matches. I might be behind though?
>>>
>>> I verified that, and yes indeed, I was behind. That said, see below...
>>>
>>
>> Right. Previous change that this change depends on is already queued in
>> i2c/for-next.
>>
>>>> Anyway, if you are cleaning up, I'm just flagging that BIT(XXX_SHIFT) looks
>>>> a bit clunky to me. You might consider renaming all those single-bit
>>>> XXX_SHIFT macros to simple be
>>>>
>>>> #define XXX BIT(<xxx>)
>>>>
>>>> instead of
>>>>
>>>> #define XXX_SHIFT <xxx>
>>>>
>>>> but that triggers more churn, so is obviously more error prone. You might
>>>> not dare it?
>>>>
>>
>> With the current code, I don't see how that is cleaner. With XXX_SHIFT
>> specified, it makes it very clear to the user that the define a for a
>> bit location within a register. You can argue and say it makes the
>> define longer, but not less clear.
>>
>>>> Cheers,
>>>> Peter
>>>>
>>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>>> ---
>>>>>  drivers/i2c/busses/i2c-bcm-iproc.c | 6 +++---
>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
>>>>> index 562942d0c05c..a845b8decac8 100644
>>>>> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
>>>>> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
>>>>> @@ -717,7 +717,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>>>>>  
>>>>>  			/* mark the last byte */
>>>>>  			if (i == msg->len - 1)
>>>>> -				val |= 1 << M_TX_WR_STATUS_SHIFT;
>>>>> +				val |= BIT(M_TX_WR_STATUS_SHIFT);
>>>>>  
>>>>>  			iproc_i2c_wr_reg(iproc_i2c, M_TX_OFFSET, val);
>>>>>  		}
>>>>> @@ -844,7 +844,7 @@ static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
>>>>>  
>>>>>  	iproc_i2c->bus_speed = bus_speed;
>>>>>  	val = iproc_i2c_rd_reg(iproc_i2c, TIM_CFG_OFFSET);
>>>>> -	val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
>>>>> +	val &= ~BIT(TIM_CFG_MODE_400_SHIFT);
>>>>>  	val |= (bus_speed == 400000) << TIM_CFG_MODE_400_SHIFT;
>>>
>>> These two statements now no longer "match". One uses BIT and the other open
>>> codes the shift. I think that's bad. Losing the _SHIFT suffix and including
>>> BIT in the macro expansion, as suggested above, yields:
>>>
>>> 	val &= ~TIM_CFG_MODE_400;
>>> 	if (bus_speed == 400000)
>>> 		val |= TIM_CFG_MODE_400;
>>>
>>> which is perhaps one more line, but also more readable IMO.
>>>
>>
>> A single line with evaluation embedded is nice and clean to me. I guess
>> this is subjective.
> 
> The "problem" I had when I looked at the driver was not any one specific
> instance. It was just that, for my taste, the code had too many shifts
> etc inline with the real code. Replacing 1 << xyz_SHIFT with BIT(xyz_SHIFT)
> is not a real improvement, they are just about equal to me, it's just that
> there are still too many mechanical things happening that could easily be
> tucked away with the suggested approach.
> 

Right, for your taste. Like I said, I feel this is very subjective. To
me, and many other I2C driver owners (I just checked how many other I2C
drivers also appear to prefer to use XXX_SHIFT and there are a lot of
them), using XXX_SHIFT makes it more clear that the define is intended
to be used for bit shift operation.

>> I'll leave the decision to Wolfram. If he also prefers the above change
>> to be made, sure. Otherwise, I'll leave it as it is.
> 
> But if you see no value in my suggestion and/or don't what to take the
> cleanup one step further, then just leave it as-is.
> 

Again, this is subjective. Personally I do not feel this is "cleanup one
step further". To me, this change will make the code less clear on the
intended operation.

>>> But all this is of course in deep nit-pick-territory...
>>>
>>> Cheers,
>>> Peter
>>>
>>
>> Thanks,
>>
>> Ray
>>
> 
