Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69C3093C1;
	Fri, 28 Aug 2026 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787877600; cv=none; b=Jx4IS2ST9sWBj1wMxbyfpA5IhLl7zwIdTIrXIxSXf+671tUM71Q5OE8hbgHNn5C2wF4xen9uFmc3x8Dhkb40qyxMKQS87Wn2My4hmWM1P/HiIFspR5yyG8OfvyUrkEpo+nSkzdY9QrZfliEpV5bTfV6WANVKVadZ20DXR2Sj0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787877600; c=relaxed/simple;
	bh=nWFmdGZ65n2ybUMz8FedGgI3ySa5BY2cAoY56svAR9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHy0SPuF+lNE7UGHwMeZSTclHun69x6zn1WxntATZnnyl54C7g5LH2gVrz1GPwYBcsky7QcvOE/uPqN4EX17no6TTG5u6rIDHkQyhQW4NEpcNRo2d6oHtpei9pFo48HCCzjnGqG6bCOdo/aRQ/ykcFkUqaZDN2TQxA4l54/dDfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo1R+p0D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo1R+p0D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DE21F000E9;
	Fri, 28 Aug 2026 00:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787877598;
	bh=hHEnBvta1ugRWQeWOsh+UzKSn1Hh9LLxMiC0EM+khwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jo1R+p0D1lMlHbSejFDUSQQ+wZvhQL/m4sdfr+8UUEVZdskcFMngKJkVlHkikoZ+i
	 hjzWINq5Ssp5DVPxPR3LBZq+Zi1Dpy9UtQnGAi2FmZtFkOpbA7smMo3X9sGlrNEuUt
	 F8qu79zrcC3Wtw/vnTIYFzUBwsCbOCISzxCyUe/VIH7oHfsM6fylPFhqsxnG3Mzs1X
	 gp/mgU7PMkw0mdHZOGhty4/C9LJeW+NI0Pbs8JBzQhzvxu008Ilbx4X5GlcakaZIsG
	 6wJr5ICd6hx1Kw9MnfSDRGyd12WFx4fOgFK1HAx+tu9HNK0qrAZ7ONPaChp6CG0zC6
	 KhgMeTu9eRAug==
Date: Fri, 28 Aug 2026 02:39:56 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hongbo Yao <andy.xu@hj-micro.com>
Cc: mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, peter.du@hj-micro.com, 
	gwilym.wu@hj-micro.com, clarke.li@hj-micro.com
Subject: Re: [PATCH] i2c: designware: Enable interrupt mask workaround for
 HJMC3001
Message-ID: <apDYuknPDkSe9wqy@zenone.zhora.eu>
References: <20260826070547.268672-1-andy.xu@hj-micro.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826070547.268672-1-andy.xu@hj-micro.com>

Hi Hongbo,

On Wed, Aug 26, 2026 at 03:05:47PM +0800, Hongbo Yao wrote:
> On HJMicro ARM64 servers, the DesignWare I2C controller does not
> retrigger a pending interrupt if the interrupt status changes after
> the current status bits have been cleared.
> 
> The issue is exposed under heavy system load when the corresponding
> SPI is routed across sockets to a core in the remote socket. The
> interrupt is then lost and the I2C transfer times out.
> 
> Enable ACCESS_INTR_MASK for HJMC3001. This toggles DW_IC_INTR_MASK
> before returning from the interrupt handler and retriggers any
> pending interrupt.
> 
> Fixes: 6816ce57c479 ("i2c: designware: Add a new ACPI HID for HJMC01 I2C controller")
> Signed-off-by: Hongbo Yao <andy.xu@hj-micro.com>

merged to i2c/i2c-fixes.

Thanks,
Andi
