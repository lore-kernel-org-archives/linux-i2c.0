Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418381D6BB;
	Thu, 23 Apr 2026 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776924803; cv=none; b=fYvY/CKUo1lGbTMibi9dv2kZZDoSY2pORN/1898oG1ASlbMAHhLXp75tn67oCQ8c4Dzh6JGHpBI34BOvZbegxwmiC8AlTNNasFqiObAGFb16dXk4QqJRljQZB1BSsq7/TcJMWPipwtEEuHR2SyirQudw65sszSIEUIKhEfJ9sQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776924803; c=relaxed/simple;
	bh=5b2ItsEOgcrpNt0Dj/TgBabMgHWL6V3RlJmmFOodDvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRAnqYqBwv5Rw7pjlKT9d6kjDEGFI2yfBpnK7Lhlc1p2FEbtTQ55J4hp1j1UsYiytllLgssAU9J9/tYyrUFCljON6CAieB4T5jI0k5Ahtt4/dCpxS/tcx+5/cw7m9q6EPFIfN5I/uUv4huIc13rPJ2GZN+Z427LRU8yp3AhkOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BVcS/Ll7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BVcS/Ll7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776924802; x=1808460802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5b2ItsEOgcrpNt0Dj/TgBabMgHWL6V3RlJmmFOodDvA=;
  b=BVcS/Ll7kH8Cf9J9zT62nwa1Am3eCCF50J+APPhVyr0elBKTvXZgAvr5
   CopfJWHFD4Ura76cWucoVE49CjTN7wZv/wT5JURCtFxo/lD2euTHIYIHn
   +ivhcqaUaOuHLiXJmxV2JniY1g2bD4QibL6HT5S8LQ0N6t6NCsx0fWqDM
   AMKhkxAEiZ0CfKwWW6JF9i5iV/SaiszmX6HWXKmN/JP2jd+GzznENubs1
   Znj60FKveP96kVxv/ifT5acFHtYejwCXaXn+lH4WC7ZIwCiYi25ifQyw1
   8P8VZ9lSnB7y7DkFHHvAA451cuIOT20qth9mYnH2tLf/MghLD/6CQ05j2
   g==;
X-CSE-ConnectionGUID: PtXfH+ufTxytLcPC/8YrRw==
X-CSE-MsgGUID: zV8nLrlBTFGSyF30IBvdPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77947132"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="77947132"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 23:13:21 -0700
X-CSE-ConnectionGUID: RQ6g6nP6QT6e/snlAYtd6g==
X-CSE-MsgGUID: 7oGI0EWsR22f4gIlwy9kJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="229384630"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 22 Apr 2026 23:13:20 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 5277E95; Thu, 23 Apr 2026 08:13:19 +0200 (CEST)
Date: Thu, 23 Apr 2026 08:13:19 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: designware: Handle active slave and shutdown
 cleanly
Message-ID: <20260423061319.GF557136@black.igk.intel.com>
References: <20260423002838.83171-1-william@wkennington.com>
 <20260423005241.89054-1-william@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260423005241.89054-1-william@wkennington.com>

Hi,

On Wed, Apr 22, 2026 at 05:51:05PM -0700, William A. Kennington III wrote:
> When the I2C master attempts a new transaction while the slave
> controller is shutting down or restarting, it can lead to bus lockups
> and system bootloops if the hardware enters an inconsistent state.
> 
> Address this by ensuring that the internal state machines are properly
> cleared when disabling the controller if slave activity is detected.
> 
> Additionally, add a shutdown hook that gracefully sets the slave
> disable bit before disabling the controller. This guarantees that any
> incoming requests from the master are immediately NACKed during
> shutdown, preventing the bus from hanging.

Can you split this into two patches? One that deals with the host side and
the other that deals with the target shutdown.

The code itself looks good to me.
