Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAB1ACEDF;
	Tue,  5 May 2026 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966492; cv=none; b=fJpt6hlGlkoxZ4F5d6vhYfTDSZ2Or+X9k12TDbFL//ZAur1aDiH2LBDkN3Kq+QHOlhD5FWK0SSlGVojrbmMFuDIJGuTMdt3zygTxB/xP/F0WxtORMfmzJQtmrqDmQUreGAGo2NEd4cu7IxkcHZAUewvNCaw1/1ng72uxFPzvvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966492; c=relaxed/simple;
	bh=upZroD9r/iiZmeCCZ3qqnbhP4klS6YS4bX5HODHfnck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhyNQ1pZe/Xn9GdXs0lJiRsz0umzZCzalQBYDL+OX5kA7VXJTbemKKub6R89xinWxVypCFT+oh1t3yHOLBtwuZ4j0wLB4nFvx6NDTXVvMxItC5bn9z5koBoqXodQZBKmBS8XOCxge3zI26HMqXMd9j4nv0C7KW6nqN58PMsy5us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOqZO/DJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOqZO/DJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777966491; x=1809502491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=upZroD9r/iiZmeCCZ3qqnbhP4klS6YS4bX5HODHfnck=;
  b=YOqZO/DJAHWgOdR7FNuqtWj6i5Yx001ktTI/8RVjcVA7AuNJtoIL2tI4
   2dTZ0hzOOg8vjXUUYvgr/W3QAibDI0MuGXNTx9JGc5YmnaBCKvEAHT5Tu
   K3nr60YEBcwOU3GNhVk6zNlUlOH249xmTTWyDAGTm2pstNFQ9G5Qp74kN
   HgRpSF7m0lEyPmNAVY1kPNU9VnYdtv6OjD1OYo13Aj6C0cPsnkTw9939m
   SAEDB3vYtivUiksshmpCcPgK+GX9dRiVCQMlB0aXWioO809C2p20qKrQ0
   F2KwSyUKGZY49GAOCnVeKfu+sbg9KsJ8lWAMGkctSmRnekDxI46+AX3MO
   Q==;
X-CSE-ConnectionGUID: UmfoVKJBRvq+YutDOQsrxQ==
X-CSE-MsgGUID: EzGIgrc1TVembJexkjWeog==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="96396783"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="96396783"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:34:51 -0700
X-CSE-ConnectionGUID: IByo5ROvQTGqhEie+0ArOw==
X-CSE-MsgGUID: pTfKj13dQuev9E43QDSk6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="259417632"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 00:34:49 -0700
Date: Tue, 5 May 2026 10:34:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] i2c: designware: Handle active slave cleanly
Message-ID: <afmdlt_AE1wb5wqx@ashevche-desk.local>
References: <20260504-dw-i2c-v3-0-57e56135d602@wkennington.com>
 <20260504-dw-i2c-v3-4-57e56135d602@wkennington.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-dw-i2c-v3-4-57e56135d602@wkennington.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 08:15:05PM +0000, William A. Kennington III wrote:
> When the I2C master attempts a new transaction while the slave
> controller is shutting down or restarting, it can lead to bus lockups
> and system bootloops if the hardware enters an inconsistent state.
> 
> Address this by ensuring that the internal state machines are properly
> cleared when disabling the controller if slave activity is detected.
> 
> If the controller remains active after disabling, perform a bus recovery
> to reset it to a known good state.

...

>  #define DW_IC_STATUS_ACTIVITY			BIT(0)
>  #define DW_IC_STATUS_TFE			BIT(2)
>  #define DW_IC_STATUS_RFNE			BIT(3)
> -#define DW_IC_STATUS_MASTER_ACTIVITY		BIT(5)
> -#define DW_IC_STATUS_SLAVE_ACTIVITY		BIT(6)
> +#define DW_IC_STATUS_MASTER_ACTIVITY	BIT(5)
> +#define DW_IC_STATUS_SLAVE_ACTIVITY	BIT(6)

If you wish to fix some indentation issues, combine these with the one from the
second patch and make it a separate change (as a last patch in the series).

>  #define DW_IC_STATUS_MASTER_HOLD_TX_FIFO_EMPTY	BIT(7)

-- 
With Best Regards,
Andy Shevchenko


