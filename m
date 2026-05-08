Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A890285050;
	Fri,  8 May 2026 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228147; cv=none; b=X04n0FkQEnL8DE5VdHFtLWh0Gwfj0R3GQ+3ZW8u6FaimCVo//uqo94zIWsshJguhjgmNEP0VMkgieaLVgemNk5zaxSGhcqYQJ+k/uLPf/0QHt0nrZ4NSqeAQJ2Uk/mxymabvyazOVfxeMBnUA2qbKZjLoUa23qqA6t5z1q8Dtd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228147; c=relaxed/simple;
	bh=4CNMtu3aufHfG66G1mNOgTVsow27/TtgPEZbZOZIo50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjhNWlKtklrltRq2EKBpSM6wrvM40KFN7ut3gGOtXwcKW3beBaUxsDgXicDa8/oadQ2qwdzt796eHN7YUEBMzY3PdMCBa2nuZEXyJUbPYRSfka8kDxsW8MnFmbPJLkuk3ywy3G36U32L3gYdqrPTE4EuiHZBQ8AI8zkxbZTpGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZX5d1nL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZX5d1nL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778228146; x=1809764146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4CNMtu3aufHfG66G1mNOgTVsow27/TtgPEZbZOZIo50=;
  b=eZX5d1nLwRYVvTvVEo3fyUSp0tNCcR5kz1+5e8PBg2iCJpISd/UWAFNY
   amDSQ8eKxUa+E0/PbQQOGxaMyEKd2ZL9v5sit4LNYhP9ByajqZhvkxYOe
   CRw+g3zaePyUQzyVVQC7FNQm4nCBR19+woycXEKt/0/SMZ0teu0HjpkoF
   gjwtdecQu7MUq4nxap+OHcWd27VDS4DTJ2o84QN12Xa6EUBNYFpS+HBSp
   /vSiv3+RIUpTZVn4xF996f44zKwgQ7xPMasQtyNSqfN1IM92oST+J1oxj
   QRuV8oWQ/udkmDm7+MpHOQPSQtD6pJY8chGjoQluKc+9b++65KWm/w7W6
   A==;
X-CSE-ConnectionGUID: +mSParDgQfel///K7e5xfQ==
X-CSE-MsgGUID: 1TUzYfKZSWGW3f+9HciRFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79180904"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79180904"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:15:38 -0700
X-CSE-ConnectionGUID: zJgji4kUTR6yYS9gCGM2Ig==
X-CSE-MsgGUID: svMhjJTlTQGpYErVvBdsCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="260427158"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 01:15:37 -0700
Date: Fri, 8 May 2026 11:15:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] i2c: designware: Convert platform driver to use
 shutdown hook
Message-ID: <af2bpjsvVsqAnqb9@ashevche-desk.local>
References: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
 <20260507-dw-i2c-v4-3-9a447b23bfdf@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-dw-i2c-v4-3-9a447b23bfdf@wkennington.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 08:05:17PM +0000, William A. Kennington III wrote:
> Convert the platform driver to use the new i2c_dw_shutdown() hook,
> allowing the controller to gracefully NACK master requests during
> system shutdown.

...

> +	if (!pm_runtime_status_suspended(&pdev->dev))

Same question here.

-- 
With Best Regards,
Andy Shevchenko


