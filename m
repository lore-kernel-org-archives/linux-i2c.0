Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D863C140F;
	Tue,  2 Jun 2026 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439075; cv=none; b=Qxy9+vBKlVZ5M74A1h4c8OzWFAa2boXQ7hjM4sA9RhEU/XrOBhjYhnLtt9kIAqZSINhsWDQdPRhmXKmLZ58MPM+AOlqo62ajZUbGqduApg7nU/e0GzeY4OhYmNbY6j5HZ/0ExA5GPYN7fSdydlPgkVlwGfipWjDEPt1CRE+zNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439075; c=relaxed/simple;
	bh=KNDz2mhCbZT5vNgM+xbtXQDL8+M7b+YNoz8au9zgKqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+RNJ/i96kzUqBpYp8/FFxKaL2PjlfHUMQxxApWDHOUP+N+bbj9MWoc1SGcIJ4jcIQJtRPN5aTFxH0qYDhpW4AkC74XlAvUfCDi1pZ90qI8nCbKOOyCRXqaHuu4KvFk3ZNqrFJW7tacuIRN/mxsZEnW0pWcNTvPE9c2DPdhQjes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAa5sc9k; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAa5sc9k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780439074; x=1811975074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KNDz2mhCbZT5vNgM+xbtXQDL8+M7b+YNoz8au9zgKqw=;
  b=IAa5sc9kpejX3/Ey6vz0+zsR7FtjYehzhNI/P42pEd1JwFWfWeAp50HN
   DV0UZwKkVLU8P0+A3hOIE5JS3W8/A4k7K14tEhTjtZHdBE9+kLsdTE3oL
   p0XGTwVPBTFpfP9tI+QH7T6B+fjHSB1HGVcsixVt4yrkOokLDCcVW1H9R
   q+xzd98mdGDiL7dP77K71ehUv9thGxkAfpk59j9GQyDPpfhb296TOsigT
   bx/Do7ffEfL3fQRIBq9v/I8rGAlTvMGz2LvuhGvRxO3YjNT/UvJ7GvcuR
   SPm3o3CwZB3wZBpR1VXyCnLsKJl57sMRp11vtWEfQPCyxwdj9QQPDPcnM
   Q==;
X-CSE-ConnectionGUID: 4t2WKIpkQBOF+Ye9ce3J4A==
X-CSE-MsgGUID: XuFTQtAfRhaCcQf7H1UDrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91549499"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="91549499"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:24:33 -0700
X-CSE-ConnectionGUID: MPWe3R1HRpK5Qt3QoLWOSA==
X-CSE-MsgGUID: +KxPXeVORWm5WiWr4UWq3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="267905428"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:24:31 -0700
Date: Wed, 3 Jun 2026 01:24:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "lianfeng.ouyang" <lianfeng.ouyang@starfivetech.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] i2c: designware: Export symbols and add __weak
 for Starfive I2C driver
Message-ID: <ah9YHcs8UyRhXZSx@ashevche-desk.local>
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
 <20260527085039.44435-3-lianfeng.ouyang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527085039.44435-3-lianfeng.ouyang@starfivetech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 27, 2026 at 04:50:38PM +0800, lianfeng.ouyang wrote:

> Export several key functions (i2c_dw_probe_master, i2c_dw_init,
> i2c_dw_xfer_init, i2c_dw_read_clear_intrbits, etc.) and mark them as
> __weak. This allows the i2c starfive driver to reuse the common
> infrastructure while overriding the implementations where needed.
> 
> Additionally, extend the register map configuration and introduce the
> MODEL_STARFIVE flag to accommodate the starfive i2c  IP's different
> register space.

...

> +#endif

My gosh, no.


>  		.val_bits = 32,
>  		.reg_stride = 4,
>  		.disable_locking = true,
> +#if IS_ENABLED(CONFIG_I2C_STARFIVE)
> +		.reg_read = sf_reg_read,
> +		.reg_write = sf_reg_write,
> +		.max_register = SF_IC_SMBUS_INTR_CLR,
> +#else

No.

Just find a different way. See how Baikal T1 support was implemented
(in v6.18, for example).

>  		.reg_read = dw_reg_read,
>  		.reg_write = dw_reg_write,
>  		.max_register = DW_IC_COMP_TYPE,
> +#endif

...

> +#ifdef CONFIG_OF

Definitely no.

> +	ret = of_property_read_u32(dev->dev->of_node, "starfive,i2c-tx-fifo-depth", &tx_fifo_cfg);

No. Why?!

Also do not use OF-centric APIs in the driver that uses fwnode.

> +	if (!ret && (tx_fifo_cfg < 2 || tx_fifo_cfg > 256))
> +		tx_fifo_cfg = 8;
> +
> +	ret = of_property_read_u32(dev->dev->of_node, "starfive,i2c-rx-fifo-depth", &rx_fifo_cfg);
> +	if (!ret && (rx_fifo_cfg < 2 || rx_fifo_cfg > 256))
> +		rx_fifo_cfg = 8;
> +#endif
> +	param = rx_fifo_cfg << 8 | tx_fifo_cfg << 16;
> +#else
>  	ret = regmap_read(dev->map, DW_IC_COMP_PARAM_1, &param);
>  	i2c_dw_release_lock(dev);
>  	if (ret)
>  		return ret;
> +#endif

-- 
With Best Regards,
Andy Shevchenko


