Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5A1419FCC;
	Sun,  4 Oct 2026 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115448; cv=none; b=A80Cl+zp+1sFrsrUN7GhYqySQP7pu+wNIjGuEgjE2Q94vbvKGOs9oWM7TYQcXFcJz8tPh6mvtMO/43K1lyEKhYGm8Knp1D962a4xk6rrCvk1qQE6W1k/mYxS5VbHwPexEMcuInhppWe11N8G3w9EmTUtU168l9C9oRD8UgiF41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115448; c=relaxed/simple;
	bh=rTXBSI9gjlO7MZWTD8NiZKn8I4di3EjowZI5Qf3O9cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLvA5odJoR065sboW9Iqd+zdPrUsP2GZJRtPvlxMMcltNhauIiQZ3uXkmdBtLcXDegsMhl828//zjXE3eoKWJgfzdpN55DkjyMSdrx3uV47fpcglEqGyfJcKS+IDW9x6afTsX8Von/32ftw9cOFlLjQN5HaJuDiH47SgAAoHBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOO+oIoB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOO+oIoB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791115447; x=1822651447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rTXBSI9gjlO7MZWTD8NiZKn8I4di3EjowZI5Qf3O9cA=;
  b=FOO+oIoBdqakA4yT/7xupoKFiY77LwP7swkVhdMIU20PeDjWiu12HUWM
   dRbQ5+Hp73JySKcULGuG9EM72jwkn4I4UtSA794lTXOtxnfwJSnbn58Gd
   I874shdh0yD7vvtWFBPKzDHc0bf8P7sIsfIlswuLBLseiyzPZnMfZaXiT
   jTKES3xyIQlyPq/+s8oZ7ZbS0ybwIIs79ETEAa+SthZBEZro4lqn8SDxX
   QE/UZux7vRX6TMJ+rlrbbC4SZAgqa0/U7ocu8vm5vAGn0nCjFh1z1RnIP
   ndwTM72O2KVQxmpGj3A/z8qC1FWq2YDm34X7aZ9GiayK9hm95EnV5Syaw
   w==;
X-CSE-ConnectionGUID: 3LbxxVGwSnS/rbiGVKKkww==
X-CSE-MsgGUID: CrvzvA58T+6EkvaG7sl4/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="90758320"
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="90758320"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 05:04:07 -0700
X-CSE-ConnectionGUID: E6haUHnHTrqQiSg5H2Iudg==
X-CSE-MsgGUID: b+mwGOPuRUOBmKv1HKNh0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="281352372"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 04 Oct 2026 05:04:04 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 0798899; Sun, 04 Oct 2026 14:04:04 +0200 (CEST)
Date: Sun, 4 Oct 2026 14:04:04 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: prinn.dev@pm.me
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <westeri@kernel.org>, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Force ASUE140D touchpads to 100 kHz
Message-ID: <20261004120404.GJ176164@black.igk.intel.com>
References: <20261004-i2c-acpi-asue140d-100khz-v1-1-cc2dbad00470@pm.me>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261004-i2c-acpi-asue140d-100khz-v1-1-cc2dbad00470@pm.me>

On Sun, Oct 04, 2026 at 05:59:53PM +0700, Harinn via B4 Relay wrote:
> From: Harinn <prinn.dev@pm.me>
> 
> The ASUE140D touchpad on the ASUS Zenbook UX3404VC (BIOS UX3404VC.303)
> starts lagging shortly after boot when the bus runs at the 400 kHz the
> DSDT asks for, and only recovers after rebinding i2c-hid. Forcing
> 100 kHz fixes it.
> 
> Signed-off-by: Harinn <prinn.dev@pm.me>

Acked-by: Mika Westerberg <westeri@kernel.org>
