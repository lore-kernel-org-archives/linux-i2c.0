Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6364385D91;
	Wed, 12 Aug 2026 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519005; cv=none; b=ksOGcbraiNbGodRkzc+VvIVKxGl1VpuUUtwB1AGXlB4Ow7dXa0Nh2OLavQfgm57iA5VEpEvoV7ixqg3OJ+EeYy/oBZUXkYO7mUfYr/iOKRjM9J3nkvyfipZxxEvCVkqcWeOSua2Y4mu1ShzpPGPEJ+oWX2MbHiwSZj+t/nFCu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519005; c=relaxed/simple;
	bh=mG/Q8Uxj4eiCByMfbsiv7AtBBBt78drdE0Qx2rHeGfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFMCMxOjbXZk3Bz/oA8hpIEx5L+xbZY37I3RzuKWAQAoM6oFXKyJne0Ls2Je9SWkrwaxvY/Ik8vX2wki94Q+T4YR1APFEdssKITr8WKaHQemEw0ODpw9xLCLon0S63666KRUk68czJYfgSuoLSUbB3FnoYx5uTDpZVtf5jxG8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVQqGZCS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVQqGZCS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786518994; x=1818054994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mG/Q8Uxj4eiCByMfbsiv7AtBBBt78drdE0Qx2rHeGfg=;
  b=WVQqGZCS+puUqV9KoLDO2XcnLJoVsysFpN0mzH+v6RKgIJMzO+TLqqAr
   n/O/qqL0FEfFbgdQRvv4CfSaklzaYGIVkL+pwkon6z9yStzEiLSGrZvF1
   Dh0S94dT5birMebN3TPbfSwJtdILiLpek8n8/gzpCsz5ygy8t7wmEMnUR
   bGosEBJI3UXyGLwlOa2BD7pwNsHMkw1ApJfEV6CXu7Cf88CtwAvDXfdVP
   tAdzrx6IQq3ugGd7+Yr9Onpz1q0tCrbM2gPRnTP4LkaTP6M6puW1LjPho
   g8LaL+RceqflvKSTuhqH0+3NpfDxXTBiT2sK7LaaZdyAKfVnhPeY6BEdD
   w==;
X-CSE-ConnectionGUID: TlyeZMRFRBSOGmC/LivEkQ==
X-CSE-MsgGUID: 5gRB55jYRwG4csRVQJDveQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86020077"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="86020077"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 00:16:33 -0700
X-CSE-ConnectionGUID: QOnaqTK/QsuFSxegFO6wgw==
X-CSE-MsgGUID: BxQKH3AIRtu18uVdx8WKIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="262249148"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.92])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 00:16:32 -0700
Date: Wed, 12 Aug 2026 10:16:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Umesh Kumar <ukumar@marvell.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, bbhushan2@marvell.com,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: designware: Enable SAR in slave mode for
 Multiple SAR controllers
Message-ID: <anwdzfNei-2GhPrp@ashevche-desk.local>
References: <20260804041842.3205356-1-ukumar@marvell.com>
 <20260812034017.3654884-1-ukumar@marvell.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812034017.3654884-1-ukumar@marvell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 09:10:17AM +0530, Umesh Kumar wrote:
> DesignWare controllers synthesised with the Multiple SAR feature (e.g.
> Marvell CN20K) only acknowledge traffic to the primary slave address
> (IC_SAR) when IC_ENABLE[19] (SAR_EN) is set. The slave enable path
> writes only IC_ENABLE[0], so on such controllers the target never ACKs
> its address and a remote master cannot reach it.
> 
> Set SAR_EN together with ENABLE when entering slave mode. The bit is
> reserved (and ignored) on single-SAR controllers, so existing users are
> unaffected.

In the commit message and in the code comment below, can we refer to Synopsys
DataBook for I²C where this bit is described? Or is it Marvell custom bit?

-- 
With Best Regards,
Andy Shevchenko


