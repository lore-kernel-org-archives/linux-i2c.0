Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123183B9608;
	Tue,  3 Feb 2026 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133362; cv=none; b=hr4jNW7SBUWjgX9rjbfMIT6vJbPHblbjupzRzBYIiZgNptSMJS04V/XML4SBUvqgbAI5ibQcsy+O+QtEb2WmZThZcAbFy2sv9ledcYPF9UjvOM9NHKYzRMcbwEVxMoWl6aq/eiJ5/DCgPOzKmMLHK4xqCXI337w04WAPOMBNgq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133362; c=relaxed/simple;
	bh=Y8zb4k44kGjEq4eI7aYH/3XMRYBq7D6e7FdgxUk7G90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1bOcHr69QonPwLf3Zm11sYOYypw6KYzEyyiLsXrn+aK0zEAvqJoX2RVtjTJEDkQx9huFntwXshdol0hlYLWdUREXC+qqZDun62ww8YDkPl5A4qc3TpcPNyBidh9jfQoTMBNyURvlClY9ajogGiWGEoDqGUuB23SAWGkeFn5ssI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5sWepFZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5sWepFZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770133360; x=1801669360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y8zb4k44kGjEq4eI7aYH/3XMRYBq7D6e7FdgxUk7G90=;
  b=M5sWepFZ9Et1jnaabSWhWo/5L/o93MEASZVCUZ9KXqw/Go9NRhgpWtFP
   dyLFEe1i8xAkLE7nXvw9yk5y8RHLJyZjO1Yafr7FunozyBfv0kG6z0uzx
   eAw1vPctZHr4HyHQ9LbwvNlPIN/xDLrMbrWH2UO4maaQW8NPACYU599W/
   4hZo3epAfcIALEFFg9PDHzcI9GbxD6fZi2EtgEZBSoFH1GFYxf1h70Mdn
   5y1nIiH2RMLxF6Jgi+Qg2gMU/IaYfNyrYLbNAsof8ceFdyZ7J3HCC5a8U
   BgWjSdj8r5OJtvG9XK5mmzpIXlX3PLH+Qjxs7nrcFtjMLrH0+UxtQqQn1
   A==;
X-CSE-ConnectionGUID: MLoUhO7BQJqXUCe6LSi9VA==
X-CSE-MsgGUID: pewmyjkpR2SqJv6l9cYgnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71387302"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71387302"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:42:39 -0800
X-CSE-ConnectionGUID: mHT7rsieSUCLxrs6Z6Ezrg==
X-CSE-MsgGUID: wduoLYv6SV6BaZHjoZz6DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="214413257"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:42:37 -0800
Date: Tue, 3 Feb 2026 17:42:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 4/7] i2c: xiic: cosmetic cleanup
Message-ID: <aYIXagCXYb4DrDLp@smile.fi.intel.com>
References: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
 <20260202-i2c-xiic-v9-4-ce4695f5267d@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202-i2c-xiic-v9-4-ce4695f5267d@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 02, 2026 at 08:37:21PM +0000, Abdurrahman Hussain via B4 Relay wrote:

> Re-use dev pointer instead of referencing &pdev->dev everywhere.

...

> -	dev_dbg(&pdev->dev, "mmio %08lx irq %d scl clock frequency %d\n",
> +	dev_dbg(dev, "mmio %08lx irq %d scl clock frequency %d\n",
>  		(unsigned long)res->start, irq, i2c->i2c_clk);

No need to do this here as we change the format string afterwards anyway.

But I leave it up to Andi, I won't prevent this to go in, if he agrees.

-- 
With Best Regards,
Andy Shevchenko


