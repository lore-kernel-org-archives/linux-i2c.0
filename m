Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C013E0C40;
	Tue,  5 May 2026 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966204; cv=none; b=us57cbTZZP5MvL52eA1NQaiTwp41Qa7U44GY4+xIGRT+Q7cADjZC4u0qXqYuFiL/R0lz1JjunmCqfn6N7w0vZyKuPeErSRsXzdUbUEiH3vOfLqqAHBumMDSoTRnw8fuen3adckakvNdc4K8oso1SSNdKHlEiNhUvE9ge7FLCtFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966204; c=relaxed/simple;
	bh=j1do+cG5ijaASZ4mv7JBa8AIx1exmnG6lOCG43n88SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSiIxpeb0KUeIiKf77bAQlzRVG1GVbA83WUBuyeTBnzQrfsgI5i3NO/VTIryE4Mb3IKaul/JBNX7mxzPzNGq7rpdZDkxNLUbesllxhtu6PX0HyaYSdyhNHEOUXq7/UBxiRwSXano/Z/hcgimuCDGfUfy8Njb7QC3cBrvFSx2mgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ccbInH87; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ccbInH87"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777966202; x=1809502202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j1do+cG5ijaASZ4mv7JBa8AIx1exmnG6lOCG43n88SM=;
  b=ccbInH87kIZO6KfsiTDWVMZ1uxRW2GRchbr/rA9H40GAdndiz27Hsv4P
   7HQ0W25gBk5vrzXugzn8ApkOygpFuwDbwOmgp6qApJfS9BXkQvBMvNUvS
   eofr/ETdB3uEr+J/sM5TDW/7YBnm8hdBn2+YijMPCafSzaLk8+RWemwv3
   F/vCFqwLJWChAd069CF/AkZVYuQKZSI+Er/ldYBytOIIJglbOSOw6sP7b
   Ou805yg2PuFnT19N3Yzek3Rv1g5LrebXpFW1DEx6BJMRI6USPwJ8DqRRH
   eR/I50f9yDq9JoCL3hDJTIxmoSJy6UOzjgDUjXGcXOX5GymeFHjv3Pkgz
   g==;
X-CSE-ConnectionGUID: ZSzEqy9zQbO/RAwQKi+cQg==
X-CSE-MsgGUID: 9Cbvd1mLSs2WGYNaa07O5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89419216"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="89419216"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:30:01 -0700
X-CSE-ConnectionGUID: m547XodqShyJ69ex9FbfmA==
X-CSE-MsgGUID: TabeMojlTleXEelDxqFyvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="232603469"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:29:59 -0700
Date: Tue, 5 May 2026 10:29:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] i2c: designware: Introduce shutdown exported
 function
Message-ID: <afmcdXJt9X0Y3mw3@ashevche-desk.local>
References: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
 <20260504-dw-i2c-v3-1-57e56135d602@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-dw-i2c-v3-1-57e56135d602@wkennington.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 08:15:02PM +0000, William A. Kennington III wrote:
> Introduce an exported shutdown function to safely shutdown the
> DesignWare I2C controller.
> 
> This shutdown hook gracefully sets the slave disable bit before disabling
> the controller. This guarantees that any incoming requests from the master
> are immediately NACKed during shutdown, preventing the bus from hanging.

...

> +void i2c_dw_shutdown(struct dw_i2c_dev *dev)
> +{
> +	unsigned int con;
> +
> +	/*
> +	 * We only need to handle shutdown for slave mode to ensure
> +	 * we NACK any incoming master requests. Master mode cleanup
> +	 * is handled after each transfer in i2c_dw_xfer.

i2c_dw_xfer()

> +	 */

Since it's a newly added comment, can you switch to use inclusive language?
Same for the whole series related to the commit messages, comments, and
documentation.

> +	if (dev->mode != DW_IC_SLAVE)
> +		return;
> +
> +	/*
> +	 * To quickly NACK the master during shutdown, we set the slave
> +	 * disable bit while the controller is still enabled.
> +	 */
> +	regmap_read(dev->map, DW_IC_CON, &con);
> +	con |= DW_IC_CON_SLAVE_DISABLE;
> +	regmap_write(dev->map, DW_IC_CON, con);
> +
> +	i2c_dw_disable(dev);
> +}

> +EXPORT_SYMBOL_GPL(i2c_dw_shutdown);

Can we use namespace?

...

>  void __i2c_dw_disable(struct dw_i2c_dev *dev);
>  void i2c_dw_disable(struct dw_i2c_dev *dev);

> +void i2c_dw_shutdown(struct dw_i2c_dev *dev);

Isn't more tighten to the probe/remove than this?

>  extern void i2c_dw_configure_master(struct dw_i2c_dev *dev);
>  extern int i2c_dw_probe_master(struct dw_i2c_dev *dev);

-- 
With Best Regards,
Andy Shevchenko


