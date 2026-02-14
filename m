Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC89E1F5858;
	Sat, 14 Feb 2026 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093977; cv=none; b=qGN2rVXuWB4/h080QC/Q2JNYYVZHGQRzA0/Nd5trL923R+E6bxjK/CXK/3dOJUzXsJwC4l8wZHacw1c0nlYgJllaBaPpc8Uv/8RPDuJSkKMsv37H01MJCpFKm7Z3D70FgnyBLo0TAota8wYtu/A95UpzZFcVZpbp+WRMDQOvR6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093977; c=relaxed/simple;
	bh=N4/bk8+svUrebupVSkwmiRPlxY1iPpvPlmx+utG0ym8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kczNp1NEpduOXw2835uo6sWjiPyXpmplWbpZ9l3z0oqX6cAGXc9Du8VfDa9o2laAr+/RbZupgXgcjlHIk4jXW/9dlFfJxLHbMu9C3XLx2Yd7acuY3YeSl5WLn3JTcVD8hcIfY1ViCqM7l+xAjettQgu/k1787ACMHgW+ULLkIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VIktpGU9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VIktpGU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771093976; x=1802629976;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N4/bk8+svUrebupVSkwmiRPlxY1iPpvPlmx+utG0ym8=;
  b=VIktpGU9fhCDqVAXr8EoVBkuvIdaJVDxxPK2FAx7bu5I/vETuoXkzDnc
   8NItOYJgKDFrfBQKSOJ7suW6MY3771KQIUHA75T0ynbyWDCAgAuM21chU
   7OkaMFGiP0WDmNc3ExZc1pvmrRZMelHQtSqGKFc7AdJEANmaAGkAD6TcM
   rf/tZjtmQssqSOgLuHcKpngj/JVAdPZMcnHk316BQEZDxpK/B2CP74deX
   TbFuI/Oa9hZheroV1eMkPNy7EvjpQoWAWgdnTZ3cHWnJJA4I68OArMLfF
   Qp0SmhtQFlSLRtfQdzYAgB2xwNMlXMqdwlHS9Lfo9Ft1OF/Hhce3fC8LF
   g==;
X-CSE-ConnectionGUID: H7qoDjW6R7Kr1dvjjA36Gg==
X-CSE-MsgGUID: BCY1ml1NRCe7w+Lz0LZdqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="83611132"
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="83611132"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 10:32:55 -0800
X-CSE-ConnectionGUID: uF0XpDBaRImge3nwrqTBFw==
X-CSE-MsgGUID: pKmM8qGGQ8mjl0QmwYYTXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="250880493"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.136])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 10:32:52 -0800
Date: Sat, 14 Feb 2026 20:32:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/5] i2c: mux: add support for per channel bus
 frequency
Message-ID: <aZC_0g_r3YETI4MR@smile.fi.intel.com>
References: <20260213-i2c-mux-v5-0-fb2cbf9979b3@gmail.com>
 <20260213-i2c-mux-v5-2-fb2cbf9979b3@gmail.com>
 <aY8JRikJpM4v5BcM@black.igk.intel.com>
 <aZBq5QGHFcQYAONv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZBq5QGHFcQYAONv@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 14, 2026 at 01:30:29PM +0100, Marcus Folkesson wrote:
> On Fri, Feb 13, 2026 at 12:21:42PM +0100, Andy Shevchenko wrote:

[...]

> > > +		of_property_read_u32(child, "clock-frequency", &priv->adap.clock_hz);
> > 
> > Why OF-centric APIs? Muxes may and do appear on other systems as well.
> > Okay, this function seems fully OF-centric :-(
> 
> :-/

Yeah, this is unfortunate, and probably in the future we can also have similar
stuff for all.

-- 
With Best Regards,
Andy Shevchenko


