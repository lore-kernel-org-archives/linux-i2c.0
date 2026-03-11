Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320633CEBBD;
	Wed, 11 Mar 2026 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231062; cv=none; b=AYs6bsJFGDMaHLcFL8waoEmXipDa8KNHZFcBnwTvEgF/NRguPb4s2Y1TIOM3M8qlbwXlPpIfttVz74WYDgSBh1c6TnV4LDqor9RXP7Ha/bDnEHdMWZE/c6PDYnTcBs/982FjbtBIXhEFvM7H/srem0FWZANzponD+8PIS9fytus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231062; c=relaxed/simple;
	bh=WLYb8tqFihrgnuTWDWW3WBcYcB+/909peNPi7FCaJQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl+CnV3O9mqgHQS7bu8KpeOOihBlpKbb80Rj9JEI51tkYB6NcfndcUj5b5mVeMX8OVTkP0TrgHo45Mrvi4pzmmUMemWHb2xpUScFxkQnahEZrxvelarFuoveCiJSEhQKb5lw2EjmIOxECGbzufM1w4uIganTVfzITI3SLt2fZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrF7sVdZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrF7sVdZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773231061; x=1804767061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WLYb8tqFihrgnuTWDWW3WBcYcB+/909peNPi7FCaJQ4=;
  b=WrF7sVdZ8M/oFWP2eAXPigTfmQzpt0sFEp5eng88Lj19uScaCfwnZTEw
   nHzuONQRBSI9KAZ/cVY+GQTZ78PxpHwpjysVHHhM5mLjzMR/kdo6uTHb4
   jXIBqGiTVnreIH16Ic+dIjNaNS+xytC1EyALtBVlphnsS0cxtjCuBU8Jn
   i9wmELVBgXog5ZxY+iIwyEpyBzFwkGkypY+XJoUEXlq0F9grj0BYd/HY5
   2zysNSeuUm/KVE4VERUNCFtRnP1AJsZOngZVdnyabi2C+qQM6FCvr+IXe
   5CSHKSnAlEJawFHrnBzkxLY0WX68EH4N/bOOND2v0DNZU0usBY2zT/YdN
   w==;
X-CSE-ConnectionGUID: OD47WTEHRv2exrqS9kQmTg==
X-CSE-MsgGUID: cctZMwS5QTGrCa7Thj+nmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="73993997"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="73993997"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:11:00 -0700
X-CSE-ConnectionGUID: Wo+8Tmf5Q7e1p9gDFMzRFg==
X-CSE-MsgGUID: Oc4Q1Xk7QISBt81PnC02SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225146526"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 05:10:57 -0700
Date: Wed, 11 Mar 2026 14:10:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: add reset control support in
 suspend/resume
Message-ID: <abFbzyYHjTCilnqU@ashevche-desk.local>
References: <20260310184046.2010403-1-a.shimko.dev@gmail.com>
 <abBvf9HgLeCpjevu@ashevche-desk.local>
 <CAOPX746OoVrQYgJiBMgDA+VOkUj5mtUmxFEXubwHsXTnPsCsrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOPX746OoVrQYgJiBMgDA+VOkUj5mtUmxFEXubwHsXTnPsCsrA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 11, 2026 at 09:20:25AM +0300, Artem Shimko wrote:
> Hi Andy,
> On Tue, Mar 10, 2026 at 10:22 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Usually we try to avoid _adding_ ugly ifdeffery. Can you elaborate why the
> > change is needed in the first place and why there is no better way to handle
> > it?
> 
> The conditional compilation is needed because ACPI and DT platforms have
> different requirements for system suspend/resume ordering: ACPI
> platforms require LATE_SUSPEND/EARLY_RESUME
> to support I2C operation regions, which may be accessed during
> suspend/resume of other devices. DT platforms don't have
> this requirement, but using LATE/EARLY callbacks causes problems
> because the I2C controller's dependencies (reset controller,
> clock controller) are not yet available at that stage, leading to hangs.
> 
> However, I agree that adding ifdefs is not ideal.
> 
> I have a couple ideas for v2, could you please advise which one is
> better from your point of view?
> 1. Splitting PM ops into separate structures for ACPI and DT
> 2. Using has_acpi_companion() checks in the resume callbacks

The second option is inline with the current approach in .prepare(),
so at least it would be easier to sell to the maintainers.

The first one will still require some ifdeffery if I am not mistaken.
(Or at least the similar has_acpi_companion() check.)

-- 
With Best Regards,
Andy Shevchenko


