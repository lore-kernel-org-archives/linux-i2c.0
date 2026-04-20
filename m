Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77763388E55;
	Mon, 20 Apr 2026 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674240; cv=none; b=bGv3D1/8NQ0ZpFsePPrVxqeOAFiQ9ayZJHdfKLnNusUoAtuLSGtg3P0wKCwcGhtrlrNu8w3Pc7YsQurBE4kwAsSass/ouZXBDrp2LgUx/BeK0uxx70P0F39vBm7E5o5Y4Ly7FbxcuHyfBilQZihtfqtdHyBcVeq9XdyUixa2eDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674240; c=relaxed/simple;
	bh=dKRuzBwG/k0FLMHeg/8aXg6fYoXyJDowLF6D6SBZJmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQ6Fc46xck/B7X2aWnF6Bg8zd6asabKU0UEVuChpEtXwPQFROiK/TC+39ZYEGbqCDMJWs0nA+yih3aYFbPBsLMw02FpXMRc/p5aoLz8OHDlgOb8xpXD/vqt+BMYnuqBNF5DS7AEoiXKAVXDn/WYIgmFXNehWBuwHUcUE+ficXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMf6gNvq; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMf6gNvq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776674238; x=1808210238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dKRuzBwG/k0FLMHeg/8aXg6fYoXyJDowLF6D6SBZJmQ=;
  b=EMf6gNvqOFJeZ5A5otk+d7A0xaTV1pnddvFkM3ql+HIiw8sTLexRnEOL
   d1lvNDJ2beJlnhYAdDtrecX/jtg8qCphK4/Uv4SFgK2hqDYxxZIpYrx6c
   DwstVOUf1d1DGhztuNT1cpyZo22irhJhn4ClTivXeiIZi24BY3j1z9NXr
   vSLGzmJDQp0X0yxS/S5WCbU5mxYdAZLJxpgVi/g3+yGgbqGR962NcWeJ7
   CnvizEDgLQhLW3lddh9S2RkZbMJtioaJ8WR9jZZF9y2iFcyjEF+sTWwx0
   eFsgP5iixnS2Ed4HHFVf3qceZNQwzo6+7UkidYiBiE/7hXg9rGrWo/GUw
   w==;
X-CSE-ConnectionGUID: wWU0FFSnSfii6HO3ITE6+A==
X-CSE-MsgGUID: xErdLy4oSeickvyCGtaWmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="76612392"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="76612392"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 01:37:17 -0700
X-CSE-ConnectionGUID: lti6nJEmTbaL9SzKuAc65w==
X-CSE-MsgGUID: MknTkTqaTKCvTkCqu2MZ4g==
X-ExtLoop1: 1
Received: from unknown (HELO black.igk.intel.com) ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 20 Apr 2026 01:37:14 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4A5C195; Mon, 20 Apr 2026 10:37:13 +0200 (CEST)
Date: Mon, 20 Apr 2026 10:37:13 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Niels Franke <nielsfranke@gmail.com>
Cc: westeri@kernel.org, wsa+renesas@sang-engineering.com,
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Add ELAN0678 to
 i2c_acpi_force_100khz_device_ids
Message-ID: <20260420083713.GA3598@black.igk.intel.com>
References: <20260418053719.15766-1-nielsfranke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260418053719.15766-1-nielsfranke@gmail.com>

On Sat, Apr 18, 2026 at 07:37:19AM +0200, Niels Franke wrote:
> The ELAN0678 touchpad (04F3:3195) found in the Lenovo ThinkPad X13
> exhibits excessive smoothing when the I2C bus runs at 400KHz, making
> the touchpad feel sluggish when plugged into AC power. This is the
> same issue previously fixed for ELAN06FA.
> 
> The device's ACPI table (Lenovo TP-R22) specifies 0x00061A80 (400KHz)
> for the I2cSerialBusV2 descriptor. Forcing the bus to 100KHz eliminates
> the sluggish behavior.
> 
> Signed-off-by: Niels Franke <nielsfranke@gmail.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
