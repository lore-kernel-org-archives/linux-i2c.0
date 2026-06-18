Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA76330D22;
	Thu, 18 Jun 2026 06:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781762961; cv=none; b=WmBGTAMKPGfWUTl2JmegOzcGGqvHMpzfJlEhxRhpIyrExkGOiW+u+fGRjBOaYa/RSUH2Ohsz/qWewAOpj2NF32jKAa8QQngjv4fhCq+mVqQHXI1F5c0P13Vf1809LsV/JUv6qy8+hbixOOh5s56SKVGwBzpTQkczDLJhSYSh9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781762961; c=relaxed/simple;
	bh=JI8jdQgZ9rrZMYyekQhaHyLhcPwXxgLHD61shgXfCV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZJ97gpK+vSxdcul8w1+f99SrjjSyT4jSD8ROm6RXB99IC944bDnmvwz1UibxBn547ocOHmIRKWXy2Vv2Z+VHd0GQ2EhrGXouFFyDCCb7I/zWgz6VGWEF0IaxJNJnwLtKUNJIuBQY26kEqpu6Xa77OwNopc1NES9B6KGrDSzB9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBCeaO3u; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBCeaO3u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781762960; x=1813298960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JI8jdQgZ9rrZMYyekQhaHyLhcPwXxgLHD61shgXfCV4=;
  b=PBCeaO3uxbVwmZxyf5sgnCIUdRbCJCvAOM6bMRWWp1aEzqEdsjwKYW2J
   /mLFnXrFY92AlNBYZI+rnlAVGkQnLDqff+FKVTA9N9+FnCFnT5HfcwrwJ
   Hauy92lyT0lePDRS3RxwyO4IUTI5bTuZE6jeeRRYWzM6p+D9aOp11bWlg
   3XcSsUaZJFZh8G3n5T3iewnluGLd69HFQXiAvtTgJL4UfFdmDFtohuqcc
   C92w+6izOiYRnAy+jgW9lQLqTHp7IWh7xyQmEEeJ9UWbYvbFgZN39t1BW
   VsVQ04tY6LkfauYmYsTB1We/aTkftb9GxyWYbQME8Ku41f1X3ylR5e/vo
   A==;
X-CSE-ConnectionGUID: gvl3rY81Tw2N2doW7oP6TA==
X-CSE-MsgGUID: 6kN7aB1+TFOg9vXuVVoItQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="86263714"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="86263714"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:09:20 -0700
X-CSE-ConnectionGUID: OLmT6bKwQBiqLOrfmLp4IA==
X-CSE-MsgGUID: 6iViCqluSq68Rd3HIe/JKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="248342303"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 17 Jun 2026 23:09:18 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 8D07495; Thu, 18 Jun 2026 08:09:16 +0200 (CEST)
Date: Thu, 18 Jun 2026 08:09:16 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Abhijeeth Babu <babu.jeeth@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Force ELAN1300 touchpads to 100 kHz
Message-ID: <20260618060916.GI2990@black.igk.intel.com>
References: <20260617192611.125513-1-babu.jeeth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617192611.125513-1-babu.jeeth@gmail.com>

On Thu, Jun 18, 2026 at 12:56:11AM +0530, Abhijeeth Babu wrote:
> The ELAN1300 touchpad with HID ID 04F3:3104 on the ASUS VivoBook
> X513UA_KM513UA exhibits severe pointer jumps and erratic movement when
> the I2C bus operates at 400 kHz.
> 
> The system DSDT describes the touchpad using an I2cSerialBusV2 resource
> with a speed of 0x00061A80, corresponding to 400 kHz, on the
> AMDI0010:03 controller.
> 
> At this speed, libinput repeatedly reports:
> 
> kernel bug: Touch jump detected and discarded
> 
> Add ELAN1300 to i2c_acpi_force_100khz_device_ids so that it operates at
> 100 kHz.
> 
> Before the change, nine touch-jump events were recorded, with additional
> messages suppressed by libinput's rate limiter. With the bus forced to
> 100 kHz, no touch-jump events have been observed and the touchpad operates
> normally.
> 
> The affected system uses BIOS X513UA.319 dated 2023-05-09.
> 
> Signed-off-by: Abhijeeth Babu <babu.jeeth@gmail.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
