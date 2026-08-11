Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727A3442FB6;
	Tue, 11 Aug 2026 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458981; cv=none; b=jHDHyPTQyTW+WZtyTaSYILwEbil18L//H+htfijxtrqxF0c7tslBQdU+llAkgR8AKfOQeiJaybJBtPf4HKOsKGKkqztogZ93dNoz2yVXMmGN785FxQlZJpzTbQPmrg6hYybm6FUzl0QCuWU3t9rW2dYuw2ZyybIKWJJUki8zkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458981; c=relaxed/simple;
	bh=stvGy0a6DnjjtudB4LekJRbsww1XodWJSsNYx9IC76Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hInfK8wTokPjytf8pO0FW+91cBUvhHDJ78hkQv9h11LDLMPRePBgaCnckKGM1ba+9JoD6Cfi3ZE8Yu5kYpWxlNfb35G9nfkeoHXtMUoqcFIuxDuJx52qzDhFqkMIGltAx8dFS8U7qMbTdS1ij/CMRpOCZ3+5R0vQzYfZ2enNS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hdH5JE2c; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hdH5JE2c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786458978; x=1817994978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=stvGy0a6DnjjtudB4LekJRbsww1XodWJSsNYx9IC76Q=;
  b=hdH5JE2cGAzaHuFVzCyx3ltHZeLP61xhrxJZr6USYb3xpSiNnpgGETkD
   A+Iu7YegesqTY7PJC4vLKL8K+4ASmX/aFUWPPMXtSVPIOzY4OXdDzQMR/
   VGp/BHJAeTZUYjEhbvKVENTngT/+O+O5h2NnSgTaXCRFh8RxU8wp+od3I
   MpV57ONVTfwEzXHo7WejDLSjeZOyvcxmLlrMp+o7xzuWtCXw3fj2Z7PKf
   FunKAGVO/xWGLvXrQzMUNPOaEVEDclmgkk6XfE3bG7BVOeonX7AxUo/0n
   qs4jze2JXi0CfdBg75Lfn1bTYTnrlzTonY3MoSteCY57RlaVPH3J9Ua04
   Q==;
X-CSE-ConnectionGUID: umxRVt5vTO+a4KmtyhcCbA==
X-CSE-MsgGUID: SDPu1WSGRVy3MtcnV9KHQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="98138635"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="98138635"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 07:36:18 -0700
X-CSE-ConnectionGUID: 5607S1XxRr60dgzaTUkAqw==
X-CSE-MsgGUID: JJ1oDp2BTKe3PobNr/tAIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="265360506"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 07:36:16 -0700
Date: Tue, 11 Aug 2026 17:36:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linkai Gong <gonglinkai@kylinos.cn>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: atr: fix dangling adapter pointer on add failure
Message-ID: <anszXdhlAJk7p7ts@ashevche-desk.local>
References: <20260806073545.2071006-1-gonglinkai@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806073545.2071006-1-gonglinkai@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 06, 2026 at 03:35:45PM +0800, Linkai Gong wrote:
> i2c_atr_add_adapter() stores atr->adapter[chan_id] before
> i2c_add_adapter() so that the I2C bus notifier can match child clients
> during registration. On failure the channel is freed but the slot was
> left pointing at freed memory, which can lead to use-after-free in
> i2c_atr_del_adapter() / cleanup and also block reuse with -EEXIST.
> 
> Clear the slot on the i2c_add_adapter() error path before freeing chan.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  	if (ret) {
>  		dev_err(dev, "failed to add atr-adapter %u (error=%d)\n",
>  			chan_id, ret);
> +		atr->adapter[chan_id] = NULL;

It's better to NULLify first and print after. This will reduce the window of
possible calls with the stale pointer.

>  		goto err_free_alias_pool;
>  	}

-- 
With Best Regards,
Andy Shevchenko


