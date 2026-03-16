Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3BA30B508;
	Mon, 16 Mar 2026 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673113; cv=none; b=YlY7EGFjYbcYZnlc2UyV2sLx3RZA+BdnHYwyNJejKYHcD/NBNDUmpKKKecjPdtzZ4KvIIHxYp+8Va1UBjagAGLbPmyXCLJi9eSrewMFcyF40kxvGfKyYugn8ixv0Q7cV9bT76FjEvIoqOx2aRcBzAUVbeU4KddFGT8ndjeqitT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673113; c=relaxed/simple;
	bh=Y1mv2qVYpFR3tZg+xb+gIrccPpvHcADmzSkdgb5F5Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNPhryLKyC0HPJ9/CvxJhaYwJnL2GZL8FtnqjuAdg7MjSt0C2jy7AzyMn/NmmMUE+RZTBoR8oZNZF0OnBX94Crv0i7xZ3mFcKDcURL7/Te8pe94w+EC4HvywNi4nTzW6GaZEFp9Qw7OUtoEInDtDmByZeqrR0SxhfMYWmkpKULM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jluEImsJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jluEImsJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773673112; x=1805209112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y1mv2qVYpFR3tZg+xb+gIrccPpvHcADmzSkdgb5F5Og=;
  b=jluEImsJ/ibG/tMtOh3+adbZAkEyjvlQWchnb5yoPz2PSQCbkVfK6vVf
   TyiEzx5dlEmckSb1/d06G4F0wTncnhMdqqKkKJfGPd7VAq4/fOI3J/3N7
   8ZWrHbDfyYMDoYICaqhDIRhD9VqslCXzBQTsrsOisI5zhJzJAHwpTBBCq
   LLPXgREhfm9WB5tujXs62jFzCN+OUZukTu/BrsrjsYO/HuTWIkYg8+PdG
   FwBqq7dJveUOiqxYcXk4K8BB8KNhAUDG7YTHs7CrqyGr+T8beAT0rK3ro
   Kxg8hEGL6Rn/QwooEEruj9I4/Shmu4ACUQsFdHyF4jTP0TT+t4TGMFtAh
   w==;
X-CSE-ConnectionGUID: 4syTQnL2T62UmhAyCCXDrw==
X-CSE-MsgGUID: uAgVBdKrQAyOdIaLlodKdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="77300013"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="77300013"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:58:31 -0700
X-CSE-ConnectionGUID: kZ7dfhnyTPqmXGCIaxuPSw==
X-CSE-MsgGUID: aAaZsCarSr2/dUuv47/4ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222156493"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 16 Mar 2026 07:58:29 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 643FF98; Mon, 16 Mar 2026 15:58:28 +0100 (CET)
Date: Mon, 16 Mar 2026 16:57:47 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Edward Blair <edward.blair@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, wsa+renesas@sang-engineering.com,
	westeri@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: ucsi: add ITE885x I2C transport driver
Message-ID: <abgaax86_52szWnr@kuha>
References: <20260314013157.7181-1-edward.blair@gmail.com>
 <20260314013157.7181-3-edward.blair@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314013157.7181-3-edward.blair@gmail.com>

Hi,

> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * UCSI I2C transport driver for ITE885x USB-C controllers
> + *
> + * ITE8853/ITE8800-ITE8805 are UCSI-compliant USB-C controllers found on
> + * ASUS Z690/Z790/X670E motherboards. They communicate via I2C with
> + * ITE-proprietary register offsets and interrupt registers.
> + *
> + * Note: Some BIOS implementations declare both MSFT8000 (generic UCSI) and
> + * ITE8853 (vendor-specific) ACPI devices at the same I2C address. The i2c
> + * core skips the generic device when a vendor-specific sibling exists,
> + * allowing this driver to bind to the ITE8853 client with proper IRQ.
> + */

Besides the above comment, this looks okay to me.

But couldn't you use the resource managed version to request the irq:
devm_request_threaded_irq() ?

thanks,

-- 
heikki
