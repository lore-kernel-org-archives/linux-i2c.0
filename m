Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B82E8B6B;
	Tue, 17 Feb 2026 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319233; cv=none; b=dN5u81x8x1wPaPDG78ql3/xtF+xegZfeajNdop71k3kqVvPXIOGnX06hKdui+3RKYWt3m8AusGTN6oUVixuNpm3wARdNXMZRKoiDaS3kBJYNXASEfBOgPE4FZ8zWYio/7oVmXDP7aIAqfyFQLwzf4jaP6XJv4pAVf6N5URr6qVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319233; c=relaxed/simple;
	bh=Ln0VhtZ3sIvknHl0ZEC4xZsk+Rl4aVV2gCMAIOiv+ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+FycHzOkwijB+BP7R6JC1o8fFnCuymvjAZSMNco1Txj5e2L/dPbxFgd0qEgB9w80lfJP+pfaxcGXAJVMf3r2tNUnoD5i6I4xDdg04doAgdNdxuIVYdC0MKpq7wdrz6IRL2xjet/kv5/EKXon6aVKdBRQXk3/27fwUIMImHqRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1wNnhuJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1wNnhuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771319232; x=1802855232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ln0VhtZ3sIvknHl0ZEC4xZsk+Rl4aVV2gCMAIOiv+ZE=;
  b=F1wNnhuJSimYH3Pl1S9sM2akXEmIw7+z+i2RxxY2u/jIMFNbADMvWX39
   cvnI9cs1DffrtGFRQquSOTIeAvkWBTtPX8EB5nYdWzoa6iTwjWPpIEJEe
   rkZnXLqgdA8LZFY5eSwHcWON4CF3C08Y9T2Os6TxbWqhlqTtzHtCIvU1W
   jTs8rrXbc4JqUP/9OBp3q89AGec2+OQZr9A0OB0cM18jSv16HuOvYFDjI
   UEsWe98N6wqqpbskrjx13wJH1B9XckPeXxjCi2dCnWoFultIhnyq2G8Hw
   aIdtj3QSRbXclg1RJt/Q344BTXbT5niVuZ2yagBk1a0/zr7g+oC/N0WiS
   g==;
X-CSE-ConnectionGUID: SoEvvguHQNO91gE+Bb5dZw==
X-CSE-MsgGUID: ipHLf2HHQMS5+11gPwtJfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="95013923"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="95013923"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 01:07:11 -0800
X-CSE-ConnectionGUID: k6EUy4e1RKaXQQs9+1QYzA==
X-CSE-MsgGUID: EvXkSzkDRG2ikYJlg5DILw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="213657526"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO localhost) ([10.124.220.245])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 01:07:09 -0800
Date: Tue, 17 Feb 2026 11:07:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/5] i2c: davinci: calculate bus freq from Hz instead
 of kHz
Message-ID: <aZQvuh1KEAWFSdRU@smile.fi.intel.com>
References: <20260216-i2c-mux-v6-0-9be28ecfd7e3@gmail.com>
 <20260216-i2c-mux-v6-3-9be28ecfd7e3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216-i2c-mux-v6-3-9be28ecfd7e3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 16, 2026 at 01:38:15PM +0100, Marcus Folkesson wrote:
> The bus frequency is unnecessarily converted between Hz and kHz in
> several places.
> This is probably an old legacy from the old times (pre-devicetrees)
> when the davinci_i2c_platform_data took the bus_freq in kHz.
> 
> Stick to Hz.

...

>  	/*
>  	 * According to I2C-BUS Spec 2.1, in FAST-MODE LOW period should be at
>  	 * least 1.3uS, which is not the case with 50% duty cycle. Driving HIGH
>  	 * to LOW ratio as 1 to 2 is more safe.
>  	 */
> -	if (dev->bus_freq > 100)
> +	if (dev->bus_freq_hz > 100000)

The 100000 has a definition in i2c.h....

>  		clkl = (clk << 1) / 3;
>  	else
>  		clkl = (clk >> 1);

...

>  	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);

(Why not using i2c timings? The I²C core has an API to parse firmware properties.)

>  	if (r)
> -		prop = DAVINCI_I2C_DEFAULT_BUS_FREQ;
> +		prop = I2C_MAX_STANDARD_MODE_FREQ;

...like this one.

-- 
With Best Regards,
Andy Shevchenko


