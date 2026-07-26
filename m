Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD7E37D10E;
	Sun, 26 Jul 2026 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785078518; cv=none; b=ddmZLuXm5xixq2ORZXXz8BZKP8U7lRTukEjIZM/G1WcrS6zO5uHvsV8BDCGxJd1iZRDzDCvWDE5R7Kg9v6au/XN5yLXD4LscBFoRsV3V0wPQW97RNQvlSe9kbMs2hXRizRBnl1Bd8q3PDXnBoRzJtQO7mbs82K13saWLTC3bnpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785078518; c=relaxed/simple;
	bh=jWTf6zp76Onyvup4be8YktyMr2K+oZxpnt7jHhb/RKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAWVTZ9+L/ZIyxbEEjt4E65vqeoO4FTcyBFZIxxNFMvBrcdO3q92aQXQDUOAP0FM2w4x+UT51ZzSknvOAX/yIDVQLsx5pwNcwUYG9EOVK0CJfA9Ge/iN8xi8P4As00nFeioctIx5YmLEtljy1fP2f6uJwrdE+mLZtaUFOclSaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww4Ct2QB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww4Ct2QB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4734D1F000E9;
	Sun, 26 Jul 2026 15:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785078517;
	bh=ciH6yAMA2aKn7oOOIrPyidEOBIpTmgO0qyHn8gQTyvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ww4Ct2QBwq2UUh474XFFFOQOW6vJpLMjeWP2MOMHHzFZI6OoD1uy6cSVK7iCafl15
	 HtLyiIu1LgHLu65vbHVoTomN9GDWoQL117UZYmMxRwg+6yMRTZVU4SQ9wLwx9puXWe
	 Vrvbofn4AZl2Q4XoaIAgP9V545IpfHbNAMFOBQ428zRaVX/1VkpMEyA1G5y/XxNh9v
	 ajFUyfP5+kBkfKneZIF903MFUDPJRr/Xra8Wt3RnYUoKKdWSvFVS5UI1XJfsxmWRbe
	 C1KU2sXE6+ZrxzvL59ETP+iONGWmjNWc6fX4/pfODUu2zTA2jM8lMrG5NFd7yNZTqK
	 2WEAdjyNrJn2A==
Date: Sun, 26 Jul 2026 17:08:33 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Robert Foss <rfoss@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "i2c: qcom-cci: Remove unused struct member
 cci_clk_rate"
Message-ID: <amYiutsYT5ol_nof@zenone.zhora.eu>
References: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
 <20260721-cci-clk-fix-v1-1-5eae78700da8@oss.qualcomm.com>
 <amPtXU_RkseFbpKm@zenone.zhora.eu>
 <fae7e3f6-2d9e-4972-a091-749295f2cc3c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fae7e3f6-2d9e-4972-a091-749295f2cc3c@linaro.org>

Hi Vladimir,

> > > The cci_clk_rate field is needed to enforce the correct CCI clock rate
> > > at probe time. The hw_params timing values are in clock ticks and were
> > > calibrated for a specific frequency per hardware variant, so running at
> > > the wrong rate would violate I2C timing specifications.
> > > 
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > 
> > Does this revert need a Fixes tag? I haven't seen very often
> > reverts with Fixes tag, but it makes sense if they need to be
> > backported.

There is a Requires tag (or similar, I don't remember).

> > I'm going to take patch 1 and 2 already while we discuss patch 3
> > separately, but please let me know first if you agree adding the
> > Fixes tag.
> > 
> 
> please put all commits from this series on hold due to my last finding:
> 
> https://lore.kernel.org/linux-arm-msm/8d20f3ab-696e-40a4-a05a-688779299071@linaro.org

Thanks Vladimir!

Andi
