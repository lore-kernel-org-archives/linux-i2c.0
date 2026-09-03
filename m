Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A18024B28;
	Thu,  3 Sep 2026 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465551; cv=none; b=QBsCNj2QYI47GVSJ/qmCDwOwlby4YOecdK9PmphBHAy2Sfne4u8yxez/bDYgE48tslalFoQO97Kb2m6hrLvo7bSFxzXQ4hTSkvne3D+XqOaAufAyz2mS9vxFaDmZTOWLuxAgzsg3DQeRH0yY3AEb+B8dPesQdSI/atd4aPM/rBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465551; c=relaxed/simple;
	bh=DToMjSHyJPUFqC5msoIa0W7ERl+FSviYe+ZGlXduWtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVtFJXmT+4MVVYac22ChifNW+AMTX2N5SH9VZdpLtbUgbBn9+bmGG4XiieYoBtJ5ru49O+4mk2rBr5Eo/oqFlRn00puJyDIAIypUuZyFUDBNktkBIfJ8MOvAaq5a15+gvWCz8q2aU5dNPak5FPa9GjeH1mXq7768vg2sDAeLozg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNAWUsGK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNAWUsGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788465544; x=1820001544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DToMjSHyJPUFqC5msoIa0W7ERl+FSviYe+ZGlXduWtY=;
  b=CNAWUsGKem26/U0hXf4fm5RslwCUi0yKtp5WbVoEjlfkSgCoc9/DBFTi
   x9Z5H+Oc4sTVwLleP3GNTHezXr/5T7hUIthjrapElPHYk8OdmDjroHmj3
   1m8KGNZ3gQyqXxFyrVp/xdz45+PzV/OMGUuAHMSXxDw/dxsySDkg6tEvo
   HpMavKWRuFp3d6QWYUahuNwEsFvZgADH07EYdxw9QrzI2Vhd5JVDyKtUw
   zLjDwT7NQgYcmkLs5cTd2ZKNFvNGbmyRaz8qEIFUftwGq8+YXTfMy4LYH
   paVQZFnbtmHlQflsshp157HtpB96zr85niFxrxL2VuY5ZTpv06Jy69dht
   w==;
X-CSE-ConnectionGUID: QqQjAu5PQ8+48TXyGF1zUA==
X-CSE-MsgGUID: GohLy7AhR1aCGHz69dDiiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88806605"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88806605"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 12:58:58 -0700
X-CSE-ConnectionGUID: mw6QYQSRQ6Wb5ONUnRPQDA==
X-CSE-MsgGUID: NhoBHqgjQAOpYN4Y62o12A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="269292182"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 12:58:56 -0700
Date: Thu, 3 Sep 2026 22:58:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@lysator.liu.se>,
	Andy Shevchenko <andy@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] i2c: mux: Factor out channel node lookup
Message-ID: <apnRfWVAiXj1fRXs@ashevche-desk.local>
References: <cover.1788298883.git.ahmadexp@gmail.com>
 <89780f7db207c7fe7adbd45e1f38f0a041794c8f.1788298883.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89780f7db207c7fe7adbd45e1f38f0a041794c8f.1788298883.git.ahmadexp@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 12:40:55PM -0700, Ahmad Byagowi wrote:
> Move the existing Device Tree channel-node lookup into a helper in
> preparation for using generic firmware-node operations.
> 
> This is a pure refactoring with no functional change.

...

> +static struct device_node *
> +i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
> +{
> +	struct device_node *dev_node;
> +	struct device_node *mux_node, *child;

Now all three can be defined in a single line.

> +	u32 reg;
> +	int ret;
> +
> +	dev_node = dev_of_node(muxc->dev);
> +	if (!dev_node)
> +		return NULL;
> +
> +	if (muxc->arbitrator)
> +		mux_node = of_get_child_by_name(dev_node, "i2c-arb");
> +	else if (muxc->gate)
> +		mux_node = of_get_child_by_name(dev_node, "i2c-gate");
> +	else
> +		mux_node = of_get_child_by_name(dev_node, "i2c-mux");
> +
> +	if (mux_node) {
> +		/* A "reg" property indicates an old-style DT entry */
> +		if (!of_property_read_u32(mux_node, "reg", &reg)) {
> +			of_node_put(mux_node);
> +			mux_node = NULL;
> +		}
> +	}
> +
> +	if (!mux_node)
> +		mux_node = of_node_get(dev_node);
> +	else if (muxc->arbitrator || muxc->gate)
> +		return mux_node;
> +
> +	for_each_child_of_node(mux_node, child) {
> +		ret = of_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			continue;
> +		if (chan_id == reg)
> +			break;
> +	}
> +
> +	of_node_put(mux_node);
> +	return child;
> +}

-- 
With Best Regards,
Andy Shevchenko


