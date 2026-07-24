Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D732247143A;
	Fri, 24 Jul 2026 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784933866; cv=none; b=ePVmaf+mEzW+DZwZTboOsSfWSaW8yZpow882lwWtC9/qZXihU97t4oAkV4RFbA+EmDk3tKhLXMY8zMpgcGp3jhEbx49k//LQr3hk7tsJnWfe9dKidlZ/vgCDRhE9OZVaZYu0fqUV5tmkqixW3uLFtJgFs1EaiQSmuMs3kgwWB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784933866; c=relaxed/simple;
	bh=dy9+mOE32it+O6s0brc1mOA7fatAhcMAflLAFQfwiZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=advClUxUxRduiTvm1bC27fEkOKB4++khupsb9f7tzi3/Dn5jmF10XHTGfCSyqCG31IF5qo7adXVP6yezJD4xBYOPjttnBeNNfdRA5ISW3IHIgXggzc9H+70vNiHav1CQg6M212LUd3Ru5JMvubEegzxGphGo7NZitumk151oa3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3nZdciK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3nZdciK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E051F000E9;
	Fri, 24 Jul 2026 22:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784933858;
	bh=Bj7QhFKypGxfrbjV6jmnq7gmPzaYZyfJ6mCI4JGDOZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3nZdciKtXQnqBb1WftBRgggjHamTx0e4wo4lESMU43WLsympXoo/xFBRM0khGA7H
	 Lv0rK5l2/wAEwGDLEwzqLEpUH2iQkXUpUafgcxzOgk9yJl2kCUfOVQOIetKqW4tzFw
	 8CcdU/eJ4eodTyStPx6tuhS9He42cABIwobgC3u0BNA/j4iZvSVKCxscYzthkiqtlO
	 g4J44iX+JX0aQGIV2MUAfGB+L2DOjqzL69kCJydWSQs2iWN5AIBTB9IkraOkvrlW3C
	 tA1B7IidV88uAS+neXAI10gmhL2TGuclmHzY/jX4nvE2nY0fHS+ZAjpXTaV5POL2fj
	 p184ryztg84dg==
Date: Sat, 25 Jul 2026 00:57:34 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "i2c: qcom-cci: Remove unused struct member
 cci_clk_rate"
Message-ID: <amPtXU_RkseFbpKm@zenone.zhora.eu>
References: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
 <20260721-cci-clk-fix-v1-1-5eae78700da8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721-cci-clk-fix-v1-1-5eae78700da8@oss.qualcomm.com>

Hi Loic,

On Tue, Jul 21, 2026 at 04:58:19PM +0200, Loic Poulain wrote:
> This reverts commit b641af684fc28a07bee9c808eb6c433f9d9bcec6.
> 
> The cci_clk_rate field is needed to enforce the correct CCI clock rate
> at probe time. The hw_params timing values are in clock ticks and were
> calibrated for a specific frequency per hardware variant, so running at
> the wrong rate would violate I2C timing specifications.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Does this revert need a Fixes tag? I haven't seen very often
reverts with Fixes tag, but it makes sense if they need to be
backported.

I'm going to take patch 1 and 2 already while we discuss patch 3
separately, but please let me know first if you agree adding the
Fixes tag.

Andi
