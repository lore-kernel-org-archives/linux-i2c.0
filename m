Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7BB21255A;
	Tue,  5 May 2026 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966558; cv=none; b=s3/QyHYqVg+LLcNsIyOGWfRonPpWlz7yYaoRYPAhSKFH/iQKyNWpMqpTdwSoGM/34Z6d7blYT6cdVUWONn3OJ1CNMo4K/n8P6FO88MUxFi3pVuLOIHKTgtJ5EXongG56wGtN8Y5h74FBi9Main7wQ391duf4i9OqbflMjgLIHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966558; c=relaxed/simple;
	bh=cO1w4W2f+yA/CaO2f6jlYn5iHOuyBF/ZTOgU7OwbcQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICZjFviLKYVqdDM/Zc9wgmN/fj3WloeDIvcgJyYbi+J/CjxkEbQ+tv50SiY3IBGqhwksYDiTX0gRjiVOFdWzuiyzHnghNePBKlo15D+GEJQ+unw5oAZyOyA49ygfJCRcJ/R3zSHb3VoywhW1/QMaEmQupnFLWpdr6xq/aVjB7EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5aZqGcx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5aZqGcx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777966558; x=1809502558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cO1w4W2f+yA/CaO2f6jlYn5iHOuyBF/ZTOgU7OwbcQs=;
  b=n5aZqGcxxtls4jhf6Ub4VMANpB281IpfU2tJgB/pAK4ZeW4uKWhtNlAz
   npm5OKZAQx3R2XG+mzTK3TnfbTbMKPYX2Y0XYFaczjlQ7Sr6Y4hr/HSWF
   4pG914hr8FyRnW+X0b0nRa1uM/J1MDn6uiKzIFHc0DEH/3MHs2/Kvhzo8
   zxsVAUz380n3lTeMTYnsQmv/Zf2pGMXEnYA7bp+YaeVCE8we0wN6XwBqY
   WIWjGPC7/PHIbJWe//9vgMiFbSvaOdEOKf/jON/gHEj6AGhdsLes0LpDQ
   aJRbPfFx+ueGrS+kNrmjmXwMHpvhxF0x/pr35i06nmRNEgS9hmevePsLp
   g==;
X-CSE-ConnectionGUID: krAn4/HqQr6LMukt7fE6Sw==
X-CSE-MsgGUID: nwwlurXKSX6XPqHgSx6wRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="96396826"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="96396826"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:35:57 -0700
X-CSE-ConnectionGUID: 9by89XPyT0C5pcrLjbSdTg==
X-CSE-MsgGUID: QCM4qghhT0ivOjXZlxs2oQ==
X-ExtLoop1: 1
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:35:55 -0700
Date: Tue, 5 May 2026 10:35:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] i2c: designware: Improve device disable handling
Message-ID: <afmd2ax-GmcKsSQ5@ashevche-desk.local>
References: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 08:15:01PM +0000, William A. Kennington III wrote:
> When the I2C master attempts a new transaction while the slave
> controller is shutting down or restarting, it can lead to bus lockups
> and system bootloops if the hardware enters an inconsistent state.
> 
> This patch series addresses this by ensuring that the internal state
> machines are properly cleared when disabling the controller if slave
> activity is detected.
> 
> Additionally, it adds a shutdown hook that gracefully sets the slave
> disable bit before disabling the controller. This guarantees that any
> incoming requests from the master are immediately NACKed during
> shutdown, preventing the bus from hanging.

In general series looks good, just some style issues, see individual replies.
If you address them as suggested, I will give my tag against v4.

-- 
With Best Regards,
Andy Shevchenko


