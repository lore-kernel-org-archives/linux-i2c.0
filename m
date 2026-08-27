Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18833A70A;
	Thu, 27 Aug 2026 06:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811097; cv=none; b=tMBvsl4JvXnDbOhpjXR6qC7EkpZewWmkg9M2U0DUGMYxvLSSeFodDigxslQWSTodZ8wXOXIYSAfYmxB4ZUjAZXGEPkeKmukvokodSQ5Ys3MbpagEixGXsv4J/W8+pkOd/ytxHX74zaLvEyJ9PideSkiGaDFcH3JRook+R8ckj2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811097; c=relaxed/simple;
	bh=IthF8h+A1eSCO6aqbHA7SVYjhSL3fkHC56HaupR3N2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvaTZGKVeCIsr07c/yyMtzY2E6mFYeD3HgHFWPVOIYpphCYgpCfPYtitrx6GygblSocIS5l1A8MTiKDjypsolMfBf7wDZTTJQ0wW7/715Q6DDv5y4R9TeYjhW8zp5csqkKFqY1izXx3sUpIixn+EQ73ek/Su4rWBMcx2kVzsjgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5lrisGy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5lrisGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787811096; x=1819347096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IthF8h+A1eSCO6aqbHA7SVYjhSL3fkHC56HaupR3N2c=;
  b=R5lrisGy9UlEYYFI5+mGyUkZ7lVbSgjySIosmbrC0tioZLVqXkuePMsM
   19FlnaijIo5yOeXj5r7d4dL3NBtJIaeUAA9/BE1zKE7Wsy1LKGWyEjF7c
   g4UUAYIWtjMsmDwSd9cig3oL2Nxxyxl3cT7KfRPhhvrhbW8zkEjny2dA2
   9oEB7RihcbgGC7K7fU3iuvo16SRr6VRmhvRuSEGg7mBECwqO/qCywxmAq
   Y2k8jNgDsOZyoTyBqfIVKi3JmOaooLImiS21e6pswUSsvJhyU2wyaerbO
   M9vZDeqJMNH1DnouUGnL7WmNtqdHDzHm7qh98E+DHlPwKGst87u+FK7lq
   Q==;
X-CSE-ConnectionGUID: Cdr3bg9HS5qfP47H/wbtgw==
X-CSE-MsgGUID: j3cUIeHZSzy1MPTUiRdctw==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="105827628"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="105827628"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:11:35 -0700
X-CSE-ConnectionGUID: mSgmF1G2QL2plcLBfJCqlw==
X-CSE-MsgGUID: ZrmhYQUQTouygd8foY5/9w==
X-ExtLoop1: 1
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:11:33 -0700
Date: Thu, 27 Aug 2026 09:11:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Peter Rosin <peda@lysator.liu.se>, Andy Shevchenko <andy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] i2c: mux: Propagate software nodes to channel
 adapters
Message-ID: <ao_VE0W-FohWqPPt@ashevche-desk.local>
References: <cover.1787502619.git.ahmadexp@gmail.com>
 <a4abcd31c3a6758e219f5edcdd4acd307e674f18.1787502619.git.ahmadexp@gmail.com>
 <ao0tPhBvK1Er_Vs0@gryt>
 <CAOQiBWNVvHpO7X8yWyZEa3-nV76YJfRbkzo+_4U-upEj4VNfow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQiBWNVvHpO7X8yWyZEa3-nV76YJfRbkzo+_4U-upEj4VNfow@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 26, 2026 at 08:29:47AM -0700, Ahmad Byagowi wrote:
> Hi Peter, Andy,
> 
> Yes, software-node handling is needed for the ptp_ocp use case.

That driver is a mess. I'm surprised nobody told to the authors of
the respective changes to look at the auxiliary implementation.

> ptp_ocp is a PCI driver. It creates its board-specific I2C topology at
> runtime with software nodes: the mux, its channel nodes, sensors, and LED
> controller. Firmware does not provide ACPI nodes for this topology.
> 
> The existing acpi_preset_companion() path only associates a mux adapter
> with an existing ACPI child. It does not associate the adapter with one of
> these dynamically created software-node channel nodes. Without that
> association, i2c_get_adapter_by_fwnode() cannot find the channel adapter by
> the channel software node, so ptp_ocp cannot instantiate the downstream I2C
> devices on the correct channel.
> 
> Does this address the concern, or would you prefer a different way to
> represent this dynamically created topology?

Wouldn't it be possible to use some kind of DT overlay to have that?

> Thanks, Andi, for taking the first patch into i2c/i2c-fixes. I will drop it
> from the next revision and rebase the remaining two patches once this
> question is resolved.

> On Mon, Aug 24, 2026 at 10:50 PM Peter Rosin <peda@lysator.liu.se> wrote:
> > Den Sun, Aug 23, 2026 at 09:34:38AM -0700, skrev Ahmad Byagowi:
> > > Device Tree channel nodes are associated with the adapters created by
> > > i2c-mux, but equivalent software-node descriptions are not.
> > >
> > > Use generic firmware-node operations for the existing channel lookup and
> > > accept either an OF node or a software node. Associate the returned node
> > > with the adapter so child I2C devices can be instantiated from
> > > software-node properties.
> > >
> > > Save the adapter firmware node before adapter deletion and release the
> > > reference afterwards, following the lifetime pattern in i2c-atr.

-- 
With Best Regards,
Andy Shevchenko


