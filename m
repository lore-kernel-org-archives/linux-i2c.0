Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD82DECCC;
	Sat,  4 Jul 2026 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783157885; cv=none; b=WmPXuzyqL6/IMj/xroP0gn6/lBtpKo994s3/hvFBZCHuUBQVJq0164A/cd2mF7gZiV26pcZriLjdBvlDnl+Bui0HHtEGrux3Nj/9qo47ZOs9Ax3Y/dzCa+IaJ9OK5fcNMGmXh8YmbxSdtaFZINmsBVi/autViLhvwimbuJjTiFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783157885; c=relaxed/simple;
	bh=+f2nRKHkigx0qd6/FAEdS0/3tUmvz4IX8ZpYVedMYH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuadCLc2ayBV8x2CwFGzWrdS+/G/vrI/C5yWaKrlyM7D1fHaJCJaBdM0y3/ifxygKsOfbUxi66py9GOmeSiiGjbqXfdukjlVz3vODwY+/THfQDAbTxBqzKmDbOtlai/Hxs/42m6oUSFcz0RkzjlcKLxKLPLkxjmCpwp/HFxELrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=FejQphiU; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=FejQphiU; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=qaPSjLoO; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="FejQphiU";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="FejQphiU";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="qaPSjLoO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1783157323;
	bh=+f2nRKHkigx0qd6/FAEdS0/3tUmvz4IX8ZpYVedMYH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FejQphiUmrmjDYx6DFk8D2CQqfVh2KDn+18fqk9MZHaNVROghYkBwfIDfKakTrw5X
	 28Z9+p/gilyOUSER7P6zSYa52rbLcg7j6zySRISMun/W1T7XCP9i8I8qtLuQv3zWGs
	 P6y3Z19hYtWdKdmTlN4ya8rfWAufOAyj4BcPA/5vuXzXbjzMbXcog12lyv0UjM639G
	 DlmvQTh+0Q0Lff8rK2UvfpOGIxtMqRTBxdz+pBTiJ7g3Apggze2RYR2vw3weRFSI+s
	 AUgyIm2a3MpL53tS4K6hj0vPzfSowjqAi3+QHyMuEwPVS9akQjv0mVLgfxpJufhCmJ
	 9zPryd4FcwpKQ==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 7719C1FEE1;
	Sat,  4 Jul 2026 11:28:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1783157323;
	bh=+f2nRKHkigx0qd6/FAEdS0/3tUmvz4IX8ZpYVedMYH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FejQphiUmrmjDYx6DFk8D2CQqfVh2KDn+18fqk9MZHaNVROghYkBwfIDfKakTrw5X
	 28Z9+p/gilyOUSER7P6zSYa52rbLcg7j6zySRISMun/W1T7XCP9i8I8qtLuQv3zWGs
	 P6y3Z19hYtWdKdmTlN4ya8rfWAufOAyj4BcPA/5vuXzXbjzMbXcog12lyv0UjM639G
	 DlmvQTh+0Q0Lff8rK2UvfpOGIxtMqRTBxdz+pBTiJ7g3Apggze2RYR2vw3weRFSI+s
	 AUgyIm2a3MpL53tS4K6hj0vPzfSowjqAi3+QHyMuEwPVS9akQjv0mVLgfxpJufhCmJ
	 9zPryd4FcwpKQ==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 5BADA30; Sat,  4 Jul 2026 11:28:43 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1783157303;
	bh=+f2nRKHkigx0qd6/FAEdS0/3tUmvz4IX8ZpYVedMYH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qaPSjLoOaEIIn+XKaHu7JZ1xUE0zrx8JHjm3I1zWSFMgmQowyPCmfr00w+kP6AQwq
	 kmNLTMEeXE9S/H0pUChj5U/fD8FAUTLpOygWLiNFTCHuskYO6pNRAvQ8FMd29VQc7i
	 fAtKdtXVHjFuCVPrrrBZdN0oZBCUEByp/4F7ILG33toaGop7p6+966Ksv1pykNRJL7
	 4EsfZO4SfNWbRFpcqRVtHJev6+mX4sSGRg7G2QyTQyBd5bw2EtzdhrZpSyAJbUPiIb
	 DeCWjVfI/vfFz/BsyMuCQN3/rUYmuE/4191TFX4TkUp94otfOT5Co+dEc+6tQuPXJ0
	 ZG+y8eNwT7c6Q==
Received: from [192.168.2.172] (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id EDA951FFBB;
	Sat,  4 Jul 2026 11:28:22 +0200 (CEST)
Message-ID: <8eecaa15-460f-4f39-b65f-98b8334994be@lysator.liu.se>
Date: Sat, 4 Jul 2026 11:28:21 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] i2c: mux: Set adapter physical device
To: Herve Codina <herve.codina@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>,
 Steen Hegelund <steen.hegelund@microchip.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260630103010.413688-1-herve.codina@bootlin.com>
 <20260630103010.413688-3-herve.codina@bootlin.com>
Content-Language: en-US, sv-SE
From: Peter Rosin <peda@lysator.liu.se>
In-Reply-To: <20260630103010.413688-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

On 2026-06-30 12:30, Herve Codina wrote:
> For i2c muxes, the parent of the mux adapter device is the adapter
> device the mux is connected to.
> 
> This parent is not the physical device related to the mux adapter.
> Indeed, the physical device of the mux adapter is the mux device itself.
> 
> Fill the adap.physdev with the mux device.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> ---
>   drivers/i2c/i2c-mux.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 681a201c239b..f4e73e7a0e33 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -315,6 +315,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>   	priv->adap.algo = &priv->algo;
>   	priv->adap.algo_data = priv;
>   	priv->adap.dev.parent = &parent->dev;
> +	priv->adap.physdev = muxc->dev;
>   	priv->adap.retries = parent->retries;
>   	priv->adap.timeout = parent->timeout;
>   	priv->adap.quirks = parent->quirks;

Given how similar the implementation details are for address translators
and muxes, I expect that this pattern is present there as well.

I.e. I think a line with "chan->adap.physdev = dev;" should be added to
the i2c_atr_add_adapter() function (in the obvious place).

Cheers,
Peter

