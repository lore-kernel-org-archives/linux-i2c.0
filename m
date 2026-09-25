Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A11E2D060D;
	Fri, 25 Sep 2026 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331059; cv=none; b=ZYBOr+AwuVzSD4WVo3RwW+Z4AiXPH6BgCzHiPeH8PURnH4EkaLldUOa8SBubejofeOwBAqtVfANz5RylU454migCuri2vkoGtL3Y6nr/iECoIjUvzu3dLAtYeIwlisZOoVD5l7dp/OtNcKS47WfF3CuM7gcAIOFhNhjm2rb3x1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331059; c=relaxed/simple;
	bh=nGspYnnDwbxEw2uzhbTdVx6pk6eDe92BH9ntuHaRs/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eu3mob5gTyVuAJtUy7jqtfAjhtiPvl/4psjqK+japyQ3oGMl3gZIj4KvObB15b8SYz4Dy1FlyNQ9gsjwD989PBHj6ZtO9LH2SbvAC2y8goUfL9VJWOchG5ymqoCnhYiVqUkcH5Ll5kZoTbLrLo78G6iru6Im27Bab92TYW63pjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQUDUcjY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQUDUcjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790331059; x=1821867059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nGspYnnDwbxEw2uzhbTdVx6pk6eDe92BH9ntuHaRs/s=;
  b=DQUDUcjYJlrYi2M0bC8/LrG+DXZe06sKT9pz0nMrhBmDjRK3at/G2CvM
   QqVmC+roUuNVhc+S681bwKZte9ghed6QC9iX7uNTFmC+DWKdCYEzEq5qq
   QAAjsS5+Cq3k44IAl1NdA5e+GyGezUYni4jtMAn9eSQdX91eNYOVPE/YA
   IOiTSM7KGwd2hM3XziHMYW/uf4/f3bSPiHNQafJE7oxwvGn/odaNI2mR0
   zdEVi25x2qmP+8IZ/P5m3KdwIYLtJhuXcG2QdW8GcArLmhet4LceR9dO9
   mnKUYlZa+C1eck8JOA8mHXDt82DUjoxGFkUCU3LMAc/3Ku44PFcIDq/VG
   A==;
X-CSE-ConnectionGUID: 9FeoPqabSZG94zN5quq73g==
X-CSE-MsgGUID: 9HQm0bLPRuadqBYDTw1JDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101288009"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="101288009"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 03:10:58 -0700
X-CSE-ConnectionGUID: prgoZqEoTTSgWFpNLRmd4w==
X-CSE-MsgGUID: nO3lvYNQTrWGkYi4OVRZxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="282384381"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 03:10:52 -0700
Date: Fri, 25 Sep 2026 13:10:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vigneshr@ti.com, nm@ti.com,
	u-kumar1@ti.com, lianfeng.ouyang@starfivetech.com,
	Ritwick.Sharma@arm.com, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/3] i2c: designware: Add TI TDA54 I2C support
Message-ID: <arZIqk6wgV_LF0rg@ashevche-desk.local>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
 <arZB2s3HOBgSRuE4@ashevche-desk.local>
 <e0f113ea-92cc-4e82-85ae-f61814c230c7@ti.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0f113ea-92cc-4e82-85ae-f61814c230c7@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 03:29:27PM +0530, Aniket Limaye wrote:
> On 25/09/26 15:11, Andy Shevchenko wrote:
> > On Fri, Sep 25, 2026 at 12:26:27PM +0530, Aniket Limaye wrote:

...

> > Still doesn't look good. The current register layout may be left as is. What
> > you need is translate it in the respective regmap callbacks in case we are
> > enumerated on the different IP. Also possible to have a different regmap
> > config for the different HW where you translate them only in one place.
> 
> Is it confusing to keep using existing offsets in regmap_read/write() call
> sites for TDA54, and let the regmap silently handle the translation?
> 
> Given that we do *not* have any new registers in use on the tda54 version
> that were not there in the original one, I guess it works... will send a v4
> as per your suggestion.

Depends on the mapping. Your series also forgot to provide the differences
Check this as an example: e539f435cb9c ("spi: dw: Add support for DesignWare DWC_ssi").

-- 
With Best Regards,
Andy Shevchenko


