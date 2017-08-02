From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] i2c: mux: pinctrl: drop the idle_state member
Date: Wed, 2 Aug 2017 16:50:35 -0600
Message-ID: <ee71d80d-840c-a784-7fc7-a72b7cc2f453@wwwdotorg.org>
References: <20170802072728.24586-1-peda@axentia.se>
 <20170802072728.24586-3-peda@axentia.se>
 <15488723-e0ef-62b3-e62f-e74d12d8328d@wwwdotorg.org>
 <cb3ecc9b-b26f-bb81-5836-ecd459ec3456@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cb3ecc9b-b26f-bb81-5836-ecd459ec3456@axentia.se>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Stephen Warren <swarren@nvidia.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 08/02/2017 03:25 PM, Peter Rosin wrote:
> On 2017-08-02 21:06, Stephen Warren wrote:
>> On 08/02/2017 01:27 AM, Peter Rosin wrote:
>>> The information is available elsewhere.
>>
>>> diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
>>
>>>    static int i2c_mux_pinctrl_deselect(struct i2c_mux_core *muxc, u32 chan)
>>>    {
>>> +	return i2c_mux_pinctrl_select(muxc, muxc->num_adapters);
>>>    }
>>
>>> @@ -166,7 +162,7 @@ static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
>>
>>>    	/* Do not add any adapter for the idle state (if it's there at all). */
>>> -	for (i = 0; i < num_names - !!mux->state_idle; i++) {
>>> +	for (i = 0; i < num_names - !!muxc->deselect; i++) {
>>
>> I think that "num_names - !!muxc->deselect" could just be
>> muxc->num_adapters?
> 
> Not really, it's the i2c_mux_add_adapter call in the loop that bumps
> muxc->num_adapters, so the loop would not be entered. Not desirable :-)

Ok, that makes sense.

> (and muxc->max_adapters == num_names)

Well, unless muxc->deselect is true...
