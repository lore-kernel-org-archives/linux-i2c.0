Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EF81A23A6;
	Tue, 25 Aug 2026 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637023; cv=none; b=TXDNrkYsl3E4r2crnDHh/hjR3tUxIlehDVvFHjo4dbV7UG1ULgV1l5xR2Uz8QNYAkn8VRyKMg71GnseZDwbz6chNVLsvZr5TggutsB93Lq2/PJOIb8TjxVFBxIMSRlKj5tvw7t1lOhxlUARa9R8zhwbaDG8OyxCfLHg+Yp3YfL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637023; c=relaxed/simple;
	bh=s+pqx/hb3++GbJUK7sn7Zg6fO9h1+ABdqj3nm8ruv+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKFlFoO3TEt0ixZTV8R6Tt2jpRN5VWDG73MBTZhuAZKQxJIm4LA3GtoeM9KlJuqvBS3DugKoah424gZH9r9yGk4Fk1z9xM+FIZAvPfnGYgojay4j0ueQrqjOT5MWkPEq2ukMk0vK0dVihp6sSM94gZeIb3j6TPGe7xw9FOucrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=pIDKt5Vm; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=LEoaV0aj; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="pIDKt5Vm";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="LEoaV0aj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1787637019;
	bh=s+pqx/hb3++GbJUK7sn7Zg6fO9h1+ABdqj3nm8ruv+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIDKt5Vmbw615U7rIZF7hia3eUzqf3lUbtVxKzrYTF1491et8eVHA+tI4qxj9Ndc9
	 c00Od8NUUAyFpyuSXAWjs/Vu5bPile2hsgTpGfg395SNKtwQkVum4TWUxsBrgRHdzk
	 bNOPXrYt0+l4tIKf2dqLfxwQUB1YsCaBYwtzJfc7okB83WUL23TsY20ImCYGLrKQd+
	 o9GdLkE50+ecmZ9PuuMKeuWa7c9M0fJIVF+55yf6YFVF85f5ZwzaG2ZhRx3OurVRp6
	 6z/jlzk8O1koQ4RztulJXFR0r/B9W5R45de4q4T6k+0IL/G1ZZv3MoCYsYb6j9bfry
	 vM3vOs9AcmuWw==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 125E914E39;
	Tue, 25 Aug 2026 07:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1787637018;
	bh=s+pqx/hb3++GbJUK7sn7Zg6fO9h1+ABdqj3nm8ruv+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEoaV0ajZjljpaqqwRKSn040IHhvSLjl8kST4exDtuScXykXcftyQgQM6mFArJVZr
	 BJl/N12ROo5PSW4zj6h4qtqjMFzal1Dm9JwwlDLiWTa+4M4ZVu4gqO8qSs/1tWDWfm
	 pPAgVBUzRAkr5Tz16dP2PE4WTIxHF8dqR6uk0/SjI7OpeG567s50kRZEuhEMXQXeIo
	 Xja04ZvVaHmA882E6Fl7whMnETS8xcczR2br7jFhlqLSSdSFCSSXzNXPjoyz7m9At2
	 zyPE+b8IDng4grX6P+JwDuae30XlkL6037b+RIWi6klSivkMqoui6G0UbdM9VK66aN
	 RIzME3e7RNTVg==
Received: from gryt (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id CEF3C14E38;
	Tue, 25 Aug 2026 07:50:18 +0200 (CEST)
Date: Tue, 25 Aug 2026 07:50:17 +0200
From: Peter Rosin <peda@lysator.liu.se>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] i2c: mux: Factor out channel node lookup
Message-ID: <ao0tGY0sCgxHq3mV@gryt>
References: <cover.1787502619.git.ahmadexp@gmail.com>
 <ab51db7f1d0ca80b0aab631c3215594b6fa33e33.1787502619.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab51db7f1d0ca80b0aab631c3215594b6fa33e33.1787502619.git.ahmadexp@gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP

Hi!

