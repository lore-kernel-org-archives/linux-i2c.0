Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B2C2F0673;
	Wed, 19 Aug 2026 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122093; cv=none; b=ubnKtgrg2W2FjK5H1BrsBAr/cl0Qul5IUaYvdleNmqxCEnSALSQ9PsPeELooyplpsTUkBT+0BzMUq9xGUadzoZHqdFMyKxb6o3hOafzADjvvuVwfHiUpQyx9N9SbOc7xTx3X01QED4tAwHnJU3BvhvGr7drpz2tD7qwhDbQV1wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122093; c=relaxed/simple;
	bh=j2H1knM9PX+Wt32Jvy9psq03GLJHDRacQxhLvd+A+78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdOrKpcHEsOksnEg69Bfa7xE7iBy+X4hzs3rgva97gYuVvup700x+bNQN0glE40wT0jM8jrP0ww9dTlZfwK6kp1NWH/u1GZhtk5HZkefX4q3Ydabpk90xN23yk4NiWzM7dB624GO8ousGfDUzNTMhVATFaswotXSe07D++Xq9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8vKmukz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8vKmukz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787122092; x=1818658092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j2H1knM9PX+Wt32Jvy9psq03GLJHDRacQxhLvd+A+78=;
  b=B8vKmukzAlPHbtfRrbcuEg6HuFaDiGMha2J9obvnIP01dx9WDKzDrcCI
   kDfsJ49+yXVA2QBLNmLqdtJJfbmn3cj7KXOSDw7w59fW7AH2aopAysjfp
   kHMwYxZBwaPfreZQPuxswPnYp+5CAiodjcx0VFU8+ygl8puQg+4I3gXo0
   uGCj5vmiWKmBB+tfJNMWOK43sPywKhRIGpew6zP8rLVY1f8YhKzC03wjk
   Qg9HeNbgLXn0htAkUPkiAeusO3afbbMk/Ru6N/8Ymzr3mWq9gCH6x0HZ8
   Skcqg6WK+H7ZMQuRlHsfD0+1IXuR3LveGickNPOTMZPXQ3ZOCao82UzSr
   w==;
X-CSE-ConnectionGUID: 29sMqEGGTzyEM+tJfeIw0g==
X-CSE-MsgGUID: BjIR6v8gT0mSvdPcl+m10Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87643464"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87643464"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:48:10 -0700
X-CSE-ConnectionGUID: fg23qZLCQPyRt/XjYmT8OQ==
X-CSE-MsgGUID: o6VJj8oiTke6KvHZWeuXxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="264137221"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 23:48:08 -0700
Date: Wed, 19 Aug 2026 09:48:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] i2c: xiic: restore non-managed runtime PM to fix clk
 WARN flood
Message-ID: <aoVRpS7EmL3YYBWH@ashevche-desk.local>
References: <20260818-i2c-xiic-restore-runtime-pm-teardown-v3-1-5fd315b078e1@nexthop.ai>
 <aoVRETUfgS4FwMnq@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoVRETUfgS4FwMnq@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 09:45:41AM +0300, Andy Shevchenko wrote:
> On Tue, Aug 18, 2026 at 08:35:10AM -0700, Abdurrahman Hussain wrote:

...

> >  	pm_runtime_set_autosuspend_delay(dev, XIIC_PM_TIMEOUT);
> >  	pm_runtime_use_autosuspend(dev);
> > -	ret = devm_pm_runtime_set_active_enabled(dev);
> > -	if (ret)
> > -		return ret;
> > +	/*
> > +	 * Enable runtime PM by hand: devm_pm_runtime_set_active_enabled()
> > +	 * tears down in an order that races the devm-enabled clock release and
> > +	 * makes clk_core_disable() WARN (see xiic_i2c_remove()).
> > +	 */
> > +	pm_runtime_set_active(dev);
> > +	pm_runtime_enable(dev);
> >  
> >  	/* SCL frequency configuration */
> >  	i2c->input_clk = clk_get_rate(i2c->clk);
> 
> >  	ret = devm_request_threaded_irq(dev, irq, NULL, xiic_process,
> >  					IRQF_ONESHOT, pdev->name, i2c);
> >  	if (ret)
> > -		return ret;
> > +		goto err_pm_disable;
> 
> This might be problematic now. You need to unwind the IRQ request in non-devm
> manner as well. Scenario is that IRQ comes exactly after PM is disabled
> in the error path. Is it a problem today? What about tomorrow (assuming some
> new chips / code is added)?

(To be clear: I'm talking about next call(s) that may fail, like xiic_reinit()
 later in the probe.)

> The rule of thumb is that, no devm_*() call should be followed by a goto.

-- 
With Best Regards,
Andy Shevchenko


