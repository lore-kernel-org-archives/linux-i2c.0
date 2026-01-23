Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932A03033C9;
	Fri, 23 Jan 2026 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157223; cv=none; b=HRj0iOGOIkUttj59RhSWINUTqjQX/eRqRdolx88JwdYrSTwCoOckltGJVUXrVu02TI7jZAsQz9enEwzZxWnY9Ro6/89Jfq4bsTTYMRYKtGVxHscYk/RyL1dVzSVHLH45JydzQKO8Sdq9H86mKC3brZkDkyycvnukJ40vh4bC/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157223; c=relaxed/simple;
	bh=gk1j60etFb/57nufBO2p6AnquY9wEDbuevPIlPtzTqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IL6buOEcQM/6TIo++ZJQ5kzR5EIjG5Buy6rchVu+HQ1bAiIKuuMS5XBXvx7wpsv2EOdBU4ANrcZe/nZyhPr6UR0N8DDvJIEPW8tdubKfbRyB7bfYO0YJsftu5wFquvauNxVk8RfcKsKwqLXaPTqvcqc57Tph4z/LeqfzQ4AZ1KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oB4pa1Hd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oB4pa1Hd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769157222; x=1800693222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gk1j60etFb/57nufBO2p6AnquY9wEDbuevPIlPtzTqc=;
  b=oB4pa1HdHSbNucYeT+gzZIRFBLJ2fLt4xoQqEECKoka5zPag/Ce7RdqH
   H5eXT8w28gKfqvwN+p136dHGiMs8x09Ch1LHp+VLSwarwn8RvmeBKDnbl
   loOR0rdlf6mW3rCs3K5QixtCjzrIHByK8D+AZrXIYwsEb2QU9+Io3Bidi
   i3vExCv9deGzyuJAAayuDgl8wXowLEmabx5inqnrACGea3VEgWM/uU6W9
   mMB5DwXDFz8A79zD9v2cHf+aNZVWVIhl6reP1KdChZoWgHz59fEWCRTSX
   vXq1ZpZbY3o34LcunHzjI5gzHkx5X+imB6+N7Zfk/i+fanc8J7HqfYPZO
   A==;
X-CSE-ConnectionGUID: lZ4I+qdrTuOnPAWIsPBizA==
X-CSE-MsgGUID: rgOQ8ExiSOWyKWn1CCe6jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="72996509"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="72996509"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:33:41 -0800
X-CSE-ConnectionGUID: HZ+78Hg8Qxq7puLNJ7VPkg==
X-CSE-MsgGUID: hGbVgeckSw6zw8C9ak/SZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="206876189"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:33:39 -0800
Date: Fri, 23 Jan 2026 10:33:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] i2c: xiic: switch to generic device property
 accessors
Message-ID: <aXMyYbDVZjS4aFA2@smile.fi.intel.com>
References: <20260123-i2c-xiic-v3-0-eb7cd4254dfb@nexthop.ai>
 <20260123-i2c-xiic-v3-4-eb7cd4254dfb@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-i2c-xiic-v3-4-eb7cd4254dfb@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 08:02:47AM +0000, Abdurrahman Hussain via B4 Relay wrote:

> Use generic device property accessors.

...

> +	data = device_get_match_data(&pdev->dev);

Should use 'dev'.

> +	if (data)
>  		i2c->quirks = data->quirks;

...

> +	device_set_node(&i2c->adap.dev, dev_fwnode(&pdev->dev));

Ditto.

> +	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
> +				       &i2c->i2c_clk);

Ditto and it will be a single line, I think.

	ret = device_property_read_u32(dev, "clock-frequency", &i2c->i2c_clk);

(yep, only 78 characters).

...

> -		of_property_read_bool(pdev->dev.of_node, "single-master");
> +		device_property_read_bool(&pdev->dev, "single-master");

Use 'dev'.

-- 
With Best Regards,
Andy Shevchenko