Den Sun, Aug 23, 2026 at 09:34:37AM -0700, skrev Ahmad Byagowi:
> Move the existing Device Tree channel-node lookup into a helper in
> preparation for using generic firmware-node operations.
> 
> This is a pure refactoring with no functional change.
> 
> Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
> ---
>  drivers/i2c/i2c-mux.c | 84 +++++++++++++++++++++++--------------------
>  1 file changed, 46 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 68a4c34b5987..a8b94b97a725 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -264,6 +264,51 @@ static const struct i2c_lock_operations i2c_parent_lock_ops = {
>  	.unlock_bus =  i2c_parent_unlock_bus,
>  };
>  
> +static struct device_node *
> +i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
> +{
> +	struct device_node *dev_node = muxc->dev->of_node;
> +	struct device_node *mux_node, *child = NULL;
> +	u32 reg;
> +	int ret;
> +
> +	if (!dev_node)
> +		return NULL;
> +
> +	if (muxc->arbitrator)
> +		mux_node = of_get_child_by_name(dev_node, "i2c-arb");
> +	else if (muxc->gate)
> +		mux_node = of_get_child_by_name(dev_node, "i2c-gate");
> +	else
> +		mux_node = of_get_child_by_name(dev_node, "i2c-mux");
> +
> +	if (mux_node) {
> +		/* A "reg" property indicates an old-style DT entry */
> +		if (!of_property_read_u32(mux_node, "reg", &reg)) {
> +			of_node_put(mux_node);
> +			mux_node = NULL;
> +		}
> +	}
> +
> +	if (!mux_node)
> +		mux_node = of_node_get(dev_node);
> +	else if (muxc->arbitrator || muxc->gate)
> +		child = of_node_get(mux_node);

You can return early here with "return mux_node;" (which also
obviates the need for the above " = NULL"-initializer and the
below "if (!child)"-test).

Cheers,
Peter

> +
> +	if (!child) {
> +		for_each_child_of_node(mux_node, child) {
> +			ret = of_property_read_u32(child, "reg", &reg);
> +			if (ret)
> +				continue;
> +			if (chan_id == reg)
> +				break;
> +		}
> +	}
> +
> +	of_node_put(mux_node);
> +	return child;
> +}
> +
>  int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  			u32 force_nr, u32 chan_id)
>  {
> @@ -327,44 +372,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  	 * Try to populate the mux adapter's of_node, expands to
>  	 * nothing if !CONFIG_OF.
>  	 */
> -	if (muxc->dev->of_node) {
> -		struct device_node *dev_node = muxc->dev->of_node;
> -		struct device_node *mux_node, *child = NULL;
> -		u32 reg;
> -
> -		if (muxc->arbitrator)
> -			mux_node = of_get_child_by_name(dev_node, "i2c-arb");
> -		else if (muxc->gate)
> -			mux_node = of_get_child_by_name(dev_node, "i2c-gate");
> -		else
> -			mux_node = of_get_child_by_name(dev_node, "i2c-mux");
> -
> -		if (mux_node) {
> -			/* A "reg" property indicates an old-style DT entry */
> -			if (!of_property_read_u32(mux_node, "reg", &reg)) {
> -				of_node_put(mux_node);
> -				mux_node = NULL;
> -			}
> -		}
> -
> -		if (!mux_node)
> -			mux_node = of_node_get(dev_node);
> -		else if (muxc->arbitrator || muxc->gate)
> -			child = of_node_get(mux_node);
> -
> -		if (!child) {
> -			for_each_child_of_node(mux_node, child) {
> -				ret = of_property_read_u32(child, "reg", &reg);
> -				if (ret)
> -					continue;
> -				if (chan_id == reg)
> -					break;
> -			}
> -		}
> -
> -		priv->adap.dev.of_node = child;
> -		of_node_put(mux_node);
> -	}
> +	priv->adap.dev.of_node = i2c_mux_get_channel_node(muxc, chan_id);
>  
>  	/*
>  	 * Associate the mux channel with an ACPI node.
> -- 
> 2.50.1 (Apple Git-155)
> 
