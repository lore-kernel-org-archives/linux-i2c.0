From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: mux: only print failure message on error
Date: Mon, 15 May 2017 08:59:12 +0200
Message-ID: <db1537f6-7d17-3ac4-f6bd-420812a27db8@axentia.se>
References: <1494780073-13713-1-git-send-email-peda@axentia.se>
 <20170515045322.GX3616@mtr-leonro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0098.outbound.protection.outlook.com ([104.47.0.98]:59392
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752258AbdEOG7W (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 May 2017 02:59:22 -0400
In-Reply-To: <20170515045322.GX3616@mtr-leonro.local>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Leon Romanovsky <leon@leon.nu>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On 2017-05-15 06:53, Leon Romanovsky wrote:
> On Sun, May 14, 2017 at 06:41:13PM +0200, Peter Rosin wrote:
>> As is, a failure message is printed unconditionally, which is confusing.
>> And noisy.
>>
>> Fixes: 8d4d159f25a7 ("i2c: mux: provide more info on failure in i2c_mux_add_adapter")
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/i2c/i2c-mux.c | 24 ++++++++++++++----------
>>  1 file changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
>> index 26f7237558ba..ccf2ce1836c8 100644
>> --- a/drivers/i2c/i2c-mux.c
>> +++ b/drivers/i2c/i2c-mux.c
>> @@ -395,18 +395,22 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>>  	if (force_nr) {
>>  		priv->adap.nr = force_nr;
>>  		ret = i2c_add_numbered_adapter(&priv->adap);
>> -		dev_err(&parent->dev,
>> -			"failed to add mux-adapter %u as bus %u (error=%d)\n",
>> -			chan_id, force_nr, ret);
>> +		if (ret < 0) {
>> +			dev_err(&parent->dev,
>> +				"failed to add mux-adapter %u as bus %u (error=%d)\n",
>> +				chan_id, force_nr, ret);
>> +			kfree(priv);
>> +			return ret;
>> +		}
>>  	} else {
>>  		ret = i2c_add_adapter(&priv->adap);
>> -		dev_err(&parent->dev,
>> -			"failed to add mux-adapter %u (error=%d)\n",
>> -			chan_id, ret);
>> -	}
>> -	if (ret < 0) {
>> -		kfree(priv);
>> -		return ret;
>> +		if (ret < 0) {
>> +			dev_err(&parent->dev,
>> +				"failed to add mux-adapter %u (error=%d)\n",
>> +				chan_id, ret);
>> +			kfree(priv);
>> +			return ret;
> 
> It is better to add goto label, this will give one place for kfree->return code.

I guess that can be argued, but it's going to end up being more lines. Whatever,
I'll just repaint the shed. v2 coming up.

Cheers,
peda
