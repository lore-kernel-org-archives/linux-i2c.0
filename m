Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE33DDDA3;
	Tue,  5 May 2026 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966285; cv=none; b=FFw4P/aqG/NK17/waEanvQ3ROCcNpgwGpCR2dxiyoRFsRC/dxrApxruBwjKDWjWhuSEr51UakuVDWEOqUl95bXYgYOA5xXXc1J5AC6RUhzHd2cx3YsrwaMnBX7WgN1ht0WIdXXrnkEdmqYHa/55ZLtkN9ewfDfLw+QcP1DJ22EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966285; c=relaxed/simple;
	bh=SJ2AX0wRrVIny/G86wKVLJTey5wK5oM2KZya5eBjEqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDxBuXDFiP3P852V8RhECf2QcAVKK7jtXtBIArDgFRMN3soP/ZPoHoC9C8WLNJVsm3noDQDT+5BM80jC8Pax5C56Rzfxd3+ee06sHAqbKjF80twX+oAiF3K/CHKycSdQx+iqCmVQzT37UUh+hmCB0W+/ZiGoMpfNp4OKyIR+mTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=io7A4I3r; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="io7A4I3r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777966284; x=1809502284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SJ2AX0wRrVIny/G86wKVLJTey5wK5oM2KZya5eBjEqc=;
  b=io7A4I3rB3BiIBp6GRjlorWLmT8dpkQKyXnrUvXZ1wBCqTnAlAtFsRmu
   f89NA4Z+YyT/95W2ZCoYrvJEpmF6bdUXvqJu32U42NeYSw4RnrjEr8lqs
   L6JnOSM0W7GrkFJpLWEZBYSsaNOlZ4HAuwj9QjEE0mJaurXXAIIeE/AQ9
   2C/ExN5C+G0+72XQqnkd75GRNqhx+9fRpeNu3avxYpf9hpDfSGI1r9Bzf
   q9cAIgAqFdhjYtBcHhQwGGhJr8ncRCc4UXpryvNGoWsA4a0K8PW45YWJm
   ViOTZqjHC1m83yopCOEgVXV2joIFhFXXP+JReLAQCWe5lb/TCZ7QbaFxZ
   A==;
X-CSE-ConnectionGUID: E3FHsU4GTCOFMx2FIyQ4gw==
X-CSE-MsgGUID: lLk4uSAvRiuz5kVkp+EjYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89419352"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="89419352"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:31:23 -0700
X-CSE-ConnectionGUID: lh0GB7V+SqmODt0TtiUWfg==
X-CSE-MsgGUID: D+a6cJgeRxuLhW+AERKK+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="232603667"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:31:21 -0700
Date: Tue, 5 May 2026 10:31:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] i2c: designware: Convert PCI driver to use
 shutdown hook
Message-ID: <afmcx9xh3R47FJEv@ashevche-desk.local>
References: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
 <20260504-dw-i2c-v3-2-57e56135d602@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-dw-i2c-v3-2-57e56135d602@wkennington.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 08:15:03PM +0000, William A. Kennington III wrote:
> Convert the PCI driver to use the new i2c_dw_shutdown() hook, allowing
> the controller to gracefully NACK master requests during system shutdown.

...

> +static void i2c_dw_pci_shutdown(struct pci_dev *pdev)
> +{
> +	struct dw_i2c_dev *i_dev = pci_get_drvdata(pdev);
> +
> +	if (!i_dev)
> +		return;

In long term this is bad style from maintenance perspective. Use

	struct dw_i2c_dev *i_dev;

	i_dev = pci_get_drvdata(pdev);
	if (!i_dev)
		return;

> +	pm_runtime_disable(&pdev->dev);
> +	if (!pm_runtime_status_suspended(&pdev->dev))
> +		i2c_dw_shutdown(i_dev);
> +}

...

> -	.driver         = {

> +	.driver		= {

Stray change.

-- 
With Best Regards,
Andy Shevchenko


