Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344820;
	b=gi2tEVPNRJ4XdoIzgpeYcde/g3AsTEs3jspGPXWPEvRcZF8ZdTX/KSTe0RQOEtjQxmsw
	 t6flUU3ioEjPapY+gvRbO80S73q7CO/X2CNQw0pCDu95ax1gdn3KOjXiFgoKqjYKDcY+2
	 jIrYoVWaLC5rMRrLC0H/wWo8GXluow7O+bnt1qq16sUz1Q44wF44NVglBSiSMYNo9v1VL
	 WFjFKPRjxb7HS2gJ7aHpTjL59Q0ujMKVcuWEa8zmZtcKtAvHTNosf6URvvyIVJYedJofK
	 hJN54j4fT7jJuD7IDGDDbqZ/F6pNJ+gZTOWAJRlSmgjEX70hsb53XnP9Wi9nD/DUYbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344820;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=DpnP2Mak7ClK0iGLIA+5g0n2afYfskurGZa8VAsvA5Q=;
	b=LQ0UKkoj3ctGT6BG5y1218JDbTuV15a8UpVrWrR+zLTILsI94m0Fjk/uaFHI3VSFYNMP
	 lZ1T3a7Or5aEBaaRStIrIMAM7P8G0/5LOm6PnKv6rXFFKnlv2U6fqznP8jQbrm3hlNEr/
	 XppU8PrZYCcKn6CdAnhZUd4Yyhl2jm2s07aVPUGPU1VGl4ISlCbejyojb5Kk/AObidM/r
	 b28DVw8htTlOCQVf9C4xaPDSKxO4bv36d8D9xWXozvF8XKGlXC0Fnv0znKYW7Til2EXYR
	 potTftiuXU/btGHCnTBxqz5dsu0BjV9FYuskKpsMaRGYLFYxthLOBCCbSV6eta7ZsLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wx6NcXCp;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6F5606A320;
	Tue, 10 Nov 2026 21:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E6F5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wx6NcXCp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794344819; x=1825880819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VepGlO4JaVIwZk/LYRXN0gv6O3En9kw6cam+UtiCf4Y=;
  b=Wx6NcXCpkjSGnKK2eLLpzDP9XoMcTKRPsVHJh3/yyonHj16GDln2UL5j
   MxgNub0hey1JaHxJ/zAQkidqzSyYQIxxq5LdD9V92k5EZgpnru2z4+Rbw
   6c8WDer25uKfUfVhF0k127Zo2lgoGnlH+vThSKmEJS2Yqi1GURiRfb9QQ
   EBBakHpchH449eNv/CSeD6dSBlwiYGPNkbEDPRaerpMcN6ObKjMJ9HSB3
   2nL1mmw6RCu3M0y0oe1gSdI82YZGfKGNkHlahELWLRmcgeu+SmEFGf5yA
   B+qO5zHwgcf6Q2Us3tcsfpJJX8q8Zv+7w69VPIjcvYASbbvqqeH4OouGt
   Q==;
X-CSE-ConnectionGUID: ON0iHAdwS8KalNUj+UqLvQ==
X-CSE-MsgGUID: H7HFSmKhRjqxTOewE9brjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3004963"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3004963"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 13:06:11 -0800
X-CSE-ConnectionGUID: ylWqEV9DSp62yHh3wXL4qg==
X-CSE-MsgGUID: i0cp5d5LStKfGbjkkOZj0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8341426"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 13:05:22 -0800
Date: Tue, 10 Nov 2026 23:05:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	apais@microsoft.com, rlmenge@gmail.com, hargar@linux.microsoft.com,
	Jarred White <jarredwhite@linux.microsoft.com>,
	Jeff Kirsher <jeff.kirsher@microsoft.com>
Subject: Re: [PATCH v2 1/1] i2c: designware: Add ACPI ID MSFT0006 for
 Microsoft Cobalt SoCs
Message-ID: <avOHEJxZG49tICa8@ashevche-desk.local>
References: <20261109210146.57766-1-sidchintamaneni@gmail.com>
 <avI7g14oGpFKlJnV@ashevche-desk.local>
 <CAE5sdEg3VKZuGqpt1Sm22Dsuh8HUFi-9w2GWEAicALS4ECXQ_A@mail.gmail.com>
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
In-Reply-To: <CAE5sdEg3VKZuGqpt1Sm22Dsuh8HUFi-9w2GWEAicALS4ECXQ_A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 12:15:10PM -0800, Siddharth Chintamaneni wrote:
> On Mon, 9 Nov 2026 at 13:30, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Nov 09, 2026 at 09:01:46PM +0000, Siddharth Chintamaneni wrote:
> > > Add the MSFT0006 ACPI ID for the DesignWare I2C controller integrated
> > > on Microsoft Cobalt SoCs, along with its 300 MHz input clock description
> > > in acpi_apd.c.
> > >
> > > Without an explicit MSFT0006 entry, ACPI device matching falls back to
> > > its _CID (APMC0D0F), which configures a 100 MHz input clock instead of
> > > the controller's actual 300 MHz clock.
> > >
> > > Acked-by: Jarred White <jarredwhite@linux.microsoft.com>
> > > Acked-by: Jeff Kirsher <jeff.kirsher@microsoft.com>
> > > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> > > ---
> >
> > Where is the changelog?
> 
> Oh I just dropped cc tags.
> 
> > Haven't I given a tag already?
> 
> no, I thought you were suggesting that I repost it.

Okay, it's fine to me
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


