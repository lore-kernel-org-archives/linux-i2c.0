Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B42E0914;
	Fri, 23 Jan 2026 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157012; cv=none; b=qXCzi0aMWZQ4XIp5ytCwAD5t27BzdZ6t6R/2yuInbqiM0KRc3JqNeAkLxob4a6/VumwR5aTeM2vV7J29pl6Xns+9YjYucYc1j49qOP7D7ceUhGiKJhuwyYYvJDqEHkCz5+ASYJRlVHFaOaayTRxK0WdaveVX/Iuxd1zYHgBJDGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157012; c=relaxed/simple;
	bh=hh5sToR9AGwKIbDihovytp3JPE3xlUNC/QVFWChK7OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhKhuNkM8jC7UmMsq5wuvxC1XWd7otBcxP+Q8PvOUsFMl9tCwe2dWUlqG8+TGaayLO/fUFdKQU+ZyKxYjzrfBT+iGvxfvOAYt0RdOyrd6R0vzRvqd/h10fUdGxb3V0tMN7+locrFl4G/jlqQVSx6a3qI4edp8an3SCLwqkGk/WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=InC87shZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InC87shZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769157011; x=1800693011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hh5sToR9AGwKIbDihovytp3JPE3xlUNC/QVFWChK7OA=;
  b=InC87shZsVrfXEJgM3wQW1yhrAXW2UnLQqSzl3OitotcnkYrE1bFCfuC
   8+0zD1TEVNBo0nWrb314og4BUGCfXGuaAPrcMvgfxhrZfwJTq3VKkvEJW
   6e/f+hCQIut1EUnLmCGcrnDDm4v3pr12Alj2doRyuPXC6O3qDQ8CMq+3U
   dvxETxqygvN+Wsnr7KmEfOBuyXD//2UcC7bDynSPuF4/p+g0Z/lLwFg94
   is9+suC+Wh9DAhcnKijGnIELaohVNx8PLCcHJfkBkwufjomdMiO7QRqEH
   TyjAxoteLyRUUbFajpkbhu5tns8hiBQ0bUWFtwM40wnxkeJGtsFJW6TzG
   g==;
X-CSE-ConnectionGUID: 4yr9STjtTaKlCZWazcz7JQ==
X-CSE-MsgGUID: a8L+jUtRQyS0YvSn4SCLVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70324202"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70324202"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:30:11 -0800
X-CSE-ConnectionGUID: rPNXQazcRA6HQjCwhWtTmQ==
X-CSE-MsgGUID: wkDdG5swQYmFViiTm5NO7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="238228011"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:30:09 -0800
Date: Fri, 23 Jan 2026 10:30:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] i2c: xiic: switch to managed version of mutex_init
Message-ID: <aXMxjo-KcfEOtsX7@smile.fi.intel.com>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
 <20260123-i2c-xiic-v3-2-eb7cd4254dfb@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-i2c-xiic-v3-2-eb7cd4254dfb@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 08:02:45AM +0000, Abdurrahman Hussain via B4 Relay wrote:

> Simplify the error path by switching to a managed version of mutex_init.

...

> -	mutex_init(&i2c->lock);
> +	ret = devm_mutex_init(&pdev->dev, &i2c->lock);
> +	if (ret < 0)
> +		return ret;

Should use 'dev' instead (see comment on the patches 1 and 5).

-- 
With Best Regards,
Andy Shevchenko


