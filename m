Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852D22E9730;
	Tue, 18 Aug 2026 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787065097; cv=none; b=dX4uB38XihtvENtLb6kDZNfflQeUtvajHFG/tmLrBLeGDqzREV93OHBkeJ4pCr1osaWnu7Q+Rc57gdlSvCuAb0GEWlv0jf5lKV+9ZrwYJn7tlgl0sJ0/bWqg31BwI+1YA8CW15CGCZhCJ3ii6+Rwq4JZA3Rd0pjSuVvjv9otzyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787065097; c=relaxed/simple;
	bh=nvgkm13RG37IehAJ7CrMCFg1oQ31UxfCE3y9DKjj1mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExfismoGtu9v8YPMhPN9d8IL01FeGctCAcLet/Y76X6MI+l+5FkcbvkRCrZfYuAzXkpA64j5B/bBbdZrm/ZER+6kkfMmuLQv+IQRRG73UcIRvuvsoM6+/I17CF0Z3DhR6hzKXKxnXpHSpmldPiVDF1su/NhI6h74ZPeFbx3TZoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxm/qsLK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxm/qsLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E6D1F000E9;
	Tue, 18 Aug 2026 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787065096;
	bh=UAkcgdEMwmE9sdUoY4qewo8s31VVAONo66F8/bIGiz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gxm/qsLK/jepvvBrLNu7hBTqsLfuIpD3GgIpFs5cidsKSl9iPBEXZog8OZYQsXY4/
	 HwnDymvczFtUEK1rgDO8omopD4PnogHS32yDGzgtzSOT5E4Eq9OXELNvGCthAKexy2
	 vdaYJLYqFO6jDEKAXxejuNgqFeLGZFhPMzagzItcGeteDH38JflsP3t7t/y4WzfmXg
	 1zDgjpbseESHdmjKdhpXbLO3FyWh5H5mPgPTwdXK5XH+pXg5cE+bhUrNT/W0VgawSs
	 3P7Tfekl7c0Ca6LSTRFrDC54h6AjAwd23jzOKfipgpb0tbc243/16jyJXwLImmtflH
	 DMYWhOXQDK8Iw==
Date: Tue, 18 Aug 2026 16:58:13 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: zhaohaiyang1 <yewentian395@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zhaohaiyang1 <zhaohaiyang1@xiaomi.com>
Subject: Re: [PATCH] i2c: bcm2835: add missing braces to for loop in
 bcm2835_i2c_xfer
Message-ID: <aoRysYp25Ni4jMaL@zenone.zhora.eu>
References: <20260817130234.372628-1-yewentian395@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817130234.372628-1-yewentian395@gmail.com>

Hi,

On Mon, Aug 17, 2026 at 09:02:34PM +0800, zhaohaiyang1 wrote:
> From: zhaohaiyang1 <zhaohaiyang1@xiaomi.com>
> 
> Add curly braces around the multi-statement body of the for loop
> that checks for unsupported read messages. This fixes a coding
> style issue where the compound statement lacked explicit braces.

it's not a multi statement body, if you look very carefully from
closer, there is only one single solitary 'if' statement.

> Signed-off-by: zhaohaiyang1 <zhaohaiyang1@xiaomi.com>

Please next time use your real name here.

Thanks,
Andi

> ---
>  drivers/i2c/busses/i2c-bcm2835.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> index 8554e790f8e3..76d017cf1582 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -349,12 +349,13 @@ static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
>  	unsigned long time_left;
>  	int i;
>  
> -	for (i = 0; i < (num - 1); i++)
> +	for (i = 0; i < (num - 1); i++) {
>  		if (msgs[i].flags & I2C_M_RD) {
>  			dev_warn_once(i2c_dev->dev,
>  				      "only one read message supported, has to be last\n");
>  			return -EOPNOTSUPP;
>  		}
> +	}
>  
>  	i2c_dev->curr_msg = msgs;
>  	i2c_dev->num_msgs = num;
> -- 
> 2.43.0
> 
