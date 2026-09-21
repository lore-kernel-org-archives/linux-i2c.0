Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5D4349BB;
	Mon, 21 Sep 2026 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989258; cv=none; b=kAiYQLzdf9GO00bv09r0idAtN/6ZvcT/nl9nSw4W7qbbn/dcuIk6bjXIGy15voF/xIMFmp7SivYU4oVBcTjpDRtGIwiIMRwiG433zCl7cWgSZqS50YdNAK273X9t5yqvSvuXcrA2opUHptNBDOy+3do1r5ULZyWfzkV2lgRvmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989258; c=relaxed/simple;
	bh=79Zf8PL5SVT74IOK8Ah2Wx7z0VraEAo3j14aT30jnoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYqSGxL8KhQ1p3mDJmsO1wBC0ykSpRgMOI2NYtTohNeyovmEYixcFLc8/mrMxLt563CnJhsoEbp9dyp1bUaAHN8AjQ/Z6LZ9vvZXx7KJQ6jwDmAryox7RUJ3iHheulTyyZhppvGqgP+qzpqskpJSD6IoJiXr1Pc/Mw5grUlwKrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWbzHUQp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWbzHUQp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789989257; x=1821525257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=79Zf8PL5SVT74IOK8Ah2Wx7z0VraEAo3j14aT30jnoc=;
  b=dWbzHUQpG9en+GYBi5urVeKbgDEdxv66ZMlfLfnoi/5kLSn54LWaebbJ
   0DtnDnYVBEOB7P7aq/FgckW08IiOiQfwR20xoBdTmxcmGhUphBdbWAuXe
   wSKfDE6Ovpmmj7//lYsTjBwHD10+fuiDsPPxSI2FyVTjR+RlToEncQu3X
   8GHXP9iKPS2w0ybdsPNhD8rAMIcedExQu+R8FjHP1PKkmYufeBElpsgB5
   0HqpOrjbO+NjKz5CD/VB5pWXs3bu6Dql31NNY3qm4WkjvTJlsK1g/wI2t
   JsVEcu9PAeinNJIsmFFR2bWTbhQtxn2UQSQQCZgdShZzD/PyGnT5Arp2R
   Q==;
X-CSE-ConnectionGUID: J/lLvxdWTgOdjfcXaa98vA==
X-CSE-MsgGUID: /rfBfsNISU6PuWH8Awqv0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="101844191"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="101844191"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 04:14:16 -0700
X-CSE-ConnectionGUID: ZYP5Z+sAQzWerACKC/X+SA==
X-CSE-MsgGUID: TgHbLUvFR3G5k1L7+2A+Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="271136809"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 21 Sep 2026 04:14:13 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id F26D599; Mon, 21 Sep 2026 13:14:07 +0200 (CEST)
Date: Mon, 21 Sep 2026 13:14:07 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vigneshr@ti.com, nm@ti.com,
	u-kumar1@ti.com, lianfeng.ouyang@starfivetech.com,
	Ritwick.Sharma@arm.com
Subject: Re: [PATCH 1/3] dt-bindings: i2c: dw: Add DWC_i2c compatible
Message-ID: <20260921111407.GU106095@black.igk.intel.com>
References: <20260919-tda54-upstream-i2c-v1-0-b0b9f77be18b@ti.com>
 <20260919-tda54-upstream-i2c-v1-1-b0b9f77be18b@ti.com>
 <20260920-warm-lurking-poodle-dd73ee@quoll>
 <de66ac18-6bc3-4693-bd76-df8113bdb914@ti.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de66ac18-6bc3-4693-bd76-df8113bdb914@ti.com>

Hi,

On Mon, Sep 21, 2026 at 01:55:23PM +0530, Aniket Limaye wrote:
> 
> On 20/09/26 23:54, Krzysztof Kozlowski wrote:
> > On Sat, Sep 19, 2026 at 02:36:06PM +0530, Aniket Limaye wrote:
> > > Add the "snps,dwc-i2c" compatible for Synopsys Advanced I2C Controller
> > > referred as DWC_i2c. Compared to the existing "snps,designware-i2c"
> > dwc is designware, so snps,dwc-i2c = snps,designware-i2c
> > 
> > I think this is *the* argument why generic compatibles are wrong.
> 
> These are 2 different controllers with some different registers and
> vastly different register offsets.
> 
> So, the official product name (short format) for the SNPS Advanced I2C
> controller is "DWC_i2c", as per SNPS' own reference document [0].
> Whereas the original "snps,designware-i2c" corresponds to the product
> name "DW_apb_i2c" as per its own databook [1].
> 
> So based on this I though it'd be best to keep "dwc-i2c" close to SNPS'
> own naming, despite the fact that it does seem very similar to the
> generic "snps,designware-i2c".
> 
> If you'd prefer to make it more explicit, I could change this to something
> like "snps,dwc-adv-i2c"? Although, again, this does deviate from the
> convention that SNPS uses in it's own documents.

What about just "snps,ai2c" or "snps,advanced-i2c"?
