Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFDD3033E7;
	Mon, 17 Aug 2026 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984422; cv=none; b=MlPYp8ObyRlDKIYKa4GsRrc3hAric093EYVjOedgZteFeVcYjuUtmHP0b7Ae0SJE7J2rbxIJWASKbypbrkkceVyj+Ke0QQ2uGX6x6g3GbV/xPT1fJ1NCD5sJziDLdfDi6hzs4iQYlHPGLU7HpCWQuNeySbmnobYsUiQc9s92+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984422; c=relaxed/simple;
	bh=M+CST8ZRUHhitduZsvFcwgzyDVVlSJpXFNtUpxsTxgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLAHOM7oISU1kFrJkx0BT3T/R/fSt9h3LG5YwRot+JU0n+gW4wf06A3tIUXTu5nJTItyB7VvOuoUpDTulXLrUE9Y93iFNOidAff6MSbgGhO8+hG29ppDa3ENlIa06K2Wx3GBfppd1lX/FO9heAtrk8wq2eRq2QKFHaatFbTn8N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOtEt6Pc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOtEt6Pc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786984420; x=1818520420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M+CST8ZRUHhitduZsvFcwgzyDVVlSJpXFNtUpxsTxgI=;
  b=ZOtEt6Pc3wnoSItmr3f65fnx6/Jjn72+7Z4s26aq9WoLJc/g2B5lVXr9
   ClZl6fQ5RhAXf+G5vRHFqVwxZex80JbfnKgd9qKLfmEDUYh2PIiVShkUx
   VQp4zMe5lJ4B2Im8c8aA7BJAdAYxlay9UkRPVe3iIddjISmE0W8jFqVq6
   y/TUE/9NVqO6aNIMre6TWGPlaSsYPNQmnw/kU1LXXr0YpDfhLXgPY/jNZ
   vocO8+DUaWPBYBpmltQZSIriZ4jTFXXnb/N96qn3g+iss0VhVvMC86JxV
   QCvAz7muatjllkBiBWuIUAxG+gK9j8M6ZMvb2a3Uz+vYbeHw7P17o8IcR
   A==;
X-CSE-ConnectionGUID: bH82AT/0RZ+RWV2K94Xoiw==
X-CSE-MsgGUID: pnVdqN+SQyS5LceglprgEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87485452"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="87485452"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 09:33:40 -0700
X-CSE-ConnectionGUID: S7fBXQ4aSGKnSKihvjISAQ==
X-CSE-MsgGUID: 3zTZhM0SSQuwi6/lriHDvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="288437907"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 09:33:37 -0700
Date: Mon, 17 Aug 2026 19:33:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Umesh Kumar <ukumar@marvell.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	bbhushan2@marvell.com, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] i2c: designware: Enable SAR in slave mode for
 Multiple SAR controllers
Message-ID: <aoM33xFR6cvpAY2m@ashevche-desk.local>
References: <20260804041842.3205356-1-ukumar@marvell.com>
 <20260817162141.300658-1-ukumar@marvell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817162141.300658-1-ukumar@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 09:51:41PM +0530, Umesh Kumar wrote:
> DesignWare controllers synthesised with the Multiple SAR feature (e.g.
> Marvell CN20K) gate the primary slave address behind IC_ENABLE.SAR_EN
> (bit 19). Per the Synopsys DW_apb_i2c DataBook v2.03a (Multiple SAR
> feature), when this bit is set the core acknowledges the address matching
> IC_SAR; otherwise the address is NACKed. The slave enable path writes only
> IC_ENABLE.ENABLE (bit 0), so on such controllers the target never ACKs
> its address and a remote master cannot reach it.
> 
> Set SAR_EN together with ENABLE when entering slave mode. The bit is
> reserved (and ignored) on single-SAR controllers, so existing users are
> unaffected.

I gave my tag and it is absent here. What's going on?
Do you think the fix is not only that and requires a new round of review?

-- 
With Best Regards,
Andy Shevchenko


