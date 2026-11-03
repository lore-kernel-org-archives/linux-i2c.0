Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699307;
	b=EfDTkGpjSpy7fRBHh3gHQWIxfntNw64a4DU+nRtd0bYVDjH3YnwvTDofLG9ypMSxvps/
	 DarhfPlImOnnTJd0ATGfB2TqHuoOkYHCjwscIpmP+nzzS/obYjxKL4wrGyZnzBEfrOiCf
	 4aviNmaByY1B3fdimMIuSaDmjkmTYZK0KODBiVd8QFWjc6guYl5EwFd6krA28APxbV8vB
	 mfT/cMyAtZzXmWRAx7ye3j+WitDdIkFp3r4rC20N46p95TsDTYW6GOFx1Pf+BynDSzEp0
	 uK0MHZiORH6606bod0Q8dPeIdkqrrfF+pW1kvYphuVZ3QN+S9EaxYBf3LDbgSV6oLSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699307;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=hFUtuIOQjZiGUhcBDFXIk4DME0buSZpk2TX7q8g3RwU=;
	b=P02mElSumSZ9fw7/oBjTPwG6SJR9jEGuwql7/NizFAQgDlwwCa5TeiiNoXlB9XY6IXWu
	 CTSgUKNMQ0R355o5iZJMG0LZX1Vf9xA99fMFuAGCFYfx9PN7EsmUkCh0W9pYlLPPNnAMM
	 go5EQkrQc02UXLU86URWi/FwIS1jPXH4WoMdw++iiCQlTADA8xKJiyE5MDxHp+zKFLRFo
	 aICBNbe6EUTIedyXluIbTM81X0soJY597/IeZaU/fKq9c3LaiVgUZK8rHLQ04feQhXOGJ
	 yssP6OcUrJc+aHRxgIHwgY9Ce96lovsRZm058IH1MKL42VlYpte3z0CBxtjdDijouBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eeh5QeuB;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FB2606A332
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 09:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90FB2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eeh5QeuB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793699306; x=1825235306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hawSgna2EBYvXybjLClEZF13TPoVwk5NUTVPDa5BKNE=;
  b=eeh5QeuB6xmNqBBv1/D/QxB2LyaD+LUs8BuaeoJRxHo6GGTqnP0cABel
   XeRBtr4dNfgxBIuHcLWHAlN0SPryQAQKhtgHUxGw9yOUYGeBqeLa/aIpk
   czvGvuMaUQxW1NP1L3OkGCKE6h0WFhDSSLSb37FJufBvR+3aJ7nW892gx
   m/WxQKPUdFpEGWkAO1EsSo50HVJYX15TdURZGlSGTDHXfF6hu7EUJtMj7
   wmZK03AaICfodFTnq7SHU22dGKf4sY3RGNT3am12S4mndjWJeDgaGt4ec
   kcAuSM65LF0MjTDhsJnb9LKd2y0JoH2Iisi4i7qDKCSDlnNYdSXhWXIal
   Q==;
X-CSE-ConnectionGUID: MqOAMoOVRF+X92T58Ldt5w==
X-CSE-MsgGUID: 3O0lgNY2QjKupX6QAWXusg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2429357"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2429357"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 01:48:26 -0800
X-CSE-ConnectionGUID: N2zc3XrySTqz9/yZdwCmgg==
X-CSE-MsgGUID: xFJ5nNs3T4mtrbyxo8eixg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6378975"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 01:48:25 -0800
Date: Tue, 3 Nov 2026 11:48:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Samuel Tirwa <samuel.tirwa@web.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 2/2] i2c: designware: use polling when IRQ resource is 0
Message-ID: <aumt5out9avKNuID@ashevche-desk.local>
References: <20261103090059.1759-1-samuel.tirwa@web.de>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103090059.1759-1-samuel.tirwa@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 10:00:59AM +0100, Samuel Tirwa wrote:
> When an Intel LPSS I2C controller has no usable interrupt (firmware
> reports PCI INTx as not connected), intel-lpss passes 0 as the IRQ base,
> which leaves the child device with an IRQ resource whose start is 0.
> platform_get_irq_optional() then returns 0 instead of -ENXIO, so the
> DesignWare driver never enabled ACCESS_POLLING and request_irq(0, ...)
> failed.
> 
> Treat an IRQ number of 0 the same as 'no IRQ resource' and enable
> polling mode.

Slow down. You have made a mess in the mailing list: no email thread, no
versioning between the series of the same, no cover letter. Take your time to
become a familiar with the process first.

...

>  	irq = platform_get_irq_optional(pdev, 0);
> -	if (irq == -ENXIO)
> +	if (irq == -ENXIO || irq == 0)
>  		flags |= ACCESS_POLLING;
>  	else if (irq < 0)
>  		return irq;

NAK. irq==0 gives a warning and has not be a valid output from
platform_get_irq*().

-- 
With Best Regards,
Andy Shevchenko


