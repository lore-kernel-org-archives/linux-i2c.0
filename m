Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3828FFFB;
	Fri, 23 Jan 2026 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179043; cv=none; b=E669awKGTipzvQYIoJIJ3j6oRrUxFEpCoNGDxEWuwwRbBKH+e2K+Y6XMwKogI4zHtz/mJAkFFQjmoLzOnnMFFviPVf8N7/IShD3t7soenRcoWuAlwL2vLyQ+NMShhWQAO7KtRb743tklXbErr2UrOVPKF6C2jB3G8id7/LCIEM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179043; c=relaxed/simple;
	bh=aDjYSZifG6+j1Xr1fLBwNCAW0H7ApXDhylx+xTZg56o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDQXAXUm5fuQZ1a80KVnL6PRHHctTKzW2BxtYcY5m+xLpkFT/jBPebPNMKQAmuG4+hyktCWkRGJr/5UfcVTePRmwpqRZxhSzLni6ZJwAayMJ9n1y6F9PRbq0FO568DdUmURRWuP0Kag6dYTArl3ASwlIfjIpSe0pcPmXJqW0st4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OELLw2Ik; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OELLw2Ik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769179042; x=1800715042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aDjYSZifG6+j1Xr1fLBwNCAW0H7ApXDhylx+xTZg56o=;
  b=OELLw2Ik4iefFkRItysONjESnvkBcfTIMHBSZejSPkC4hzs+GdPENjhI
   378hTkIfm+A2W+30CxBCjFfAVOpBBuE8gSRVsUva5YubwOu+c9klzHz1B
   iQlnXFRc6GBm3ERGsoXaJ+93BmW9kuV0uXnTltJE+zvVGu2oIJjHBTFKu
   GO0isvmw1wS+0pNCQ8mLOtoIw0CdNUw/z0jV3vfTntcDUHjOwi+ijKDwZ
   hH7GxtyFHeMaop7TZyddTEQxF2kc5Tb53K1vhXiGQJuUzWuhGUAFqRNp8
   qx9ya8HfExEelxVb9ToH7iIZaEweHiBKDjuCOGMhCtu+PHfNtUUDZyowM
   A==;
X-CSE-ConnectionGUID: TsGiO4nNQhaDT0DJghNCJw==
X-CSE-MsgGUID: iiUn2QsWSVK7l9ERLOt4BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70492040"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70492040"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:37:21 -0800
X-CSE-ConnectionGUID: Wf2aeaClTcmPpdagfBubRg==
X-CSE-MsgGUID: /KAjGKLpQWKAtaggnaLe2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="206297644"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:37:18 -0800
Date: Fri, 23 Jan 2026 16:37:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Dmitry Guzman <dmitry.guzman@mobileye.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5 4/6] i2c: designware: Implement I2C_M_STOP support
Message-ID: <aXOHm3tasb_yq7hq@smile.fi.intel.com>
References: <20260120-i2c-dw-v5-0-0e34d6d9455c@bootlin.com>
 <20260120-i2c-dw-v5-4-0e34d6d9455c@bootlin.com>
 <aXJPljHeRxBXH_Jo@black.igk.intel.com>
 <7226044.9J7NaK4W3v@benoit.monin>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7226044.9J7NaK4W3v@benoit.monin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 03:25:24PM +0100, Benoît Monin wrote:
> On Thursday, 22 January 2026 at 17:25:58 CET, Andy Shevchenko wrote:
> > On Tue, Jan 20, 2026 at 10:28:04AM +0100, Benoît Monin wrote:
> > > Add the support of the I2C_M_STOP flag in i2c_msg by splitting
> > > i2c_dw_xfer() in two: __i2c_dw_xfer_one_part() for the core transfer logic
> > > and i2c_dw_xfer() for handling the high-level transaction management.
> > > 
> > > In detail __i2c_dw_xfer_one_part() starts a transaction and wait for its
> > > completion, either with a STOP on the bus or an error. i2c_dw_xfer()
> > > loops over the messages to search for the I2C_M_STOP flag and calls
> > > __i2c_dw_xfer_one_part() for each part of the messages up to a STOP or
> > > the end of the messages array.
> > > 
> > > i2c_dw_xfer() takes care of runtime PM and holds the hardware lock on
> > > the bus while calling __i2c_dw_xfer_one_part(), this allows grouping
> > > multiple accesses to device that support a STOP in a transaction when
> > > done via i2c_dev I2C_RDWR ioctl.
> > 
> > Does i2c-tools support this. I.o.w. can you put an example of user space call
> > to achieve the above?
> > 
> I posted a patch series for i2c-tools, adding support for message modifier
> flags including I2C_M_STOP to i2ctransfer:
> https://lore.kernel.org/all/20251223-msg-flags-v2-0-8d934a4366e2@bootlin.com/
> 
> I am working on version 3, following Jean and Wolfram's reviews.

Thanks, it would be nice to have this being mentioned in the commit message
that the user space tools are going to support this in near future.

-- 
With Best Regards,
Andy Shevchenko


