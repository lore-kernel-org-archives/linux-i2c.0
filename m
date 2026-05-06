Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F7375ABE;
	Wed,  6 May 2026 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082528; cv=none; b=Tfht6oP6SG9Y0Ajqb1/TFvD62VotT57GkMdtRVZT7Iq7Tx1KKEONwi5vKhcSQGEK5TiG/FVXCRbDxyJlPjIqxLkN+zanaUDB34znsfehsB0rOFQNvRpZgcVKsf10S2fZWM208IElKJ385fel807em1cFP5pU7IYX2Mx1gibKPmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082528; c=relaxed/simple;
	bh=xtbhPhxYrIGs/SE6qryYPiEu0pqnkTbLizziUK6pfuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evotfPxlhpK6XWQfygoJjKE27RJ2pBqzptAZ87Szkhe7qsbFP26KKOfwRi68D5/K6K3W95TRDgNSdz7CiC4q/bHrFbGLBAHNuPU3++3oUBEPh2DK0vTCWMwdAfAEaiVJD6dLICmtfwF5H2sruDLhWNWqJhD6f+uDtFPPkTW4raw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAFH+WCu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAFH+WCu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778082528; x=1809618528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xtbhPhxYrIGs/SE6qryYPiEu0pqnkTbLizziUK6pfuo=;
  b=NAFH+WCuaaQ5n57X8Yn1JX5dNbOsubjBlg81duwJEOYVhZTMz/T1srs4
   emOuiZYCGZxnDyg1JzZXPp4d2tbRYB4kTZQg2PnCE87hXjYsrXq0aPEZ4
   QEbtV1RgwSvABVy6rY213qrq/2rhdC8oqKYIXZFNUuVVZqHDO9Ysqfi4b
   MjY9phxvVmUkXYTcGoKZRx5Il/QpliVNRl6I45Tvptnd5IeOAf3u2ylOk
   VfCCWy8fYaFFkA47UjFi6qoENAX+2XWRMmbUwt4al0NpKvwtZ8pWeI18x
   WVSwy0R/eJXSTtDukyApflSxMixnpdwLl00tDZjytb9WfBA2pP2B+Brjz
   A==;
X-CSE-ConnectionGUID: Diu3knHBSb2VOKlfWeADeQ==
X-CSE-MsgGUID: ZGrJ/9LtTMKiQl4eXcq6Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="101694915"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="101694915"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 08:48:47 -0700
X-CSE-ConnectionGUID: aU0RvqRRRFWBp7FJyo8NCQ==
X-CSE-MsgGUID: faEnLLtSTSqy9wR1dEULWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="274310828"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 08:48:45 -0700
Date: Wed, 6 May 2026 18:48:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Carlier <devnexen@gmail.com>
Cc: zhoubinbin@loongson.cn, andi.shyti@kernel.org, chenhuacai@kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: ls2x-v2: return IRQ_HANDLED after servicing an
 error
Message-ID: <afti2mWZ5_qoTqZX@ashevche-desk.local>
References: <20260506044818.19842-1-devnexen@gmail.com>
 <20260506154015.94815-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506154015.94815-1-devnexen@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 04:40:15PM +0100, David Carlier wrote:
> The event ISR reads SR1 and, when an error flag (ARLO/AF/BERR) is set,
> calls loongson2_i2c_isr_error() which clears the offending flag, issues
> STOP for the AF case, records msg->result, masks every CR2 interrupt
> enable and completes the waiter. The handler then returns IRQ_NONE,
> declaring to the IRQ core that the device did not interrupt.
> 
> That report is wrong. The device did interrupt and the handler fully
> serviced it. Because the IRQ is requested with IRQF_SHARED, the genirq
> spurious-IRQ tracker counts each error as unhandled. A bus that emits
> sporadic NACKs, arbitration losses or bus errors will therefore march
> toward the spurious-IRQ threshold and the line can end up disabled,
> wedging the controller.
> 
> Return IRQ_HANDLED on this path. The other IRQ_NONE site, taken when
> neither an event nor an error bit is set, remains correct.

From the analysis and code sounds legit,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
but my tag applies only after Loongson people confirm this is correct change.

-- 
With Best Regards,
Andy Shevchenko


