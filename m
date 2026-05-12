Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106E5395AE0;
	Tue, 12 May 2026 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581633; cv=none; b=EfdUwzCCHQx2vm0bouyTJBs7yXK8tuZPiSKGC3mxn+34zG/fOmpcXd0OfiZTpl7MR1TZvjKMMeVeRHeXXud/de7x2+kNMrqO6ZF0m12lxd+9pJe9KnU1ySsan/nWRzFTYUwsVvYVSgK8DnSCyPBfJSHmTh8ZrBLZNoubEWcfQcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581633; c=relaxed/simple;
	bh=NsVB3395UrLbQDg3g74ZbT/NL4JbTwBv898Lkciwh9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hipbY55Wb8z96XYccyL5CtGJtEYJx5yIe/yNdtm6noeAeSWCouleCWSQj5vzBrCmgE+Q1TSMNHKl6fF0ziH8NvQfT0DOAJQ7x1Hu6iu1eZVcZyz31u9fPM+nCOnEKmyIicuIREWfYjc91rUhHkn/66l2yFzZT8qlBRi/2WNQLwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmQuS3+a; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmQuS3+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778581631; x=1810117631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NsVB3395UrLbQDg3g74ZbT/NL4JbTwBv898Lkciwh9U=;
  b=gmQuS3+aZ5GnQhi3vvMtHE05nFmtLveHmZ7un3zgPK0bkGqZZVEOPV7M
   oSHqrBBKbmMXfPpQqeewpby1llFKBG9LMTbH8ShGWBl78HW9ZZD8JUxV1
   OrpwP7bztMPYAorWBfw2qCIYYdLYE8D8IqCbhoyLIVLC42p/XjPoeT3Ca
   pgcYraKa2NrIQsHxOIrdsfhmAVJ9V7uO1/hUvng9bKTupjrjZSYtRtAGp
   uA2dLdeZNnIgwuiJ77fCde8CGwTGvY57eTkNWgemkFKxo0Kvlea3nc7kn
   KJFYxNZJmUsX784fvfoQIOgGW0L82xn0wXn53Wf73s6bNaC70H98od/1u
   w==;
X-CSE-ConnectionGUID: ia7m1ZKqTM6e6bqZtljk3g==
X-CSE-MsgGUID: kF5M7KUwSaaC7/WaHFxtmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78517891"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78517891"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 03:27:10 -0700
X-CSE-ConnectionGUID: HAzY45c2QoC7/MSKHq9lpQ==
X-CSE-MsgGUID: MWoIPCUdRzKp15csvO9tIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="236744029"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 12 May 2026 03:27:08 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 553C398; Tue, 12 May 2026 12:27:07 +0200 (CEST)
Date: Tue, 12 May 2026 12:27:07 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] i2c: designware: Improve device disable handling
Message-ID: <20260512102707.GA84797@black.igk.intel.com>
References: <20260511-dw-i2c-v5-0-6c382e1b5de6@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511-dw-i2c-v5-0-6c382e1b5de6@wkennington.com>

On Mon, May 11, 2026 at 08:06:25PM +0000, William A. Kennington III wrote:
> When the I2C controller attempts a new transaction while the target
> controller is shutting down or restarting, it can lead to bus lockups
> and system bootloops if the hardware enters an inconsistent state.
> 
> This patch series addresses this by ensuring that the internal state
> machines are properly cleared when disabling the controller if target
> activity is detected.
> 
> Additionally, it adds a shutdown hook that gracefully sets the target
> disable bit before disabling the controller. This guarantees that any
> incoming requests from the controller are immediately NACKed during
> shutdown, preventing the bus from hanging.
> 
> Signed-off-by: William A. Kennington III <william@wkennington.com>

All look good to me,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
