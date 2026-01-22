Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF0B3A7F49;
	Thu, 22 Jan 2026 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072638; cv=none; b=f99IuUtD1+k3XOgwWG/WWza+ywJsQQMMKrPIRvSmIu4XxcCPxkdF58QCDawVJeXwO0nO6Yi7oVoeucgYuGArNdhHeYtuSctFhfX65CxeDfc1xdRa89sLIXnrHa/2L1tx4Dyhtyyf89TxmkV+ChEcR5c0Lpe7U9X+XKmCpVHJOc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072638; c=relaxed/simple;
	bh=4ohGY88eWkGMmFgVvnuEy0jhbn8Jw1vVAxE6b2ba4dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjz0mgSjv2X57H1YojCqWjbP2ClCV8KBE8V4OauRSXmPRLsgRkAQm2Pso4JINGlHhOB8pT3Pek69NKuUjXhqSwml6tol2Mv+wC+U5jY6vV3JEf8IdVI4KkQ0dS42WTkaZMzRm7jJUPlE2OxkPEdbG6ZuaPCvEC3/3hxvKqPt3bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKYBue16; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKYBue16"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769072638; x=1800608638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ohGY88eWkGMmFgVvnuEy0jhbn8Jw1vVAxE6b2ba4dM=;
  b=MKYBue161OjutgkDBTHAvsstSIEUzU0Zb4nDQUfYzQgF0JlvIgwnQTf5
   +K7cRw+eyEH1ptAzl9oBLmQRjdWRFwSkm47A1hl5JJwIMxyXc5o1TlL5W
   Lnla1RFARddJRwVIixveSrF3OZSQugKabQYH6JLrlNP9KztxbqEnZ4hl/
   Mi8a/3bCY4p5o8xmJmgN63dBrJwtsCEFrO8vRR+6DkRoUQJjJyMZ0SxIP
   ht4kNQEuyEUjoKLmm1+TMKwogURJF3qSOzN2t7KNpqxUk6v2iEn9sMCLz
   sk0e2uMtdTzDXInSgPJUV9z3+LuRZOrcLYVHkVbFauQInWZF3Cu0XeNMS
   w==;
X-CSE-ConnectionGUID: Cd9IrJAdRtSXo58gv3DVfg==
X-CSE-MsgGUID: u1qXUvXcTUGAPosvc1o3Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="57873879"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="57873879"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 01:03:56 -0800
X-CSE-ConnectionGUID: 4XmMHhiLTv+BOKI/lEXCsg==
X-CSE-MsgGUID: SAcLZZBOTEKZrMnpfQ/UzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="244284372"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 01:03:54 -0800
Date: Thu, 22 Jan 2026 11:03:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i2c: xiic: switch to generic device property
 accessors
Message-ID: <aXHn9g_aYmfJ-2ak@smile.fi.intel.com>
References: <20260122-i2c-xiic-v2-0-134f5d743e8b@nexthop.ai>
 <20260122-i2c-xiic-v2-1-134f5d743e8b@nexthop.ai>
 <aXHnDXHfjEnKpRmg@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXHnDXHfjEnKpRmg@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 11:00:01AM +0200, Andy Shevchenko wrote:
> On Thu, Jan 22, 2026 at 08:32:31AM +0000, Abdurrahman Hussain via B4 Relay wrote:

...

> > -	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
> > +	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
> >  	if (!i2c)
> >  		return -ENOMEM;
> 
> This type of changes should go in a separate patch after this one.

...

> >  	mutex_init(&i2c->lock);
> 
> Please, consider also switching this (in yet another separate patch) to
> devm_mutex_init().

...

> > -	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > -					xiic_process, IRQF_ONESHOT,
> > -					pdev->name, i2c);
> > +	ret = devm_request_threaded_irq(dev, irq, NULL, xiic_process,
> > +					IRQF_ONESHOT, pdev->name, i2c);
> >  
> >  	if (ret < 0) {
> 
> > -		dev_err_probe(&pdev->dev, ret, "Cannot claim IRQ\n");
> > +		dev_err_probe(dev, ret, "Cannot claim IRQ\n");
> >  		goto err_pm_disable;
> 
> Before doing it, just kill the message, it is a dup since devm_request_*irq*()
> already prints the similar one on the error cases.
> 
> >  	}

...

> So, this patch should be transformed to three

Ah, to four!

(in the following order)

- convert to devm_mutex_init()

> - removing a dup message
> - converting to device propries
> - utilising the temporary 'dev' variable elsewhere

-- 
With Best Regards,
Andy Shevchenko


