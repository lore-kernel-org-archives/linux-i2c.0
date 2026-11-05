Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857673;
	b=RBkO41QI0uwudqsY+FRNtfNE9j6Y0OEDWoHti9AuPH1SRYw1Mk+I54gNDnvgOKfPUtX/
	 X9TUGu+5IDvKeoGdC1vw47TV17wpQ+sN/IXIce2xr+PWkSY9xmSW4r6Mw7DgkjaDWVgMm
	 4ds7RVOn7R/TKAeC99+zffeDsLzfxvKF0BSVHg+9rHlUjsrnQiuDgCL+i8fAQ/bq0e50E
	 J22ZEQfx+I/ZHNd2eo3rbyTB4dRKPSwYTnzewHk7jfoJbTVZuGn+7kZlugTbSd2e24Ngp
	 iK646YAColesOZBwaKGDZv1NZkhlZCIkWSic37AoqDv2ZiEkx0EvrtfphG5oep2ujtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857673;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=cMJW19wi3AUy5xpsrBVnbC4Fa8g33RvlwJC/485ALLM=;
	b=2WKf2/8A/5YAknCz26mArJ3WIIcOfc3cVFdBRrneJrOJDlx0pPF9mvGgMo8ZtZxQMf5Z
	 GEx8ESr/8U7MyGDSficLAGuOVIYX5SA+RDUZhNe1GjSQnZC+qGwGYZFYYavgQiLJa0o8S
	 yCw1/m51tOj+scb3Ls2BPLxBAcdDONrSN5+Fbj93subng2HTk4ti9zgX1gkKU8R78wQLa
	 HgAtaaeK+TKLMq2fniL7DP8RWEJLroegfQ9qYFXuLUEre1aCy1L7zoF7ivv+J+Rcn6nUg
	 3ysCWPSP/EedpAdvQFMf/tSJvYp2isenYl6rxAqU6R9qkJJVHCHfUNAJbucQyhizEag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nBQWwmqg;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8D8606A31B;
	Thu,  5 Nov 2026 05:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D8D8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nBQWwmqg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793857672; x=1825393672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nPyHAWDO9ZJOoEBFmCM/8d/dyr2AIFxTIVHy1CLHVws=;
  b=nBQWwmqgehzZgrgrRMgVI7xdO0BTdD/0/UULLe72twZtQdzNvTiMO28i
   zehkgF7dSV8Ehrj8UgEookn5XPtA75jROY1/RUt9E2edvV+rV1NWDUZjR
   MLWE4Wv5RmqkLuUx+BkR9dsDceCZxtgF9plZhDmyO++2qtgWVZS/mXiXX
   fZ5vlDaEolKXmIFcYgzW6AYYuKyf6cD5pyxICIsaNVokDo4wpSJbrPqwo
   rXTsHQzCU2XWOexpu05r3OrhMeXTZ5aSB9n2uBTriOlEfP0NQ3DfNAloM
   JtXCqNGpj7AKXAwXDNiq30Xy51Kk1AOZ4qgmXZR/tuSEoFWMBivad1FIf
   w==;
X-CSE-ConnectionGUID: 7WLvvQixTCWU2BT8AcE5mg==
X-CSE-MsgGUID: phuexvRnTeCK0tm24ussYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2521697"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2521697"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 21:47:52 -0800
X-CSE-ConnectionGUID: Xj/kuXkNRo6akP2buYOZOA==
X-CSE-MsgGUID: 1UHc0PeRTBS863DrUu5kTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6755405"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 04 Nov 2026 21:47:50 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id D245299; Thu, 05 Nov 2026 06:47:49 +0100 (CET)
Date: Thu, 5 Nov 2026 06:47:49 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: return proper fault codes
Message-ID: <20261105054749.GF176724@black.igk.intel.com>
References: <20261103-i2c-designware-fixes-v1-1-f83dd71f988c@mobileye.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103-i2c-designware-fixes-v1-1-f83dd71f988c@mobileye.com>

On Tue, Nov 03, 2026 at 06:12:16PM +0200, Dmitry Guzman wrote:
> I2C documentation Documentation/i2c/fault-codes.rst defines fault codes
> for different negative results in I2C transmittion. Previously,
> i2c-designware driver didn't implement them properly - it returned
> EREMOTEIO on NACK either on address or data phase instead of ENXIO and
> EIO respectively, and EINVAL instead of EOPNOTSUPP if a message cannot be
> sent due to controller hardware limitations.
> 
> To comply with the documentation, return the proper fault codes for
> different conditions, namely:
> 
> - EOPNOTSUPP if the controller cannot transfer the message sequence
>   requested (for example, target address change without STOP condition)
> - ENXIO if target address is not acknowledged
> - EIO on other faults detected by controller (for example, NACK on data)
> 
> Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
