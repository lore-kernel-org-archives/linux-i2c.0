Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A07459AE3;
	Thu, 23 Jul 2026 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804756; cv=none; b=ohnMnUnTY4DrgNQrVZfqY83b77UJLyXzAf5kzXbgA4iY5qkiv3FJwif1DDDd0Xg4OQOO9K9M2ZpLlIkevw2jVUadn47ELQUP4WGl2SSC3o2JrO2HG4Uacd+xPTGXZVSCMw8zmaJUC+Oag+gVril5x+nx8CgPuTZed/QbFTk48Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804756; c=relaxed/simple;
	bh=5EnBNbL8mJ2vOm/XrE/Iei5zExtp+PyyvXixlb5GfSU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fn2lXBnnAML4BX/kG89P/YZYlKLBS7hTE3xoxovFbqAxesBDUclbuU8WvrEWalTZH5onzJL0YWAKF4ZD2ceOaaX6HSab++hsB1e0ION8aPsXGBjFn+qA4SrphYILShCvfJQeIu524JNIznn7F+X0XPEbPgPwv+FmRo9A7l0mbSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=dBLYgIXW; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=dBLYgIXW; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=hknXcs48; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="dBLYgIXW";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="dBLYgIXW";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="hknXcs48"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804752;
	bh=5EnBNbL8mJ2vOm/XrE/Iei5zExtp+PyyvXixlb5GfSU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=dBLYgIXWRluAY74hxIOXBxgNDf7bAVieX+LXYY72RqudJpK7SeLkymbOzo45ocRE7
	 vSzPuCBtGLWliGvOsQx5cFK4vixmtp00sv8Et/niXUvGOad0zwKa20JsociJHwluWY
	 ZH6E00q/buGyTy79wKCxItzVrauXFnfSyh55HG4rIxV6hrbRMcSSfjh52H2esjzhtI
	 MViMqDH10tOyxEDQH/tsLb99RAKuUHHVFrInQQIKiAqtXUBoSV4iVUiYB+6d+YSL6H
	 JyTzm4WPR7sDnQNL+deaEzqOykhuh4uAXENuOP/CA5EfPLYfipbqcETMYCWZCFFVDW
	 aExC8VYy3iTNQ==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id BAFF11BAB9;
	Thu, 23 Jul 2026 13:05:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804752;
	bh=5EnBNbL8mJ2vOm/XrE/Iei5zExtp+PyyvXixlb5GfSU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=dBLYgIXWRluAY74hxIOXBxgNDf7bAVieX+LXYY72RqudJpK7SeLkymbOzo45ocRE7
	 vSzPuCBtGLWliGvOsQx5cFK4vixmtp00sv8Et/niXUvGOad0zwKa20JsociJHwluWY
	 ZH6E00q/buGyTy79wKCxItzVrauXFnfSyh55HG4rIxV6hrbRMcSSfjh52H2esjzhtI
	 MViMqDH10tOyxEDQH/tsLb99RAKuUHHVFrInQQIKiAqtXUBoSV4iVUiYB+6d+YSL6H
	 JyTzm4WPR7sDnQNL+deaEzqOykhuh4uAXENuOP/CA5EfPLYfipbqcETMYCWZCFFVDW
	 aExC8VYy3iTNQ==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 87ED91B971; Thu, 23 Jul 2026 13:05:52 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804749;
	bh=5EnBNbL8mJ2vOm/XrE/Iei5zExtp+PyyvXixlb5GfSU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=hknXcs48OmPqWhVaBE5JXEumNfeQqa5pBU4ezW7JN/y7VZonPtZCPH/oj3BNITaIy
	 tQDdXg502Bri7TSTCF32zGN5wkRiQpAAZfL1gW10FYy9UGKT0HADtw7eASly3pSlua
	 8p1dzORq0I7dE5VVlTbsXKe43sFMYMwc8uPlYEHtBjA/nTRws9+g5LwdxhNYpXqOXs
	 vQJUPfkw0bs0lDbIkjKD142GWGUzx33y811zCDIhsPJZ6e5eqZf7zne+TiTg/Hu97N
	 sj7S2+qTLL4WFyFbeEB6jprRh8AuSF70Dx7rgdtsw++5t0DCeXgxmy7TlN+SVqvZgy
	 q91FbnzhxOa3w==
Received: from [192.168.2.172] (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id B904D1B9E7;
	Thu, 23 Jul 2026 13:05:49 +0200 (CEST)
Message-ID: <74d0929f-1f51-4b57-a23d-ebb059dc8328@lysator.liu.se>
Date: Thu, 23 Jul 2026 13:05:49 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH v12 6/7] i2c: mux: ltc4306: set correct idle_state in
 i2c_mux_core
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
 <20260719-i2c-mux-v12-6-a5010d623a57@gmail.com>
Content-Language: en-US, sv-SE
In-Reply-To: <20260719-i2c-mux-v12-6-a5010d623a57@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hi!

On 2026-07-19 16:59, Marcus Folkesson wrote:
> Inform the core if we intend to disconnect channels during idle.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>   drivers/i2c/muxes/i2c-mux-ltc4306.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/i2c-mux-ltc4306.c
> index 18228f5b80e8..df7136b7b042 100644
> --- a/drivers/i2c/muxes/i2c-mux-ltc4306.c
> +++ b/drivers/i2c/muxes/i2c-mux-ltc4306.c
> @@ -232,6 +232,9 @@ static int ltc4306_probe(struct i2c_client *client)
>   	data = i2c_mux_priv(muxc);
>   	data->chip = chip;
>   
> +	if (idle_disc)
> +		i2c_mux_set_idle_state(muxc, I2C_MUX_IDLE_DISCONNECT);

Perhaps augment with

	else
		i2c_mux_set_idle_state(muxc, I2C_MUX_IDLE_AS_IS);

now that the default is IDLE_UNKNOWN.

Cheers,
Peter

> +
>   	i2c_set_clientdata(client, muxc);
>   
>   	data->regmap = devm_regmap_init_i2c(client, &ltc4306_regmap_config);
> 

