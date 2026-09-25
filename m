Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9F39E18E;
	Fri, 25 Sep 2026 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329319; cv=none; b=gkeDLmO7ko/xAYtKwblu5tNP8QlB/UuKR/JTAqRYu0lV3wmAGBIh2Qx7Gab2MM6ATsKMg31i1/KifWsW+jtM+8ELTCgJVb/8DDTaCINOIIl3q5YuLkOQkhuIfPpwExPRsRxopgaHsKNg2JmgosR+n9VrTCBvZEGXUnH+0LUtJGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329319; c=relaxed/simple;
	bh=pinOX8WRyr3ERKakIVV56UL40/ntXRmy6CdeaaIRHKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2GUtLhK1N558hW98DxFuyume9B8luNykiKLlgAop+LBQp5p4Ybg0d5RgvcNIQ9IPJdISindq0RJdWNptxp8SBnyyjddcWEDvnQjTahFGy5HrQu4+YGxVAObj4zMly2PfozFNVl7/UCLJD25HmbS8h9IhqiF50IrY9uFs8TogFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNnRjQn2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNnRjQn2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790329317; x=1821865317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pinOX8WRyr3ERKakIVV56UL40/ntXRmy6CdeaaIRHKs=;
  b=dNnRjQn2NJL2t38/U6rm/yHkDl5JhF0+9e649rX6t+jhMnHfF93hDoWZ
   SYQs4qePmAh02FF8Pwx8AiXl6V/HnSzQ53/45q6JmJSdPGFgipnyjSg5y
   yM1Xlzb/NkX/yyqIBVhYwG8apWGXHzM1xM3v8tVwnqMgYrj5ZVDCSWm2B
   mCNIz7SKCEBmj7IFRhTthyhtUjC96nY1G7j3ao88Q0ZvqrZE2zZJEa84l
   ueML4PxNU6T+yrhtaTvNRDmeg/WAwAuw5Fedzv/B/rTBQkIipROTFBFEM
   itmjK3oXFpDredy39A8szxgVqTbtdZuDO4DYSpjksWkHJmJZlZXHk/XqT
   w==;
X-CSE-ConnectionGUID: i/rsM0R/RiypuYhszQzj1Q==
X-CSE-MsgGUID: 1nBAta8MQ/aP4iB3DrcOsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="108602584"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="108602584"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 02:41:54 -0700
X-CSE-ConnectionGUID: 3ShRyZ7aRBGJlskZZuKMvg==
X-CSE-MsgGUID: QsoZh8iATzmcCbfUS82mXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="278057352"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 02:41:48 -0700
Date: Fri, 25 Sep 2026 12:41:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vigneshr@ti.com, nm@ti.com,
	u-kumar1@ti.com, lianfeng.ouyang@starfivetech.com,
	Ritwick.Sharma@arm.com, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/3] i2c: designware: Add TI TDA54 I2C support
Message-ID: <arZB2s3HOBgSRuE4@ashevche-desk.local>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 12:26:27PM +0530, Aniket Limaye wrote:
> Add new compatible and update driver to support Synopsys Advanced I2C
> Controller (DWC_i2c [0]) present on TI TDA54 SoC. This is needed since
> this controller differs from the existing designware i2c (DW_apb_i2c
> [1]) in its register offsets and some register definitions.
> 
> The new compatible updates driver logic due to changes in register
> definitions:
> 
> - The new register offsets are handled by first refactoring the driver
>   to use a map of register IDs to their offsets.
> - Similarly, also update the driver to use an updated CON-register
>   bitfield definition.
> - Interrupts are acknowledged by writing a bitmask to a single CLR_INTR
>   register instead of reading N dedicated CLR_* registers;
>   i2c_dw_ack_intr() picks the right method based on dev->flags.
> - One HCNT/LCNT register pair is shared between standard and fast speed
>   instead of having one pair each; i2c_dw_write_timings() writes
>   whichever value set matches the configured speed.
> - No COMP_PARAM_1 register, so FIFO depth and high-speed-mode support
>   can't be autodetected: FIFO depth now comes from the required
>   snps,tx-fifo-depth/snps,rx-fifo-depth DT properties, and the
>   high-speed capability check is skipped.
> - No defined CON.RESTART_EN bit; treat it as always set.
> - TDA54 SoC does not support SMBus, so skip accesses to those registers.
> 
> [0]: DWC_i2c_reference.pdf
> [1]: DW_apb_i2c_databook.pdf

Still doesn't look good. The current register layout may be left as is. What
you need is translate it in the respective regmap callbacks in case we are
enumerated on the different IP. Also possible to have a different regmap
config for the different HW where you translate them only in one place.

-- 
With Best Regards,
Andy Shevchenko


