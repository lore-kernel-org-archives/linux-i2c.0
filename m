Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D8377A97;
	Thu, 13 Aug 2026 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607218; cv=none; b=Jnd4EZLgTJ/9UXqcw4VKAgUqgo3EzJ6hoSGoQ23wNv3mk6ySZZqQWtZayo4s2AUnQ62uSBZ41drvm+zeK4spPIhFm0lSnhhKVdWCWmATENcaDHvn35ChwAepkPICvP0E9kn8isc8k5UnutgC7q/M0slb92kyCg7tiKFIDIUOjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607218; c=relaxed/simple;
	bh=7TJvnSQdzhgDLoRvXwUcs2eorXeI5JZica+Ckitf+tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNLPdFszEOU3o2qD2SLMR2fYUIubnvh3ISWzcZtG4v5gMbRu/NB6g3PYIRhJHEyEWIVXZCMnytuVPXDBn8CeE9E/BDYoyNYvBTN6HrLaJpBxYRtY9ie2FEqLwQkPB/MuqFxrDrfiYsjmUKlvhq+bcLAdmf+s2I0DkXn5LYjb6eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=II1/4kNu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="II1/4kNu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786607215; x=1818143215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7TJvnSQdzhgDLoRvXwUcs2eorXeI5JZica+Ckitf+tA=;
  b=II1/4kNuVE2GFYtuFLGn14LDlQ4mzCpFBQEXoYaPahHu4QpwQSOE4JpM
   V2fTL1EdC6PSpgsTjBYRFmgNNrxLLg42bK/wW+C1QZRvZ3tBXaTODz2YX
   CPm+owUoxpIvjtw3rsXWzw9JVgHAFYHBG8KHKnf85x6r8Gfvj3WgXllY1
   2Lv/RWYVwZzhirQ9GTRmDECKkNiHSUyLcbf+bpuIVI29LcdIPF+H3Cq8P
   ygyKZY1Zrmiz/TmZPS6O9cSDYcfC7wfDoybLv48Fye/ojDvTM30qLj6PX
   zm6jF8RRgzjkUXU2JDv1xbzye4Fj0hOqjpy68KJZKTmMW8ZTM1WhCJqlF
   Q==;
X-CSE-ConnectionGUID: 2BN90jVyS1i3cO60Snautg==
X-CSE-MsgGUID: 7HgrC++6RDuvjm/TGclKlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87195232"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87195232"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 00:46:55 -0700
X-CSE-ConnectionGUID: 6ObqZuvbSQ2q8HMZupjilw==
X-CSE-MsgGUID: aIVPM+XxSgqcNdeLddoSvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="257647129"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 00:46:52 -0700
Date: Thu, 13 Aug 2026 10:46:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "clarke.li" <clarke.li@hj-micro.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, andy.xu@hj-micro.com,
	peter.du@hj-micro.com
Subject: Re: [PATCH v4 2/2] ACPI: APD: Add clock frequency for HJMC01 I2C
 controller
Message-ID: <an12ahIltvJdt8XK@ashevche-desk.local>
References: <20260813063005.42925-1-clarke.li@hj-micro.com>
 <20260813064025.45242-1-clarke.li@hj-micro.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813064025.45242-1-clarke.li@hj-micro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 02:40:25PM +0800, clarke.li wrote:

> I2C clock frequency for HJMC01 is 200MHz, define a new ACPI
> HID for it.

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +	{ "HJMC3001", APD_ADDR(hjmc_i2c_desc) },

Vendor is in the official registry and ID is real, thanks for that!

-- 
With Best Regards,
Andy Shevchenko


