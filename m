From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] i2c: imx: Remove a useless test in
 'i2c_imx_init_recovery_info()'
Date: Tue, 8 Aug 2017 09:40:59 +0200
Message-ID: <9279b880-558a-17fb-404c-98012bb0f9f1@wanadoo.fr>
References: <20170806234953.30682-1-christophe.jaillet@wanadoo.fr>
 <20170807063617.5wr4i7b7k72uyrit@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:59587 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdHHHlD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 8 Aug 2017 03:41:03 -0400
In-Reply-To: <20170807063617.5wr4i7b7k72uyrit@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

Le 07/08/2017 à 08:36, Uwe Kleine-König a écrit :
> On Mon, Aug 07, 2017 at 01:49:53AM +0200, Christophe JAILLET wrote:
>> 'devm_pinctrl_get()' never returns NULL, so this test can be simplified.
> That's wrong. If CONFIG_PINCTRL is disabled devm_pinctrl_get returns
> NULL. But I think this shouldn't be considered an error, so your change
> is right, just the commit log is not.
With that said, in fact, I think that the test is correct as is.
If CONFIG_PINCTRL is disabled, we will display an info about a missing 
functionality, but would still continue normally without it (i.e. return 
PTR_ERR(NULL) = 0 = success), as stated in the comment in front of 
'i2c_imx_init_recovery_info':
     "These alternative pinmux settings can be described in the device 
tree by
      a separate pinctrl state "gpio". If this is missing this is not a big
      problem, the only implication is that we can't do bus recovery."

So, I won't propose any v2 patch with an updated commit log.
Feel free to update it yourself and apply it if you don't share my 
analysis above.

Sorry for the noise.

CJ

>
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>> index 54a47b40546f..7e84662fe1c0 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -997,7 +997,7 @@ static int i2c_imx_init_recovery_info(struct imx_i2c_struct *i2c_imx,
>>   	struct i2c_bus_recovery_info *rinfo = &i2c_imx->rinfo;
>>   
>>   	i2c_imx->pinctrl = devm_pinctrl_get(&pdev->dev);
>> -	if (!i2c_imx->pinctrl || IS_ERR(i2c_imx->pinctrl)) {
>> +	if (IS_ERR(i2c_imx->pinctrl)) {
>>   		dev_info(&pdev->dev, "can't get pinctrl, bus recovery not supported\n");
>>   		return PTR_ERR(i2c_imx->pinctrl);
>>   	}
> Side note: I'm not sure, this construct is valid. IIRC PTR_ERR should
> only be called for values x where IS_ERR(x) is true. Here it is at least
> surprising that an message hints to a problem but the return code is 0.
>
> @Julia: I'm sure coccinelle can find more of those?!
>
> Best regards
> Uwe
>
