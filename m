Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAABA42901D;
	Thu, 15 Oct 2026 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078075; cv=none; b=s8mgqcccZ8TN842j4jxDufp3ADRh5A1Tir3Nu6fJNZOm7z5AwcpoqI/bEHBg2nDg3LSMqn7TbI6MQ+iXoSDd7c0t+FZ5reJV7DqlohW/SkJxSP29Qv60DnfjY9M529mqiadcghsWdWS37jJbIvlG0hQ3h7vCSx01u+39np5SzCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078075; c=relaxed/simple;
	bh=zFUuoTGFCZ0cX7jMsVkWNSsPSR6iK0hFeLBCqliRwbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bskA/SY8xi5wQ9/1KTuJO50EgYfls3a0HRkx/codq9lfwzv6CP3n2lT7XzlNxBPN/Li6mTUAAU73Neivzq3eX5UHzHSqMq6be32oF/tOmYb8+ISOIt6fC2kk9iegxQBasABVPLXPKjKbPOQWDD7wAne+IsT/2C3C55ik1tYFFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bewWaxuB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bewWaxuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AF61F000C4;
	Thu, 15 Oct 2026 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792078065;
	bh=dWMEp4PZ5/I5dHIWrGo973usMiwe4sGSv2uqkjZ9+gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bewWaxuBOgxHr6vDfWnMTyWzug8Q8lafvhyxEWNU8ECrwaLjvRGCZUEEbTj17+rC2
	 Sx36GzlZTD5WikKPPnkftv8N+ZvB+6CoUbFrj70eT0L9lhogTji/fQqG25pOxqHmWG
	 fQJthQ6ZbEzROilLttJyq674D6ST2gSZm1BxN7nSGBg3ICb9tccPXQ1IqP38U/z7lx
	 Oyoqi5z511rVzSkcFlsFHnMD6CqPF9Qhe/wLdpEMw//qBeKrCpkAwG/QvSmLpP2P9B
	 ffpIVWwDxGv8Rk+TmfbQvmxkSjh9d/9cV36cx81qSr9pNI8lfL2U74iGSJLLAlaQ6K
	 AW+IsHNFS/cgw==
Date: Thu, 15 Oct 2026 16:27:41 +0100
From: Lee Jones <lee@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 4/9] mfd: cgbc: Use PLATFORM_DEVID_AUTO for child
 device registration
Message-ID: <20261015152741.GB2048969@google.com>
References: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
 <20261002-cgbc-i2c-storage-devices-support-v4-4-eb42e0f1df59@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-cgbc-i2c-storage-devices-support-v4-4-eb42e0f1df59@bootlin.com>

On Fri, 02 Oct 2026, Thomas Richard (congatec GmbH) wrote:

> Since parameters are now passed to the i2c-cgbc driver via platform
> data, the I2C driver no longer depends on the platform device ID to probe
> the correct I2C buses. Drop the hardcoded cell ID in favor of
> PLATFORM_DEVID_AUTO.
> 
> Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
> ---
>  drivers/mfd/cgbc-core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
> index 0cd9e6f888cb..8522df882509 100644
> --- a/drivers/mfd/cgbc-core.c
> +++ b/drivers/mfd/cgbc-core.c
> @@ -71,13 +71,11 @@ static const struct mfd_cell cgbc_devs[] = {
>  	MFD_CELL_NAME("cgbc-hwmon"),
>  	{
>  		.name = "cgbc-i2c",
> -		.id = 1,

If you shuffled the patches around a bit, you shouldn't have to hack
your own new additions in and out, no?

>  		.platform_data = &cgbc_i2c_gp_pdata,
>  		.pdata_size = sizeof(cgbc_i2c_gp_pdata),
>  	},
>  	{
>  		.name = "cgbc-i2c",
> -		.id = 2,
>  		.platform_data = &cgbc_i2c_pm_pdata,
>  		.pdata_size = sizeof(cgbc_i2c_pm_pdata),
>  	},
> @@ -349,8 +347,8 @@ static int cgbc_init_device(struct cgbc_device_data *cgbc)
>  	if (ret)
>  		goto release_session;
>  
> -	ret = mfd_add_devices(cgbc->dev, -1, cgbc_devs, ARRAY_SIZE(cgbc_devs),
> -			      NULL, 0, NULL);
> +	ret = mfd_add_devices(cgbc->dev, PLATFORM_DEVID_AUTO, cgbc_devs,
> +			      ARRAY_SIZE(cgbc_devs), NULL, 0, NULL);
>  	if (ret)
>  		goto release_session;
>  
> 
> -- 
> 2.53.0
> 

-- 
Lee Jones
