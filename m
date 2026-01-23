Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB9330B2D;
	Fri, 23 Jan 2026 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166797; cv=none; b=VBuDPza37gFQSiPraHK2uEuKXEvJyoofSapXfTWI9+TF4QXHSft++bSR8MqrPA3UdwXDME3hev/YNPeBUmoHBW89/VRauPleIFA0fC/us1eGYtMnTJuiZT46KIysyEtZOl1EWae0KCBPxbHC+uTENA1RFtMmgii7cBhA2FHw2zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166797; c=relaxed/simple;
	bh=g19ooGBMggEH7dginTGsQ0xOOB5I8wTOVpJ5V0a66Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4WFZjvhGrCIkHEahm9ySZNKPk3+i0HV1hHKWTUnoFRydUIBUSRLlXPYHuStnT/Lac53gR+BBw1Q9Lk8XJo+F2/S5cNizI+7TvYTUJ8pBkU1d0WcrP9sNvB2V1F+QNC0ChXF19eTN1YKnK9bHkKKzZsIxBHBcY92tJcuntQAR8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jltfCTgy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jltfCTgy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769166796; x=1800702796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g19ooGBMggEH7dginTGsQ0xOOB5I8wTOVpJ5V0a66Os=;
  b=jltfCTgy2J8l+reTdi+2DX43uvfzxQhAdmmXpgCgdoL7T2gZKgUVtvnq
   O+kK4MxC2iLM0Qx1YOBtgFqwmlaUoD7F3VsFSA/fPG2rCczEJ6I3OLISq
   BTBIkOxO1wS++mEXwIbu/4VCKyL3I/NoEQdhFgxCuYMbBLF2/0DLbQdrb
   b0Zoz9ydRNqTpCSwDMFMh/mTdDyatlSVYsv0El49cS5s0aroW1k+1YDdH
   noMEYj5VnvZSlWt1NeNp1NS7JIYe/e54Am5hKKXidtS+APfHwp/OERyib
   AjUSgHqnWJV/QJT86IWeeWMVqd7OPTooySL6Zell8uelyKFuk3we2cuBA
   g==;
X-CSE-ConnectionGUID: pPZhWAGyTy+F0zBgZZROYA==
X-CSE-MsgGUID: oQE9Vu7rQiq7Gwu3Bz/3hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="80726019"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="80726019"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:13:16 -0800
X-CSE-ConnectionGUID: c1syr/YXRZ+pGqsvcU4QDA==
X-CSE-MsgGUID: kNJVoR+yR5aCEU+64geW2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="207030280"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 03:13:14 -0800
Date: Fri, 23 Jan 2026 13:13:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: andi.shyti@kernel.org, p.zabel@pengutronix.de,
	mika.westerberg@linux.intel.com, jsd@semihalf.com,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] i2c: designware-platdrv: simplify reset control
 and error handling
Message-ID: <aXNXx4elBVRpWCWf@smile.fi.intel.com>
References: <20260123100537.1429497-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123100537.1429497-1-a.shimko.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 01:05:34PM +0300, Artem Shimko wrote:
> Hello maintainers and reviewers,
> 
> This series refactors the DesignWare platform I2C driver to simplify
> reset control management and improve error handling:
> 
> Patch 1 replaces the manual reset control acquisition and deassertion
> with devm_reset_control_get_optional_exclusive_deasserted(), which
> combines both operations in a single call and leverages automatic
> resource management.
> 
> Patch 2 follows up by refactoring the probe error handling to eliminate
> goto statements in favor of direct returns with dev_err_probe(), resulting
> in cleaner and more linear control flow.
> 
> Both patches maintain functional equivalence while improving code
> readability and maintainability.

You send a series as _three_ detached emails. Forgot using

	git format-patch --thread ...

?

-- 
With Best Regards,
Andy Shevchenko


