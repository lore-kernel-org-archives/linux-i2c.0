Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943C3D903E;
	Thu,  6 Aug 2026 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786048269; cv=none; b=VSdUTJ4KrJzgWLWFpuB+ewC/TDaGMdb0NWIMOWTDFwP+TpFFrNIrD3SDIKwbugepRgwK4fKscMJr5Oj144wOG8JrZVllKWUZ55Vz6czb92GQGj+pNE9IGha78us+f8TG+a9/DO3kv+sh+KqgZxqT83X28y3NMv2MizhmOk5mwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786048269; c=relaxed/simple;
	bh=t/PIAtEvXxDRpBZQM2ESUuIuueEch/Z/b5otMUZkrKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoMlDD9/HG4qi4oQ0e5BNHGFPtMbFzHXe6I+QIUPJc/qjstT+Q4AAtaPPdLoPmho+8X3ih1Iof4CRJxHcruB63o3tIuOa4KIBDxvALyu8hDCDUhJRt/7qwLcnHm5CLfr5/T9TBwP6juhVt/nU4ost7t2+Wb3kwqd2GE83cdDY4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PcgQR0nU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PcgQR0nU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786048268; x=1817584268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t/PIAtEvXxDRpBZQM2ESUuIuueEch/Z/b5otMUZkrKA=;
  b=PcgQR0nUG5FJ/On1bvnUaEy5WVXBtU+tIgbmjisEszG8fFpNn7Qx++nh
   Vxuk30Kjs63czHv1BeaQV5lfbK+teMmt6y6gnWwmdosoYii7r+BzcFGS3
   tldNfk/BtdVprlNqx2W9/sjvSVlqW8nYDiX3HOYofwFqApPFwRLTVeZfZ
   vrlqEbX/SdN3PjVDgnHG+SMN61mPxOkV+iSCvVwupXc/y8uEWR77KRHy9
   yYTFotX5jqAD6FqplnAUU1WJIqTGbBMGBVKlgqWSxup3dgpDOCRb6ap+u
   m8CpExi6v+jBtcFzClD7gxcvIho471mO8gbvj2tsaDUfs2RsDTJEqbgPZ
   Q==;
X-CSE-ConnectionGUID: YX+ln0UPThW684r7+1BoKg==
X-CSE-MsgGUID: 1EyH9fCcS/mTkwVqkF1FYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="90471592"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="90471592"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 13:31:07 -0700
X-CSE-ConnectionGUID: Q4DuLegUQMa5j67akLn1oA==
X-CSE-MsgGUID: d6gGHfqhSXqSoIbHgV5brA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="262268896"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 13:31:04 -0700
Date: Thu, 6 Aug 2026 23:31:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "clarke.li" <clarke.li@hj-micro.com>
Cc: andi.shyti@kernel.org, rafael@kernel.org, jarkko.nikula@linux.intel.com,
	jsd@semihalf.com, lenb@kernel.org, andy.xu@hj-micro.com,
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org,
	peter.du@hj-micro.com
Subject: Re: [PATCH v3] ACPI: APD: Add clock frequency for HJMC01 I2C
 controller
Message-ID: <anTvBaRZNDhCz60e@ashevche-desk.local>
References: <yha25jhjmd5qh4prwnyhqr2sfxvw7v2hzwhhv66twtx7ft4siz@fk3d4t2d73dj>
 <20260722073031.1078080-1-clarke.li@hj-micro.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722073031.1078080-1-clarke.li@hj-micro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 22, 2026 at 03:30:31PM +0800, clarke.li wrote:

> I2C clock frequency for HJMC01 is 200MHz, define a new ACPI
> HID for it.

...

> +	.fixed_clk_rate = 200000000,

Can you at some point update these constants to use

	.fixed_clk_rate = 200 * HZ_PER_MHZ,

and so on?

...

>  	{ "HISI0173", APD_ADDR(hip08_spi_desc) },
>  	{ "LECA0002", APD_ADDR(leca_spi_desc) },
>  	{ "LECA0003", APD_ADDR(leca_i2c_desc) },
> +	{ "HJMC3001", APD_ADDR(hjmc_i2c_desc) },
>  	{ "NXP0001", APD_ADDR(nxp_i2c_desc) },

Keep it sorted.

-- 
With Best Regards,
Andy Shevchenko


