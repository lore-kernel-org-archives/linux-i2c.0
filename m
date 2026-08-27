Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F71135CB60;
	Thu, 27 Aug 2026 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811779; cv=none; b=M8FV6lUuK8kem0dISUPFSa7EEOsi2p0Yb+T6MaIzmUQ4p0ppob3u6DZ8DMliFTZ2RV7aX/GjJWce+S5rjYGgsi5pFw178ykOicPH/LVAXZDfPUVXhHUrQptWWiALLiB/GFcwBJlGgj8PPOY2lNaAN9R/PYbC0blb24/53gM8XKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811779; c=relaxed/simple;
	bh=S0MFObbzMYfGZPvhLGUQnmSIcx9IDKqS9/i758u2B5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOhxF9kbUmCTBzLEcDcxu2bJ+TyssO+FImPdAJWPlQ9Y5ENKF5KniIQx5zvhbGfAm93yvJTxIOTSrfIUV+N89aL4cKxirUOhUGOSdvtqYeH9HCDGq+JBJYqA1MR2p6D7sLzPv/P3jsbOchulguCu4+b2E7fZdMsdoFnsx7Q0trI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U10DQYys; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U10DQYys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787811777; x=1819347777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S0MFObbzMYfGZPvhLGUQnmSIcx9IDKqS9/i758u2B5k=;
  b=U10DQYys6pTJCqCtKflf0LGHvMk2jFYRkXDIcJmGhppGPxqW8p0dkGiq
   GQSQAWPCms1Mr4AIbcGdhJoebhxGVUDorws0/SfiHj1H245BOkh8wABbR
   wUkFPDTGW6c6/lSK22XgrPaG5mb+LyBYM1h9zmNaoS0Wh7OmOMcG5x7si
   Aw8JFB9MnjkUrL6mU/ey/ctetknBVAyw+bA1U1IaTZm8w0lE+CU/hiCdc
   muV4rt68jo6PPGHpH4cU08te1cL98tr03zQDTTY+z2sDAGS3mdZoQdUXb
   7s42Q3fOvHX7+IDLDOfL/QcifNE8QkaLyE68vdFyeGwJw3LWeTguf3GXD
   A==;
X-CSE-ConnectionGUID: IP+dWgrOScORLyL/WPQYPA==
X-CSE-MsgGUID: 6RmHITE/RxeH/ot/Hs9vzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="75845960"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="75845960"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:22:56 -0700
X-CSE-ConnectionGUID: a01mTHa9QcmxBUiBUT8uxA==
X-CSE-MsgGUID: qbbYqFUrR9exqWj7SVXqKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="266475938"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:22:54 -0700
Date: Thu, 27 Aug 2026 09:22:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: xiaoyueyoqwq <xiaoyueyoqwq@gmail.com>, andi.shyti@kernel.org,
	westeri@kernel.org, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: acpi: Add DELL0A86 to
 i2c_acpi_force_100khz_device_ids
Message-ID: <ao_Xu-43lnM6I7Pn@ashevche-desk.local>
References: <63cb7f6e-27ab-43d8-adb5-d2f4acd57674@gmail.com>
 <20260823123310.188189-1-xiaoyueyoqwq@gmail.com>
 <20260824102221.GE893316@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824102221.GE893316@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 24, 2026 at 12:22:21PM +0200, Mika Westerberg wrote:
> +Andy
> 
> On Sun, Aug 23, 2026 at 08:33:10PM +0800, xiaoyueyoqwq wrote:
> > The ELAN 04F3:3185 touchpad exposed as DELL0A86 on the Dell Inspiron
> > 13 5310 intermittently exhibits excessive smoothing when the I2C bus
> > runs at 400 kHz. During an affected period pointer movement becomes
> > severely sluggish and sticky for tens of seconds.

Just for the confirmation (no need to include in the commit message) can
you share the DSDT excerpt of the device in question?

(acpidump -o tables.dat; acpixtract tables.dat; iasl -d dsdt.dat; # open dsdt.dsl)

> > The ACPI firmware configures the touchpad bus for 400 kHz. Add DELL0A86
> > to i2c_acpi_force_100khz_device_ids so that the bus runs at 100 kHz, as
> > is already done for other touchpads exhibiting the same excessive
> > smoothing problem.
> > 
> > With the quirk applied, the kernel reports that the firmware requested
> > 400 kHz and that the bus is forced to 100 kHz. The problem did not recur
> > during extended heavy use, including an S4 hibernate/resume cycle.

...

> > +	{ "DELL0A86", 0 },
> >  	{ "DLL0945", 0 },
> >  	{ "ELAN0678", 0 },
> >  	{ "ELAN06FA", 0 },

At some point this should be switched to C99 initialisers and dropped unused
driver_data.

-- 
With Best Regards,
Andy Shevchenko


