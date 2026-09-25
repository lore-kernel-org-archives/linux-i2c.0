Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502EE44B69C;
	Fri, 25 Sep 2026 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790323926; cv=none; b=ZSgU7wP25FmGMse6DG0WruIT8ZDhmYirVCm2LOF2IcyWuekVTfNfd0g+v4/FuEVR5FC1dRgQNsz61133I3mUi/rJ9fyC4cZVeTaNqOb1wZWF3UxceiJSiD9lk6zVqTMDBk2gbVGerqg5sgqiPRfhuCIwj3zPhIkIoPiAXrp+mcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790323926; c=relaxed/simple;
	bh=IjeL6lQxC5wfgimI7fNsrGkvvTPhkEWoddXXRqMbvUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9O8zmYD5HVhJZ6rKwtln1KSxMwjp5zDeaCrbd7pWSKBKJ6XE55bXl/ZEinij+UYTEjvTQtMUo9hRYt/JzWmlvVRAzauPZ/c40GGVKzvwj9l/IZ0e0RxHNGvCwjw7VhjoI0voIHOg0cpjN7sWX3P30RhfAdok/YkL6vUeBuyIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WZsMMWV+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WZsMMWV+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790323924; x=1821859924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IjeL6lQxC5wfgimI7fNsrGkvvTPhkEWoddXXRqMbvUQ=;
  b=WZsMMWV++sV2/m9yfc1uYPHzRf4qWMEEWMQs7eYYzPnJs+a68/NHRcTN
   F2djqPoVjc/Mu+D1wC9wM0pZiu9FbtNlAggDVuKqzvfeB7+xCp/KneoQE
   HesknvW371n3DXFw5ccxo9O3EApUT6IaG4+7ZTzlclD4QtequI1HWI+jV
   8wBK+/imYXyWCvFdnDiZm0f5p8hjlrW3ppofvr1PsBP7778CG6xexh5xi
   lSg6vIQWbTEJwexp6lMSYURW7Kf75JrljFqy4q8oMiUTTDqKoecWeCggz
   mga5qPacsWuZLsiwvrFLB4kQI5Hnn1FEf7Xq0j/f66NczVyKqrJULpftj
   Q==;
X-CSE-ConnectionGUID: KxYyP3GIS8aTtc+X0BM7ow==
X-CSE-MsgGUID: 32Z//ApJSXiXJaFlIRsatw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="91211221"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="91211221"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 01:12:01 -0700
X-CSE-ConnectionGUID: Hc5aw++YSMy/x7myuLeEKQ==
X-CSE-MsgGUID: 0K945wrTQrmEvyGtHP6A2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="273363683"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 01:11:57 -0700
Date: Fri, 25 Sep 2026 11:11:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Aniket Limaye <a-limaye@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vigneshr@ti.com, nm@ti.com,
	u-kumar1@ti.com, lianfeng.ouyang@starfivetech.com,
	Ritwick.Sharma@arm.com
Subject: Re: [PATCH 2/3] i2c: designware: Introduce per-variant register
 offset and bit-layout tables
Message-ID: <arYsyiu4KG-m23hh@ashevche-desk.local>
References: <20260919-tda54-upstream-i2c-v1-0-b0b9f77be18b@ti.com>
 <20260919-tda54-upstream-i2c-v1-2-b0b9f77be18b@ti.com>
 <20260921111148.GT106095@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921111148.GT106095@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 21, 2026 at 01:11:48PM +0200, Mika Westerberg wrote:
> On Sat, Sep 19, 2026 at 02:36:07PM +0530, Aniket Limaye wrote:
> > Every DW_IC_* register offset and CON-register bit position is currently
> > baked in as a compile-time constant, which only works while there is a
> > single register layout. Introduce a logical register-ID enum (enum
> > dw_i2c_reg_idx) plus a per-variant offset table (dev->regs[]) and a
> > per-variant CON-register bit-layout descriptor (dev->con_bits), selected
> > at probe time via the new i2c_dw_select_variant().
> > 
> > Replace every direct DW_IC_* offset/bit-position reference with a lookup
> > through dev->regs[]/dev->con_bits. Also fold the read-to-clear
> > interrupt-acknowledgment pattern into a new i2c_dw_ack_intr() helper,
> > driven by a per-variant dev->intr_clr[] table.
> > 
> > Only one variant exists at this point (DW_apb_i2c), so this is a
> > mechanical, behavior-preserving change: the values in
> > dw_i2c_reg_offsets[] and dw_i2c_con_bits match the DW_IC_* macros
> > exactly. It lays the groundwork for adding a second register layout
> > (DWC_i2c) without duplicating the whole driver.

...

> > -		regmap_write(dev->map, DW_IC_TX_TL, dev->tx_fifo_depth / 2);
> > -		regmap_write(dev->map, DW_IC_RX_TL, 0);
> > -		regmap_write(dev->map, DW_IC_CON, dev->master_cfg);
> > +		regmap_write(dev->map, dev->regs[DW_REG_IDX_TX_TL], dev->tx_fifo_depth / 2);
> > +		regmap_write(dev->map, dev->regs[DW_REG_IDX_RX_TL], 0);
> > +		regmap_write(dev->map, dev->regs[DW_REG_IDX_CON], dev->master_cfg);
> 
> Instead of all this. Can't you do this inside the regmap so that here and
> elsewhere in the driver we continue to do:
> 
> 	regmap_write(dev->map, DW_IC_RX_TL, 0);
> 
> but internally, depending on the hardware it then maps this into the
> corresponding register offset.

Exactly what I was going to say when I hit "reply".
These series is definitely NAKed (in terms of the approach taken).

-- 
With Best Regards,
Andy Shevchenko


