Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45933F9F3A;
	Wed, 17 Jun 2026 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701332; cv=none; b=P+15NnxLZW1ghbie1oRC2QWS6YgGEA1d8cfC4xyI2nu5TGKqljZoHM2GBZ8pbixryg0PJISHUmj7y2PNw1BWNc8zdzrL9E7EemrhoIZmIRC3ngwLCYMwjHC9cKEQiqN8Wy8j+nR8PTWZ2HzzfG4PljVYaFJTJL10qcCzl5sYilk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701332; c=relaxed/simple;
	bh=5/2zXFvzXzSV2yBrDo/OteVabvktH67LlJ0Yv4vQA7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxG38uPOPfX/2bYCsryr5hM+GzHZYBc4PIUmJfJqXBRmXt3qGeZMWip1THEedQMFhIAHkV7F/BKN7qslVU8t2lVpQXOnuPhWRjXRmKnItI/+feJ+mOEyqi2orEXJ3nlst6TzxFrV77HxEBuE5eX/yjtEaKbpx+pBrlDXYWB2eiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXnZ0YCV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXnZ0YCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781701331; x=1813237331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5/2zXFvzXzSV2yBrDo/OteVabvktH67LlJ0Yv4vQA7g=;
  b=eXnZ0YCVOUkUa0k74hZf7fkLilEzXoLxCbDKdsFuTe7rno2EQefXOA7T
   UZBFmE8i5tK5y+YMlIMZmo16rnX7wjI6j5LJgVaamDNwP3XPJc5Gufe5s
   C/dI42EOppIlZSE7FUsfQB4T0ydZT/qKFer/WKlart5bpiH73P6fI0EDi
   vPCPJR6tJ27zlmCyhp70oDI3Q1vBxmmoRemS/hJmReJQIB7VeQtKtbDPo
   qqQOHFKr/7HsZOFao1PGvkIiVFKpQpY5zHmnpGY6zcSXUnCsvbGyAhs8A
   dweF9BLWesrFYmU9cz6fXq9acT0hRLUYfraToXYh7VV+npY7GZNAip71i
   Q==;
X-CSE-ConnectionGUID: IqslTSK5QKeEGfvBhj6CMw==
X-CSE-MsgGUID: OvJ8pjv8S065su0PJQ6ufg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="99905641"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="99905641"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 06:02:11 -0700
X-CSE-ConnectionGUID: QR25O72kQs+YgoIn4EcgJw==
X-CSE-MsgGUID: LAwX1i+fRMqCNSJ77hjTww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="243901616"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 17 Jun 2026 06:02:08 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 84CA795; Wed, 17 Jun 2026 15:02:07 +0200 (CEST)
Date: Wed, 17 Jun 2026 15:02:07 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	hardikprakash.official@gmail.com
Subject: Re: [PATCH v1 1/1] i2c: acpi: Free resource list at appropriate time
Message-ID: <20260617130207.GH2990@black.igk.intel.com>
References: <20260617092046.2649219-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617092046.2649219-1-andriy.shevchenko@linux.intel.com>

On Wed, Jun 17, 2026 at 11:20:46AM +0200, Andy Shevchenko wrote:
> We do unneeded "double free" (emptying an empty list) in one case.
> At the same time we shadow a real error code. Address them by
> refactoring the code in question.
> 
> Both are not critical issues at all, they just make code robust
> against any possible future changes in the flow.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
