Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8391850A4;
	Wed,  4 Feb 2026 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770192144; cv=none; b=UzJeVRqrK49P3J4+bTCjBNrkryVCOqJ13EablCK1dhuVP7G9NS6ctZG9fo4svSU67j6HO7SEuxDXtr27vRmk6McH+R1ft6cRM5br/s591OJ5v0c98YaqUQNqbE4O3EaXgCbDq5uLinuVQum8ZpJlMzslJfGyzIQwsE1RlFaZlg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770192144; c=relaxed/simple;
	bh=nRrC8wphQ1dc/BfGnKr7IWUN3Ln6veciQrvR7VK7Ook=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6Y/ti0WgbJXJHXW2DsWBFW7K0oX1rKbl4jhomj7I+srxOepjrtiy9BmU0o04UQ60Uz2l04JZ28blFe6l7CqizTV7lZkBaU43yIYSgDeDaTIv+ji2fhQKWxqyy8efd9hNa5gGV1rzmSoKj7vzkfg15cH5dhsjfUUuQgYAQXR5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0kyECe9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0kyECe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BD3C4CEF7;
	Wed,  4 Feb 2026 08:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770192144;
	bh=nRrC8wphQ1dc/BfGnKr7IWUN3Ln6veciQrvR7VK7Ook=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0kyECe9zWPpUVDyRYGYpTfDn14yi64ekYqYmxZee7Riz1wWcOOBoyPnRXZ/6ekBA
	 sNc4VzDWLWlT3A1k4Aw7mJiZMUwHw6oEFSFZTHE8ryyOt1dKipxppN9S9TzScTMZqi
	 yze/jCixMgyabO3dGH4wr/ZeYI61T2M+PEjxmVLQk1Bg0RECk6vblAGzsX18Yng2ob
	 5yOu8Okf4u/0a8LiJkoxtZC2lmEWnBz0drbjEYOmqH0BUU0+4bUkpHUhUarROd17Zz
	 KietqbYBSlFdrKRu4vE42l9J4uOkfT6geC68q+juJN2jBUWJZw2VD6NS6al3zQRYHC
	 7X8/lbcymdzJA==
Date: Wed, 4 Feb 2026 09:02:19 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Wolfram Sang <wsa@kernel.org>, 
	Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: sun6i-p2wi: Fix device node reference leak in
 p2wi_probe()
Message-ID: <aYL2OAdZTV78Vsy0@zenone.zhora.eu>
References: <20260201-p2wi-v1-1-e0ec9cda82b3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201-p2wi-v1-1-e0ec9cda82b3@gmail.com>

Hi Felix,

On Sun, Feb 01, 2026 at 02:29:00AM +0800, Felix Gu wrote:
> Use the __free(device_node) scoped variable to automatically release
> the device node reference, preventing a device node reference leak.
> 
> Fixes: 3e833490fae5 ("i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/i2c/busses/i2c-sun6i-p2wi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
> index fb5280b8cf7f..652b37b57159 100644
> --- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
> +++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
> @@ -184,7 +184,6 @@ static int p2wi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> -	struct device_node *childnp;
>  	unsigned long parent_clk_freq;
>  	u32 clk_freq = I2C_MAX_STANDARD_MODE_FREQ;
>  	struct p2wi *p2wi;
> @@ -223,7 +222,8 @@ static int p2wi_probe(struct platform_device *pdev)
>  	 * In this case the target_addr is set to -1 and won't be checked when
>  	 * launching a P2WI transfer.
>  	 */
> -	childnp = of_get_next_available_child(np, NULL);
> +	struct device_node *childnp __free(device_node) =
> +		of_get_next_available_child(np, NULL);

A few spontaneous questions here:

- Why are you moving the declaration of childnp in the middle of
  the function?

- Have you run checkpatch.pl before sending the patch?

- Is of_get_next_available_child() allocating the device_node?

- Have you tested the patch?

Thanks,
Andi

>  	if (childnp) {
>  		ret = of_property_read_u32(childnp, "reg", &target_addr);
>  		if (ret) {
> 
> ---
> base-commit: 33a647c659ffa5bdb94abc345c8c86768ff96215
> change-id: 20260201-p2wi-a199cdfe69e0
> 
> Best regards,
> -- 
> Felix Gu <ustc.gu@gmail.com>
> 
