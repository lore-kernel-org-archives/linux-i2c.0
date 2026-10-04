Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F393382CB;
	Sun,  4 Oct 2026 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791101548; cv=none; b=ri9IHEr5IsHpPOuiBn51oIzbEAlxMoNWZ4SAwHTM43EbSUmPTnqF/Pg3ArrZ/iYGGMyxLVgdPmX08Xt/5DgFw3iHy6TIWpIdxIWJhIAz+pcqpSckGyPt3p3CLhiIo+47goZ/0ykOMBWnY4mg/0oAG9KB2k/PJQqXJGOxK0F1mic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791101548; c=relaxed/simple;
	bh=u67W7iMb8JZcEskbfVpFm/cWflSyLMOArT25Sy8oa58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8ApxObg4z+J316+23dt4B8vnNvuRpgflyJ/W/HnAqfOvmXt1no+xcaZWtMGyiLZDDAX9PxtRLLf+0iEl5ak0pZ0GqQX6JZFCxfkMxgyagUmYTw0OsbkRYZ5QxlTWxch3Y48odwHqy8Qv8ktGCZGUh4pk9170AYmvSHTdtdUDoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaWCHoTD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaWCHoTD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791101546; x=1822637546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u67W7iMb8JZcEskbfVpFm/cWflSyLMOArT25Sy8oa58=;
  b=XaWCHoTDdlCli3y2xfwX0dyanBOeDhzUlk8Vi19wMY8M9kZ4stSkI7MU
   w6KXLoubIhexFYGX2JsUkcdP4Jp2aaXWVeJZS8M/V88/EFl/17TLnflbI
   sEWifRw3y6hdAS2fPq/n659/G/JJ40xKQeGUwfJJsQFvgZ9Xk65nhaEoy
   bJP3fjQWbOGcn7PvxaQh5gKA32cUCB9BGRueX2KSGJF49IiD9l7bEH80O
   LH1eJhL6348bz9VB0iJ3RhGTau0tLzaIrwGyHAasQhHH6gLo9FKRHJCLB
   r6k1FE27yLfoWO7vc3kyJKQoj3bqU4dIYF94fm+drcddDtSFe2k07Uyrk
   Q==;
X-CSE-ConnectionGUID: kebhoXxcSYyC4GId7wQb6w==
X-CSE-MsgGUID: AYnz07fXRhy5kZQ0mj2S2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="91010762"
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="91010762"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 01:12:26 -0700
X-CSE-ConnectionGUID: 3z7otWumSpqCKtsTq+BL8A==
X-CSE-MsgGUID: YEXWkMo0SSiVuMdO25dRzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="570261"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 01:12:24 -0700
Date: Sun, 4 Oct 2026 11:12:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Navon John Lukose <navonjohnlukose@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: size the RX FIFO threshold to the
 queued transfer
Message-ID: <asIKZluOk2ocK_mw@ashevche-desk.local>
References: <20260919232647.448748-1-navonjohnlukose@gmail.com>
 <20261003223659.13974-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003223659.13974-1-navonjohnlukose@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 04, 2026 at 04:06:59AM +0530, Navon John Lukose wrote:

> Patchwork has had this as Changes Requested since 2026-09-29, but I
> don't see a request on the list. What should change?

I think you might need to adjust the commit message (and pick Mika's tag).
My concern was the oddity behind /dev/cpu_dma_latency: Does the commit
message suggest to set it like this (then it's no go)? Or does it state
the fact that CPU power states affect the latency (then it should be
clarified)? Or something else behind that?

-- 
With Best Regards,
Andy Shevchenko


