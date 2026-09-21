Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF904455616;
	Mon, 21 Sep 2026 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980221; cv=none; b=H6N8oKD6CdoH+vua+RzZFRCYZTT0XVkd4U4Zlk/B9cscAHHzzumYn9NstvD5ae8OV4vVP0X2nDrTW5OaVlnuPfk5w+LZPYLYZWuj6gs5+lTs/qkQWqxxB+BRqoOTS03gkq9mrxTxDQtEjAyspFophWvbkXePj+pdFkHQl9Pk2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980221; c=relaxed/simple;
	bh=CTyUk3bXeRQEBicqspo+8zMGMw6o41y6qZ7TDPLl+jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD4Uc3aiDaviCr0G8kCGcEOSiOei222hcJOLhl3NIohR58wKpuQEtET13GVSCdlUcwzE9p7M15cr4uXYrLkHFCChU11H21DxzTFk30aktnE0eMwiHDKbssDBasYPeamLioEU23f5/sz8kJLen1uZ6KMkwVJGsPz4+WZ45qUy+p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mILJ6K+/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mILJ6K+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3631F000FF;
	Mon, 21 Sep 2026 08:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980215;
	bh=kMQoUbFbkBmtg2Op/ssogbW7S871P7MvOsFe4ikx5pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mILJ6K+/4ifQWXrg46EePjbXVwCVVBln1I3gCIIpwWmKkdN0eUKdRIQyvWulys4iz
	 3I+CsOokgKWic5PEpnTGd5C1ZYgzUqTjd+jyICJGcHP7Wmfcm/6Qh20/gEwq/Pg/Uy
	 gw6jE/RQva9tBf/RPRv8GjMJGxOQ1e/WPGk/Z+L8HYcf4umTCfIAL/vByuTQwpoSlJ
	 HYa4OyQ9TsdpHR5b8K7ptXwufSOr6yIJBhREVTj9IUMKD+s5AW+/PuBvSKY7Ir5zZB
	 IEMWt/pxaYs/lPJxhmE+xtNBQsCjfxWeM58OLusdaTx56koqRHmk2bCiDvF8iVOVBc
	 SyXXt0nrpJkrw==
Date: Mon, 21 Sep 2026 10:43:32 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] i2c: xiic: preserve PEC byte length in SMBus
 block read setup
Message-ID: <arDgdyG0QsNerDH5@zenone.zhora.eu>
References: <20260909-i2c-xiic-v4-0-218df31e9d3b@nexthop.ai>
 <20260909-i2c-xiic-v4-1-218df31e9d3b@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-i2c-xiic-v4-1-218df31e9d3b@nexthop.ai>

Hi Abdurraham,

...

>  		xiic_read_rx(i2c);
>  		if (xiic_rx_space(i2c) == 0) {
> +			/*
> +			 * If the setup path padded a short SMBus block read up
> +			 * to SMBUS_BLOCK_READ_MIN_LEN for the HW exit
> +			 * workaround, trim rx_msg->len back to the number of
> +			 * bytes that are actually valid so the SMBus core's
> +			 * PEC check reads the right index. Must happen before
> +			 * the rx_msg = NULL below.
> +			 */
> +			if (i2c->rx_msg && i2c->smbus_actual_len)
> +				i2c->rx_msg->len = i2c->smbus_actual_len;

We do need to reset smbus_actual_len at every xiic_start_recv(),
otherwise this would be true for every rx_msg. Right?

Andi

>  			/* this is the last part of the message */
>  			i2c->rx_msg = NULL;
>  
> 
> -- 
> 2.54.0
> 
