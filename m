Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49DB23A9B0;
	Tue, 27 Jan 2026 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549102; cv=none; b=rLKxClAXGQDVYRB5V/teroL7+tb3FFN0B019i6L2aDZuTGmOQeZ8g2y5880ttxFQ2lbUuLGf5kzrW+Vqvt98MwWccLNZJKCMhFtQeWMsitZl8N5xHkzYV7ufFDqDj9WZrHsyvPbx9o5dkNsPhffx1bj0g6dxnn4XLI+57QaOJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549102; c=relaxed/simple;
	bh=q5wUxehBpPLw0xkxOWjY4JK5mWWU7Rxj8x7jeUkVZ8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpfkeR8f3gf6G5bcQ/CqRCpUiTWCBYBkQntJqhKn4YBBd0uL6F5HwUuugziy1da0D1cRr099A1aER6axP34kIxQG5+3Sw3qAq1fzWzbgAlu+EdPmzONR5bBVoftC2d5oDZlUVXi/N1KQgNnzEKaCFpkM6VSm7FyM3VjfVF8Jy6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Na3S5ekr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Na3S5ekr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769549101; x=1801085101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q5wUxehBpPLw0xkxOWjY4JK5mWWU7Rxj8x7jeUkVZ8I=;
  b=Na3S5ekrn2RZJRaD1DJk25DN4Zsd+jBTIqY2htBgvBqQpgmqfTvRBQjX
   khtpqhQJ0nZcOFW3c3Edd8ONO+/Y8XgMigC1/4NHUWNvTxlf7rG9eBiX5
   fRURH2MmvE7qcPtTUpjZKO7PV+NbqeseUL4+ZETpeSdL9reZCTZE3WHfP
   enLhJIqIpP/SX1qCIwVOLwLu1zg4bFulJiykHv7ZeZmOMTYkXJqlQFzIc
   8qQunJh+r+NimrwUuJI47i85SnRMh6W3xc+nfVy5oe+PNTCkOrfR+xy7/
   p+TfA/KTfNBV8tWzw5TEgq5EfnZU+dGkkcNudHWUdAqSuo29Wha0MgIOg
   Q==;
X-CSE-ConnectionGUID: 6FgBoSn7Sz29TxW6IKVDYA==
X-CSE-MsgGUID: n3ZRa/VwSfCbofx/Pjygpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81478898"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="81478898"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 13:24:58 -0800
X-CSE-ConnectionGUID: 7BHqFVaiShKNtEhTDOVdlA==
X-CSE-MsgGUID: XvVQPI5IRMWk8J4XscMCDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208523906"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 13:24:55 -0800
Date: Tue, 27 Jan 2026 23:24:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: abdurrahman@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, info@mocean-labs.com,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/7] i2c: xiic: switch to devres managed APIs
Message-ID: <aXktJPe2YMkWEqEI@smile.fi.intel.com>
References: <20260127-i2c-xiic-v6-0-e82e2f6f657c@nexthop.ai>
 <20260127-i2c-xiic-v6-3-e82e2f6f657c@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-i2c-xiic-v6-3-e82e2f6f657c@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 09:03:57PM +0000, Abdurrahman Hussain via B4 Relay wrote:

> Simplify the error code paths by switching to devres managed helper
> functions.

...

> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "Cannot xiic_reinit\n");

I told you to use slightly different parameter. Please, read reviews carefully.

-- 
With Best Regards,
Andy Shevchenko


