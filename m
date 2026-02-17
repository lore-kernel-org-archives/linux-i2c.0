Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F257E3081DF;
	Tue, 17 Feb 2026 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771320520; cv=none; b=DHMwla62jPX5tp9dC1ObhFC0c3Vo7zHMUxulc0bWV9oExJnTmtjscuwMUKiuk+3gFtpEmnykoa8nyckR6nGdnr7dTwHjoQ3Qln8ntBHupgyeex0MHmPpSdnEFKdX9FNxuqL20PZff+ymeQNsrlbxHTQ8z382D3M4rXMx6lXLKIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771320520; c=relaxed/simple;
	bh=IuCwtXGupLH3G6r6el8kwJBmhgnLnvtMKCQcxutXZdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=UkDV7z3vot3YuO6uqZkFKhqONQHfcSykg/a0lGDKHFaob1MgG0UoTuXeT9g3yuAjjzQ0tB+sjZOAGZ8ROtS9ePIkPL7PidlQ/qX2vQiT3QjWJfgm/XAwnp0pN9up08NOo3oi2uPrF1nkr30sYF3LDsrh/qJnGXkYB8ywrdaYJcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de [141.14.13.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 84BD84C2C37D75;
	Tue, 17 Feb 2026 10:27:58 +0100 (CET)
Message-ID: <296e66c2-b110-400b-86ab-136b128c105e@molgen.mpg.de>
Date: Tue, 17 Feb 2026 10:27:57 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: npcm7xx: Use NULL instead of 0 for pointer
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260216085825.70568-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>,
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>,
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>,
 Andi Shyti <andi.shyti@kernel.org>, openbmc@lists.ozlabs.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260216085825.70568-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Krzysztof,


Thank you for your patch.

Am 16.02.26 um 09:58 schrieb Krzysztof Kozlowski:
> Pointers should use NULL instead of explicit '0', as pointed out by
> sparse:
> 
>    i2c-npcm7xx.c:1387:61: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-npcm7xx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
> index 8b7e15240fb0..f667a873b81e 100644
> --- a/drivers/i2c/busses/i2c-npcm7xx.c
> +++ b/drivers/i2c/busses/i2c-npcm7xx.c
> @@ -1384,7 +1384,7 @@ static irqreturn_t npcm_i2c_int_slave_handler(struct npcm_i2c *bus)
>   		 */
>   		bus->operation = I2C_NO_OPER;
>   		bus->own_slave_addr = 0xFF;
> -		i2c_slave_event(bus->slave, I2C_SLAVE_STOP, 0);
> +		i2c_slave_event(bus->slave, I2C_SLAVE_STOP, NULL);
>   		iowrite8(NPCM_I2CST_SLVSTP, bus->reg + NPCM_I2CST);
>   		if (bus->fifo_use) {
>   			npcm_i2c_clear_fifo_int(bus);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
