Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F9338905;
	Fri, 23 Jan 2026 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156894; cv=none; b=D5vKbO7w3mRzczGzgFv/AvQS3GLumTmVVDeJa8s/AFVMLwyRN4VGNn36cXxsi8wCogMDzuhEc0mvLhqJJ+Flhuw5ak8BsqfxfegN4ucijSfN0HP7azJR48HzgmpooS1UNXjPLYdwulukfIKSSmqYOFUEAQ8YNAhGKf6lXNLLXTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156894; c=relaxed/simple;
	bh=f65dWROhIgQSllIOrHPg4GN88gqDR35g4mKGzowJeJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4p4NEL3Ny1GdVSgFLEyjfr/Fqq07b+/Gd0aBmpGoJ64Fw9+IuVehUo4BRPlFCey5cRkMam4tgIB3FTuC8o7D/VH7btDWn3verJimJPqxbUs3+0l9WRtSLdsVf5ZKx8Xc1b09huD4RFU1jlcB0yGauDwNXw80/FNRSVlzd67+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EfUHxJkQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EfUHxJkQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769156893; x=1800692893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f65dWROhIgQSllIOrHPg4GN88gqDR35g4mKGzowJeJ8=;
  b=EfUHxJkQnn5L5+Lut0OQ011I9W17hn5aN98vQpx1MIl5ilVzTszw/duw
   k0yrYrFx4HVwy4AIvGUSjyq4ZujxuYMMdXaco6ax8lEzxYeioFZFp3pKq
   U5THiSyYpPjuE888t8RRdES6UurItpKRIjavPCos9GlQ+34dyCbbml7UZ
   qAj02/w/BVBxQBXMqNmhDPn6MKt8hPs0MEAIiig/BdavnroQI+r6+Bx0S
   YcK5phicYxvJ4zI8geJxEvvqpIqn40ZOHifsicP6oDkIXOTxFq8cVaky9
   xTlzblcNzAhZqHOTgp9BCH2+9Vypk5+cydqU2scca5Ti5aWRazJSilus7
   w==;
X-CSE-ConnectionGUID: VkpRgRkIQbilBEHm3OAk2Q==
X-CSE-MsgGUID: iDLstC1oQLKuoAocSilxRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="81851012"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="81851012"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:28:12 -0800
X-CSE-ConnectionGUID: rlqY79jXTOKaQE/biOXfOw==
X-CSE-MsgGUID: qOMa2TYySp+eDSwebWS2wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211091828"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:28:10 -0800
Date: Fri, 23 Jan 2026 10:28:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] i2c: xiic: minor cosmetic cleanup
Message-ID: <aXMxF45gX1qS-CeU@smile.fi.intel.com>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
 <20260123-i2c-xiic-v3-5-eb7cd4254dfb@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-i2c-xiic-v3-5-eb7cd4254dfb@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 08:02:48AM +0000, Abdurrahman Hussain via B4 Relay wrote:
> 
> Add a temporary dev variable and reuse it instead of referencing pdev->dev
> everywhere.

...

> +	struct device *dev = &pdev->dev;

No, this part should go earlier because of other patches that use it.

devm_clk_get*()
device_get_match_data()

Without this you add an unneeded churn.

-- 
With Best Regards,
Andy Shevchenko


