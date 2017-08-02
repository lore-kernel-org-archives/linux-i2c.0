From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/2] i2c: mux: pinctrl: remove platform_data
Date: Wed, 2 Aug 2017 23:19:52 +0200
Message-ID: <ae7ab989-fa37-c907-40f7-1a73211eb927@axentia.se>
References: <20170802072728.24586-1-peda@axentia.se>
 <20170802072728.24586-2-peda@axentia.se>
 <bcf82834-7bdd-8a55-2746-389144d68e64@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0107.outbound.protection.outlook.com ([104.47.1.107]:24385
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750725AbdHBVUC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 2 Aug 2017 17:20:02 -0400
In-Reply-To: <bcf82834-7bdd-8a55-2746-389144d68e64@wwwdotorg.org>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Stephen Warren <swarren@nvidia.com>, linux-i2c@vger.kernel.org

On 2017-08-02 21:05, Stephen Warren wrote:
> On 08/02/2017 01:27 AM, Peter Rosin wrote:
>> No platform (at least no upstreamed platform) has ever used this
>> platform_data. Just drop it and simplify the code.
> 
>> diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> 
>>   static int i2c_mux_pinctrl_probe(struct platform_device *pdev)
> 
> (eliding some - lines for brevity in the following):
> 
>> +	for (i = 0; i < num_names; i++) {
>> +		ret = of_property_read_string_index(np, "pinctrl-names", i,
>> +						    &name);
>> +		if (ret < 0) {
>> +			dev_err(dev, "Cannot parse pinctrl-names: %d\n", ret);
>> +			goto err_put_parent;
>> +		}
>> +
>> +		mux->states[i] = pinctrl_lookup_state(mux->pinctrl, name);
>>   		if (IS_ERR(mux->states[i])) {
>>   			ret = PTR_ERR(mux->states[i]);
>> +			dev_err(dev, "Cannot look up pinctrl state %s: %d\n",
>> +				name, ret);
>> +			goto err_put_parent;
> 
> This error path doesn't undo pinctrl_lookup_state. Is that OK? I think 
> so, but wanted to check.

I also think so, looking at pinctrl_lookup_state, it seems to just match
strings and return a pointer. No refcounts or other state change involved
that I can see. Either way, the preexisting code would have the same issue
so it would be orthogonal and fodder for another patch...

>> +	muxc = i2c_mux_alloc(parent, dev, num_names,
>> +			     sizeof(*mux) + num_names * sizeof(*mux->states),
>> +			     0, i2c_mux_pinctrl_select, NULL);
> ...
>> +	/* Do not add any adapter for the idle state (if it's there at all). */
>> +	for (i = 0; i < num_names - !!mux->state_idle; i++) {
>> +		ret = i2c_mux_add_adapter(muxc, 0, i, 0);
> 
> Is it OK to potentially add one fewer adapter here than the child bus 
> count passed to i2c_mux_alloc() earlier? The old code specifically 
> excluded the idle state (if present) from the child bus count passed to 
> i2c_mux_alloc(), which was aided by the fact that it parsed the DT 
> before calling i2c_mux_alloc().

Yes, that is perfectly fine. The only issue is wasting space for one extra
pointer.

> If those two things are OK, then:
> Reviewed-by: Stephen Warren <swarren@nvidia.com>

Thanks!

Cheers,
Peter
