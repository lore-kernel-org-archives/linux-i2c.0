Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69B480DEC;
	Tue, 19 May 2026 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185134; cv=none; b=g9i5bsxzcAEOKsslCbV0TCm+ARMCxm/lxVnafOP/QjJD9QIXSeQO78x6URRM2BEBUuSQQu7tY2oGmppLrpK9u/xIMdfEITKLxQAI9l9lpOaZOJOXeH0wY/LOWwaR+qZh9lMr27Xwzfn66fW21ib70TfAjhunSlD+olgvmDxqatA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185134; c=relaxed/simple;
	bh=JfHxkiYYYsRZk/sQ8UDVFTOv9W9E8MI4MSUnUR+6nQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgbHQ5TBP3IRDZogp30moj4DmVhkkrMgoCM39GezmWaKZ580JdTCx9rzN1z4PLiuqHYHKQRv077ApI1Bm2BayJrQWjawsaGhPJKkPAvF67cLYAskM8fxfTjiJ9I3wUQE+C8cKRz/jb0kd0/fnSKcWMp73OsWfHqF6xrHcozvveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfTaMXs3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfTaMXs3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779185133; x=1810721133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JfHxkiYYYsRZk/sQ8UDVFTOv9W9E8MI4MSUnUR+6nQE=;
  b=UfTaMXs3TX6/uRvMYT2WO+5gUY48f2zlnsT5/AXvN9WgsknIPKRHUTwY
   XZClMemRV++Kg7A6IEn+uxVZzjlRTGzvVmqs9AAhlu1Xsuip46uSSqsDH
   IkmjMWcMtLSVh9k8accyU3r4OeXKod55WrznkdocddUqKVuSuMq0mvAnP
   omh0/L76KcrhTFmVkVAFhgrSBW1RXJ9eX4bSr073Bl32c2Fj86OCD+MDI
   IWQdj61EhINXYGkUD7KS5S7r4/PEye5jUFw3k8OlmHUY+Jmp17/I2U6BL
   StmMsL2S2lt5XeYXKqNb0uGbfDYyUDdc6hOrC2rOgL9B3cmvNhs3e9W1+
   Q==;
X-CSE-ConnectionGUID: /wBrlr+uTJerJq6KG8Up7Q==
X-CSE-MsgGUID: hBi9yKnZSZORN25fdjur5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79959210"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79959210"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 03:05:32 -0700
X-CSE-ConnectionGUID: 3vtqKRjZQiGb3zoXjJ9+IA==
X-CSE-MsgGUID: X/trvKl+Tj2ryzVUEMbRPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="244714976"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 19 May 2026 03:05:30 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1F83E95; Tue, 19 May 2026 12:05:29 +0200 (CEST)
Date: Tue, 19 May 2026 12:05:29 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jacob Bazata <jacobbazata@gmail.com>
Cc: wsa+renesas@sang-engineering.com, westeri@kernel.org,
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c: acpi: Add VEN_04F3 to
 i2c_acpi_force_100khz_device_ids
Message-ID: <20260519100529.GA8580@black.igk.intel.com>
References: <20260519052424.7591-1-jacobbazata@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519052424.7591-1-jacobbazata@gmail.com>

Hi,

On Tue, May 19, 2026 at 01:24:24AM -0400, Jacob Bazata wrote:
> This model trackpad (04F3:32AA), found on various Dell XPS models
> from 2023 including XPS 9500, 9510, 9520 and 9530 is well documented to,
> at random, exhibit excessive smoothing with no obvious cause, similar
> to other trackpad devices listed in the i2c_acpi_force_100khz_device
> _ids struct.
> 
> Forcing the bus to 100KHz eliminates this behavior.
> 
> Signed-off-by: Jacob Bazata <jacobbazata@gmail.com>
> ---
>  drivers/i2c/i2c-core-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 28c0e4884..512ebdfcc 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -373,6 +373,7 @@ static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] = {
>  	{ "DLL0945", 0 },
>  	{ "ELAN0678", 0 },
>  	{ "ELAN06FA", 0 },
> +	{ "VEN_04F3", 0 },

This is interesting ACPI ID. Adding Andy just in case he has any comments
on it.

I'm fine with this.

>  	{}
>  };
>  
> -- 
> 2.54.0
