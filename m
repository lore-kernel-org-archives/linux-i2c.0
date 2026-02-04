Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C675C613;
	Wed,  4 Feb 2026 01:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770169851; cv=none; b=tyaSBP4aqyD9H3GRZnj1AWWtGtt+RP1P8hRYwiLtW8sLYtXBRezqnNvxRATKQhB/MKzz5q1ed6jvzEJb0lZot0hiXI31zvRsdOKSADQT8fHMlBu4OS6DCHCipU41QiEmuxapCKgsy+nP3MJAAM+tz8roJKNBFkiRIEHTkniMbqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770169851; c=relaxed/simple;
	bh=QDjbQ6rVY+x+XmOr6GSDK9LzKHqmqn9DY6iU1AOHoqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CegHhBlXHjoFG1zSQpzJ+e6T5VrB44SYwtuyUGEP8BDhYTgHy6mSMrBCFkmIZa4dkZdZ3KPgHGLw9oDSk9UYx2mkVBFdEXKB8+9NM0Se1F+8+6FNOqWYQC6yPqpa3ZWHhxPsrKA7KXXT12VjzEXlgjLDQrQLVatAZ5lFgjlI1W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtsF8WVF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtsF8WVF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770169850; x=1801705850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QDjbQ6rVY+x+XmOr6GSDK9LzKHqmqn9DY6iU1AOHoqs=;
  b=CtsF8WVFxw97vZGvO8og/PGRqMawoL+c31gv4+q81rQPjODVAdouxrBT
   WoZrdpK4OLGNcVJS1Uf5WaY7hURsWHJq282NLkH8c4riLnWdbY1kj4nf7
   Ab8e5qnVnMhrzf4eQLE5OwYEpYbnVCIqSJ2oyVTQh+aqVYxPxIAT/qhA+
   jIamW8ZVXFbXUn6KxiIH2N2/SoL0Vyil7LBVEmJ/joRpqf5RhaTvz0iAq
   1M5LiHAjZsc8jNRve2mr6ocqBBeP9WWVJY71/LhZARuo49w4LCvJaqga7
   1XF1wHwVtABuUefrgv1j5HlOA2DhyRCJDZRi7N+iYZz0LUp+iCuzi5Gdt
   w==;
X-CSE-ConnectionGUID: yqoVPvN6RLqi/8fsgfn8/g==
X-CSE-MsgGUID: xmhfSdicQe6Ax5wjHRbBMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96807993"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="96807993"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:50:49 -0800
X-CSE-ConnectionGUID: Eo7skKPkTWGFFA3/2l/eXg==
X-CSE-MsgGUID: ngydNiqwSISaKh5KrG9nhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210125367"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:50:47 -0800
Date: Wed, 4 Feb 2026 03:50:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Artem Shimko <a.shimko.dev@gmail.com>, p.zabel@pengutronix.de,
	mika.westerberg@linux.intel.com, jsd@semihalf.com,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] i2c: designware-platdrv: simplify reset control
Message-ID: <aYKl9RqkISSV3Fn7@smile.fi.intel.com>
References: <20260130111039.874548-1-a.shimko.dev@gmail.com>
 <20260130111039.874548-2-a.shimko.dev@gmail.com>
 <aYKj31hi1bF4wmsi@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYKj31hi1bF4wmsi@zenone.zhora.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 04, 2026 at 02:43:30AM +0100, Andi Shyti wrote:
> On Fri, Jan 30, 2026 at 02:10:36PM +0300, Artem Shimko wrote:
> > The current implementation uses separate calls to acquire and deassert
> > reset control, requiring manual error handling for the deassertion
> > operation. This can be simplified using the dedicated devm function that
> > combines both operations.
> > 
> > Replace devm_reset_control_get_optional_exclusive() with
> > devm_reset_control_get_optional_exclusive_deasserted(), which handles both
> > reset acquisition and deassertion in a single call as well as
> > reset_control_put() which is called automatically on driver detach. This
> > eliminates the need for explicit deassertion and its associated error
> > checking while maintaining the same functional behavior through automatic
> > resource management.

...

> > -	if (ret) {
> > -		dev_err_probe(device, ret, "failed to probe lock support\n");
> > -		goto exit_reset;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(device, ret, "failed to probe lock support\n");
> 
> the dev_err_probe() changes are not mentioned in the commit log.
> Can you please split this patch in two, one for the
> devm_reset_control and one for the dev_err_probe?

I believe they can go together.

But can be split as well, first we replace goto by return ret followed by
the joining the dev_err_probe(). In any case the commit message might be
improved, yes.

-- 
With Best Regards,
Andy Shevchenko


