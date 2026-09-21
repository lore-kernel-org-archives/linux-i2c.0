Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0574A0929;
	Mon, 21 Sep 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999842; cv=none; b=L6RJohk9/v6EX7XBt1FqaRa0MGntbK/k91CHBPsSBzWtNZuBNbx4PbubKcsLCNa9FUnYXUBfS/zG1vGBHuvDXtv+hRNCyQy9RljLEaBTBanAYvZy32fsHNlBFJF2WyeMoTSy/1uFhvnuSXvppIKxIpwlpiUQotwLGv9cE82x/fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999842; c=relaxed/simple;
	bh=Tk1Sz0bMnIy+S6wTMhvDyDYwSxQCIFCDvDIORXCA41Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0yDYPenjqjt0k/BTmEeM8ALgNHnQqYO+wJFAbSUmZcmipPnKX7jRr4TssZ9Hoip2fEMVAFjX/+2ckQVGp6uMimkPbBUZJkSodPtXA/VgrgUP2dcsR0U0DZQirciP3nj8DqeKJWxT8wzLIbxR7hrYhXp7UrjDn7NwX4dJ0aXkI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QkkVyBcG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkkVyBcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789999841; x=1821535841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tk1Sz0bMnIy+S6wTMhvDyDYwSxQCIFCDvDIORXCA41Q=;
  b=QkkVyBcGicgRjglrhRNgu8jdtpcS0Fii3rcRMhq4jqiim2XpkxXH5JUJ
   Kp/nj5qZ/BZqP+HoS0yfVts4bLNG5bPR9mb4KdbwmPjSZSCrNftEaNeu/
   Gmyc34+gFXDggmzig0YZxzLQoOaezS6KuSvGbQDmCJVQhUZJw6AyPDGaL
   M2zILtv2UVjy0sU5dmcmn2V1nvcDMjXfy/BwQlTJYfT06ZXFTkW5CNFTa
   RratGKujHz023ACF7tthZyckaiWF7Fke2iJTAdcDmV7gekRerS7dbF0wn
   gzRokD98OALN836R81Oh0lPQEqkM7lbGG0VGu3gVSKJjer+4VzuzYWtqV
   A==;
X-CSE-ConnectionGUID: h6yHAcd/TAuz6Ex6tguncg==
X-CSE-MsgGUID: wfkgChX5TxOMSwskokSA4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90533552"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="90533552"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 07:10:40 -0700
X-CSE-ConnectionGUID: 1YGukldCQLy8pERidkCJwg==
X-CSE-MsgGUID: VMy4Rk44SOmo2fuQ7/Ocow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="280722609"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 21 Sep 2026 07:10:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6B8E399; Mon, 21 Sep 2026 16:10:31 +0200 (CEST)
Date: Mon, 21 Sep 2026 16:10:31 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Aniket Limaye <a-limaye@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vigneshr@ti.com, nm@ti.com,
	u-kumar1@ti.com, lianfeng.ouyang@starfivetech.com,
	Ritwick.Sharma@arm.com
Subject: Re: [PATCH 1/3] dt-bindings: i2c: dw: Add DWC_i2c compatible
Message-ID: <20260921141031.GX106095@black.igk.intel.com>
References: <20260919-tda54-upstream-i2c-v1-0-b0b9f77be18b@ti.com>
 <20260919-tda54-upstream-i2c-v1-1-b0b9f77be18b@ti.com>
 <20260920-warm-lurking-poodle-dd73ee@quoll>
 <de66ac18-6bc3-4693-bd76-df8113bdb914@ti.com>
 <20260921111407.GU106095@black.igk.intel.com>
 <6fa3b1a7-33bb-4619-a0a5-42d99c076d2f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fa3b1a7-33bb-4619-a0a5-42d99c076d2f@kernel.org>

On Mon, Sep 21, 2026 at 04:00:52PM +0200, Krzysztof Kozlowski wrote:
> On 21/09/2026 13:14, Mika Westerberg wrote:
> > Hi,
> > 
> > On Mon, Sep 21, 2026 at 01:55:23PM +0530, Aniket Limaye wrote:
> >>
> >> On 20/09/26 23:54, Krzysztof Kozlowski wrote:
> >>> On Sat, Sep 19, 2026 at 02:36:06PM +0530, Aniket Limaye wrote:
> >>>> Add the "snps,dwc-i2c" compatible for Synopsys Advanced I2C Controller
> >>>> referred as DWC_i2c. Compared to the existing "snps,designware-i2c"
> >>> dwc is designware, so snps,dwc-i2c = snps,designware-i2c
> >>>
> >>> I think this is *the* argument why generic compatibles are wrong.
> >>
> >> These are 2 different controllers with some different registers and
> >> vastly different register offsets.
> >>
> >> So, the official product name (short format) for the SNPS Advanced I2C
> >> controller is "DWC_i2c", as per SNPS' own reference document [0].
> >> Whereas the original "snps,designware-i2c" corresponds to the product
> >> name "DW_apb_i2c" as per its own databook [1].
> >>
> >> So based on this I though it'd be best to keep "dwc-i2c" close to SNPS'
> >> own naming, despite the fact that it does seem very similar to the
> >> generic "snps,designware-i2c".
> >>
> >> If you'd prefer to make it more explicit, I could change this to something
> >> like "snps,dwc-adv-i2c"? Although, again, this does deviate from the
> >> convention that SNPS uses in it's own documents.
> > 
> > What about just "snps,ai2c" or "snps,advanced-i2c"?
> 
> Can we just drop generic compatible completely instead? The block cannot
> work alone, needs SoC integration.

Works for me.
