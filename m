Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431253644B6;
	Tue, 24 Feb 2026 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929498; cv=none; b=T/6gAZ155O5W9LFdHTI4A6IaMDLl71bBh8XDiHh1CJm3mciV2yF5miUEnxo5et3beVguw0cPzXgA72nuuTEw/Hu/f0WExL36OQnnxdctF4pBUh9Qg0x5ElFkoBwdCMVOyZCnDHzxL8aRAkJbB89GdCZLcYCGB681sET9TjltuNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929498; c=relaxed/simple;
	bh=LLhSOQ43bpwsISzId3Xh3ItJ21ru1/jS4ja3DtUA20k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPm4Cbr2BPxQq3cFnE7HqOE+oyW+7O2RIpjgvQGQkoKIZuOScAJzgY2RFjGOlOQilXIabZ4PGgacfMCPasZF5jKpWQTW8v5AHqlAxXE62YoF5t/JpO0T9SqiyGETx4TGONvC1buhQ+zQJgvOEZp033PTVdCj/RdPu2TGyeEZmKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoFd55jv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoFd55jv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771929497; x=1803465497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LLhSOQ43bpwsISzId3Xh3ItJ21ru1/jS4ja3DtUA20k=;
  b=eoFd55jvap3WBD07PpXCkqMbfkzDM19jPHnnTL8TsGJVeMocxgczbnj5
   Lf2OUKgiZGOV+MwHlCbhmAZfIG7hZq49aC9ptGp8fU4qQipqdPPX44BHd
   2Ep9V7vC8i6aR/iHdRswduhWXuhrjORJl3eO+9f0W+fxLCUETTJmv4vTR
   TepKJA4QJ+cnR3BOCbMEnwNBIffzvIQZMbAszeFKO+9WM10T0bjKnL+Nd
   h/372lBo9VGnGiPVoVldk4kl3zYq7muu4JOeyUAz/5Hf3/qX9x+7hr6jc
   Gngl6ayMX6V7V+Z6lUVqh5ulhA2cVY1wzUp8HJlsQYVdB0gsdi7PDQeUn
   A==;
X-CSE-ConnectionGUID: 1WvMehU4QXSnmd2aPQgvdA==
X-CSE-MsgGUID: kFRt6olcQKaGzGkDHYoEBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="73003627"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="73003627"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:38:17 -0800
X-CSE-ConnectionGUID: 15+egK+SRX6xcDR08fugSg==
X-CSE-MsgGUID: 1D2ybtWCRYW9ESuzHskDIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="213133993"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:38:15 -0800
Date: Tue, 24 Feb 2026 12:38:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Filippo =?iso-8859-1?Q?Muscher=E0?= <filippo.muschera@gmail.com>
Cc: jdelvare@suse.com, andi.shyti@kernel.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: amd8111: Switch to pcim_enable_device() and
 pcim_request_region()
Message-ID: <aZ1_lZLd37VyREHY@smile.fi.intel.com>
References: <aZx_Yvo_an2_13Lq@black.igk.intel.com>
 <20260224102216.17606-1-filippo.muschera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224102216.17606-1-filippo.muschera@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 11:22:16AM +0100, Filippo Muscherà wrote:
> Following the conversion to managed devm_* APIs, update the driver to use
> the PCI-specific managed APIs.
> 
> Use pcim_enable_device() to properly enable the PCI device and
> pcim_request_region() to manage the I/O port region.
> 
> Switching to pcim_enable_device() also addresses the fact that
> pci_disable_device() was  missing in the driver lifecycle, as the
> managed API now automatically handles the disablement when the driver
> unbinds.

Looking at the code now I see the difference this patch may bring.
I was under impression that there is pci_enable_device() already in
the code. But it is not the case, which makes quite a different
enumeration flow (it will write CMD register and touch some bits
that might be sensitive). While the code looks okay and I can even
Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
the change needs to be tested on real hardware before going in.

...

>  	if (!(pci_resource_flags(dev, 0) & IORESOURCE_IO))
>  		return -ENODEV;

While it seems now being unneeded, I would leave this check in place until
somebody who knows the platform better can come up with a clear justification
for its removal. It also sounds aligned with the above remark. It might be
we can not do this patch at all.

-- 
With Best Regards,
Andy Shevchenko


