Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5623BED74;
	Fri,  8 May 2026 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234477; cv=none; b=H9+SHs17t6InOKiAUT+bJyR+VL4UaCRkTJYXRnL5HW7C2eakBDbhiOkqKdH9hM1LcYd0/pe5BFFXYQP/40UVQw/mTYly0IQIf1icAYx73mJm/J1vGBdbIia/uhKtppdjxIgdulWnaQEQ0ig0k3jPqcvV/jPJs/2xJz5MGExgwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234477; c=relaxed/simple;
	bh=8HCo33/8Hy8gbBhHnyR03Be0YBNlC1qJpgZDySmMpLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFXBSFVkqOKaQAqTIWJkn4Kvmq6H9Df7hdUZqp0usx5t1/obH8GdcPiZA1W63Du9iYTgj+Kl+1uckFrN7w2vHH01fG6fzel976xaa0JSDoGUO+fgFDG+4/JWONriwk0diDj/eL7NhVILy/3HRxW0NyaKpOA7AcVv3Pxq1v65cUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltvljKWL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltvljKWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778234477; x=1809770477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8HCo33/8Hy8gbBhHnyR03Be0YBNlC1qJpgZDySmMpLQ=;
  b=ltvljKWLiGqnyhUGlx5MfjbcVM45Tsvl/0CMlBgGzPawcCskuOhl2oqS
   +g6+lWaN1SgmZkcr5mPFvESyul+xwfg4kJuk4sW3OVu/r1sbaRAHoN6jR
   ZPwnq6hIcVZQOh/lreM0rvfKQJmIyyX0CkWhwLtx2gkhvOjjP8rq3YU2N
   t9caMoe5eS8NxyrOtIRFeZvw4HNQcZTg4SnJEKcY8sIc+MgEwytaFEwDd
   KJ9wpbSjoNU+EvFs+dDtccg5XzsqnJLS3Fqa+P0E0bOfpyAVQDIUv1Cvk
   1ig/g/J4OT3Arsb3o2M7tJyX4HcL8lCmqNU3DSoQNaupHsdyUsLrQ6iDX
   w==;
X-CSE-ConnectionGUID: MgZBC/AnTPa7jPgwl2PyLQ==
X-CSE-MsgGUID: iTgafKaQSTm3USkUOEPRgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="89509630"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="89509630"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 03:01:16 -0700
X-CSE-ConnectionGUID: gDc8kJAdQhOWYRXnmX9hqA==
X-CSE-MsgGUID: m9i2ZSqyRmmCLYB0R0QP+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="230331175"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 03:01:14 -0700
Date: Fri, 8 May 2026 13:01:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] i2c: designware: Handle active target cleanly
Message-ID: <af20Z54nj0x21Ybz@ashevche-desk.local>
References: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
 <20260507-dw-i2c-v4-4-9a447b23bfdf@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-dw-i2c-v4-4-9a447b23bfdf@wkennington.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 08:05:18PM +0000, William A. Kennington III wrote:
> When the I2C controller attempts a new transaction while the target
> controller is shutting down or restarting, it can lead to bus lockups
> and system bootloops if the hardware enters an inconsistent state.
> 
> Address this by ensuring that the internal state machines are properly
> cleared when disabling the controller if target activity is detected.
> 
> If the controller remains active after disabling, perform a bus recovery
> to reset it to a known good state.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


