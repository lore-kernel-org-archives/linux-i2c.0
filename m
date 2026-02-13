Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E80B34D38E;
	Fri, 13 Feb 2026 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770975260; cv=none; b=V4zikCk/sOJeI98KAkvayougIX3iVNTxi9b0hufTu5Kl9dC9Ry6kljwXncd/xpdGL5DoVT/1jDoUtnKpe/iL6Y3Y70PM0AMPME6Gg+qSTS0WjRQxqSYy+xccZnRfMNF0G3PbK2agoC1YSbTJB3Pzf51+tmLwNawKV8F9nEYFGt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770975260; c=relaxed/simple;
	bh=u2WYAevwv/bre8sXgj9rzmMSY8BHqfPohwWP/K3U+PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEBu+N5yLQaI01vnrMCJsrlBEiL/XrweMqFZCT4ZaHuM01514pc/+grxmn9Mm4Duqtze9Uat5cqW1DikzrPRPOIM8NCkTR4rVZbyNu8c/9EscDqROKVJZd9y67TnzcemxdpGNfvfG63PD+bTxrOIauH/hCP7o+bqRGGLZ3jEK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R1uNWkjX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R1uNWkjX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770975259; x=1802511259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u2WYAevwv/bre8sXgj9rzmMSY8BHqfPohwWP/K3U+PM=;
  b=R1uNWkjX0v6aJCwbEpppCCCgTGAUsEAZ4EJm8JB6fYCrff54wRhgaUfS
   Rumx/VIu/Wuf3p+g+XLRPv2uF+hpDJqTzbZ+mmvREAmRFA2MLcMx2qyRy
   qNScug/tEOqXGjy+CRXXuXzvNsZRxzhklq/dEhJXpsJyyWetHOV3qLH4C
   niTiPbjz8NA9jUSwXdFPRSATwqZ1f3eQikps9ec4LwBECpfP7drg/hDpI
   AUBXvbgEvUJBVLzo93py8RiL+dCrYE2g7p8/9GQn0Y5MbTU1Xpg65Ol7z
   HRAZz7bqjE5tS1x1NbEt6dV01XaFfTr6DxcU5GYsceg3o5sSvBu7J0Y10
   w==;
X-CSE-ConnectionGUID: 9COukf0RTOGjmIEv6wU4Bg==
X-CSE-MsgGUID: WFindOKzQPerUbPp36zzZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="82792042"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="82792042"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 01:34:18 -0800
X-CSE-ConnectionGUID: r3qh6X7TScGQFOLfBlP3Lw==
X-CSE-MsgGUID: xwZTVq/PTcm2YlPgSq7zMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="212910054"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.242])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 01:34:15 -0800
Date: Fri, 13 Feb 2026 11:34:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v11 7/7] i2c: xiic: skip input clock setup on non-OF
 systems
Message-ID: <aY7wFbwUr3KLT0Zi@smile.fi.intel.com>
References: <20260213-i2c-xiic-v11-0-5d18aea11bde@nexthop.ai>
 <20260213-i2c-xiic-v11-7-5d18aea11bde@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213-i2c-xiic-v11-7-5d18aea11bde@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 13, 2026 at 12:15:22AM +0000, Abdurrahman Hussain via B4 Relay wrote:

> Currently Linux does not implement ACPI ClockInput() resource to describe
> clocks, unlike DT. However the xiic driver is happy if something
> magically enables the clock before the driver probes, and does not
> turn it off again. The clock should always be considered optional for
> ACPI.

...

> +	if (is_of_node(dev_fwnode(dev))) {

You would want to have

	struct fwnode_handle *fwnode = dev_fwnode(dev);

at the top now, as here is the second time it's being used.
Perhaps it makes sense to do in the patch that switches to
agnostic device property interface.

In any case, wait a few days before doing any new version, unless Andi asks
you for it. The first 6 patches may be already applied as is, in such a case
the above comment can be addressed here (with a little churn of touching
a line that has been already modified in the series).

> +		i2c->clk = devm_clk_get_enabled(dev, NULL);
> +		if (IS_ERR(i2c->clk))
> +			return dev_err_probe(dev, PTR_ERR(i2c->clk),
> +					"failed to enable input clock.\n");
> +	}

-- 
With Best Regards,
Andy Shevchenko


