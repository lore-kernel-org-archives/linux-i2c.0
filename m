Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129B4287247
	for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2026 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255999; cv=none; b=EBUNSfQaknTvDyQmv4GzVkEWqoofAmsM62XcKQYRHhVG4jiYGBzi/bY8sVtKwmQDg+G5xNFmEVMlU5LFMvO/KA/2e+ff4ZTwyhQPseKDGbezd0+2HbYDhYlmbbDrHnA0h9keHBbCNCuw0zyCdRdz6cAxPANVTbv3kbYYLRZhF98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255999; c=relaxed/simple;
	bh=VbsesXy4cGJY3Bz+mG4mbStpBp+srD97jXefZADi4LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMf/CRqiIbyIquqjohLDmCcShoAyUuJrFb/w3aGZm1SVk/uUc25wu74wLpCuIA0XaWJblBPA3SMMOHKPhK6p3Nka24wVvI7fuppQPfuWcW08lGQx4DDi8B360j/TReYchlUz04P/hxE2QPfTLCeWx5VoLjp+oHBmUZ6dkKAtFg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hJD0rGsl; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hJD0rGsl"
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B9587379;
	Wed, 11 Mar 2026 20:05:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1773255928;
	bh=VbsesXy4cGJY3Bz+mG4mbStpBp+srD97jXefZADi4LU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hJD0rGslTeBltubUF4ThwItbJ/P6C8YGmsIVk2i5WDHXG0OAfbUU03ipna04e97Ml
	 N3SygGEPO2B5XQTBgO0c3aNDicaIRwRaXdUbEYcy+z9xWYjW3Fk42MmIhlnn03opMo
	 n2RXlHH2ZEmx/fxSCTtCPVLSTPSAO4MqBdsaGZZA=
Message-ID: <84d1a341-147b-46a6-ba2a-36f905a26d80@ideasonboard.com>
Date: Wed, 11 Mar 2026 19:06:32 +0000
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i2c: imx: Don't recover bus when arbitration lost
To: Frank Li <Frank.li@nxp.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Andi Shyti <andi.shyti@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-i2c@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20260311-i2c-imx-fixes-v1-0-e625034d8202@ideasonboard.com>
 <20260311-i2c-imx-fixes-v1-1-e625034d8202@ideasonboard.com>
 <abGNjJnf40fqPz4s@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <abGNjJnf40fqPz4s@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Frank

On 11/03/2026 15:43, Frank Li wrote:
> On Wed, Mar 11, 2026 at 11:47:43AM +0000, Daniel Scally wrote:
>> The i2c-imx driver runs i2c_recover_bus() if i2c_imx_start() fails.
> 
>> One of the failure modes is an arbitration-lost signal from the
>> hardware however, to which bus recovery is not the right response.
>>
> 
> Supposed
> 
> One of the failure modes is an arbitration-lost signal from the second I2C
> master or slave devices, which is expected behavor. Specially two masters
> try to control the bus simultaneously.
> 
> So bus recovery is not the right response for this case. Add check -EAGAIN
> of i2c_recover_bus() to avoid wrong action.
> 
> Fixed tags here!

Ack - thanks, I'll make the changes for v2.
> 
> Frank
> 
>> Do not try to recover the bus if it loses arbitration during start.
>>
>> Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
>> ---
>>   drivers/i2c/busses/i2c-imx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>> index 85f554044cf1eec7d28310c3d9e7a7346237afdb..ed2316ab1ba8b6261dabe8af4377136a002e2f0b 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -1539,7 +1539,7 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
>>
>>   	/* Start I2C transfer */
>>   	result = i2c_imx_start(i2c_imx, atomic);
>> -	if (result) {
>> +	if (result && result != -EAGAIN) {
>>   		/*
>>   		 * Bus recovery uses gpiod_get_value_cansleep() which is not
>>   		 * allowed within atomic context.
>>
>> --
>> 2.43.0
>>

