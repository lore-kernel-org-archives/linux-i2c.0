Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAFE3DE42C;
	Mon,  4 May 2026 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906271; cv=none; b=UhDN2IlewMIIZ/BZf1PCYic7Tzrpv7vcf/PIv10L4LJBqIYQ4TlvUKcRZiVba3X/AOaBjvLryGfa/9lqZ+eVv00FZX4CsHiJ+colcsj/Ma2arD+6RXmsJGstNOGQV16WI0AskHlprTcTpgXod5QNTbvmuYaC+FwTz2MQgZP79X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906271; c=relaxed/simple;
	bh=u7WUfco7aNCBZAcaZ6OWPTE8F0jRgmu52I21/lXYShM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONGp/Tof2iNQBeiS8Uk3zmm7lApwKAaX9zdixqPzRwzyu5tcb5zCwWocZF7dtVQ6F3Qf96T14udUXDJMSLx93YmUxK3DGfuJ0n8770NhG7AT2wU3r94dTmXNTC64jKPPXh8XO5lT41hL57Dm183+UpZbLBR76apWfdmXofRpoXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=khM+Ihik; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khM+Ihik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777906270; x=1809442270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=u7WUfco7aNCBZAcaZ6OWPTE8F0jRgmu52I21/lXYShM=;
  b=khM+Ihik/zBCr/XCPDL1SsjasHSLyAYT6M+IdX1g3FGEmJ3DjsbivhXy
   C6NV3byyHgELjeVc4ItpL/kL74sHj/043t7vKD2wAnQT5GDTZYq3gy2lj
   OfITp8KGO302LuhziVUlV83tAY9wu/hL/4jq5AJvvzdg7ZIPniHv7ZZcs
   7lflIR6c4kFHGWF+hGGxf8nTdqwIy+tSxzzjyWgvzaPPunTbXHINdGlo6
   o2CC4To69Mv4qPvhEGaaRPNjnF8ljvqf/j2CAVUuswcYf4iNQeylwbG+S
   P948aSk2N+Ut8TOEgtvkUsJrY2UHu64cJQlqV9xRcNoxt6p07B/JHJvlX
   A==;
X-CSE-ConnectionGUID: BPOt3fl9TRu3YqQsnqELvA==
X-CSE-MsgGUID: XIuK4w9ES6yVlO9phWoN8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78663165"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78663165"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:50:32 -0700
X-CSE-ConnectionGUID: mWVy57D/Qt+OOxEUf/RoYA==
X-CSE-MsgGUID: SSLAqSJFTEO2lC4sS137mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="265885995"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:50:30 -0700
Date: Mon, 4 May 2026 17:50:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] i2c: Consistently define pci_device_ids using named
 initializers
Message-ID: <afiyNKhJTD__jAYF@ashevche-desk.local>
References: <20260504142639.2119645-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504142639.2119645-2-u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 04:26:39PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> 
> The .driver_data member of the various struct pci_device_id arrays were
> initialized by list expressions. This isn't easily readable if you're
> not into PCI. Using named initializers is more explicit and thus easier
> to parse. Also skip explicit assignments of 0 (which the compiler then
> takes care of).
> 
> This change doesn't introduce changes to the compiled pci_device_id
> arrays. Tested on x86 and arm64.

Split by driver, please.

...

>  static const struct pci_device_id pch_pcidev_id[] = {
> -	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PCH_I2C),   1, },
> -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_I2C), 2, },
> -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_I2C), 1, },
> -	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_I2C), 1, },
> -	{0,}
> +	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PCH_I2C),   .driver_data = 1 },
> +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_I2C), .driver_data = 2 },
> +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_I2C), .driver_data = 1 },
> +	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_I2C), .driver_data = 1 },
> +	{ }

This may gain with PCI_DEVICE_DATA().

>  };

...

The second driver is fine to me.

-- 
With Best Regards,
Andy Shevchenko


