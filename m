Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2137B40A;
	Thu, 29 Jan 2026 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769672931; cv=none; b=SOjOwH7VPFrow2PBEMkvyeBLYG3daLyoqTLuWrsOok2SCGIo3px8DiKbUZ8V7FNwtkqi/VK/FRuJNF+w4uA6uWEVeKWT7zgRDl38nXDMCQ2wO1M/Q+B3Oqt+6snthJ9sDxcUwKrqgtBaxt0ABkrnuC6iqwdj7PRcaEpvbqs2Xvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769672931; c=relaxed/simple;
	bh=N1n5iH1I6H9Z6SqaMYFKHSqa1YgvE2UHyKlj1De/3+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVFOIWi6fHeI2XQLfc/jD7raCNe/K79PWDYOX3j9MNXZ+b9dXL2TlEjxdPogv7VAJUKnG4Ig70P9lnFI/mlKXJvkHfyCBQ5UZnhN+V652eV42fkWPxB5Cq+x1M7o2e3sOGk2Ei1AuJy06vIGnkFMRuewK2saZwdyWaYQh+2wLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i69foPZy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i69foPZy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769672931; x=1801208931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N1n5iH1I6H9Z6SqaMYFKHSqa1YgvE2UHyKlj1De/3+8=;
  b=i69foPZyC2A/Ue6xBoyI5393zcnR1j2zSNjcPqjyBncFYtKCenLjfwin
   OR8r01CDTRiii8GHXk/idz6psmqTqVE4P0XZP01WqT+LkzNRupwTnPCvo
   MCTiMrbt9UKZYtrlRIBb3MXLAODakIu3cM1qpZPZ55HYCJTBkE4GV46/D
   mAnx7gUDwTv4J08tTVunphGaUl9/iPtNarBvX1cV4qPFlS688zvHmS/Lf
   Z3E7fVmbhlBpsvhkp7rQnCrPGWmyMe3ciRbQdpvOvvBJRsAjPkbx3kSnL
   3wQLWi0J/yJ9/CYCjN0j6QDI3XCvWpKyLhT1HVpKVEax2Yao2iGUX4x1J
   Q==;
X-CSE-ConnectionGUID: O4rNoN6LRN2mUz+cI9hwlw==
X-CSE-MsgGUID: tElpSxxPQ0+sY6QPpM33Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="74750594"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="74750594"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 23:48:50 -0800
X-CSE-ConnectionGUID: b7B3yOV4Rp2UQUZP3/Rmtg==
X-CSE-MsgGUID: 6hfgPNoAS0Oh9LMT4NoAyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="208396371"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.105])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 23:48:45 -0800
Date: Thu, 29 Jan 2026 09:48:43 +0200
From: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, BMC-SW <BMC-SW@aspeedtech.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"andi.shyti@kernel.org" <andi.shyti@kernel.org>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"naresh.solanki@9elements.com" <naresh.solanki@9elements.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v24 3/4] i2c: ast2600: Add controller driver for new
 register layout
Message-ID: <aXsQ2xgao5PPqnk6@smile.fi.intel.com>
References: <20251118014034.820988-1-ryan_chen@aspeedtech.com>
 <20251118014034.820988-4-ryan_chen@aspeedtech.com>
 <6b99a6ea267fd0f75d4c366293fe6887cc038b7e.camel@codeconstruct.com.au>
 <TY2PPF5CB9A1BE6E6353CEB66FFD0E498C1F29EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PPF5CB9A1BE6E6353CEB66FFD0E498C1F29EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 02:08:00AM +0000, Ryan Chen wrote:

...

> Will add in i2c-aspeed.c aspeed_i2c_probe_bus
> 
> 	if (of_device_is_compatible(pdev->dev.of_node, "aspeed,ast2600-i2c-bus") &&

Just device_is_compatible(...) instead of OF-centric APIs.

> 	    device_property_present(&pdev->dev, "aspeed,global-regs"))
> 		return -ENODEV;

-- 
With Best Regards,
Andy Shevchenko


