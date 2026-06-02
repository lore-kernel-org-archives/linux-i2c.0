Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9343C5850;
	Tue,  2 Jun 2026 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439220; cv=none; b=kVbPYe4+Wby11j+fB2wCtT7C7ECZzDRrYnT3c+qMsnEOO7ZP50SRm18OHz00gwJz8edj6cDiCfHZpJEJzPyJaZ+smFIOjalGBrl5oX0kmx4anPC69rYoMOoeLPhjX8W7K3n/9+I1pb/JKJ2gWaFfHtzAOuynU1m4Sb63t5+Viic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439220; c=relaxed/simple;
	bh=G2xGDBvQjJ7m//Fyoc/JIojKKfMhKrEI4gg6nSuCUd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1GSatAAUKaUJSZ7pOHnkYOCGPJpk0BnFJBbxARrSEN6tq/x08Z0MssLEUemnJqWVYDIBRAkwed5aTGLq6Y93UYpI9ZGLFrGZKAXc2IeFvriQng2cLK4vGswdVoChVEsmDu3U2ff40+l8rVyRNUPXVeT9iBACwIwELo8X35t8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=figWxLIQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="figWxLIQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780439219; x=1811975219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G2xGDBvQjJ7m//Fyoc/JIojKKfMhKrEI4gg6nSuCUd0=;
  b=figWxLIQrhHWc3i/NJf/D1iL5rqiyPA97i5s+gPQ6gEv6R8bkQEX6SB9
   Vcdcl48xuwVi4QQZfBZMANSckqJQzA0RwBoiSTvFphogzbEpGQqMtjvRS
   sxWjIE03a5zhZcFDijDXMx8cZ9LiEd2IWYbyXxaT601eca59xjvO6x+Na
   vOaLEJGtlftWMAAKbOKAWz+BnrjfUnwBKaq4rW0KD+ZHfkw8pSVZ9R08S
   ZuogKGTMrxB2gbbppOnsbfBjqLdDpg2aN60HZ4Dx8x1TOleqCz92QrwHB
   Mhc98Jktc43vGBeaTYrBKaD97TgDoxgcLrBqNDtJw1IYdelMAdeJxXOIt
   w==;
X-CSE-ConnectionGUID: BHd7mZwDQXquR9g7SICy5w==
X-CSE-MsgGUID: lt/270peS6SfcHOKEH4qbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92721579"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="92721579"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:26:59 -0700
X-CSE-ConnectionGUID: C9YQLwbJSy+jyd7S10wvjg==
X-CSE-MsgGUID: urDVfMAySdKuiM8G6Uj/JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="248341826"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:26:57 -0700
Date: Wed, 3 Jun 2026 01:26:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "lianfeng.ouyang" <lianfeng.ouyang@starfivetech.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] i2c: Add Starfive JHB100 I2C master/slave support
Message-ID: <ah9Yrt_gO8uGaPw_@ashevche-desk.local>
References: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527085039.44435-1-lianfeng.ouyang@starfivetech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 27, 2026 at 04:50:36PM +0800, lianfeng.ouyang wrote:

> The Starfive JHB100 I2C controller is a variant of the widely-used
> DesignWare I2C IP, with a distinct register layout and enhanced features
> such as SMBus Alert and programmable FIFO depths.
> 
> The series is structured as follows:
> 1.  Adds the device tree binding document for the starfive,jhb100-i2c
>         compatible.
> 2.  Prepares the existing i2c-designware-core by exporting and making
>         certain key functions overridable, allowing code reuse.
> 3.  Introduces the new i2c-starfive-* driver, with separate modules for
>         master and slave functionality, based on the 2023-07 revision of
> 	the Synopsys IP manual.
> 
> Currently, due to the following differences, i2c designware cannot be
> fully reused
> 1.  For high and low level counting settings at different rates, i2c
>         starfive can use IC_SCL-H/LCNT to set SS, FM, FM+, UFM
> 2.  Interrupt clearing is achieved by writing 1 to the corresponding
>         bit of INTR_CLR, while designware reads different clearing
> 	registers
> 3.  Master and slave require separate probe callbacks and cannot rely
>         solely on the runtime mode switching provided by i2c_dw_set_mode()
> 4.  The value of FIFO depth is not obtained through registers, but
>         written through DTS

NAK in this form. We well discourage code duplication and ugly ifdeffery with
full of __weak annotations that may not be present in the regular driver. There
is not even a tiny bit of justification for this nonsense.

TL;DR: this series needs much more work.

> I have written some poorly styled code to reduce changes to i2c designware
> and reuse its functions by keeping aa always true, for example
> 1.  the implementation of i2c-d w_probe_master() differs only for the two
>         IPs in i2c_dw_set_timits_master(). In order to reuse
> 	i2c_dw_probe_master(), i2c_dw_set_timits_master is declared as
> 	__weak. A better approach is to use a callback function, but using
> 	a callback function requires changing more i2c designware files.
> 	I don't know what the attitude of the community is
> 2.  For the operation of clearing interrupt flags, i2c designware reads
>         and i2c starfive writes. Therefore, in order not to modify the
> 	relevant logic of i2c designware, I added a write operation to
> 	sf_reg_read()
> So I think this version of the code is not allowed to merge, but I don't
> know how to handle this situation because if i2c designware is not changed
>  at all, we will have to write code that is similar to i2c designware.
>  Will this type of IP not be allowed to merge?

-- 
With Best Regards,
Andy Shevchenko


