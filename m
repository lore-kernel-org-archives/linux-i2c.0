Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE353E47B;
	Fri, 27 Mar 2026 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620789; cv=none; b=HGrvtAzN3cMMh7BKmKe+trqB5xgAf2VQHaWzS9dhn8iNkGcIyLUL6Og8jwKPXMdjBOA6GjboTdzj0R8Sx6bVSRYPBEF+4NRNzDgjoGkmu4WFq8MtmjHL+XLRQmrVmYldbc7Afyw8qbOqHHINMAd99OjPuyiTkITc/Q7WEs4WkEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620789; c=relaxed/simple;
	bh=5mcg1waPoO21wSoUWMynxOB1O+1L/amm4zTHgrcVfQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlv4VyEgvmk3OSkykrzStPUy82TfkwDRp6uNWSjX9MEYR5uq/pFTolskKYqhanGek6p6ZQwYyl13MHq2rmqN44AyTZtA+qsEQ38eE/ToFx+tGcmiIV5wQfkEKC+pRVxanrKV9uFGMlkS1nRxk/T3n+oz2OAuRxy0H7GcCw+mky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGhTJMkh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGhTJMkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F51C19423;
	Fri, 27 Mar 2026 14:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774620788;
	bh=5mcg1waPoO21wSoUWMynxOB1O+1L/amm4zTHgrcVfQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGhTJMkh9Bq+k5+k40xOk3NeFoqbDJo/I30Evnz/mWtxMt3VlEaMpsrG2kVcpdgrx
	 mgjY1TYRrpGs2SUriLWnErf0NxHX8J2s+1TSggVuTcFCCgbA+9gAMwMXKy2ajtAMVW
	 psCh8SPtq/sUPrkouY9yCGB+s+hk2IhEG5HgBbqETSvuCuu0EuF+zSrp53uGd11Q27
	 ogRz6OwWmBEV+dXlrLobzC+68g3q5g7OjKiPGOXUEq7prS6Bfk618AyepMokewo6Me
	 GG4wbsShy/h72C9j7E4znJeCSxVjxYz3Q/GUMkg7sVq5LiOrhOWV72tFYFMAPsPCMu
	 Wd+VaI4cDgegA==
Date: Fri, 27 Mar 2026 15:13:04 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	David Wu <david.wu@rock-chips.com>
Subject: Re: [PATCH v2] i2c: rk3x: add support for SCL OE debounce and slave
 hold recovery
Message-ID: <acaO5ouMmGA8-tqJ@zenone.zhora.eu>
References: <20260321105146.7419-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321105146.7419-1-linux.amoon@gmail.com>

Hi Anand,

...

> @@ -1125,6 +1141,17 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
>  		}
>  	}
>  
> +	/*
> +	 * If a timeout occurred and the slave is holding SCL,
> +	 * re-apply the timings/dividers to attempt recovery.
> +	 */
> +	if (ret == -ETIMEDOUT && i2c->soc_data->has_scl_oe_debounce) {
> +		if (ipd & REG_INT_SLV_HDSCL) {
> +			dev_err(i2c->dev, "SCL hold by slave detected, resetting timings.\n");
> +			rk3x_i2c_adapt_div(i2c, clk_get_rate(i2c->clk));

argh! this nests i2c->lock. rk3x_i2c_xfer_common() already holds
it when calling rk3x_i2c_adapt_div().
Andi

> +		}
> +	}
> +
