Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC3B334695;
	Mon, 16 Mar 2026 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679339; cv=none; b=bqsxgXMLEb2YeYcaLtaMCaNpT6LijDimii+RNq069h2Moj0ayFWrE4G2Rv4uZ5scrQtsq7+XoM0mw2cAcZSD4cvylZdG/+PcX9Ay2oUBUz1LWq3KqUU+eEyFwT1BluqNjCQ+9zDD4u/aF59lxp0eGlHff+TTSYFoQ4xH8jrkCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679339; c=relaxed/simple;
	bh=4Cca7wFU3NqZ9ihPyI8voUp020s3tYVrtxBvsYfDEC0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Q4ZY+95l30N9HpMWpOtseSqljw+UzcxQ3GpJYxRl1KO+S2lpJRqFle3aHombTk8NfQdXX26+2mvIJ30INOwfiNOzba3wbkSTmzldpH9+eDDrS9coB7fn6GXbSHJOGqDCuPhaXWzp58L3PvYLvvyk30jOxy7LUhOXdJl3BynAZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=glNbwmSP; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="glNbwmSP"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3C01227109;
	Mon, 16 Mar 2026 17:42:16 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8xe37CrHEaKL; Mon, 16 Mar 2026 17:42:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1773679335; bh=4Cca7wFU3NqZ9ihPyI8voUp020s3tYVrtxBvsYfDEC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=glNbwmSP3qENxf8uSk0d0PMt0CBJTGGwHmEFjkF00o9y/yjEINN+7F43b5NlWruOE
	 Hmf1f145kEw8y5G1dKpp/bwdDKO1LQf2smj8j86JuUUGfAjZZ97sDr4QDKpeolffQh
	 kPf6mbTF4AGEjixqvZDvhhbUUjZtOoSYcvnkhJVQHB1+5/b9h7xXwCSyn5NaSHHMtM
	 ItX/8RiniVZ3j7SMGLFw8wn/Y5g2nV7s50+Ud8RV7TRs49TchqK9FRHgUY0D/h+1Sj
	 FhldHAXqAHlQc/2trSQYMvfFuFZsV56qSSJcy+5t7h8UNfO6EO0/SGT0jBdH0l7ijx
	 OaZ7luZbkJLKQ==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 16:42:15 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Kantert
 <jan-kernel@kantert.net>
Subject: Re: [PATCH 6/8] i2c: rtl9300: intoduce new function properties to
 driver data
In-Reply-To: <c933a245-2b35-41a5-9eee-cb655c8231ae@alliedtelesis.co.nz>
References: <20260314082628.25206-1-adilov@disroot.org>
 <20260314082628.25206-7-adilov@disroot.org>
 <c933a245-2b35-41a5-9eee-cb655c8231ae@alliedtelesis.co.nz>
