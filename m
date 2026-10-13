Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B93B52F8
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883009; cv=none; b=Lg+LnlNEPHSMvp0Ky4ir355ZztCZwl3WVE4Pr4r+6hQEWM1yBx7aDGuIuesO8GNWAGRvVzw0MbUUgbTzEOoRUCu6cBEj9b601ckTcjz11S/SUNB+2xLkgp4GNSPp8nWb+/OCq7oHycwSEnMZ6ka58jdAnhJh3Tbt491gHF9z80o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883009; c=relaxed/simple;
	bh=e1bYgP1Ux+WgY7SbfmeeypIvqGWpzOLvrrHybfG4oq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTBVvXw9lBIosZv1YOUt1KdD7Msi6QOEQkLdfFzcK45CSdG3A1q/bxuY8aACN3HSEi18QcAg3PYQB4CuJwOvEk1zft65BkK5sf0Td+i0McWsEwKXcMrKRG3TLLrlJx/9pdO/xMVbPmxmtj08ZGbvfrS6yHPCZNDqXWIWYxKEZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ab1k3beB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ab1k3beB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791883009; x=1823419009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e1bYgP1Ux+WgY7SbfmeeypIvqGWpzOLvrrHybfG4oq0=;
  b=ab1k3beBLwob1fUljqTt/3VT51HJAAZWe/EBY9bIhNrNyi0X1c0+Wrh+
   rRHcU9fi1ZomqsrPpA/sBhHyl2eucqDx0hWMOn5dm40LCrf4ZqGVTgLz4
   Q63Eq7q22uQXgiqUx4t8Ol8JR0LllW+jHG4AnFVhDd5XVLrNOEqM+zSoD
   Rm57I3e1k4p5e6vLXrMp7fFIVQya4pdzIOSpCkor8Y9+k7zyh9xePz7uF
   CB766dZPQoFCvwYmAtQx+ASEI579ZecjyIstOMfrcCnZnnEUSvsI3zz0N
   FInkMBOTrSBwk3ETVeeVCbqfyCqOby6YRgBpDwLUsnxUe+dnTT2WLDsRb
   A==;
X-CSE-ConnectionGUID: 8KQ6hZlfQO2walQ7xsQEgw==
X-CSE-MsgGUID: p7HDKeV2TDq7R614VRfmPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="633074"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="633074"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:16:47 -0700
X-CSE-ConnectionGUID: /zeblXWgQWOuCZEA/UXkYQ==
X-CSE-MsgGUID: 6WRwXmoFRmyYCVL4XlzN5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="2873475"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 02:16:45 -0700
Date: Tue, 13 Oct 2026 12:16:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Saranya Gopal <saranya.gopal@intel.com>
Cc: linux-i2c@vger.kernel.org, andi.shyti@kernel.org, yo-jung@canonical.com,
	mpearson-lenovo@squebb.ca
Subject: Re: [PATCH v3] i2c: i801: Gate SPD instantiation on SPD Write
 Disable bit
Message-ID: <as32-0-_OWW7ZsY_@ashevche-desk.local>
References: <20261013080603.808196-1-saranya.gopal@intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013080603.808196-1-saranya.gopal@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 01:36:03PM +0530, Saranya Gopal wrote:
> From: Yo-Jung <yo-jung@canonical.com>
> 
> When DDR5 memory modules are present, probing the spd5118 hub requires
> page-selection write transactions. If the BIOS has set the SPD Write
> Disable (SPD_WD) bit in SMBHSTCFG, the transaction fails and wedges the
> controller into an unrecoverable "SMBus is busy" state.
> 
> Pass the PCH SPD Write Disable status into the SMBus core via
> i2c_register_spd_write_disable(). This safely skips spd5118 instantiation
> under write-protection while leaving legacy DDR4 (ee1004) functional.
> 
> Retain the original #ifdef CONFIG_I2C_I801_MUX preprocessor block around
> mux_pdev to prevent compile-time regressions when the multiplexer driver
> is disabled.

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


