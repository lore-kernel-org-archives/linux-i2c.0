Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7293033E5;
	Thu, 22 Jan 2026 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082582; cv=none; b=bz4HqzTOG2JytLvCt+Scol8tdMh0cn6DNkGaHbGAkNja3ef7+2rit2Z1GDkSTyQmXUMN7tAnc0vig8AyE1Cr1eR18LSDYxAPBLbm3JTcchFPm9rQwuZPCI9gVx/1qJZKH6CYqB7UFQ3fXj+/UOApXiCnAD9AQxEjeYUHCRNEB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082582; c=relaxed/simple;
	bh=4j7YJkbnOxR/MvySWqmB4MgSIDH7Fdw0JXk9nhr0x1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6lvUTcpvq2rq00qDOc3byswtlSgb9Ibny3I7tGwp+S2oPScchS/tHSntgUsRUf5oWxqB/y59O7kKhshkZAFsPtF8gTxpO6D8TQvyMo6qfMz6X7aXN4rZZks0YCrpzntl+pJ8UBSRyJ7CDIE5jGiV8m7Tvy70UbEve8zCc9ZpbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRZ3EaHy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRZ3EaHy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769082581; x=1800618581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4j7YJkbnOxR/MvySWqmB4MgSIDH7Fdw0JXk9nhr0x1k=;
  b=BRZ3EaHyKdi6D1K2yoEVb+v5X+kGPygMqFVxD6HGAxcgrlJ+eNdnD3gb
   p2tzN9f8nbQ4vfx3z7Qjh0xcc3gTulNH6Hxi5V113o/wdFg3GY1fG7FBx
   50ROSA9Y4gEB6AhcPsuEj0ZbE2FJmrYkJV2/oBjM0bKS6R8YS/T0zS7uH
   6uRuR2OJweV2l4QEITKkQA/qc9gP6x05gn/mBcUNXV9GXhkfY7KJNi6HQ
   rtE7pLoilW5IHRFuCBOrpRA42H9Nj4N3B5b2Ku1OiI7dGF5roIoLbVpan
   EmN5JVanc/c+JrR82tnqSOYjVaVJoRkUAR0fhXD4GBxx+8zewkweBqliX
   Q==;
X-CSE-ConnectionGUID: n0tnaaECTyenmMHuI046qw==
X-CSE-MsgGUID: bwfPZJGlTMq/QsA1562RIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70370238"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="70370238"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 03:49:40 -0800
X-CSE-ConnectionGUID: WA6LsTiLSnqB6cYglaqWBg==
X-CSE-MsgGUID: JYdx8+YbQ4+b2LfMKLj61g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206773814"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 03:49:38 -0800
Date: Thu, 22 Jan 2026 13:49:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>
Subject: Re: [PATCH v1 2/2] i2c: designware: Use device_is_compatible()
 instead of custom approach
Message-ID: <aXIO0FpyuHX56FCy@smile.fi.intel.com>
References: <20260114081954.252160-1-andriy.shevchenko@linux.intel.com>
 <20260114081954.252160-3-andriy.shevchenko@linux.intel.com>
 <aXIDQtLlzYvbJSGV@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXIDQtLlzYvbJSGV@zenone.zhora.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 12:10:48PM +0100, Andi Shyti wrote:
> On Wed, Jan 14, 2026 at 09:17:51AM +0100, Andy Shevchenko wrote:
> > We use MODEL_MSCC_OCELOT effectively is a flag for comparing against
> > "compatible" property. Use device_is_compatible() directly to make it
> > clear.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I'm coming into the discussion and I personally like Andy's
> approach. As a third party, I believe this patch has reached the
> consensus and I'm taking it in i2c/i2c-host.

Thank you!

-- 
With Best Regards,
Andy Shevchenko


