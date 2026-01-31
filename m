Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E73EBF25;
	Sat, 31 Jan 2026 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769855470; cv=none; b=FDq60AJzE4ddkE8uxXZAOtT/P15SMzRSsDMen3tvJppK9VyXf7Dkm9von0FuyFVIHdIxxTPsBQFrHkHqHL2xX3yRBoKgM+KEuIo7aNhcGyxW4bga1vsKVcOiXFf1z/1NmBf2vEPz6rLgZQRtEL+BCWuQKIctRT1WRL4Hz/H4dQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769855470; c=relaxed/simple;
	bh=ItTHBVV6a1xUVuw79oxoj7YOc+pNqkuJFb6cv9Lch3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdcuJaAvCmQSoqx7oLMQRpBpKIPV3MUUnz7nx2/efA3d8TMhzJgwMdWqzIsvZ10Ar4VPMISYT+RKjyfL/BT6PHGInBH4DKzAXbLLKgHMpin/z9AGa6iKmmg8rMR9smjYXTt4gbOf3koAaMwzzHBJtkBgrHCTSnC0hyupKXF6fFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6fhprC3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6fhprC3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769855468; x=1801391468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ItTHBVV6a1xUVuw79oxoj7YOc+pNqkuJFb6cv9Lch3Q=;
  b=Z6fhprC3gPYT0vzPDLQUq4EbY96M4RNLA04lixcvh5yjYfXqmsSJchL+
   8PiAzSU+bLFh2+xh2MB6PA+P/tvl94tbXZC7fhGZ8/P3w9Y7YzPAt/TWv
   Ee2xHu7or/o+34qyAmBFvI5v5K2IqVGTu+Whk0o6U7XY48XbUsxtDKE38
   SgaqyJDPnIEMh8rbn5c1EccTTXF0XWXWu8/MNjwGjjPLcIw9KOUFgikla
   nEOQNQ4ihmfOuy7vPVxKVOvqfVMX57Z7ap4i04qSFDrFgep9lmpPW0USQ
   DmeKUUSOvX/QGy4CSTLk26ohwYCtSwBXfgwIi5CgugiBUTEqu2/Or/mY7
   A==;
X-CSE-ConnectionGUID: KazksGvWSUa7k2MJyi2m4g==
X-CSE-MsgGUID: EHdKa4ZwSKeohKw7+QzXuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="74715300"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="74715300"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 02:31:07 -0800
X-CSE-ConnectionGUID: F96DbFF7Tc+UOxybAuXsBQ==
X-CSE-MsgGUID: D1YrCgj/SBud2qJzUtP90Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="209420321"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.97])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 02:31:03 -0800
Date: Sat, 31 Jan 2026 12:31:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/6] i2c: xiic: switch to devres managed APIs
Message-ID: <aX3Z5iEZO8a0GYDs@smile.fi.intel.com>
References: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
 <20260129-i2c-xiic-v7-2-727e434897ef@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129-i2c-xiic-v7-2-727e434897ef@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 09:43:14PM +0000, Abdurrahman Hussain via B4 Relay wrote:

> Simplify the error code paths by switching to devres managed helper
> functions.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


