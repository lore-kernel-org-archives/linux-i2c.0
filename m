Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9741A3DFC8C;
	Wed,  6 May 2026 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778063771; cv=none; b=UOjweNfWZobCHH5tOSFcSf1wAwKtzx/3EuB4k5kr2fuqoqW80VFAKMtmt8H4N8poiuMctC/WtOfDy28Q1t321n5BB9C2OxYIYNymAvk/ksiBCHtkAozO12E0LCqYBp1BxvCbhsyHv23em6hfHJwwJQivoJfLRxe5CxvM1boou0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778063771; c=relaxed/simple;
	bh=OGT9ZQtGWO9hWl+j36aXgJQfN13asm3rVno0BsZVOes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS3gHx1okfyGMtXetvTo2Yfk3Rtc3lAHlarsKod/aAJNdehtRzaPa6os+VbE845Ll6dT8in0vrG1vIJqPPQPNNRaTzsgl0AV3nDqIIlTGx7hF44nb7KbBRxQZJ3Z6zPuvTtAaeAO6YlWr1zNend3yEw2FoWMB/GJeJE+aOfDqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0Eo6X1W; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0Eo6X1W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778063770; x=1809599770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OGT9ZQtGWO9hWl+j36aXgJQfN13asm3rVno0BsZVOes=;
  b=T0Eo6X1WFDV8eF2pOskQT73ksK0rINtcTzVhB6G7vBUR59hISbw7FV+L
   KFlXn4uFfsa3acPB4NMre+vjPx2eKtNQQfvx/wE8oDADoQtwfyHCH+5KV
   /XiBgbIT3DRteAWu6Zo4FfJqJ8sQ3Ap2eMglEeFCzD9OG3aLNrg0SIvad
   pVfOX5V2i1+m5h0pnZb4mhsDOAihZqpujfghvhhfS8QH0bmIZoMs/NWo/
   5dSjJr01DkngZdzqGDuMbhGjG2aJ+7mhLG7OUCKYeoLYXqx2F8igFLY3a
   wBXHL4s1d9JVQIfh9uuHZAGIhLgBQu+w7N99YB4THuY+iex+Purd8fH6d
   Q==;
X-CSE-ConnectionGUID: VkxwYXMgShuSstrNTKaGeg==
X-CSE-MsgGUID: kGeAR7qVRLiYkVO/l6tKoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82833948"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82833948"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 03:36:09 -0700
X-CSE-ConnectionGUID: o9J5gNAMQ1y0tDEi0ORVWQ==
X-CSE-MsgGUID: v2F6PJKnREq5l7Zjg32Pnw==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 03:36:07 -0700
Date: Wed, 6 May 2026 13:36:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David CARLIER <devnexen@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>, linux-i2c@vger.kernel.org,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: ls2x-v2: return IRQ_HANDLED after servicing an error
Message-ID: <afsZlXm61ktTAa9U@ashevche-desk.local>
References: <20260506044818.19842-1-devnexen@gmail.com>
 <afsF2y0_oe2IloXT@ashevche-desk.local>
 <CA+XhMqw=WCkAn66X=P29ojx=wOVezfjnwvDbxYnZ1FOK=4Z8ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+XhMqw=WCkAn66X=P29ojx=wOVezfjnwvDbxYnZ1FOK=4Z8ng@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 11:26:14AM +0100, David CARLIER wrote:
> On Wed, 6 May 2026, 10:12 Andy Shevchenko, <andriy.shevchenko@intel.com>
> wrote:
> > On Wed, May 06, 2026 at 05:48:18AM +0100, David Carlier wrote:

...

> > Is the analysis and/or commit message AI assisted?
> >
> No h w but I Vs seen the pattern in another driver but I used codex to
> write commit message so I ll send a V2 later then. Cheers

Don't forget to mention any AI assistance. There is a special tag
Assisted-by: IIRC, but dunno if it's for reports and/or code analysis.


-- 
With Best Regards,
Andy Shevchenko


