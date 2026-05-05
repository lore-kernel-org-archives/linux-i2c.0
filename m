Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE723EB81B;
	Tue,  5 May 2026 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966313; cv=none; b=etZ55pM1aYMxDpOdBvAp/vEHOOJgB3HItXwTSQkB3+GQsAcNweVxs5QwRatm56JvQ6oSHRJvuqC8FUulkeKAU4FluIXUcq6lCXStL/kzNtPamkh555e+RBtCyUUpllkHKjD0w8hV8e0WRFnv8bkLGEv6iuy18kFugUClgPVtnAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966313; c=relaxed/simple;
	bh=NR2A04+AHSwFoJYhAZRKYb1/fLNRNZS3em51vHjcnpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfCz0rzYjXFZGuYkvb8jiz1KLRRSdwRJizA7YcSl5aiy/p51uQ+gwZ79FaAUuUvq6whcBR4lxNmkn4ahwK+1luAyIh+QYcIgULxhgfNacWrwJnAvAmQiTUfX87i/5J6XYq/7wsncSJaB1R1SA5HTO1fJIZsv+X0a5HXX/a0KslM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFqfEdkr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFqfEdkr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777966312; x=1809502312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NR2A04+AHSwFoJYhAZRKYb1/fLNRNZS3em51vHjcnpg=;
  b=nFqfEdkrmiEHkEpIZlEmTQH6QDO6AmGufhx+UgrFDwyuRu7JDpjgg7PT
   0HqV/YRFsdPWxhmU1TAhRmkWctxx0qpSwqzbvBr2+rplvXfnxj+gSA5ew
   m7PBosMkUaUEO6GoVnaq2/OzlWhXgGnd64WFMy4bWMX091RLW2ikFmcl6
   3EtmQ90rxrbchBCvL9h1/88tlYvJZeQKoHVLeMw2Kd4RuLub6sQ5DuqC3
   U4OW0hHaWuez3cg4y4z35/2WSZ8LMxG9LGMFPqWGdvLfk6TSsivIuuAXS
   6tdAW8AJvYF2lGmUxof3sdIzaVPOzUvBg6RTOB1cw7fVSjSl62fGwUmoV
   A==;
X-CSE-ConnectionGUID: TJkQsimoTUSfjElVA17iKQ==
X-CSE-MsgGUID: TV83RBNCTxyruQj1xnSM3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89419538"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="89419538"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:31:51 -0700
X-CSE-ConnectionGUID: VCN9ghE1S62DnbVarcD5Rg==
X-CSE-MsgGUID: NNvwnFtJSIiQwmOqBiSDpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="232603808"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:31:49 -0700
Date: Tue, 5 May 2026 10:31:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] i2c: designware: Convert platform driver to use
 shutdown hook
Message-ID: <afmc49g4Q-m8xm79@ashevche-desk.local>
References: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
 <20260504-dw-i2c-v3-3-57e56135d602@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-dw-i2c-v3-3-57e56135d602@wkennington.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 08:15:04PM +0000, William A. Kennington III wrote:
> Convert the platform driver to use the new i2c_dw_shutdown() hook,
> allowing the controller to gracefully NACK master requests during
> system shutdown.

...

> +static void dw_i2c_plat_shutdown(struct platform_device *pdev)
> +{
> +	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
> +
> +	if (!i_dev)
> +		return;

Follow better style.

> +	pm_runtime_disable(&pdev->dev);
> +	if (!pm_runtime_status_suspended(&pdev->dev))
> +		i2c_dw_shutdown(i_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


