Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A71746AA77;
	Thu, 23 Jul 2026 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804654; cv=none; b=kphPrHMjB/wWgp1jcA70lSjIjbDN1Prff/aU0r0np6CNo0qlMod4mz64X8NtAY2e8BvJqRevvf/KrkMmeRGe8huWiKKrT9qjGp/E1pFm26iUj2fZHigi/NAGc23sWtCbaTyaaunIjduS1UW3hWqxXcs4iuaeXj9fF44qWTEnERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804654; c=relaxed/simple;
	bh=MvTqgjxNS84PYlMlgMtDK8GM9GogEAoF0piEZXQLulU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rRciC9Ozbv29Edo6YHJMe4ZYjpx4/KzvdgP19C7HmZ0jkXjUDLRS+85GZhVojcPZyTqNa+kWI6jYW3KdFjAjchBNMcIi5VOvisL1BKbhPebvRrbCtgkDo0IsMF7TCFbA+PivCjYwmRwubUqdbzTaLve6wGc0KoztDsSidPRUGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=k9WYKSAg; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=k9WYKSAg; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=fRPANJUr; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="k9WYKSAg";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="k9WYKSAg";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="fRPANJUr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804641;
	bh=MvTqgjxNS84PYlMlgMtDK8GM9GogEAoF0piEZXQLulU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=k9WYKSAgUMfyDXdpLMHXKBsgp8Q5JY2Yxyg0fEUqgD6xm/YMnx9sII9mVYCEvgeQN
	 Vsk8VI2zM5hyYIfLnhI14brgy2E0VTqDgb5F7tfGo2+0F2kvbjPouLz6VRjCrMZRGT
	 FZEfbYi4eqL8yQrnPZl1xhjAo4fzzbxDzPqUrveZoOTKlYMN7gB/AJyXGCEaP0jcQ+
	 zFFCmJPwhwGUu+3tueLHifOiuGmPcLFhSfN8XQsjmDqWBMrgGvL8mAj0QM7qvu7wda
	 +HGRyH+VXh0r4J7K0H13HLyhApsLn3EWvYd/ua1sq9zH0AsnJQ/Ta5RZPaNk3e/yCz
	 A62/PKZZ7kz1w==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 445401B9CE;
	Thu, 23 Jul 2026 13:04:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804641;
	bh=MvTqgjxNS84PYlMlgMtDK8GM9GogEAoF0piEZXQLulU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=k9WYKSAgUMfyDXdpLMHXKBsgp8Q5JY2Yxyg0fEUqgD6xm/YMnx9sII9mVYCEvgeQN
	 Vsk8VI2zM5hyYIfLnhI14brgy2E0VTqDgb5F7tfGo2+0F2kvbjPouLz6VRjCrMZRGT
	 FZEfbYi4eqL8yQrnPZl1xhjAo4fzzbxDzPqUrveZoOTKlYMN7gB/AJyXGCEaP0jcQ+
	 zFFCmJPwhwGUu+3tueLHifOiuGmPcLFhSfN8XQsjmDqWBMrgGvL8mAj0QM7qvu7wda
	 +HGRyH+VXh0r4J7K0H13HLyhApsLn3EWvYd/ua1sq9zH0AsnJQ/Ta5RZPaNk3e/yCz
	 A62/PKZZ7kz1w==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 1792C1BA93; Thu, 23 Jul 2026 13:04:01 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804635;
	bh=MvTqgjxNS84PYlMlgMtDK8GM9GogEAoF0piEZXQLulU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=fRPANJUr08xFv3/+Fa3DGpkeAgN3NOgxGNv2LEM4re7gkU9QmPGwaJOIW7QMxsFdS
	 /tVGYBv6YZ8HWFzFfvQNDxOCIhd4mS6XqNEXy6wIqJbbDwiHnXOxYTTzYuwMFZqC64
	 mhFosfN24rv+KpVycw8bRJjMvwxJfNnv5NTvQ9QxV8Ox3R4mknxF+sZYWbUAkDmsOc
	 59rGemRMxO/ZJLuUJcUSs8hnjjDqNr0fFSEdquiInJfrOhf4FeHcJ6PlNROUYOipzB
	 uNBURUcI121smTO0XPNvg6EAEiZf/Gg5rXD27qKlLVWpuX6uN1dSoa7OPTCW7p+8zd
	 SQJuY3WFp+12A==
Received: from [192.168.2.172] (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 053F61BA8D;
	Thu, 23 Jul 2026 13:03:53 +0200 (CEST)
Message-ID: <19dbf4be-5f17-46b3-924d-eb24ae41fdd9@lysator.liu.se>
Date: Thu, 23 Jul 2026 13:03:53 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH v12 1/7] i2c: core: add callback to change bus frequency
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
 <20260719-i2c-mux-v12-1-a5010d623a57@gmail.com>
Content-Language: en-US, sv-SE
In-Reply-To: <20260719-i2c-mux-v12-1-a5010d623a57@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hi!

On 2026-07-19 16:59, Marcus Folkesson wrote:
> All devices on the same I2C bus share the same clock line and the bus
> frequency has therefor be chosen so that all attached devices are able

Perhaps one of:

has therefore got to be
must therefore be

> to tolarate that clock rate. IOW, the bus speed must be set for the

tolerate

> slowest attached device.
> 
> With I2C multiplexers/switches on the other hand, it would be possible
> to have different "domains" that runs with different speeds.

that run

> Prepare for such a feature by provide an optional callback function to

providing

> change bus frequency.
> 
> As a side effect, several bus drivers keep the bus speed in a
> private structure and can now have this value stored in a uniform way
> instead.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>   include/linux/i2c.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 20fd41b51d5c..b3b0d16b4ddd 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -729,6 +729,9 @@ struct i2c_adapter_quirks {
>   /*
>    * i2c_adapter is the structure used to identify a physical i2c bus along
>    * with the access algorithms necessary to access it.
> + *
> + * @set_clk_freq: Set clock frequency for the adapter. Returns the actual set frequency.
> + *      This function is optional.
>    */
>   struct i2c_adapter {
>   	struct module *owner;
> @@ -742,6 +745,8 @@ struct i2c_adapter {
>   	struct rt_mutex mux_lock;
>   
>   	int timeout;			/* in jiffies */
> +	u32 clock_Hz;			/* bus clock speed */
> +	int (*set_clk_freq)(struct i2c_adapter *adap, u32 clock_Hz); /* Optional */

To expand on the comment from v9 by Wolfram [1], I too think it
would be good if this function pointer did not live directly in
i2c_adapter but instead in some other struct so that the actual
pointer could live in read-only memory. I.e. if i2c_algorithm
does not fit for some reason, a new function pointer struct might
be called for?

Also, returning int instead of unsigned hints that the function
might return a negative error code, but the new code in 3/7 does
not handle errors. So, either change to unsigned int, or update
the support code in 3/7 to handle errors. I think the latter is
the better approach.

Cheers,
Peter

[1] https://lore.kernel.org/all/ahX44_rzaRlTLSLU@shikoro/

>   	int retries;
>   	struct device dev;		/* the adapter device */
>   	unsigned long locked_flags;	/* owned by the I2C core */
> 

