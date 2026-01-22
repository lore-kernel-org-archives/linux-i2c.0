Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0C63B8BAA;
	Thu, 22 Jan 2026 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078242; cv=none; b=FWB+wp4uD7gAbolDrOeJyIQa5AsEwhtpMK5Chwc8DvxVpJ4BuRhbmRaUYW/s8WZLaE0TjINprkNTVZ0QOAA+rkIxzBq1C8Y1ORiZwALh6IbaqYzSBgm90NUF49eMAH25cfEcsDCbenV3MsAeiYSptDN7A49x0/QjED0Fij25U+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078242; c=relaxed/simple;
	bh=FccswDt1ve3Bw8PGppebIjkWsHqjiqkrCg5Iexi5hHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jh+RZPLsZSCFR/9EsJBOEP16erwjrgPgvbFq2ZZ8Rk7+v42HzoJf3G5yEzThIEysuve2V899YqQX6f77VAJA1z06XcZae0ueR+uvQDeg/30hoy6YV9B/19tU7+ix1NxYM3Tf0y9vEZ7vbxVk5lo+IEVSm9+ZUcAEwg5Ce8EUTys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIMAmIy0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIMAmIy0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2411C116C6;
	Thu, 22 Jan 2026 10:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078241;
	bh=FccswDt1ve3Bw8PGppebIjkWsHqjiqkrCg5Iexi5hHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UIMAmIy0OycHyT26S6tNnTJbPhbPrw+fqjhvwtoWA34HqqzTSSHbk8dZVGxswwcAw
	 MjErjMsmZGVMccIlBYhv3atQQAPFWTU0Z1+4QEjJ5eK24Z2DySDFwj9pDU1dZzoQvH
	 1ktdM1zRO+e6TLPHvWXhkZNPd4/LEOBNXsYjzUL0pSBRqsUgXJjSVbMZ+Ovik6uLSb
	 sUGw3KpmhnqKhsJt/XelJabWDXdHOF2jM7R/rC9zqhae2jdKv1mb99ESyWzZlKYa+q
	 czZumrZpOk333rp9POghKBcrbIRZtdTqg2PrCs/wIOxKcBrsGG7BHD7n+Nt+Zl5qT0
	 FnRZLBvdaRDCA==
Date: Thu, 22 Jan 2026 11:37:17 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2] i2c: Add FTDI FT4222H USB I2C adapter
Message-ID: <aXH1fEkQWnekwSui@zenone.zhora.eu>
References: <20260116101816.1200416-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116101816.1200416-1-flavra@baylibre.com>

Hi Francesco,

...

> +static int ft4222_i2c_get_status(struct ft4222_i2c *ftdi)
> +{
> +	/*
> +	 * Multiple retries are needed mostly when retrieving the controller
> +	 * status after doing a write with the I2C bus operating at a low speed.
> +	 * Empirical tests conducted at 100 kHz showed that after a
> +	 * maximum-sized (512-byte) write, up to 11 retries are needed before
> +	 * the chip clears its CTRL_BUSY flag. But under certain conditions more
> +	 * retries may be needed: for example, when trying to do a write after
> +	 * disconnecting the SCL line from the I2C slave, tests showed that up
> +	 * to 64 retries are needed.
> +	 */
> +	const int max_retries = 70;
> +	int retry;
> +	u8 status;
> +
> +	for (retry = 0; retry < max_retries; retry++) {
> +		int ret = ft4222_cmd_get(ftdi, FT4222_CMD_I2C_STATUS, &status);
> +
> +		if (ret < 0)
> +			return ret;
> +		if (!(status & FT4222_I2C_CTRL_BUSY))
> +			break;

How about adding a small delay here. Does it also help to reduce
the maximum number of retries?

> +	}

...

> +	dev_dbg(&adapter->dev, "transfer with %d message(s)", num);
> +	for (i = 0; i < num; ++i) {
> +		const u8 addr = msg[i].addr;
> +		const u16 len = msg[i].len;
> +		u8 *buf = msg[i].buf;
> +		u8 flags;
> +
> +		flags = ((i == 0) ? FT4222_FLAG_START : FT4222_FLAG_RESTART);
> +		if (i == num - 1)
> +			flags |= FT4222_FLAG_STOP;

Are we setting here both STOP and RESTART at the same time.

The rest looks good to me.

Andi

> +		if (msg[i].flags & I2C_M_RD)
