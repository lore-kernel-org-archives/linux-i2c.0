Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51570305046;
	Sun,  8 Feb 2026 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770559920; cv=none; b=kQR0Pqe9sXtRBhEgn8smPnsBz76h2399tArmvqC7AY5Q3HI+acPIgBtPj3uPUIK4FU7V60Jk6XNyNruvLGTmwVHdNiewZkEVg7K1wndxtIO14dA/DtHbA2YAt4jytXNSiDaLN+f8/UaYiuluy3kOGSuBm6Ns/ebLZEaP1y2KQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770559920; c=relaxed/simple;
	bh=0Cre6VEHeivJNXwn4UyRRfJOv+DOE2XvyUOpNu+zQjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm1VQ5bc8RfxDUoHG9tJbrnNDkRCprvxFzuamsFNH+TDjzGa3OCxQZSnog4J93Sy5DLADEwQhkkyt0nbO4PNI5FksS28bZZT8BjGsDdcAO1jbQ6Jg3GDgXQI62Skqq07LT3zMeNcxHwCEvxaaUjSqHwFexBVPqgNtE9mEe3g9Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=dRyWc3+g; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="dRyWc3+g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=cvQzn3HpfaP9SKHFgaRPRh6odBgX24tfEJllJZ5Gf20=; b=dRyWc3+gR91ttHyBS322jAlurV
	y1lPF0fkz/4y8iTAWHo5qHC22mFNYAf3/gGnPkVUtxXsLSrw9R2NgPel8HYeUPUBHzbkU8QB7YWmq
	kLnOD7aQRgO810cv7WxnkCxIqL5ROb8fRI2nBxTnLjqkp+DUpXq2Wx2ztnc8mCMAKQll3Kh2Q2vGZ
	395B+/04v9QCjDDgxu0mERaZnw8O6LWjo6ohj/D3sCwOJLGYCKsTG1iFyV9YVtVcfp/h4dij/skTu
	w2xA4NTONF94hmvhfiKLXLSKsGd1T2hDlIhTwyrAP4UY2zrCU5oZkXOWbYHuwUhP0OhpQWCryR0Az
	qy1VH8gw==;
Received: from [2a01:e34:ec5d:a741:1ee1:92ff:feb4:5ec0] (helo=ohm.rr44.fr)
	by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1vp4zZ-00000001VPd-2nK5;
	Sun, 08 Feb 2026 14:38:25 +0100
Date: Sun, 8 Feb 2026 14:38:25 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Alex Elder <elder@riscstar.com>
Subject: Re: [PATCH v7 0/2] i2c: spacemit: introduce pio for k1
Message-ID: <aYiR0VQXvBJDSQPh@aurel32.net>
Mail-Followup-To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Alex Elder <elder@riscstar.com>
References: <20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207-b4-k3-i2c-pio-v7-0-626942d94d91@linux.spacemit.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi Troy,

On 2026-02-07 23:08, Troy Mitchell wrote:
> This patch introduces I2C PIO functionality for the Spacemit K1 SoC,
> enabling the use of I2C in atomic context.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
> Troy Mitchell (2):
>       i2c: spacemit: move i2c_xfer_msg()
>       i2c: spacemit: introduce pio for k1
> 
>  drivers/i2c/busses/i2c-k1.c | 316 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 236 insertions(+), 80 deletions(-)
> ---
> base-commit: 2fe0719258a48c204270366ef574066122e81924
> change-id: 20260207-b4-k3-i2c-pio-318088c1b3b7
> 

Thanks for this new version. This is:

Tested-by: Aurelien Jarno <aurelien@aurel32.net>

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
