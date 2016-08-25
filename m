From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 6/8] i2c: mux: inform the i2c mux core about how it is
 used
Date: Thu, 25 Aug 2016 18:22:37 +0200
Message-ID: <856c696f-b0c4-63f0-ee50-1b96556cf6e0@axentia.se>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
 <1471268431-5148-7-git-send-email-peda@axentia.se>
 <20160825161900.GD2856@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0110.outbound.protection.outlook.com ([104.47.2.110]:18432
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750734AbcHZEEI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 26 Aug 2016 00:04:08 -0400
In-Reply-To: <20160825161900.GD2856@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>

On 2016-08-25 18:19, Wolfram Sang wrote:
> 
>> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
>> index 3cb8af635db5..f052c3067791 100644
>> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
>> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
>> @@ -349,7 +349,8 @@ static int pca9541_probe(struct i2c_client *client,
>>  	force = 0;
>>  	if (pdata)
>>  		force = pdata->modes[0].adap_id;
>> -	muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data), 0,
>> +	muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
>> +			     I2C_MUX_ARBITRATOR,
> 
> Does it make sense to rename the file to i2c-arb-* somewhen then? Just
> asking, I'll apply the patch anyhow.

There should be a clean branch with /only/ this series that both i2c and
iio can share, to prevent merge problems. I said I'd make such a branch
in the i2c-mux repo, but you are of course also welcome to provide that
branch if you prefer...

Cheers,
Peter
