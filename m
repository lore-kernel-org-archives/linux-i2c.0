Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D6C29993E;
	Mon,  2 Feb 2026 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024137; cv=none; b=IVDMmtPQwpMW7BNPvvKYShrLHolq1dOSDTUSJoEgU2tNAR6SJ5ZLQQx6FUxUGd1O8Rx2uy4vzvOHKyVTQhyV2H6lwFA+/GyN/Qhrdgpk3UYHNy8YKE606ftnwJJ4A23vC+M/3kumTPx49le/F3yz9eeWIVXqFb6Lgr5QUMR6R+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024137; c=relaxed/simple;
	bh=1rijhdGc535LJR7vV6A/scmH7IVbyWnnFyGIoXnd6UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmnSNR3Bm+z/Y9+Fr0mGLo2cbi/Pm8rppz0/NquRxjm3cBbZovCnqtXWcSH9usT6wHogGlbsRsACrkGtYBGu/yGq2nsu6/QmnOIqWofH/4qb4tS+x6mH0MUDt8Vy/pUwI1rcLuvdM68ai+QndWXNG//7AQcYIEAdkhkhkzA5bZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyoJ3p8I; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyoJ3p8I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770024136; x=1801560136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1rijhdGc535LJR7vV6A/scmH7IVbyWnnFyGIoXnd6UE=;
  b=hyoJ3p8IuujKfoguUg7JwGaSxZ9alN+znw99OKLiE++y6cB5sLIncRNl
   iFnz0kMP9MRb42azJL8OuWDNhoWRcHTLuE6HQ3E4RZKW5XizNKKlaRCaJ
   S1+/YR+DJKeU1I3mA0Bzcl0C+GObZOsRip7w2qPCQ5r4ADijRCk1flM5t
   uX8swYUdNMEuFlWC9JI9iV8phiCpT/+3Xd9rS7RwU/ZbmZ/wab2kq8vvi
   /IC11VZfAX5QtszV1tONrPdOKCGDHD2WrWNmCj9iukmw7Sab5lYC3HO8t
   ztA99db4iE15jN6d8vQBo3mIqaSyAuNEP9e1xFEoyTPZCu/EIgfqQnYDb
   g==;
X-CSE-ConnectionGUID: dO4UAq9JSZG8cGvgQ3Lq5w==
X-CSE-MsgGUID: 9Uv1zKVKTlu7BPh6TMtf5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="96637382"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="96637382"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 01:22:15 -0800
X-CSE-ConnectionGUID: u9xe2R0RRD2e6dVZW+wnqA==
X-CSE-MsgGUID: Tdb45PvXQPCkT4nc+jWwkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="247076851"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 02 Feb 2026 01:22:13 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 59D1195; Mon, 02 Feb 2026 10:22:12 +0100 (CET)
Date: Mon, 2 Feb 2026 10:22:12 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: andi.shyti@kernel.org, p.zabel@pengutronix.de,
	andriy.shevchenko@linux.intel.com, jsd@semihalf.com,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] i2c: designware-platdrv: fix cleanup on probe
 failure
Message-ID: <20260202092212.GA2275908@black.igk.intel.com>
References: <20260130111039.874548-1-a.shimko.dev@gmail.com>
 <20260130111039.874548-3-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260130111039.874548-3-a.shimko.dev@gmail.com>

On Fri, Jan 30, 2026 at 02:10:37PM +0300, Artem Shimko wrote:
> Simplify the error handling in dw_i2c_plat_probe() by consolidating
> cleanup operations directly in the error path instead of using a
> goto label.
> 
> This eliminates the goto statement, makes the error handling more
> transparent, and reduces code indirection while maintaining identical
> cleanup behavior on probe failure.
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
