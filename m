Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269901CAA78;
	Mon, 23 Feb 2026 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838114; cv=none; b=eqzmVkjYdPS3dJ4RlqY35h58HqA2kZbrj+rvkMjuENFhUa1+elHoXmN6k90jstbIrC3p8VNqKsroLtp/jnN90QODUvhlhUNkHVbIbC18j2z8JUWrd6KXLpc9HekrYIMOIg2omc9WDcdXG9MD7LcaBQMGrQDRl2UL1KZ6O9xpf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838114; c=relaxed/simple;
	bh=0TE3WFhsoPiZvQit2yAUsjjsgl2SuCxdZXHnxt7yk60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7NVwYbnrQadQ005cF21yPABpW1lZh3OJ+BoqAwZhNbYdlaJK26iasS5I2oJeFyTdcXDeXaCPxHhNAnrI16PXIHaYo+fwFfzl3YQVI6VVUAG2V5UJPTGrCfsZTZYp7JOxAV4ihaKH2I7m5AkcRPhwO0rblTZ8Rccppk+qQAQohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/IN1zFJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/IN1zFJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771838113; x=1803374113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0TE3WFhsoPiZvQit2yAUsjjsgl2SuCxdZXHnxt7yk60=;
  b=i/IN1zFJ3MIo4XbTjqFemlyUGM9K0A5ILi8o5MwO8uudJZipJ71/EUus
   PVIGfxreHXDVd8UVX4pYP1zHXFoTIJX9TTnmELzOkdvQ7aNqHiSIhk15v
   kldptVhJKJpMUlgX2fSjbaSKbP7edDw0ql5Etc0UJbbMcvSjes/Q8qYJ/
   S4+JdZDWhz8RNKl4d1gnTOxq0WtWHSOPhkMfZujb2ijHK3iKNts19bUyW
   DKJoLsHCPjW31thnJaCM2BkS0Lcgsz9Wuk9Xku4+SBWbssO7XxE4RGQJI
   CHOLWpqvKGxd/6E0WL8C0nrKafL7Y+Y9jceQNtNZPSJjn5/w1qbOvMntn
   Q==;
X-CSE-ConnectionGUID: HnlB+QVwQsKTQouIvL6JZA==
X-CSE-MsgGUID: rs4Ovd2eSimVfNLDM60hsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="90412545"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="90412545"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:15:12 -0800
X-CSE-ConnectionGUID: rXOP+mPuQv+tVleSPI4pfw==
X-CSE-MsgGUID: aB/7wtzdRO23VIhIQtUXew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="212917950"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:15:09 -0800
Date: Mon, 23 Feb 2026 11:15:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jean Delvare <jdelvare@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Hans Hu <hanshu@zhaoxin.com>, Bartosz Golaszewski <brgl@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2 0/4] i2c: provide and use i2c_adapter_dev()
Message-ID: <aZwam0bLyuCIflXr@smile.fi.intel.com>
References: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 10:02:48AM +0100, Bartosz Golaszewski wrote:
> It's been another year of discussing the object life-time problems at
> conferences. I2C is one of the offenders and its problems are more
> complex than those of some other subsystems. It seems the revocable[1]
> API may make its way into the kernel this year but even with it in
> place, I2C won't be able to use it as there's currently nothing to
> *revoke*. The struct device is embedded within the i2c_adapter struct
> whose lifetime is tied to the provider device being bound to its driver.
> 
> Fixing this won't be fast and easy but nothing's going to happen if we
> don't start chipping away at it. The ultimate goal in order to be able
> to use an SRCU-based solution (revocable or otherwise) is to convert the
> embedded struct device in struct i2c_adapter into an __rcu pointer that
> can be *revoked*. To that end we need to hide all dereferences of
> adap->dev in drivers.
> 
> Other series address more generic problems - like printk helpers and
> parent/of_node setting - but there are still some more specific
> use-cases of drivers dereferencing the internal struct device of
> i2c_adapters. We need to hide the fact that the device is embedded in
> i2c_adapter before we can move it out so provide a helper that provides
> the address of struct device without showing how it's stored and use it
> in some drivers.

LGTM, and I follow the evolution of these two series for a while,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
for this one.

-- 
With Best Regards,
Andy Shevchenko


