Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452B8F5B;
	Thu, 22 Jan 2026 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080252; cv=none; b=DODtO2uoa5eoETW3vZotZOZUuFF2Mk9CNXfmoegbw8kUTHpnE2mHOIgUa2M9D70RJEN66h8okaEVKKVAYCOTqGJNcM8M57hiX03rBL9GOaReeljrYzw86ARE4VVrl6v4WVKFWd4NaAmtzA54BwXCWm9/9BNDEfHBTJcpCVYfKMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080252; c=relaxed/simple;
	bh=pwRnhBLDDEYGv7Gna1sNHvTMPTjU37Gx4SvZPDuiuMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OThvUW/+FulSQOYycuE3ULe2FIFDQwmmVgbXw5zeY1Q6YTaaOQlwbDvDmDjpSrN7rKgSIOs94OPD90LKrL0XJuWnMIGEiGNyzbFEBJ1O9fWAqSs3dMq+HdWHFrR59lRdYREe8CF0X/y7oMMDJGJI1Osqb5vQZ5Md/PJXhuQw9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6d8vjg+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6d8vjg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CACC116C6;
	Thu, 22 Jan 2026 11:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769080251;
	bh=pwRnhBLDDEYGv7Gna1sNHvTMPTjU37Gx4SvZPDuiuMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6d8vjg+ROODJ+7/QWM1h/jH1bCwD19wk/OFKERc7JG2758wMZqJGE/6mqr+JzqqO
	 BlKznuus7tXhCqhMCIKxAzmXXPJo6tMUD0fmVXimN198HxuIBrSebYoZ3FJTNBzaHI
	 nGECUpyeGKawb8D7TodHbtptTlKc59tctUWG3a+6cAhon1F8V0lgjHShPV3JxyXGcu
	 oNyNUS+XkQ9KgH/cKMm4mnPRSjkLICn65IoSbBJAlJVA/SlHd+LJmoc2stZU/TV9E8
	 9qQxKHj9Ynpd0OEAua0ofW9lWzJOufc/by+i+3zACrpJ48ttotoMNrxxti1IamJBXw
	 FCU2Un4o1IsTw==
Date: Thu, 22 Jan 2026 12:10:48 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Jan Dabros <jsd@semihalf.com>
Subject: Re: [PATCH v1 2/2] i2c: designware: Use device_is_compatible()
 instead of custom approach
Message-ID: <aXIDQtLlzYvbJSGV@zenone.zhora.eu>
References: <20260114081954.252160-1-andriy.shevchenko@linux.intel.com>
 <20260114081954.252160-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114081954.252160-3-andriy.shevchenko@linux.intel.com>

Hi,

On Wed, Jan 14, 2026 at 09:17:51AM +0100, Andy Shevchenko wrote:
> We use MODEL_MSCC_OCELOT effectively is a flag for comparing against
> "compatible" property. Use device_is_compatible() directly to make it
> clear.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'm coming into the discussion and I personally like Andy's
approach. As a third party, I believe this patch has reached the
consensus and I'm taking it in i2c/i2c-host.

Thanks Andy,
Andi
