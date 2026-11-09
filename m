Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227674;
	b=4JezMjzzYi7h48V4ifYAW50D1zTd1hdfiIriYkJmGXtvTmG3nC5z6a3grfR7AOHVc6P/
	 ktly5VPZ4MddqC3HrfeGAPiWGWdZ4nY4RKvmtCuSW2c8M7t7tZWbvIQIc2JMgji3JrquY
	 vKmNZUAYsP7taGeq5Rb/oE4RxUwr3cCGjFgYZBBjhHOzrk588tClWCy6P9t9yxcYQd0xF
	 v7RKF4BX33LxUJ6FNW2RHq+uzKRZ+eJbW1qp9po7+RbQtwTkAL5x6zNScXpluxTQfN3Ek
	 pbb2eUPnpg5GBkfpQgbJTAF3aIIIlhhnN1XzOP87cqZsVoq5+H3JhNHxWDI8PzST8cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227674;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=gt/3XOB68SSu53/G0Tef5w8/IHOUQEz+9XwgpJEET4I=;
	b=wnJ8CKC1iXgYtvfKqxoCImzALdmwr/x46DYXzLqOx9YC2qt4sV0bkPulq8NfpWHEe7mT
	 yJwXX6O6cSSJ3Y/HrSbn2n4qdJX5glwsfq/4fW4EiZjnw8wxVYGfvdLfs+1yYCzlxFiUs
	 8iV89Q65DP7GZJmTdyLHvNNQHj/RbWc0lnOuhos+IlZR8JYdnj+qZjQZ8AfvYxUcgDc6k
	 UedqXsismSWuNck8co7YBL8Jgp7uU5yk7+68IdBmVIIN1Oj6E4bWke/tbTOchjhzWTykY
	 KlFtvehjeHitpKxOTj1vkyBwnr1c2E4//6El/cicBxRqcmfXuVxurJzOK7uAXWwP+0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bZYnJIW7;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8B8606A334;
	Mon,  9 Nov 2026 12:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A8B8606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bZYnJIW7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794227675; x=1825763675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=usCKxZZR8RyJY+rSPMuZugBONggC3XR1NlE53FogDNg=;
  b=bZYnJIW7+3HCXKMgf2uY5GnXLCjcUCddsSjBqU5iFeLa2SFyfjBKVHzM
   ozX+/ZQ65L+Ziw7+JjwCZd8G1sVyDrqgBsPflJrH50Jw0mTPgj+YKsXal
   n6/84AUPho9CSkiwrpWgA6RRZgVkPpFEHgdRDtsniyW9Xcjw8UsnARyae
   86PaQ9LBfAbpRq3lrgfNaF4nsr/pR6ogOo/fSWLHUYEPLp2qN6Cq155hr
   +UXURp9Q0gnZnb73R2LOEY0/GxNl2IMIC6+F4jqQxBrP+19rflv4NT1sh
   7WCWRw9lN/Aa9/RthpihJqkwAvPOn/4w8Dbfi5MRQqP7w8N2BjTr5+yCg
   g==;
X-CSE-ConnectionGUID: jTet3CC9SAaq1Bwr6eZpHg==
X-CSE-MsgGUID: F+7cc2maSKaKOlwsmmsZCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2979790"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2979790"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 04:34:34 -0800
X-CSE-ConnectionGUID: 5YNLzSIdQk+scpqzXkS2Kw==
X-CSE-MsgGUID: HUpK+atSRuq0gKDikhBrxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8186273"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 04:34:31 -0800
Date: Mon, 9 Nov 2026 14:34:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Allen Pais <apais@microsoft.com>,
	"rlmenge@gmail.com" <rlmenge@gmail.com>,
	"hargar@linux.microsoft.com" <hargar@linux.microsoft.com>,
	Jeff Kirsher <jeff.kirsher@microsoft.com>
Subject: Re: [EXTERNAL] [PATCH v1 1/1] i2c: designware: Add ACPI ID MSFT0006
 for Microsoft Cobalt SoCs
Message-ID: <avG91GDyffzeuBVg@ashevche-desk.local>
References: <20261104234928.86458-1-sidchintamaneni@gmail.com>
 <DS1PR21MB4279C556CFB876C5562C7F1182772@DS1PR21MB4279.namprd21.prod.outlook.com>
 <b660d79f-887e-4594-ba76-c45dc5f75435@linux.microsoft.com>
 <CAE5sdEhozq5SVj-SJLndiaANx1N_sTiAMBD0zeA_aafUYAGOKw@mail.gmail.com>
 <CAE5sdEi9iOwEmuhzWZ=O5u30UVCbCerckhggBqEY9qU5jBce4A@mail.gmail.com>
 <avBSrChTZTQL2rNj@shikoro>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avBSrChTZTQL2rNj@shikoro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 08, 2026 at 11:45:00AM +0100, Wolfram Sang wrote:
> 
> > For Cobalt, the firmware exposes the designware input clock frequency
> > through the ACPI HCLK object.
> > Is there an existing way to retrieve or configure this clock frequency
> > through the ACPI tables, rather than hardcoding it in the driver?
> 
> Calling for Andy here for being the designware + ACPI expert.

We don't have the common way, it's unspecified. However, many drivers and some
firmwares adopted the "clock-frequency" property. Unfortunately for I2C it means
the clock of the bus, and not functional clock of the controller. So, I'm
afraid you will need to have your own custom solution. Also makes sense to look
what ARM people do in the same situtions (I know that Qualcomm tries hard to
enable ACPI on laptops, if I was you, I would ask them first).

-- 
With Best Regards,
Andy Shevchenko


