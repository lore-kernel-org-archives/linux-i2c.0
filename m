Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E9751A730;
	Tue,  8 Sep 2026 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864188; cv=none; b=kGkgcnEYrCnhieEYp3S3N6KzlxtgYnW+zSg9ZY+avivW3rj9G/8ha+/Dcb0cFElrmmaJQFhBqFnoCQ8aEOP9p99tOQ9YKbpQZSu8gTdAlgjZLt+Yv5ZYgFQnlQRdr/aFsEyEebhR5FxR23x9afLlmVw3m2SUmlVbg+uCzfCeY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864188; c=relaxed/simple;
	bh=HOgx9eSSs2TeN48lnr11+UWgiU20ofZ5Qj+vNLEuzN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpTh7t7Ua+sSicNJG51HCfddIfuFJamdKwmrft1Ao5gKrnxAuvop2wkpOY7D9UtfmmrtnfeN1yrnVspcsWPq5OCv41+SC19HywEvIvPjHZv5mvjINDGTuGR/8TRxJz670Hy18b/0gB9QfD8t7AkjHhGXgMgMPKOf+SswLQQ8AYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0VPDJXx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0VPDJXx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788864186; x=1820400186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HOgx9eSSs2TeN48lnr11+UWgiU20ofZ5Qj+vNLEuzN0=;
  b=J0VPDJXxgnyapyLvqfZgrehfCyR6voi3zuuywFriY3BqjpNmg31bDPqJ
   kBCnSDupFDTbaI7PfcpB+ZQIsRk/r5cwT+qUvbZvAgB6AiHn7HXXWXJ1O
   RfEPQaNk+Bh6iCKK5PNkXIMR/0wgO1CqQw7n9LmSHkrL1ZjbYPGmI7jGX
   sBChcedwUkg2kHmHtt5WZr562MoDDXB4rA45TN2nfq0RcO+2m+1s8Uq6m
   pGBCGdDSS2p1gjjTADVGYU0EJXwPWhOun/DqSIkzFdEivAPZS7Zq6dt1s
   qkKpnBtINTLnd7h4aCHB2zyTsrRTeS5ARTwhz95LR02FO7Wn93yAKGSDR
   g==;
X-CSE-ConnectionGUID: ZY9Em3yXRgGdBKvmx4aVQw==
X-CSE-MsgGUID: H7EEoHekQJq4U1blEowKzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89465869"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89465869"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:43:05 -0700
X-CSE-ConnectionGUID: KeG0/2yeQhGodvjlZidXSA==
X-CSE-MsgGUID: tIBpa6lhQ3eS/AaJ5Fupbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="294440477"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:43:03 -0700
Date: Tue, 8 Sep 2026 13:43:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@lysator.liu.se>,
	Andy Shevchenko <andy@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/2] i2c: mux: Propagate firmware nodes to channel
 adapters
Message-ID: <ap_mtZa1bGidHXfq@ashevche-desk.local>
References: <cover.1788623619.git.ahmadexp@gmail.com>
 <00b33b4b352848ff87dd9089190b35d8732676f3.1788623619.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b33b4b352848ff87dd9089190b35d8732676f3.1788623619.git.ahmadexp@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 07, 2026 at 11:26:23PM -0700, Ahmad Byagowi wrote:
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> -	struct device_node *dev_node;
> -	struct device_node *mux_node;
> -	struct device_node *child;
> +	struct fwnode_handle *dev_node;
> +	struct fwnode_handle *mux_node;
> +	struct fwnode_handle *child;

When the local variable changes the type (usually this is related to
the pointers) the best practice is to rename. In such a case it will
avoid the cases when some API accepts void * and the change would not
have been noticed until run-time crash or subtle issues.

I hope here it's just a mechanical stuff and we don't have side effects
as per above.

-- 
With Best Regards,
Andy Shevchenko


