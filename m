Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F85372B59;
	Thu, 29 Jan 2026 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685132; cv=none; b=Pqe9Ak9FgBUUR+BlamaBUL3FhcOwv94Cs6yJduCBEH/y1sSR02amx153tPuhlRZRCQUW6RqOHk6tq2UmSk4mhhmAulrBTt0KsYuJpOmpIuvlQY0I0epNsenP8czyy9i53Xemwqj4Kxx0o39E8O6IKBZOKsjXWjaXX+vpkL1g+8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685132; c=relaxed/simple;
	bh=3Q1n9mlFgdfPm/z4oi70MCdv4lb0f34kGGpfGg3jIig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSo3xxVrOqsJGHbxXj1x+pWofSNoyOivdH56bmkJ3D8y9TWsfBihBvH3GS7UG5HJv0hib66NZvVVDnkh9aEC79iMth0nfZbvO+UNkQgXPVdu4fEbVA+uo9q4q6mbnQ6Ci6wabmfCI3BW9OPwtTy+s9B+Acr882d4Ew5Md+CNSYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMa3qO3/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMa3qO3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769685131; x=1801221131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3Q1n9mlFgdfPm/z4oi70MCdv4lb0f34kGGpfGg3jIig=;
  b=PMa3qO3/McA2i+nkE8kHSwBbO8A22Xx581HaPymmzj6AGuOb9+QBXw3t
   oobls+DVFEAEhCUgKsNxqCWzoT88wDH6vsfVsCEAeeDcmwsiLh8zyiD/Y
   fzmV/7ZNuTN059lsWGFZ83xmndR2mbY2+bp9503QIucwEH5ApgnYFlaab
   LQfNKSeYCpYm31nisv6KY3VLxo+QB7DuooJ87Dvq8yVGdk9PRfXo+IcVQ
   ngbDWGRrNl3gkspUX0frkJLmm0RLe46irSNs3eShkeGX5xG72pfE3ekHI
   y3n042mvbZ513wMcpO5oF6OAOPTUgQ9kcxkIEDCQf26byQyLeaq6SV8aX
   w==;
X-CSE-ConnectionGUID: o9yKUck9Rl2JuaVpusemqA==
X-CSE-MsgGUID: qnd1lVkESJK1Yd7SCk1S9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70823889"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="70823889"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 03:12:10 -0800
X-CSE-ConnectionGUID: 40QJVL/WTt+Ba4v+WPlS7w==
X-CSE-MsgGUID: CcmV5aNRTdCcVl+xos/l9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="239805813"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 29 Jan 2026 03:12:09 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 9A20098; Thu, 29 Jan 2026 12:12:07 +0100 (CET)
Date: Thu, 29 Jan 2026 12:12:07 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Pratap Nirujogi <pratap.nirujogi@amd.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Dabros <jsd@semihalf.com>, Bin Du <bin.du@amd.com>
Subject: Re: [PATCH v1 1/1] i2c: designware: Remove dead code in AMD ISP case
Message-ID: <20260129111207.GU2275908@black.igk.intel.com>
References: <20260129103439.187478-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129103439.187478-1-andriy.shevchenko@linux.intel.com>

On Thu, Jan 29, 2026 at 11:34:38AM +0100, Andy Shevchenko wrote:
> The I²C bus shared with P-Unit is Intel only thing as far as I know.
> The AMD ISP driver has no relationship with P-Unit. Remove dead code
> that seems copied without much thinking.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Good catch!

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
