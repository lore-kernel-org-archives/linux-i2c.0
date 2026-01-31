Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA66A330B26;
	Sat, 31 Jan 2026 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769854383; cv=none; b=C1yqYWpZIrSgLFiKvwy7hOt1UqOBEfWp8lryfzef0zyCWgXZSUmJI9FAhCYH1hitrFjKTLNiTRMyZQv4V7TnSN4CjNMxBBaosC61TjFvvNBXEQ102fE2PLi6QPr7tMRivsBdi9nGnRDMaYFCHTTyNyYB2QrUysHcPIiqM+BBxHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769854383; c=relaxed/simple;
	bh=bDV6Ml2elbMroNLtxz9Br8GhUvJQ9gJTZXYx2UqJoMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7hdz2SAXC2yf9Eo9wyQ2VGl8HzJQU8k3oFWAe0oE96ohIh9hvc2PCmNgNJDCrUGUhIitWDc2B46B86nypJN7W7WvE9a6cmKm5qxYuDdwRXjVtbdWHkkXGR9hYMarBv9177S6jDEET+aEkfMTqr+f5v6SNMaMlrV+5lx/QylYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0fnUXBk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0fnUXBk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769854381; x=1801390381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bDV6Ml2elbMroNLtxz9Br8GhUvJQ9gJTZXYx2UqJoMM=;
  b=W0fnUXBkt09Xw3ZeEWKuTJez7pA9idr5OIt2dHVHPGPYEH6CmdHJt5lH
   u8jT1wm6u4chyhQhIvjA3rbMnOebyPmVJGCXnTcFhz88XV1l+/U7M/UF4
   uBjlyluOa26jr1+5DI29W2yjpM9qohpDEVYJx+sdLtfazQ+cKyg0D2KlO
   mnj/9whalVjkvnM8zvBuAKtJL/ZllVDEfEYnt6IRg7Y8/uiQd7Kr6c2B+
   JrTPBlz6+AmQMgLwo3hrIVKmrkbeHUVN/tNVbuqzJjosDsDlUhEO2hJTY
   TrMGGyYcHpAl1G8cxRAMVn+SvbPvMtNPpzhDMy3Z5YGWNBzB504Dc5DDy
   g==;
X-CSE-ConnectionGUID: yLNBNAXJSymcClfNOIHFJQ==
X-CSE-MsgGUID: tsckFS6aTuGLuy3rqC0nag==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71176677"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71176677"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 02:13:00 -0800
X-CSE-ConnectionGUID: Y9P1ZjhcQLa7lIeELafqxQ==
X-CSE-MsgGUID: EyfjgURpSt+yQA0l0FBXSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="209456821"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.97])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 02:12:59 -0800
Date: Sat, 31 Jan 2026 12:12:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Andrew Lunn <andrew@lunn.ch>, Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/6] i2c: xiic: skip input clock setup on non-OF
 systems
Message-ID: <aX3VqGlIUGCvMY5p@smile.fi.intel.com>
References: <20260129-i2c-xiic-v7-0-727e434897ef@nexthop.ai>
 <20260129-i2c-xiic-v7-1-727e434897ef@nexthop.ai>
 <ab9dc191-59c1-40a9-bbf1-e6c082af128a@lunn.ch>
 <2428D892-89F9-4013-9681-AD9BD76B0874@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2428D892-89F9-4013-9681-AD9BD76B0874@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 03:29:45PM -0800, Abdurrahman Hussain wrote:
> > On Jan 29, 2026, at 2:43 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> > On Thu, Jan 29, 2026 at 09:43:13PM +0000, Abdurrahman Hussain via B4 Relay wrote:

> >> The xiic driver supports operation without explicit clock configuration
> >> when clocks cannot be specified via firmware, such as on ACPI-based
> >> systems.
> > 
> > Are you saying it is technically impossible to specify a clock in
> > ACPI?
> > 
> > Maybe a more accurate would be:
> > 
> > The xiic driver supports operation without explicit clock
> > configuration when the clocks are not specified via firmware, such as
> > when the ACPI tables are missing the description of the clocks.
> 
> Actually, ACPI (since 6.5) added a ClockInput() macro that can be added to
> _CRS of a device node. The ACPI subsystem in kernel could parse these and
> convert into proper clocks integrated with the CCF. But, AFAIK, this idea was
> rejected in the past.

Rejected by which side? CCF?
Because specification still has that.

-- 
With Best Regards,
Andy Shevchenko


