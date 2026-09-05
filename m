Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EB030D3E0;
	Sat,  5 Sep 2026 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788594542; cv=none; b=B8qMd5HoDevt+jd4/35cCvLhAu9lkJSXxdl+VzLGTp8df5+lSTVCPWoGAfUVr+ogRCmhGmlumGhhvJVzoOf7ZgqCxnWZ8rnAkjiKVHDD1WMhUL5/sVQJkC3OwJgClOwG6ABsljHle6KAu2jtfU2v38sTzqbiiR+U1+6eqqNfJmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788594542; c=relaxed/simple;
	bh=egGzBShQ6WlzwWjn7JYd1KUqRp7nJX9LDdJwRCk2UF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyPOUATBi9WZ11+K7Nm4m+F197nc2m8ReEcsw+SFcH0TAwpfPqXQ8KrKC/dxU+CFuaCtWpE+EheSISieRapILHXTAn2aQbUNiYYKOY0n6c22AnGqUmNAQpOh3VGcX6f04U6iSTwDNo30d8GiTS/IEPch9kuMM8O1boN80eCb9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLvhZ2qc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLvhZ2qc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788594541; x=1820130541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=egGzBShQ6WlzwWjn7JYd1KUqRp7nJX9LDdJwRCk2UF0=;
  b=ZLvhZ2qcveKOhwZ3KQr0t4Es+jGijDjWviTbjHxJPACO5zzJZiuLD3YQ
   +Z4nkkaE1lMTLgAh6yPNhZknZ+yOE9hKGtxh8QHbXXeFmC4EmriVMUB2U
   QQ0B7+AosmjvxX0Pb+vYbqudmUBD12w1+kcPEqDvTlIrS8zrclRM6/Br2
   bfafWHV4P+X8Odvyi413f96yHwXNN1iEHkr35ysKyZn51SpcIodys17xW
   hFVrOvPOVCe7PSpTeN6bc6buCkMbboBf7Kq4zl3HY2Iu+pMxADKuN1FeI
   XCA5H7I2MRj7vWa70QlBtS4/xiH9o9oyoXHhKrQt8sN0JKgIcG+mBmsJf
   A==;
X-CSE-ConnectionGUID: 1a9hdcaBQYOr8ERGOKSAZg==
X-CSE-MsgGUID: 7GXWL+kLTj6k3l+fi5qHZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="91598516"
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="91598516"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 00:49:00 -0700
X-CSE-ConnectionGUID: P3J8wFb8QpqavtHvY+s9gw==
X-CSE-MsgGUID: veq7M1oJTyGZNpcKzYhmPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="269741486"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.105])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 00:48:58 -0700
Date: Sat, 5 Sep 2026 10:48:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Ahmad Byagowi <ahmadexp@gmail.com>, Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] i2c: mux: Factor out channel node lookup
Message-ID: <apvJaBo4Zzz2GAMx@ashevche-desk.local>
References: <cover.1788298883.git.ahmadexp@gmail.com>
 <89780f7db207c7fe7adbd45e1f38f0a041794c8f.1788298883.git.ahmadexp@gmail.com>
 <apnRfWVAiXj1fRXs@ashevche-desk.local>
 <apusvKc2PnSShaoI@gryt>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apusvKc2PnSShaoI@gryt>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Sep 05, 2026 at 07:46:36AM +0200, Peter Rosin wrote:
> Den Thu, Sep 03, 2026 at 10:58:53PM +0300, skrev Andy Shevchenko:
> > On Thu, Sep 03, 2026 at 12:40:55PM -0700, Ahmad Byagowi wrote:

...

> > > +	struct device_node *dev_node;
> > > +	struct device_node *mux_node, *child;
> > 
> > Now all three can be defined in a single line.
> 
> They could, but three is a crowd. So, if you bother to send an update,
> please use one declaration per line instead to make future diffs
> clearer.

True, but it can reduce churn between these two patches if placed on
a single line. Whatever, it's a bikeshedding, so go with what Peter
prefers (as he is a maintainer IIRC of this code).

-- 
With Best Regards,
Andy Shevchenko


