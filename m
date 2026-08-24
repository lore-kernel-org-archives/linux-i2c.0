Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B72DC792;
	Mon, 24 Aug 2026 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583609; cv=none; b=d3y0md3uKLvLwtFgw5dXLJSGGOeWsIDdGAym64mH0wmlZ9dG/QSB4VK1/f75Tvb3uUoeFhJVqWf13eTP9HJU6S3UphbOohAGlCVhsaCgfSlp3MvV1wbPbW3MvGDNUTpPqcASNuAqtWzQviS2VrGr8Fy25OgKRJKwydtxpyJE8JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583609; c=relaxed/simple;
	bh=zcW0ALYvjrfiDIXSsozF1jyvZ03s8p0N8eHkyyeNoy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRDn68q758wjNvR6rb2/dOfOcn8stoxEVD3IoJya4YOtjE4r+w6HJYRmG7jJKatO4hwBHOkzvBSSGIhT9eDXme5YPahRW8ugVuTLZKqJqCrc6tyVSyj1bO/zneEIx/BrXRtld/AGjnb6Ab9QQUi+Sz5HgrfmVfTgGiD5ooM5jWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6rx5IJ5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6rx5IJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787583608; x=1819119608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zcW0ALYvjrfiDIXSsozF1jyvZ03s8p0N8eHkyyeNoy4=;
  b=A6rx5IJ5vyb5MY0vUd6skW62oRxxxmwzepySUBRCN0jm8K94+Z0EPfRT
   UoBW2idYQ2zBl2o/JFJmaoRWqnruRcgvRPu44aPX6ECl4QYqkcy0wGy+P
   1Bh2+M+ut0xM89ZiqdFuAQS758jgfvDxgyQBpRpPwKG/inJygdj5KFxRd
   uRDK0KKkuKCZEv93A0bqQIZ5wfCgzKITzzfhrQsw6n4D7czzUgga0tqEN
   uPHENlmswb0E0CxQLeo5w+01Fo++ywLSjrMOGAf8CXa0h2EJJowS9qjxh
   OZUCjchYmCSvGdXVQA6z2KX6m8TrfoyFtXqUgJJSemKHHPjzrgX95/WZ8
   g==;
X-CSE-ConnectionGUID: 9hnmKj2TQYi1aNLfIUwinA==
X-CSE-MsgGUID: 8ey2brs8T6+lZas5rsjCiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87803253"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87803253"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 08:00:08 -0700
X-CSE-ConnectionGUID: 37dAJ3oCT1+pKznGhe6Qgw==
X-CSE-MsgGUID: bVCo7nnmTeedzqOG/ABzKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="291863266"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 08:00:05 -0700
Date: Mon, 24 Aug 2026 18:00:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: xiaoyueyoqwq <xiaoyueyoqwq@gmail.com>, andi.shyti@kernel.org,
	westeri@kernel.org, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: acpi: Add DELL0A86 to
 i2c_acpi_force_100khz_device_ids
Message-ID: <aoxcc4tkTcgv5is_@ashevche-desk.local>
References: <63cb7f6e-27ab-43d8-adb5-d2f4acd57674@gmail.com>
 <20260823123310.188189-1-xiaoyueyoqwq@gmail.com>
 <20260824102221.GE893316@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824102221.GE893316@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 24, 2026 at 12:22:21PM +0200, Mika Westerberg wrote:
> +Andy

We need to convert the ID table to use C99 initialisers and drop the unused
driver_data. It may be done either before or after this change.

> On Sun, Aug 23, 2026 at 08:33:10PM +0800, xiaoyueyoqwq wrote:
> > The ELAN 04F3:3185 touchpad exposed as DELL0A86 on the Dell Inspiron
> > 13 5310 intermittently exhibits excessive smoothing when the I2C bus
> > runs at 400 kHz. During an affected period pointer movement becomes
> > severely sluggish and sticky for tens of seconds.
> > 
> > The ACPI firmware configures the touchpad bus for 400 kHz. Add DELL0A86
> > to i2c_acpi_force_100khz_device_ids so that the bus runs at 100 kHz, as
> > is already done for other touchpads exhibiting the same excessive
> > smoothing problem.
> > 
> > With the quirk applied, the kernel reports that the firmware requested
> > 400 kHz and that the bus is forced to 100 kHz. The problem did not recur
> > during extended heavy use, including an S4 hibernate/resume cycle.

Is here any bug report somewhere publicly made?

> > Assisted-by: Codex:ChatGPT-5.6-Sol
> > Assisted-by: OpenCode:Ox Alpha (x-preview-f-free)
> > Signed-off-by: xiaoyueyoqwq <xiaoyueyoqwq@gmail.com>
> 
> You should use your full name here.
> 
> Anyway looks good to me.
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Otherwise agree with Mika's judgement.

-- 
With Best Regards,
Andy Shevchenko


