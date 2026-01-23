Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A03EBF1F;
	Fri, 23 Jan 2026 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157077; cv=none; b=ffjeHGXHnYajkeaX9EV5gc7mufV2FHBvUUOCUmlWJRiK9syk0yr7A+sNaO6d09b6wJn4+pMEIzSA6dnEFvpOT05o8mY1Shtuc7ITeCW3SBTELKxc0/uwrmSEOIA3qCyfOcDqojaZDhF3B1emBaw733gHr9Nv9u7uo9uuGz4spFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157077; c=relaxed/simple;
	bh=Wrxe/WpAWkOO8ZfQvMNXSIgzMIh+zwoBUGouZ5gx4uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U576t/sXTZOA1HjijHZLGec2FfyTvb6r0EhH2BpVdQesiAfk/zfussnOXK3EugdF8/nMps59cn183qLJaDepFKxW5wL3Fx5VX+wkWbH+eDF+G3dxHfSr0Rjsnpp6gqeKra6iVCWYoJWcEoqYSquM0CDz1zQ10uMrmeO2Gzbt5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgcAEASr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgcAEASr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769157076; x=1800693076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wrxe/WpAWkOO8ZfQvMNXSIgzMIh+zwoBUGouZ5gx4uQ=;
  b=DgcAEASrIYcpCpGZahldDNsDy/qO1gzUhLdsO/oEsZ5M1P5bssKM+99P
   Wh9ND51mPq88KPorTRz2SDJa9yhu5KdvFauud0cekN6redWVDJ0yakip3
   nweniEpMLB2HejBOzty1bFBA4sePgkSI+jGl7cQOQmIOxq2VFcI74OqS/
   T04zXQdqjoYuEjZIVWBrV6qXbPyzaXob4CoKYwv6fYdANKf7NrS5YKY+B
   C1o7/7Arz8bynnv+CQrf/BQyo5Q2VUbRBfJ+qL9/gBffY0hK4ClIpQHRH
   HiHYF5f2krXIU8DRFoCuWffiah+g1H1+pLC7hTcH2uVIgRTX5he+YdYY/
   g==;
X-CSE-ConnectionGUID: NvVyXEMDQk+2JapwrS9DcA==
X-CSE-MsgGUID: YvEmSawkTFyJ2LA/ZkESyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="95879593"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="95879593"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:31:15 -0800
X-CSE-ConnectionGUID: XrQTufygQmmNRvsPhmoMyg==
X-CSE-MsgGUID: e23z/7rhT0CvmExoizIX4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="244585847"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:31:13 -0800
Date: Fri, 23 Jan 2026 10:31:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] i2c: xiic: use generic device property accessors
Message-ID: <aXMxzohj6yD-8KSK@smile.fi.intel.com>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 08:02:43AM +0000, Abdurrahman Hussain via B4 Relay wrote:
> Switch to generic device property accessors and make minor code
> refactoring.
> 
> Make the clock optional since the driver is designed to operate without
> explicit configuration in firmware thus making it useful on platforms
> where clock is not or cannot be provided.

Everything looks fine in the result, but one nuance ruins the series.
See my other comments. After fixing it and rebasing I will give you a tag.

-- 
With Best Regards,
Andy Shevchenko


