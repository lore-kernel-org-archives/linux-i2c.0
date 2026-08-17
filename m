Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803523B27DA;
	Mon, 17 Aug 2026 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965051; cv=none; b=ew8+LS9dkqw6aSQ0wnfLSNbUr4CbWMyPaKuNVSLw5mOqvv5IW5BdZYrTjt1JV5cPMLgHp+w3qd3dWHpsTozQOIWb+Q9xbZ6llhccQ5+lzUV96/BkPi+Scx1UZ1zKILEfV3xyhbdXG3oK7kdWZU8ttQR7z6wxu6DyRFRWZmwNBHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965051; c=relaxed/simple;
	bh=aN8xMA52py6tC1sHlxdSEonVRyMSiWAFN33GJzvX1nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dy+ZtEbwU29BSrOqDL/oKaRQoLdV8SHUDYg9sd+l4X9QLbQiPmQSK2SzWgtJxKWDxazTaxwpMY1oaJ2TqOx+xEUM6XRc+A99G5NiFZ15iYC+mWbDRU5nG1ijhdr9wSlDsgELcOs6t0axHJerXIwekUEXrGJPujC4BleA6VuF0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkYh+M6f; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkYh+M6f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786965048; x=1818501048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aN8xMA52py6tC1sHlxdSEonVRyMSiWAFN33GJzvX1nc=;
  b=HkYh+M6fxqyVgR1c3SKxTb0SDP80bEkeD9P/8YTGccFc+dJ5bhqWwBz3
   jqGNPl7Xk+XiutQpGYz17mZ7BDLfSOnIs4UDP5X7ZV4OAbft7dyp8zUBc
   7PIzIpSHjzAkokVku7ZeHOOPH8+8QWKlF+lOXRYIRr3qcuP3EauYN9GZM
   kwkovx2MNMOvmc+li/4ggKAfpLKK9p8H76wCPW6SzKMW/TgEab2Dsg0Mx
   +d1lWEdrlo1O5rlB9ZTZzjkZb7O0Yib3iKzhVqzunfnk40bm95KeV+9r0
   mVmvIurHXgAlMj0AwyBZx0JsXFgzrXtuEZLtio8wah5TIaMZklbAorwG9
   w==;
X-CSE-ConnectionGUID: V1aJxCIsQQa8kWrCoXQjAA==
X-CSE-MsgGUID: n15ZEIs9Qde91ZIUAyXcOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="91309728"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="91309728"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 04:10:48 -0700
X-CSE-ConnectionGUID: GLzoEM4CSSSag6qmykpv4g==
X-CSE-MsgGUID: tUyrNOx+RMCmFocpoOBCRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="269162302"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 04:10:46 -0700
Date: Mon, 17 Aug 2026 14:10:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Umesh Kumar <ukumar@marvell.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	bbhushan2@marvell.com, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] i2c: designware: Enable SAR in slave mode for
 Multiple SAR controllers
Message-ID: <aoLsM8aTSwmIHrUd@ashevche-desk.local>
References: <20260804041842.3205356-1-ukumar@marvell.com>
 <20260817084023.176584-1-ukumar@marvell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817084023.176584-1-ukumar@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 02:10:23PM +0530, Umesh Kumar wrote:
> DesignWare controllers synthesised with the Multiple SAR feature (e.g.
> Marvell CN20K) gate the primary slave address behind IC_ENABLE.SAR_EN
> (bit 19). Per the Synopsys DW_apb_i2c DataBook v2.03a (Multiple SAR
> feature),when this bit is set the core acknowledges the address matching

Missing space after ).

> IC_SAR;otherwise the address is NACKed. The slave enable path writes only

Same here for ;.

> IC_ENABLE.ENABLE (bit 0), so on such controllers the target never ACKs
> its address and a remote master cannot reach it.
> 
> Set SAR_EN together with ENABLE when entering slave mode. The bit is
> reserved (and ignored) on single-SAR controllers, so existing users are
> unaffected.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


