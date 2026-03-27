Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478C3DBD4D;
	Fri, 27 Mar 2026 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603319; cv=none; b=UXboe8rNp9FOuyHhQ52V22GnJ0MbrX42/ZztNBH5VYTO61fw76SaIdlE3AGRk1MDG4ZoDGxBrrMZWwLlDJj8f/J6RwMIbkJqH+7baD8BjNBeY07SNuW9CltanykF+pHic0tYAs+v8QNoFIvhmoqyV8jzssAccDDmfmbi98QQ4io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603319; c=relaxed/simple;
	bh=vwlW21nqjKkZTkDO8U71NsRgyfAUzFf+bMrDDDPaKpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTiJ4fgT3CsrxSDNlg4LvFhih79SUXSZek2r/C6QbtnZ2LRhjjRPUqpOmEE94xOeHvdW0deTSP03C/ZwXqZm78Xrmqtp/GUBBR0zM7CrzZaEaYM3W5Xke7sYKu1lFVStJgC/KziHpyNCZ4QuKgDifMmVggTr5RvVuG+Yoei8ecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gU3dGtps; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gU3dGtps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774603315; x=1806139315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vwlW21nqjKkZTkDO8U71NsRgyfAUzFf+bMrDDDPaKpg=;
  b=gU3dGtpsVyd+GjnNoyUAdhwLlIrR5iKLXJ/llTGf8hXjK81gSKM2X32o
   w1k039Qy+L6jR7wmcE5OK/id85PXQ2GlYihjC4Jdlvlgb23HRQbM2RWJu
   FAMo0m8uhJbh52yztFrPxoIYbwKFp+zuxilOfJs9TqClNBd0IzYJLVyBn
   tLXD/xW7OoSb6lW2+8vusyG3SU0YA0RUE53Z3zQHy7lTBGquH/y1NXFh/
   +ic2YP/ZqwcuHC695KScD7w39GP4iO/6Q7PrqG8JoMUFu5XtQdokw/ZyS
   vlHtMGmrkrO0ycZEjaO0LkKkH+mk+yKUD89mQmkrDhtXtzHChXqXoYfQa
   Q==;
X-CSE-ConnectionGUID: ny7GhGDeTRaJd2Bvu3eEXw==
X-CSE-MsgGUID: 52HbpMqVSqumGec46K88Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74704444"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="74704444"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:21:53 -0700
X-CSE-ConnectionGUID: 3vp8IH8dQKCcIdizzdTBgg==
X-CSE-MsgGUID: qkk98jboQzmvk4b05Cpa7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="225184061"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:21:52 -0700
Date: Fri, 27 Mar 2026 11:21:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Moritz Fischer <moritzf@google.com>
Cc: linux-i2c@vger.kernel.org, andi.shyti@kernel.org,
	linux-kernel@vger.kernel.org, mdf@kernel.org, ovt@google.com,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>
Subject: Re: [PATCH v2] i2c: designware: Add a new ACPI HID for GOOG5000 I2C
 controller
Message-ID: <acZMLbIdOAvO0VsY@ashevche-desk.local>
References: <20260326200451.2904375-1-moritzf@google.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326200451.2904375-1-moritzf@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 08:04:51PM +0000, Moritz Fischer wrote:
> Define a new ACPI HID for GOOG5000 as used on Google Axion.
> 
> This has been validated on Silicon.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


