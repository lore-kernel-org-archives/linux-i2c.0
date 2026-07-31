Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783C489880;
	Fri, 31 Jul 2026 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785531270; cv=none; b=dGRvdSCa4tlxTrsdgL8Amz+gPZuD7LbB30CXxTB/wBhsrLkT0wy4ScirU6k4nIwxzZgUARSW92iLx8wW5+ZqDJpasSDKetbONv4P0B+csJvPhADdDKBuWc+ErgKBwdIIzHCWsLTWtJTR0GYpma4yqW4EyPE/Rih8Z25BKM9l/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785531270; c=relaxed/simple;
	bh=dkwgGWyNl/APWDE8rp4J6XsL36P+rEr1t+WQqrhNXOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP3xkrIe/zalxVo+YzFLAFFSN9mlM5Pa5Ugfm7Fr8hEaRPQHdHCTmqy4lHe0Ba9moZXnxaBJ65iGq2p2RpaO8wcrvc6pNmJzt2mIDLgUGSI+bFzKYKxLJ3jSPvgEqk9OynOgg8FTgD1fKJliuS01u9dGcQsBvHkUYpYKstk/DaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omZO3bch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omZO3bch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5DD1F00AC4;
	Fri, 31 Jul 2026 20:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785531269;
	bh=Gp7UsgtGNRys8U9vweTj5w4B6PupIewvt5O5Y0yDopI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=omZO3bchXrShL7pYPQ37YY3hBZnPPy5LZWAh9KVjaqk5g5HBrOWHCAiR02xsZ9hfQ
	 dChHpB7iA4etq1LkXD0QIKs4A80wWcXVlm3cjO0Y6VcrANdp1JmAo10sOrSwbtFFnM
	 JtrKjwwiEuyRa8Qr/1ECUnHaVTmIcPgziY9939uq9Mn6FdDacsdUG8trpsKFRTYGuY
	 ygT1zzFc/3O+nhj5+tLPNrFVE3LyMxwtZ/jNQ3PpmDjNa/86021fyQHsye9Ud/I1WH
	 9stVRDudvs+ZnSd1M4zUdh+IcheVm5HqdV1n7aVRCPwGUX4NuXQ1XjXZk7NBtdW25X
	 zKswjDKvgMyuQ==
Date: Fri, 31 Jul 2026 22:54:25 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org, konradybcio@kernel.org, 
	stephan.gerhold@linaro.org, Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/5] i2c: qcom-cci: Enforce the required CCI clock rate
Message-ID: <am0LW4Jk_NngWBf8@zenone.zhora.eu>
References: <20260729-cci-clk-fix-v3-0-f3c731d1596e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-cci-clk-fix-v3-0-f3c731d1596e@oss.qualcomm.com>

> Loic Poulain (5):
>       i2c: qcom-cci: Switch msm8953 to the CCI v2 timing/rate config
>       i2c: qcom-cci: Support per-mode CCI clock rates
>       i2c: qcom-cci: Add 19.2 MHz timings for the v2 CCI
>       i2c: qcom-cci: Share the timing table across CCI revisions
>       i2c: qcom-cci: Enforce the required CCI clock rate

Can you please rebase the series on top of next/master or
i2c/i2c-next? Patch 2 doesn't apply.

Andi
