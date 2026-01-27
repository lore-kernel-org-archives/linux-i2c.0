Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EA2C0F7A;
	Tue, 27 Jan 2026 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506645; cv=none; b=YiLjOZKwH2C0mWYf1A7JWOvlDK76Jo7/SxYVbwykesMOeTRYIQGC6w4nDCDc1QcMF2wxGVhli3PklJdpLRO3mWZnNCekHCW76TqXhYaSGZ06aB1bMiasZEcgMx2sQ3vskAe8JuoOsAmdAciaeeLEEa7v7RWYeGHjQ+03jGHFHHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506645; c=relaxed/simple;
	bh=9Ksoto5cWtFdF2r5Bda7ISytlQRnnzHsKeVdlVqlfms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zhmdv/o5Y2e426erBnV/RdxqbFDmMntJb3aVGqUINreBZdfbWYtP7852gYoaVq+DwZGrG5u0TuSqHezrwnzHlUmsLyihgQbW/R95drESBDm+R+1VDA19+7Mp5WxE/DXQ6S52RrvfM0GAcDryQoQv+JxhEgZuVU5hkfY9TXXdRjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mI8PJQwW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mI8PJQwW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769506644; x=1801042644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Ksoto5cWtFdF2r5Bda7ISytlQRnnzHsKeVdlVqlfms=;
  b=mI8PJQwWso4YXmkY4Vz54siqin5VfoRM1wGkigLnpIBMz4O0zITq0woH
   F5nwNdV7gJ1MfVSQQCu9JceNP0hkPfXtwBIIaOJxM46L6rquTNiHEJoHA
   z63Jl30wWa8YcVA6TRxmdUCxVjITw8XvtB78Dn9/j5kLiVS64QCXBmwxr
   xKzBvDhY+hyo6SRgmrn+De7jckOEeeCpZOXRV/XH46/zxaYsX0w/4iDpc
   q8zUWokTKeAd8NXWhJ+l3m5ay8XBo5rVbVudj+PpsVPtiEACj02XtTSkR
   YdI57jnYFLb82+igNxmZApI0c01+1naxHvkc+kZIqArQeSm0xby1WwMla
   g==;
X-CSE-ConnectionGUID: gbWl2T1DSkG/1lHTKqPbHg==
X-CSE-MsgGUID: SKAhURY6SDOHwaYOb0eZUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="73282587"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="73282587"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 01:37:24 -0800
X-CSE-ConnectionGUID: Lgz6eiX/QoCCbXCKPeVOlA==
X-CSE-MsgGUID: WFZxxpuFTmuGup6Qu4/e7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="207165698"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 01:37:21 -0800
Date: Tue, 27 Jan 2026 11:37:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/6] i2c: xiic: remove duplicate error message
Message-ID: <aXiHTnqBi2A964k3@smile.fi.intel.com>
References: <20260126-i2c-xiic-v5-0-88a16a28721c@nexthop.ai>
 <20260126-i2c-xiic-v5-4-88a16a28721c@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-i2c-xiic-v5-4-88a16a28721c@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 05:08:19PM +0000, Abdurrahman Hussain via B4 Relay wrote:

> The devm_request_threaded_irq() already prints an error message. Remove
> the duplicate.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