Message-ID: <33f702e86ee5cbf98c29141cc78d364a@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2026-03-15 21:36, Chris Packham wrote:
> Hi Rustam,
> 
> On 14/03/2026 21:26, Rustam Adilov wrote:
>> Due to the very nature of differences between RTL9607C i2c controller
>> and RTL9300 / RTL9310 that are incompatible with each other in some areas
>> of this driver, for example in clock configuration, channel configuration
>> and initialization at the end of the probe, introduce new function
>> properties to the driver data struct to handle those differences.
>>
>> With these new properties, create configuration functions for RTL9300 and
>> RTL9310 and assign them to their respective driver data structs.
>>
>> Signed-off-by: Rustam Adilov <adilov@disroot.org>
>> ---
>>   drivers/i2c/busses/i2c-rtl9300.c | 54 ++++++++++++++++++++++----------
>>   1 file changed, 38 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
>> index 4953223ec97c..7930f47a37b2 100644
>> --- a/drivers/i2c/busses/i2c-rtl9300.c
>> +++ b/drivers/i2c/busses/i2c-rtl9300.c
>> @@ -59,6 +59,9 @@ enum rtl9300_i2c_reg_fields {
>>   struct rtl9300_i2c_drv_data {
>>   	struct rtl9300_i2c_reg_field field_desc[F_NUM_FIELDS];
>>   	int (*select_scl)(struct rtl9300_i2c *i2c, u8 scl);
>> +	int (*config_chan)(struct rtl9300_i2c *i2c, struct rtl9300_i2c_chan *chan);
>> +	void (*config_clock)(u32 clock_freq, struct rtl9300_i2c_chan *chan);
>> +	int (*misc_init)(struct rtl9300_i2c *i2c);
>>   	u32 rd_reg;
>>   	u32 wd_reg;
>>   	u8 max_nchan;
>> @@ -169,6 +172,24 @@ static int rtl9300_i2c_config_chan(struct rtl9300_i2c *i2c, struct rtl9300_i2c_c
>>   	return 0;
>>   }
>>   
>> +static void rtl9300_i2c_config_clock(u32 clock_freq, struct rtl9300_i2c_chan *chan)
>> +{
>> +	struct rtl9300_i2c *i2c = chan->i2c;
>> +
>> +	switch (clock_freq) {
>> +	case I2C_MAX_STANDARD_MODE_FREQ:
>> +		chan->bus_freq = RTL9300_I2C_STD_FREQ;
>> +		break;
>> +	case I2C_MAX_FAST_MODE_FREQ:
>> +		chan->bus_freq = RTL9300_I2C_FAST_FREQ;
>> +		break;
> There was a series from Jan Kantert[1] (added to Cc) that added a few 
> more speeds as supported. Looks like maybe it got missed or perhaps you 
> need to rebase on a different tree.

I did actually notice them when i wanted to add my patches to the OpenWrt cause Jan's patches 
were merged there as pending. It shouldn't be hard to rebase my patches on top of them i think..
Will do that for v2 of this patch series.

>> +	default:
>> +		dev_warn(i2c->dev, "SDA%d clock-frequency %d not supported using default\n",
>> +			 chan->sda_num, clock_freq);
>> +		break;
>> +	}
>> +}
>> +
>>   static int rtl9300_i2c_read(struct rtl9300_i2c *i2c, u8 *buf, u8 len)
>>   {
>>   	u32 vals[4] = {};
>> @@ -316,7 +337,7 @@ static int rtl9300_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr, unsigned s
>>   	guard(rtl9300_i2c)(i2c);
>>   
>>   	drv_data = device_get_match_data(i2c->dev);
>> -	ret = rtl9300_i2c_config_chan(i2c, chan);
>> +	ret = drv_data->config_chan(i2c, chan);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -383,6 +404,12 @@ static struct i2c_adapter_quirks rtl9300_i2c_quirks = {
>>   	.max_write_len	= 16,
>>   };
>>   
>> +static int rtl9300_i2c_init(struct rtl9300_i2c *i2c)
>> +{
>> +	/* only use standard read format */
>> +	return regmap_field_write(i2c->fields[F_RD_MODE], 0);
>> +}
>> +
>>   static int rtl9300_i2c_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>> @@ -447,21 +474,11 @@ static int rtl9300_i2c_probe(struct platform_device *pdev)
>>   		if (ret)
>>   			clock_freq = I2C_MAX_STANDARD_MODE_FREQ;
>>   
>> -		switch (clock_freq) {
>> -		case I2C_MAX_STANDARD_MODE_FREQ:
>> -			chan->bus_freq = RTL9300_I2C_STD_FREQ;
>> -			break;
>> -		case I2C_MAX_FAST_MODE_FREQ:
>> -			chan->bus_freq = RTL9300_I2C_FAST_FREQ;
>> -			break;
>> -		default:
>> -			dev_warn(i2c->dev, "SDA%d clock-frequency %d not supported using default\n",
>> -				 sda_num, clock_freq);
>> -			break;
>> -		}
>> -
>>   		chan->sda_num = sda_num;
>>   		chan->i2c = i2c;
>> +
>> +		drv_data->config_clock(clock_freq, chan);
>> +
>>   		adap = &i2c->chans[i].adap;
>>   		adap->owner = THIS_MODULE;
>>   		adap->algo = &rtl9300_i2c_algo;
>> @@ -479,8 +496,7 @@ static int rtl9300_i2c_probe(struct platform_device *pdev)
>>   	}
>>   	i2c->sda_num = 0xff;
>>   
>> -	/* only use standard read format */
>> -	ret = regmap_field_write(i2c->fields[F_RD_MODE], 0);
>> +	ret = drv_data->misc_init(i2c);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -509,6 +525,9 @@ static const struct rtl9300_i2c_drv_data rtl9300_i2c_drv_data = {
>>   		[F_BUSY]		= MST_REG_FIELD(RTL9300_I2C_MST_CTRL1, 0, 0),
>>   	},
>>   	.select_scl = rtl9300_i2c_select_scl,
>> +	.config_chan = rtl9300_i2c_config_chan,
>> +	.config_clock = rtl9300_i2c_config_clock,
>> +	.misc_init = rtl9300_i2c_init,
>>   	.rd_reg = RTL9300_I2C_MST_DATA_WORD0,
>>   	.wd_reg = RTL9300_I2C_MST_DATA_WORD0,
>>   	.max_nchan = RTL9300_I2C_MUX_NCHAN,
>> @@ -533,6 +552,9 @@ static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
>>   		[F_BUSY]		= MST_REG_FIELD(RTL9310_I2C_MST_CTRL, 0, 0),
>>   	},
>>   	.select_scl = rtl9310_i2c_select_scl,
>> +	.config_chan = rtl9300_i2c_config_chan,
>> +	.config_clock = rtl9300_i2c_config_clock,
>> +	.misc_init = rtl9300_i2c_init,
>>   	.rd_reg = RTL9310_I2C_MST_DATA_CTRL,
>>   	.wd_reg = RTL9310_I2C_MST_DATA_CTRL,
>>   	.max_nchan = RTL9310_I2C_MUX_NCHAN,
> --
> [1] - 
> https://lore.kernel.org/all/20260227111134.2163701-1-jan-kernel@kantert.net/
