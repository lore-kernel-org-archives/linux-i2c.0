Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0F730E84E;
	Mon, 23 Feb 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863910; cv=none; b=J7/ka7v9F7xJpDNdiLnXS+/sD+0u5BxX/LbgmKX9u4bT1Zgn3/cnhhCEBfWssLM8HgfBkk8p24J/K5MxTn99I5QWywqAGm+NslU3xHN7j0mQPAhA0CSFnzrYA8odjk7vgkj/cK5Ou1FqOfrZwHYvuF+Gy6dMZJ6vNdhLJreoK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863910; c=relaxed/simple;
	bh=RaIFmorfuz8x3xFCqV+d1f8KOZa2SkqKZuHvgJJVDaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qp7kG7/nWttgCG7LM5OUXjlLeG1ZmW49M1mxcd1GyZKFsxulm4irNAHh5pI9R0zYBW337Grc0B/zDWgBZNgKIHDEZmXZF9AETi9ZjEsL5R3BK4C9MLe8Wt/uooJTWDyH2A+Ud2mTIzZeGGRQUA3qON9RXV9hiAuCni8wb9ZJvis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMfond0P; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMfond0P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771863910; x=1803399910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RaIFmorfuz8x3xFCqV+d1f8KOZa2SkqKZuHvgJJVDaE=;
  b=JMfond0PRs4toDLf6bXj4jUERffc3TkSkDNOBfcwUSpJDQ3QLXsqigsx
   sS03kCerGElMkXzvEmHxNKRgVQMKPGbMCwDVOZPWRqJRBIQLDo/rQYTuS
   /lDHmVWprsY6WFQh1IRArIdIlYSVckzNHm1MaZtKOZ7/zghhmChWaRzRk
   Hq6OYwvUYQGW65okZ0cPkubzYYvGhDa9slZ2r32GVQNgUaH+qJR395EGA
   zItT8kZ9smMaAYTmi8q9O5McqEwvtmlzfV0xOmLqorvqs2EJmqivNEjaA
   ojC1BgOgKIaEpA3BEp+cXbjupZowpXHaZIFw4nXN6BJi/0QYMfscili9G
   g==;
X-CSE-ConnectionGUID: J6mWM1wGRxOCh/OxTs3d1w==
X-CSE-MsgGUID: I7HnJT+RSXyo+pzLB48BZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="71888363"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="71888363"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 08:25:09 -0800
X-CSE-ConnectionGUID: caBAQ2m3S6WpUIo/29AdtQ==
X-CSE-MsgGUID: NBfGV0MJSY69VvgA6gLxzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="220119140"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 23 Feb 2026 08:25:07 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6E58A99; Mon, 23 Feb 2026 17:25:06 +0100 (CET)
Date: Mon, 23 Feb 2026 17:25:06 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Filippo =?iso-8859-1?Q?Muscher=E0?= <filippo.muschera@gmail.com>
Cc: jdelvare@suse.com, andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: amd8111: switch to devm_ functions
Message-ID: <aZx_Yvo_an2_13Lq@black.igk.intel.com>
References: <20260202131304.8524-1-filippo.muschera@gmail.com>
 <20260202131304.8524-2-filippo.muschera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260202131304.8524-2-filippo.muschera@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 02, 2026 at 02:13:04PM +0100, Filippo Muscherà wrote:
> Use devm_kzalloc() to manage the memory allocation of the smbus structure
> and devm_request_region() to manage the I/O port region.
> 
> This simplifies the error handling paths in the probe function by removing
> manual cleanup and allows for the removal of the explicit cleanup in the
> remove function.

...

> -	if (!request_region(smbus->base, smbus->size, amd8111_driver.name)) {
> -		error = -EBUSY;
> -		goto out_kfree;
> -	}
> +	if (!devm_request_region(&dev->dev, smbus->base, smbus->size, amd8111_driver.name))
> +		return -EBUSY;

This is a PCI driver. Why not using the pcim_enable_device() with the
respective pcim_*() call for the IO region?

I believe the driver misses pci_disable_device() as of the current
implementation, switching to pcim_*() should address that as well.

...

>  static void amd8111_remove(struct pci_dev *dev)

>  	struct amd_smbus *smbus = pci_get_drvdata(dev);
>  
>  	i2c_del_adapter(&smbus->adapter);
> -	release_region(smbus->base, smbus->size);
> -	kfree(smbus);

(Somewhere here I would expect pci_disable_device() to be called.)

>  }

-- 
With Best Regards,
Andy Shevchenko


