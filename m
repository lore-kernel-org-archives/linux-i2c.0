Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805DF361DCA;
	Wed,  1 Apr 2026 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086902; cv=none; b=juW/ALG+gdPH/hfmSC2Low/oK0OVmK+NWiXPkZ/yP/KgKDHLB0X0JcDky9y7hecGO/qHwx28TGSFH2YhWolXOwAT306wsOiMdh80MjpTZW7zZhbMmZC/iuH8aiziH+2vOEaMkm0FCoR+U4omfWNbuMFduMxk3NbkURd3dFuwTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086902; c=relaxed/simple;
	bh=gN4hivXJdZhMCDtFZTLE02AlhGI7gMy3Za7afn2x0ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2aFAVC28n2NQgvLtIKeDUv3HgTNhKMHcd0AyKI7nDxODllyIIeJ6YbCngIqNIgRa8WWAFzKXT5RtsPoGMy0QPWR5MvLztv3PhXo8lv/SaQIYKjq1N1fRtHBo6E8SccGLN+DPh68IgkAc2cYK2h0FnWNV1FgJiY68Bp4/gpAVHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3YOr5rp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3YOr5rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9B2C4CEF7;
	Wed,  1 Apr 2026 23:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775086902;
	bh=gN4hivXJdZhMCDtFZTLE02AlhGI7gMy3Za7afn2x0ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3YOr5rp9aVVK+XrE43E70EPT4m7Iu1o7iV3qHYHuAjfNWpblUT3QvzVnmi340aYF
	 dpbxq60t+X5FM4XLrxnUxBe2wdkSIj4xEnnVhnX1s88Kh3nqOQiEmuY7OCOGWFdOc2
	 gySaeOhN8J8JdMkYBbONeE+z+F4NlxuiGsspU2iYChCmsVtuHe9xChHL5OEYF2QmQx
	 BMFkFW98SpEWEZWDsFydShQm2Kc1tgLBcv084BIJcMoOEqaTEZrVRB9RyYbumMZ9hN
	 8Oastbs2IBaeebaCDo7XzrOTQt1iDJdCQsjU+CTUCD/KYjsTL5gE6XUjF+E31FbmDV
	 vM4I3wcomRCTw==
Date: Thu, 2 Apr 2026 01:41:37 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v12 0/7] i2c: xiic: use generic device property accessors
Message-ID: <ac2r9m9mSMZxgHwN@zenone.zhora.eu>
References: <20260223-i2c-xiic-v12-0-b6c9ce4e4f3c@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-i2c-xiic-v12-0-b6c9ce4e4f3c@nexthop.ai>

> Abdurrahman Hussain (7):
>       i2c: xiic: switch to devres managed APIs
>       i2c: xiic: remove duplicate error message
>       i2c: xiic: switch to generic device property accessors
>       i2c: xiic: cosmetic cleanup
>       i2c: xiic: cosmetic: use resource format specifier in debug log
>       i2c: xiic: use numbered adapter registration
>       i2c: xiic: skip input clock setup on non-OF systems

Good job Abdurrahman, thanks for following up in all the rounds
of reviews. I finally merged your patch in i2c/i2c-host.

Thanks,
Andi

