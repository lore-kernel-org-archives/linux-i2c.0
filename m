Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B2A3F9268;
	Tue, 14 Jul 2026 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018994; cv=none; b=Os2XDa+bYCgP/hntyczQYLE9KedhfuKy89OaQZYYz4ZdJvsB+hkhW0GBHXbDi0EtRa7khVFIC49NgMSju6P3O+6V9Hk4Y2gIiVs3fPWwxZRIhKY0zpuy/wzZncZ5lsT5Aq7I58o7i5x/f81xLfQaN2YYn5OcVWlAmeu0howGaxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018994; c=relaxed/simple;
	bh=+E7FMZfjaMpGYXNkxgxHTecyjtzcJGKD+XR1OvEDBsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz5pTihHJ4oxAhhAPJKvuE0yw1B8xrZO/4o50UN4rgHlwQ1BdwPEt6gvIisZyY0XkxJYdBTi70ClmfPMFGgiDjssdUDSinAZVQE94vQMAdBQlGKTrq+Dn33GuY9ssNEy4O5O+BiwsQSJQyoqf7mknidIuAYPbn938IdBI9dDprY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTEuXRck; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTEuXRck"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784018993; x=1815554993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+E7FMZfjaMpGYXNkxgxHTecyjtzcJGKD+XR1OvEDBsA=;
  b=cTEuXRckQLTHoIBOzAWj9ANVNz7tTJFh+TlMSX9RLZ2dncmywD33AfSL
   as4p58ICLem858tP7155neig5bgzwiMrR5hTW7BVSy4A+78fggIt4/A9u
   vWg4xszaYQULXdJUqrvEZR4YAT1eqIiNslMjcdms9SplKZdStYFLqtulD
   OPFAcg5jE5zlR+cUfGh2q46vyqWQls1CmhT6wnfaabYVPFA3NCFWrAV0U
   WVe3cgw9GxB6mWdGgF9ve/I8fvCdjAwkcZz3LxmcnigzfeqT97xkl5MgT
   aO0rYUn3AZrN3NajvjUhxvA6ezxHEqbZi5lzWzPSjsb7iUuYiltjCRZPz
   Q==;
X-CSE-ConnectionGUID: 5uQQ5OA/SZe08yt9vxZw0A==
X-CSE-MsgGUID: AAcWIdaaQGGMcQxC5ieeDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84755990"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84755990"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 01:49:51 -0700
X-CSE-ConnectionGUID: EEd/uLT1TvGHqn1QHAWiFw==
X-CSE-MsgGUID: 4JYHRuwTQEC0U62oxVTcNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="285879297"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 01:49:48 -0700
Date: Tue, 14 Jul 2026 11:49:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 2/7] i2c: mux: add idle_state property to i2c_mux_core
Message-ID: <alX4KrhAr6ysaaQJ@ashevche-desk.local>
References: <20260713-i2c-mux-v11-0-72bb8af8ee8c@gmail.com>
 <20260713-i2c-mux-v11-2-72bb8af8ee8c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-i2c-mux-v11-2-72bb8af8ee8c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 13, 2026 at 09:19:58AM +0200, Marcus Folkesson wrote:
> Muxes treat their channels differently when idle.
> Let the mux core have this information to make it available for
> internal use.
> Reuse the same state values used by CONFIG_MULTIPLEXER.
> 
> Possible idle states are:
> - MUX_IDLE_AS_IS: Leave channels as is when idle
> - MUX_IDLE_DISCONNECT: Disconnect channel (set HiZ when idle)
> - <n>: Enable channel n when idle

Here and in the comment in the code I would elaborate a bit to justify signed
type for the field. For example, put it as

  " - <n>: Enable channel n (starting from 0) when idle"

> Default value is set to MUX_IDLE_AS_IS.

Otherwise LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


