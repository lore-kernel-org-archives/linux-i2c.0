Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DCA473C86;
	Tue,  1 Sep 2026 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252623; cv=none; b=rPFLNd/a8PqYIdSn0s7I86kmMPRyrbAW1QPFMPlef3BMwgcA5FY+GFlZmunzK100X15ZSHrvCD8PfUOCO9KpUVZ4NETDNbs+CXIhnMa3pQTxNHAd24jT/dKvN8eq1QETNl7SIDJThInILnvkrv5Ee13bz2U8M6AisRCg9X6ltKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252623; c=relaxed/simple;
	bh=ZByHrQ0BE4WZ1gKED4uORNIxOHo/HIUa78/DaFlGkUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ/eon0SGg4bjNnvRRkMZgAQNRhgFJ+zIhplgVV6mjdIjm/Hf0KvTvYLYHe8d8PHQLQHAF/H81lxVHlOVpAolvJN17JZPiKJF/KQFA5LQiZCFKbB49qHj/qEjb2Edw+5phoGmQ9JpsgWNBwd4QdpjQemdUPnOxkeCvr/z65/xI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLbU7tdH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLbU7tdH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788252622; x=1819788622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZByHrQ0BE4WZ1gKED4uORNIxOHo/HIUa78/DaFlGkUs=;
  b=JLbU7tdHQwGHucztshl8zBeiRNljSBMIJr3UHePsA/0hHUsbELMwJTos
   EMJEKCENNpnofaWVoqIr8yn9vC0Njn+a4bV3d7L73ezq9SVGi4hoDlXwX
   XqORwrEwPVVE1xQeBOvvw9g3nZhpHhlv0DmbJ3u7SHsLe9Z51v34eurub
   mbAg9wCl6GbEmRbTzVm7XLH95KIDRSBS6jQ1Kfj38A9HqrUsDUQSvdglN
   za86pqpVWTE+133cdwkJ87QOMcYpdUgpP4JcK6WdQ6pqMcf3VVr9ZHdvd
   gICjd3UGR9Nu3n2dobyIvqEwYppMDH3BJlGUZ3xqT65rtiiJc5jv1G4Bl
   A==;
X-CSE-ConnectionGUID: RetCV/XZS3qum75244yKyQ==
X-CSE-MsgGUID: lozJ4WlaTMSyAOXHYpztYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99835536"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="99835536"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:50:22 -0700
X-CSE-ConnectionGUID: i6m9EgR4SgyjOyB664S7CA==
X-CSE-MsgGUID: m0HwN4WQT/GezhYpX6sLtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="269618972"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:50:19 -0700
Date: Tue, 1 Sep 2026 11:50:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@lysator.liu.se>,
	Andy Shevchenko <andy@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] i2c: mux: Factor out channel node lookup
Message-ID: <apaRyWDhpZ87sG4W@ashevche-desk.local>
References: <cover.1788181174.git.ahmadexp@gmail.com>
 <6ff921823286515e75b62493e748ed08f4816358.1788181174.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ff921823286515e75b62493e748ed08f4816358.1788181174.git.ahmadexp@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 10:22:06AM -0700, Ahmad Byagowi wrote:
> Move the existing Device Tree channel-node lookup into a helper in
> preparation for using generic firmware-node operations.
> 
> This is a pure refactoring with no functional change.

...

> +static struct device_node *
> +i2c_mux_get_channel_node(struct i2c_mux_core *muxc, u32 chan_id)
> +{
> +	struct device_node *dev_node = muxc->dev->of_node;

It's better for maintenance to split assignment (due to validation below).

	struct device_node *dev_node;

> +	struct device_node *mux_node, *child;
> +	u32 reg;
> +	int ret;

// also use getter
	dev_node = dev_of_node(dev);

> +	if (!dev_node)
> +		return NULL;

Looking at the code, it's NULL-aware as far as I can see and this check is just
a shortcut.

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


