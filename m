Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC6133D6F1;
	Wed, 28 Jan 2026 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591306; cv=none; b=Yr6IWOK8SiHItgzA4bsx6YbxG2DP+DWSug8hINPeGQG/t+f7Nrr5ilgwJSOQXNBUs1WvanPyeahbbwTpsjr4sSmiDw+OEuZxmvaTp+7PtcNRMPHv6ZdbfqRZ98+wvusEYMnx2jWGI+R5D9tfnuW7zJt4zsXWHC2ULd0/sKEXelg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591306; c=relaxed/simple;
	bh=gxwCy0FohwCt9CfP2SEhBKQ4OsUrFKsR651bzfSP/XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN+TQLZ3dgDiGjCUcS86/kx900CCi/UFVMNN6UTfOda8+6war66emCmyHSlglsrBNpwADiTV9GjaMdH4Q1hX7lwxj4M+4FZ2WxDCNfemgSzblVimbPC5dqtWtbh4p9dQm1yuAUKHAbWZXnWWTndPU5J2nx8fFWXwI3jO85wJiKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQKIvy6d; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQKIvy6d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769591304; x=1801127304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gxwCy0FohwCt9CfP2SEhBKQ4OsUrFKsR651bzfSP/XE=;
  b=cQKIvy6d1Gj85XX2OLBHD/ifN4PmfD6jGRrd4Q69FwsjTiUn2rzWYHpa
   k/IRfk20C0ifo+FJkr59Dl7wUGRzuwTRPioxm8nRNGSuB4BDiAT0xSP/z
   NaB3RlzTNJ0StUxaxn29BHvs9JbafwJglzZPymXwRY0WF1uaMwEF+ypvR
   +EvuiXAwvEupYb6t8i+Pk9FJyLWlPcTwOB/Y2JaStKbxY1xcrhknnCoaj
   Gq5GJ7IdIoFJYz4S9ReZBhqCCc3EUT3SHgvgbJ5Q5k7AL8ieD7mFJi4cl
   ZJ2ljD9hpVDcfeqsa73R8UGTO3S1Dnw4qunYjchPoN9DnA+C0oWKgyZ5e
   Q==;
X-CSE-ConnectionGUID: U+tbU99qSJWpL5eSrtQGoA==
X-CSE-MsgGUID: MgFj7+XOQT6r/iiScmpU4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81907542"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81907542"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:08:24 -0800
X-CSE-ConnectionGUID: 9M5/o0cUSTW0V0iCuyGmKg==
X-CSE-MsgGUID: PEobMgvDSRCos5YnKU1ttg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207352824"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:08:20 -0800
Date: Wed, 28 Jan 2026 11:08:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C
 controller
Message-ID: <aXnSAgPbTZ_IY8mQ@smile.fi.intel.com>
References: <cover.1769476820.git.zhoubinbin@loongson.cn>
 <402121da829497fc97f1461c8aaa3a44252c3f06.1769476820.git.zhoubinbin@loongson.cn>
 <CAAhV-H5mYypVAXJVpQ7ZJCMd4OvtxkJ6BcKbph1e-JTd5u3xiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5mYypVAXJVpQ7ZJCMd4OvtxkJ6BcKbph1e-JTd5u3xiA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 12:15:08PM +0800, Huacai Chen wrote:
> On Tue, Jan 27, 2026 at 10:48 AM Binbin Zhou <zhoubinbin@loongson.cn> wrote:

...

> >  F:     Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> > +F:     drivers/i2c/busses/i2c-ls2x-v2.c
> I  still think it is better to move this line below. Though it may
> cause a checkpatch warning, but for checkpatch only errors must be
> fixed, whether warnings need to be eliminated depends on the fact.
> 
> >  F:     drivers/i2c/busses/i2c-ls2x.c

This should be sorted, and

$ cat << EOF | LC_ALL=C sort
> Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> drivers/i2c/busses/i2c-ls2x-v2.c
> drivers/i2c/busses/i2c-ls2x.c

Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
drivers/i2c/busses/i2c-ls2x-v2.c
drivers/i2c/busses/i2c-ls2x.c

The patch is correct AFAICS.

P.S> Remove the unneeded context when you do not comment on it,
do not make others to waste time on reading that.

-- 
With Best Regards,
Andy Shevchenko


