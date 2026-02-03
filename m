Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE8A3BB57;
	Tue,  3 Feb 2026 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770161900; cv=none; b=Au4/RetrcCbPRIzzaFsaoHbx8hq+tdof9LsTwPgHgGetmwUdIDbL3soiKu28QDuewScLdm6S4azcK31iyBK/XrqFmZpnGrca+L7yySJi1YxTBrFTG6MC6DqyI1NaCytZb4IC4bYqk1MrBJWLp5855W4DgK5ps/Npoj+NKPuuLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770161900; c=relaxed/simple;
	bh=VUA7xPz2k2DqTILvSG8MJrzRqVcjkXmJKeKSnbJhE8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hV4VrIJQyXrwZvv2IMuYKMSe2PdvLjRIaJOYp9Yp8FeFhrqlRt4dsXLJx433deZrpQtO4/G+uNW1/wUbKJmXNxswLxRSVGYLbE44EeZC9M75axYLSjs13mK+fUUToOvaBRyraTtnTIGEbjakR5WIh3TqgionYWiiPPh5SgrBvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6z5x8DW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6z5x8DW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770161899; x=1801697899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VUA7xPz2k2DqTILvSG8MJrzRqVcjkXmJKeKSnbJhE8c=;
  b=X6z5x8DWHLzXx1XJgClbbrMkU/v8MvPcXrdLcqVnA8jrUzFy88NoVN6f
   ZnXp+2ELsv+gc0Qp+UzmDWC8K8nUKavOezElpVYfkRJ2qNDheYBN49yix
   X0VtbqWKKXGuBWmRkI956WOjmTFJdNyFYLaClWqLaM2/PG2ncUh7VKzJ3
   FOOgroMrbW7JmpeaFEiy61u5AdPNjkqRG6U3KyGThvnYhuCa905SxSeGf
   j+UpY/D3U560hVMw72He2DdPoD4e7nvc8YA2vqwaz27ff+T/J0s6ufjfM
   7VPx21Wt4wb093Hra634aibSGWJ9KgZpptPuVy813fc34PfuiWntxxnMU
   Q==;
X-CSE-ConnectionGUID: shIJ1ZgMQaaU4gjuhmKZYw==
X-CSE-MsgGUID: xR/1IfmqT1GE+B41Tk0MTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71065833"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71065833"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 15:38:19 -0800
X-CSE-ConnectionGUID: u2/E/qW7S8KctZQwAD6OFA==
X-CSE-MsgGUID: Gj/xUhl9RSSVJf+5vGhJUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="209100278"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 15:38:17 -0800
Date: Wed, 4 Feb 2026 01:38:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 7/7] i2c: xiic: skip input clock setup on non-OF
 systems
Message-ID: <aYKG5k5-6ll_RzQz@smile.fi.intel.com>
References: <20260202-i2c-xiic-v9-0-ce4695f5267d@nexthop.ai>
 <20260202-i2c-xiic-v9-7-ce4695f5267d@nexthop.ai>
 <aYIYUNejGCVdekx7@smile.fi.intel.com>
 <9F7815FA-80D8-4C96-B61F-5CA6CB405F7A@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9F7815FA-80D8-4C96-B61F-5CA6CB405F7A@nexthop.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 10:38:51AM -0800, Abdurrahman Hussain wrote:
> > On Feb 3, 2026, at 7:46 AM, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Feb 02, 2026 at 08:37:24PM +0000, Abdurrahman Hussain via B4 Relay wrote:

> >> Currently Linux does not implement ACPI ClockInput to describe clock
> > 
> > ClockInput() resource
> > 
> >> resources, unlike DT. However the xiic driver is happy if something
> >> magically enables the clock before the driver probes, and does not
> >> turn it off again. The clock should always be considered optional for
> >> ACPI.
> 
> I just used the wording provided earlier by Andrew verbatim. But can change
> to the following if you insist:

I do not alter the wording, I correct the mention of the respective resource.
And yes, I insist.

-- 
With Best Regards,
Andy Shevchenko


