Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061FA3EDAB3;
	Thu, 22 Jan 2026 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072403; cv=none; b=MtcwmbhHhYCkPTbjiU9Pv2WhT1//oGh2J5vrGbEU9K5udNJ1gVoY3iGhn7ZH2DyyLD9VhLZaSsZNRhwAsJ/tsmEp1oN61TTXjxsK7Q74N83mXDDY0WLjsdLXNFP5+ledAyQFd9SZJOyxziRqSZyn3TOn2RjAgmkrRhJShy+qFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072403; c=relaxed/simple;
	bh=LLmeG593shN9Q59lrWBA8eb94dOcapiaOJUE9SxHrzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYUhuV+s2kmBqBFZtJdJe8uF0eBpjtpHGk8DtJ3yKCENMaL1jgJFDddm7aES5GAqVkqCdwELf4h3vFrIRMwaYHvnWYCAOaxRTayNxYAXLnhYYP84bkzHkW4OX+J2gKYwBq92DRTa7o9HnDPA5uYPJvG7vROU+1wW3Eoa7iylHLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afhkUhsY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afhkUhsY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769072402; x=1800608402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LLmeG593shN9Q59lrWBA8eb94dOcapiaOJUE9SxHrzU=;
  b=afhkUhsYnrYcAPrmJHAVB+R+oMUs9C62Ycwu4Z70DytDhNSTsaD9GG4v
   fo3VX864ejgHQT7vLUIcHlpGjyHdF/PB2RgPdMe10cWLqEq+e03wTI37R
   zoDKx8zF8zclJwgE4YsGS1brxZriiygSk/m7KgOV4b5e45Nx17t5osNDS
   MWswWXdxHm0/b8CrYm05jQlGaa1NvBXFFBhXB8ydieJGtga7aOux245j/
   KdHwBByf21gT5OUml+8piCchiBb3p3gkj8/v90C+tasl7dflTIh6ljQqY
   cDyfZRrV5miTYdhuzbfdNzT7ykG8rpS7DU1qcKDnl6L33YUH5rIQvlxza
   w==;
X-CSE-ConnectionGUID: b+pzYs1kRDq1HelIfQAnbg==
X-CSE-MsgGUID: JY9EkDQHSkySoM2c7RJfCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70217605"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="70217605"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 01:00:02 -0800
X-CSE-ConnectionGUID: 6Ekd8WSKRaeslsOMQjP6Fw==
X-CSE-MsgGUID: 8n2W5K7cRAWIz2oBvoJ5TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="206741545"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 01:00:00 -0800
Date: Thu, 22 Jan 2026 10:59:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i2c: xiic: switch to generic device property
 accessors
Message-ID: <aXHnDXHfjEnKpRmg@smile.fi.intel.com>
References: <20260122-i2c-xiic-v2-0-134f5d743e8b@nexthop.ai>
 <20260122-i2c-xiic-v2-1-134f5d743e8b@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-i2c-xiic-v2-1-134f5d743e8b@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 08:32:31AM +0000, Abdurrahman Hussain via B4 Relay wrote:

> Use generic device property accessors.

...

> -	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
> +	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
>  	if (!i2c)
>  		return -ENOMEM;

This type of changes should go in a separate patch after this one.

...

>  	mutex_init(&i2c->lock);

Please, consider also switching this (in yet another separate patch) to
devm_mutex_init().

...

> -	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> -					xiic_process, IRQF_ONESHOT,
> -					pdev->name, i2c);
> +	ret = devm_request_threaded_irq(dev, irq, NULL, xiic_process,
> +					IRQF_ONESHOT, pdev->name, i2c);
>  
>  	if (ret < 0) {

> -		dev_err_probe(&pdev->dev, ret, "Cannot claim IRQ\n");
> +		dev_err_probe(dev, ret, "Cannot claim IRQ\n");
>  		goto err_pm_disable;

Before doing it, just kill the message, it is a dup since devm_request_*irq*()
already prints the similar one on the error cases.

>  	}

...

So, this patch should be transformed to three
- removing a dup message
- converting to device propries
- utilising the temporary 'dev' variable elsewhere

-- 
With Best Regards,
Andy Shevchenko


