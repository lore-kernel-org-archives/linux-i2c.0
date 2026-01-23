Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862971F1518;
	Fri, 23 Jan 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177427; cv=none; b=GWt62VMEvTRlCcPqyJxX3gNY9FCP7X3pKnmYMTGaDfoXzy8ywZ5cBoe2y1Os0UX8BWrzxXcKkYDKAZW2DwozZbFCoNQ4h/zqEoBB5DECUR8DKuUleIefIDqBGAaGHsr8TfPrAaFv94czmCGdI6bOy1IBCMHyovJCLH0FIYnKIOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177427; c=relaxed/simple;
	bh=h+/Z9Yes6ScdNolaLLAflTQSgtOpNvBxXOIhcFp/PcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+IFEdqfjZjHifDNfoLt0OSI+8l0bofQ1KlUnlF20ZsCeVTcEvXfFTE1KOBAcEtTKaTnCeHpODki+ylhKCKbOb9tq7l1WfcGGBVDBkEckV3IYyKWE9JWEMThVKdh/HA9GiwiNv1072MZKLl+kJjy1rLw4tWN1zcaxLkSYgwCFGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mb0pc29U; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mb0pc29U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769177426; x=1800713426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=h+/Z9Yes6ScdNolaLLAflTQSgtOpNvBxXOIhcFp/PcY=;
  b=mb0pc29UNZ683r8nTBy1ZbYT01EcXgnhvP542NSHvQE3eZIIbu7b9o+j
   ZAw3+ZTpHSQ4ppJyrohG260LFDltTJ5dlxfEPAAZo0BdBPy/3LiUs1l1i
   mhspElUjBAXg3ljDmmSmZ3UeB3ewIzi2crhyLijrEj9SviyEVHyU81jWk
   S6F6Rd/kBTf3M1i6kyUPq3CFrNSiIapoV3zWu7H+z4kJgC04VZD25VJQy
   DRsLE3X3cMhnTkpB4DnEDJzaA1GEaEtacPMKYbQBNsEVQWRd+rxKLHbk6
   F6ELsmBh5xfMduD3XA7ti77MJhtBU57VDOpm/nRvmxlCNm1pOneRcE+pt
   g==;
X-CSE-ConnectionGUID: CzGTdHRLQFScvt0hnBh3DA==
X-CSE-MsgGUID: T7rIxCdrT/CBRfWqR7SQDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70481600"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70481600"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:10:25 -0800
X-CSE-ConnectionGUID: W3wRB1YNRG+nF2gpf/WUGw==
X-CSE-MsgGUID: H3SsJvxIS5muJ5VMninPkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="244641358"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:10:23 -0800
Date: Fri, 23 Jan 2026 16:10:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: andi.shyti@kernel.org, p.zabel@pengutronix.de,
	mika.westerberg@linux.intel.com, jsd@semihalf.com,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] i2c: designware-platdrv: simplify reset control
 and error handling
Message-ID: <aXOBTME6GOiiSowD@smile.fi.intel.com>
References: <20260123100537.1429497-1-a.shimko.dev@gmail.com>
 <aXNXx4elBVRpWCWf@smile.fi.intel.com>
 <aXNYBahiKTnVkRfg@smile.fi.intel.com>
 <CAOPX746Fo4VP9tCTz+T42Uhy_LnbmNNSx8MtMJbRh41YtfHhpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOPX746Fo4VP9tCTz+T42Uhy_LnbmNNSx8MtMJbRh41YtfHhpw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 02:35:44PM +0300, Artem Shimko wrote:
> On Fri, Jan 23, 2026 at 2:14 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On top of that, this is marked as v5, where the changelog for all previous
> > iterations?
> 
> Got it, yeah... Thanks!
> 
> Could you please advise, should I send it again with changelog as v6?

Wait a bit (24h + ) for others to have a chance to comment.

-- 
With Best Regards,
Andy Shevchenko


