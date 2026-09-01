Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2664C471404;
	Tue,  1 Sep 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252851; cv=none; b=FCBxq2DwmCSy3qbyo1k5vy8/6oR93q9DKhx+hvGNqSVaa8hEjv4OR4IfP4CnJh4GSLtMpNMwc17o+9WdD6xjOmhyyyIg9b1U6PbKpi+bcwthc6408B1G9xxuF8G3bGIgGw1a4Jq9Y8aNV72671+QfeIVd+Lts1BK5K+SnWP8N94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252851; c=relaxed/simple;
	bh=0G7uy8JLNAmprieqWJ95xv7RIvhVnHrsQ5A3d4H2dPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3xeVHph2kRMIryOYe9t0YcHxzUgGdiUWZ+/Otrlai1nx1Wj+A3rC2Hc4juPKSF8Es1+bdGtwjpTxZ80FbKz4y9ZIFeObH+wOmNM0qQWp55rt1/adBzKC6eQCqyyHUFFDiU4PMBbQAen1h/vJfOsmniKILtBxMR+AHVom30XoSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TN2z760V; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TN2z760V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788252850; x=1819788850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0G7uy8JLNAmprieqWJ95xv7RIvhVnHrsQ5A3d4H2dPk=;
  b=TN2z760VeStunKuLh8r0lceFnvbiBAAlgNG5JcSPkaOWrlxjJw3R5ep+
   AweEYTNHjszaSqC+9i8Ta2HjfoTv7egfpFhyfmIbznzjJPz0cI2mzP+H6
   awxb8k83cjtnB+eTkipxREXbRpmx7jNqfroE8vqYH7SLvICvKevgDOQPn
   D2zm5iJB9RUOu15oizihdZahZj2w5erA07CB0pRvmbInD/z8mR/fm5oxH
   UwiAM6nR1LJ5orORj0xSohH42PSM7TKAW1z3GBXMNLMWBf/KL/WXBmjZp
   O4lrvCtuEbdCqmmfbzAS1vriMtWJJgpDsKGQEX91dVpQsj4+CHp6CzJod
   A==;
X-CSE-ConnectionGUID: QbT7/hqlTEqVVOx7ZCeGzg==
X-CSE-MsgGUID: vgA2o2nHSc2BzcuscTWhPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92363727"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="92363727"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:54:09 -0700
X-CSE-ConnectionGUID: duhObOGwT3ulEDaosVIVbw==
X-CSE-MsgGUID: YKDMBUWLRqa/cFEZ/5OyTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="292544114"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:54:06 -0700
Date: Tue, 1 Sep 2026 11:54:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@lysator.liu.se>,
	Andy Shevchenko <andy@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] i2c: mux: Propagate firmware nodes to channel
 adapters
Message-ID: <apaSrJFAp5Fr6ZT1@ashevche-desk.local>
References: <cover.1788181174.git.ahmadexp@gmail.com>
 <7a4cf4b288afaaa085e1c4ec592fbb0fb43eefd4.1788181174.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4cf4b288afaaa085e1c4ec592fbb0fb43eefd4.1788181174.git.ahmadexp@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 10:22:07AM -0700, Ahmad Byagowi wrote:
> Device Tree channel nodes are associated with the adapters created by
> i2c-mux, but equivalent firmware-node descriptions are not.
> 
> Use generic firmware-node operations for the existing channel lookup
> and associate the returned node with the adapter. Do not restrict the
> lookup by firmware-node type, so Device Tree, software nodes, and ACPI
> descriptions all follow the same property traversal. The existing
> acpi_preset_companion() call remains in place for the standard ACPI
> channel association.
> 
> Keep a separate reference to the node returned by the generic lookup
> because acpi_preset_companion() may replace the device's primary
> firmware node. Release the saved reference after adapter deletion.

...

>  	if (muxc->arbitrator)
> -		mux_node = of_get_child_by_name(dev_node, "i2c-arb");
> +		mux_node = fwnode_get_named_child_node(dev_node, "i2c-arb");
>  	else if (muxc->gate)
> -		mux_node = of_get_child_by_name(dev_node, "i2c-gate");
> +		mux_node = fwnode_get_named_child_node(dev_node, "i2c-gate");
>  	else
> -		mux_node = of_get_child_by_name(dev_node, "i2c-mux");
> +		mux_node = fwnode_get_named_child_node(dev_node, "i2c-mux");
>  
>  	if (mux_node) {
> -		/* A "reg" property indicates an old-style DT entry */
> -		if (!of_property_read_u32(mux_node, "reg", &reg)) {
> -			of_node_put(mux_node);
> +		/* A "reg" property indicates an old-style firmware entry. */
> +		if (!fwnode_property_read_u32(mux_node, "reg", &reg)) {
> +			fwnode_handle_put(mux_node);

Consider using __free(fwnode_handle) at some point. Perhaps as a patch
on top of this.

It also may help with the rest of the existing code elsewhere in the file.

>  			mux_node = NULL;
>  		}
>  	}
>  
>  	if (!mux_node)
> -		mux_node = of_node_get(dev_node);
> +		mux_node = fwnode_handle_get(dev_node);
>  	else if (muxc->arbitrator || muxc->gate)
>  		return mux_node;
>  
> -	for_each_child_of_node(mux_node, child) {
> -		ret = of_property_read_u32(child, "reg", &reg);
> +	fwnode_for_each_child_node(mux_node, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
>  		if (ret)
>  			continue;
>  		if (chan_id == reg)
>  			break;
>  	}
>  
> -	of_node_put(mux_node);
> +	fwnode_handle_put(mux_node);
>  	return child;
>  }


-- 
With Best Regards,
Andy Shevchenko


