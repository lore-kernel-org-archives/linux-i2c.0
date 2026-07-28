Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2182BEFEF;
	Tue, 28 Jul 2026 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251093; cv=none; b=UXbz85I8iC/qXfl5GA1HpmNADDjKql/ABWn5v7yhJqMbUSDJ0RFfMTmsmBlju0SDjk0m0vy/ZqUK4orzPRA7qkwESnaclmKVQyBcEAHn7VIOtReK9D6ypSr+1D6Fc2xeGv9IjZALrJdmoQGG+78oNsGMGPs4ePTGTiVKp9ChwLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251093; c=relaxed/simple;
	bh=+HKsrMkCi+XzPBvfB3IlHVER/UvclDLfqQoXW9pXG7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBhn68rrkgsf3sYlRSiSNAn/VQdDgFNYHitGpxXVDeHU7bch1EddjoaROJ62Hs22JCIPFzK6gMVIMv9AQ6RgU+BvOGCkjdt7r7OZhH6Q8GEYfDQzU7Q2LIWXqE7OZKzTzy1VjE6CwUnXfv+stgFDfi5YIK9NGyxQ012o3Pwarvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwgtnfnn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwgtnfnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEAC1F000E9;
	Tue, 28 Jul 2026 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785251092;
	bh=OU1UYYzgK2OnsQUDtZlUXsO0y8vH10YtQbu83GhdYec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dwgtnfnnoetGxkNWCraCuFJ0wy+gNQtppjs7e8vtB01nHBGxtOI89/oujAOaFFNKH
	 jvj2iF6k5jRwlfpUOAWiuAQW7dG5Vm47p0oimg4Hj6BZtfH4LxJUFsokUoRQoAz3YY
	 YAV+nV0QpSQ+y0hOIKnrs84dt69Q5ToRmidWF6mI5wq+Z+njqSOf5CmrAwpAoBR1VK
	 H8GriH7jHWyXl8ENgHcHnXy3S7S699/hhbK3lfJ3ReGcyYEbyusxJdynD9TZ4ZbftI
	 4N1L2rxWH+7R0HHWPByIkeDzP/EMDHIzLih2wWCQs0yE6eh11axrQs3DKKgmoJZF0K
	 tsBoySQX2Pf7g==
Date: Tue, 28 Jul 2026 17:04:48 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Jonas Gorski <jonas.gorski@bisdn.de>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Kevin Cernekee <cernekee@chromium.org>, Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: iproc: reset bus after timeout if START_BUSY is
 stuck
Message-ID: <amjDbiXiq6Rse0Ir@zenone.zhora.eu>
References: <20260717085507.34209-1-jonas.gorski@bisdn.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717085507.34209-1-jonas.gorski@bisdn.de>

Hi Jonas,

...

> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index b5629cffe99b..86ca4c2221c4 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -803,6 +803,17 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	}
>  
>  	if (!time_left && !iproc_i2c->xfer_is_done) {
> +		/*
> +		 * The controller may fail to clear START_BUSY after a timeout,
> +		 * reset the controller to recover in that case.
> +		 */
> +		if (!!(iproc_i2c_rd_reg(iproc_i2c, M_CMD_OFFSET) &
> +		       BIT(M_CMD_START_BUSY_SHIFT))) {
> +			bcm_iproc_i2c_enable_disable(iproc_i2c, false);
> +			bcm_iproc_i2c_init(iproc_i2c);
> +			bcm_iproc_i2c_enable_disable(iproc_i2c, true);
> +		}
> +
>  		/* flush both TX/RX FIFOs */
>  		val = BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);
>  		iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, val);

the patch makes sense to me, but can I have an ack from the
Broadcom folks? Ray? Scott?

Thanks,
Andi
