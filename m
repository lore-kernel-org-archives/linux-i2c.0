Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647437C915;
	Fri,  8 May 2026 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227976; cv=none; b=DBEQR66kRe6iUE3ovXmKp4zorjsNL1TE49R6J5L0qC3M7/V9reIYH7wZgVj8oMIEbdC4MdvDnefyecMU6gOa+dyNOgpUC/P419oaOG+rCYjX2ssbmLwHd+l7huTGgUi4PAy2vr4hCOV4YoWXQT8LNCIBhJuC4rkdl6BtLVMTgi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227976; c=relaxed/simple;
	bh=Mc3mXJhF7hmiwfL44uVUPaW7TwzIyHhVqwuKh8w9pbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0hrjLc6k0Pnwd1oANHIQRlF3Jgh7/SADw3oWMeQZrd+0f/Uq+l/5h0KAXMGocOcWpmMsKVyfi1RHXKaRQS+ybS089esXWyxFxnMSScVrs0ROqOa5TBTzMYIbKEPhcAxjsgSvYNK5bAzsW3OD+ub63AJt9FZfoWM65AmTNLD0E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBzMMi/g; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBzMMi/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778227975; x=1809763975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mc3mXJhF7hmiwfL44uVUPaW7TwzIyHhVqwuKh8w9pbg=;
  b=bBzMMi/ggpqzYoD1TayBvlvXjz4nEVJxToQDE1lGpiwh7F+mvYoBkASy
   PexnHjrLEfyDSBopes8zbth9OBk0uDmhWqug1Cteef3QVCqxAFdgB6kwr
   gb3X0CFDVej2q8U1Of9nsq5Lb8KIm/mRjWP1OvWQ1x2WOx2PduM1qMmfo
   gJ9n3e4SksIgu98uoDvO2ZMNRKpGy86kgJocdIB1Bojq9AG6g0U+kebvZ
   eJjrYw3KJP7PFcvRP78Xe+aOzmeGeXWFZdhcU2bMLeCOQhpvkySs/+pnS
   xBrsum19zahLdz/0ZdpCTYPgy+0BwfaXR/+n3J7rzmqdUMc4nAKCW+NAE
   g==;
X-CSE-ConnectionGUID: 6HxeEv+3S4aihxAcbjnAyA==
X-CSE-MsgGUID: w7dMDgn4Tz6x9aQzS3UEEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79180543"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79180543"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:12:53 -0700
X-CSE-ConnectionGUID: yXYm6oPBQAKhv94FsmFJCg==
X-CSE-MsgGUID: wXC6yIRISCmHnBeiR4FG9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="260426686"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:12:52 -0700
Date: Fri, 8 May 2026 11:12:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] i2c: designware: Introduce shutdown exported
 function
Message-ID: <af2bAeuNx131OipX@ashevche-desk.local>
References: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
 <20260507-dw-i2c-v4-1-9a447b23bfdf@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-dw-i2c-v4-1-9a447b23bfdf@wkennington.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 08:05:15PM +0000, William A. Kennington III wrote:
> Introduce an exported shutdown function to safely shutdown the
> DesignWare I2C controller.
> 
> This shutdown hook gracefully sets the target disable bit before disabling
> the controller. This guarantees that any incoming requests from the
> controller are immediately NACKed during shutdown, preventing the bus from
> hanging.

...

> +	/*
> +	 * We only need to handle shutdown for target mode to ensure
> +	 * we NACK any incoming controller requests. Master mode cleanup

Master --> Controller

> +	 * is handled after each transfer in i2c_dw_xfer().
> +	 */

-- 
With Best Regards,
Andy Shevchenko


