Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A909258EF9;
	Sun, 26 Jul 2026 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096673; cv=none; b=H8eGwQ35Ye0/JeQWTOZfLCiKtMpWMC7MYT+T4CoJGPUral5goC8oWadCyQ7LSnQHXJL2JrRkSjMR226osCnrtO/S31qDNqGxb9RvIMbOT5pKDu0oBYTW/g3JS0Izf+VuncT3RP173/nqkGXGMJXW0YqgZpa5SXwue6tMiQn6Gdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096673; c=relaxed/simple;
	bh=OreYQOrZ6UNqoHhuVoPOtIOPmzrs9/KeCA7aSaFTXzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNR6xehckQZMAqIxW3bFxDYWBx76wnaDDuPaRKy9vf14UvI+IVK2WQTvrL5NW3g5RCYSKAiXKrKpnnp1Rnzs4amIk8+CAi4A4QICt6VYT+yVVhyYqUi4vJCDqatZEj5dv9F4qVLOaA1tn2Ak7w9drK3stol3DmXd7GZby/fUiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLbku/9O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLbku/9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258C71F000E9;
	Sun, 26 Jul 2026 20:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785096671;
	bh=k3nHeAEMQLfO3MELUrR33VPFp3S0R650orjQi8TyOcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hLbku/9O0USRWmuDaaHB1IFPBfIHuHs8SIWUKez9d12XwfP5y4i4TpKDGhnqrmyRz
	 CjdLoSuqPNCOEeQK+8TINH+T6Fe3yBozqG5q9QO08f91i0RUMWfIorEs2Mut0HHKVP
	 mSYRDy6ChwRUcr3lwJe+DS61bx+FVR+6cndjrRPd8doGg4x/0IFUFYZzxGKZMrjNwu
	 rXiLBWqmYxlH5qbuCdsHqUUob+Y20/K6NGgo7p+yC3rVqoko9+PUu3CEogSsEcHTiy
	 MOJCPCaV0ETQlXMSK5sIXfP5HoJt8zsM7T0HOeiY6UKp3pU4Qy5pxq7A68K/+pDdH1
	 aNNKpcIDyHYWA==
Date: Sun, 26 Jul 2026 22:11:08 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Aniket Randive <aniket.randive@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 1/2] i2c: core: Add i2c_update_timeout() helper for
 dynamic transfer timeouts
Message-ID: <amZkf3lu7gjWhw04@zenone.zhora.eu>
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
 <20260720-master-v6-1-671261b05c61@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-master-v6-1-671261b05c61@oss.qualcomm.com>

Hi Aniket,

On Mon, Jul 20, 2026 at 05:11:19PM +0530, Aniket Randive wrote:
> The transfer timeout for an I2C controller should reflect the actual
> message length and bus frequency rather than a static 1-second value.
> A static timeout causes unnecessary delays on error paths for short
> messages, and may be insufficient for very long transfers.
> 
> Add i2c_update_timeout() to i2c-core which computes a transfer-specific
> timeout and stores it directly in the standard adap->timeout field.  The
> formula accounts for 9 bits per byte (8 data + 1 ACK) at the configured
> bus frequency.  The caller supplies a safety multiplier and a minimum
> floor so that each driver retains full control over its timing policy
> without those values becoming public API.
> 
> Storing the result in adap->timeout makes it visible to all consumers of
> that field, including the arbitration-loss retry loop in __i2c_transfer().

this patch does not take into account a timeout set by userspace
through the I2C_TIMEOUT ioctl. That value would be silently
overwritten by the driver.

> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>

...

> +/**
> + * i2c_update_timeout - compute and set a dynamic transfer timeout on an adapter
> + * @adap: the i2c_adapter whose timeout field will be updated
> + * @bus_freq_hz: I2C bus clock frequency in Hz
> + * @len: transfer length in bytes
> + * @safety_coeff: multiplier applied over the theoretical wire time
> + * @min_usec: minimum timeout floor in microseconds
> + *
> + * Computes a transfer-specific timeout from the message length and bus
> + * frequency, applies a safety multiplier and a minimum floor, then stores
> + * the result in adap->timeout (in jiffies).  The caller supplies the policy
> + * constants so they remain internal to the driver.
> + */
> +void i2c_update_timeout(struct i2c_adapter *adap, u32 bus_freq_hz,
> +			size_t len, unsigned int safety_coeff,
> +			unsigned int min_usec)
> +{
> +	u64 bit_usec = mul_u64_u32_div(len * 9, USEC_PER_SEC, bus_freq_hz);

bus_freq_hz must be checked before the division, otherwise a zero
value will cause a division by zero.

> +	adap->timeout = usecs_to_jiffies(bit_usec * safety_coeff + min_usec);

If min_usec is a minimum timeout, why is it added to the
calculated value?

I would expect something like:

   max(bit_usec * safety_coeff, min_usec)

Otherwise, min_usec is an additional margin, not a minimum.

> +}
> +EXPORT_SYMBOL_GPL(i2c_update_timeout);

I'm wondering whether changing the adapter timeout from the I2C
core is the right approach.

Perhaps i2c_update_timeout() could return the calculated value
instead, but then  do not see much value in exposing such a small
calculation through the I2C core.

I know you were advised to move this into the core, but it does
not seem particularly useful there and, as it stands, it looks
somewhat controversial.

Unless there is another good reason for keeping it in the core,
I would drop this helper and keep the calculation in the driver.

Thanks,
Andi

> +
