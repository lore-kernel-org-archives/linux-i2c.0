Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A30426429;
	Fri, 25 Sep 2026 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340841; cv=none; b=bB0Xa8RV979Jr8fd8bR1zReZR8csjy8CKG/jf4hygwuQshZ1dVa31MPvAZiDvopoRC7REZ1tznrdrtnxReRFAiT362gBIye55teyO24EvnOwCbQim8dR2n2RzcAbEbEdGcSihwpLK8tHxTxYrtLsBqRLtJaZ5N3CKUjtJSoi8qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340841; c=relaxed/simple;
	bh=7QFQaHhQHwO4JjYiWqEtP4ey1qTU6R5eBhvbiXj4+cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYJ36uChpReu8WM9LYZzEpcrz4MwVQz0zNj/NPEcNEy1tXh/ts5OtmadMPODkkuhmWyQAbiyC5FnNfMW2wZA0yPmCDJEwcriue7zBUH6pTOm3faLDkq1NWZhSgePqaDMvUBXBfLvX6HWdXqdUa0y0ezQ+XKoflPGEDWzgbV1bgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqEFl0nT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqEFl0nT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790340840; x=1821876840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7QFQaHhQHwO4JjYiWqEtP4ey1qTU6R5eBhvbiXj4+cY=;
  b=AqEFl0nTf32VjvPU6jGRFSlvBIgrQGvmVfLO1HCoIcV9kckNsxmvRs3X
   gsBU4fYXWvd3tEH5Tl8pp3968xIedbbzTlp6YmW3Ch/eNMoNzgI36Pskk
   kbsQUxqR2z72gK20NsvV76Fr8vuLw+wfYhRAyUnv+m/tOq45baOGmYymE
   ck04wuPTY20nbSWFbIzyVwM9qUo1iEE559il91j2Krf8MjfS5E6nrRteD
   eQfyNTm1xmIACdT4Yz6oQ+ww5XieAGDOwhnWPY5Lolqv/pT9MrmEML+8r
   I4dayewAmpt95ArEbx4V5fdmnxPqb5nRm55xq6hf25rx1jgoB+OGtzDgr
   g==;
X-CSE-ConnectionGUID: bxmujoH/Qh+c5jGkSPHo2A==
X-CSE-MsgGUID: nGEZis6PS0O/WXasbxs6Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="102486238"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="102486238"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 05:53:59 -0700
X-CSE-ConnectionGUID: 4PIYZybqQxehFdbSfdSDZw==
X-CSE-MsgGUID: bpl31Ej6T1GrkfDHe8iYYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="274497205"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.27])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 05:53:54 -0700
Date: Fri, 25 Sep 2026 15:53:51 +0300
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
Message-ID: <arZu33UFU2b7kVRR@ashevche-desk.local>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
 <arZB2s3HOBgSRuE4@ashevche-desk.local>
 <e0f113ea-92cc-4e82-85ae-f61814c230c7@ti.com>
 <arZIqk6wgV_LF0rg@ashevche-desk.local>
 <386f23e4-d573-45f7-9e2f-fe47015a4761@ti.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <386f23e4-d573-45f7-9e2f-fe47015a4761@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 25, 2026 at 04:46:39PM +0530, Aniket Limaye wrote:
> On 25/09/26 15:40, Andy Shevchenko wrote:
> > On Fri, Sep 25, 2026 at 03:29:27PM +0530, Aniket Limaye wrote:
> > > On 25/09/26 15:11, Andy Shevchenko wrote:
> > > > On Fri, Sep 25, 2026 at 12:26:27PM +0530, Aniket Limaye wrote:

...

> > > > Still doesn't look good. The current register layout may be left as is. What
> > > > you need is translate it in the respective regmap callbacks in case we are
> > > > enumerated on the different IP. Also possible to have a different regmap
> > > > config for the different HW where you translate them only in one place.
> > > Is it confusing to keep using existing offsets in regmap_read/write() call
> > > sites for TDA54, and let the regmap silently handle the translation?
> > > 
> > > Given that we do *not* have any new registers in use on the tda54 version
> > > that were not there in the original one, I guess it works... will send a v4
> > > as per your suggestion.
> > Depends on the mapping. Your series also forgot to provide the differences
> > Check this as an example: e539f435cb9c ("spi: dw: Add support for DesignWare DWC_ssi").
> > 
> Ahh sorry about that, will remember to add a clean mapping in cover letter
> of next version.
> 
> For now here are the structural differences:
> 
> 1.  Reg offsets  Existing        New TDA54
> 
>     [DW_IC_CON]                     0x00           0x2c
>     [DW_IC_TAR]                     0x04            0x30
>     [DW_IC_SAR]                     0x08            0x34
>     [DW_IC_DATA_CMD]                0x10            0x80
>     [DW_IC_SS_SCL_HCNT]             0x14            0x4c
>     [DW_IC_SS_SCL_LCNT]             0x18            0x50
>     [DW_IC_FS_SCL_HCNT]             0x1c            0x4c  /* same as SS */
>     [DW_IC_FS_SCL_LCNT]             0x20            0x50  /* same as SS */
>     [DW_IC_HS_SCL_HCNT]             0x24         0x54
>     [DW_IC_HS_SCL_LCNT]             0x28            0x58
>     [DW_IC_INTR_STAT]               0x2c            0xc0
>     [DW_IC_INTR_MASK]               0x30            0xc4
>     [DW_IC_RAW_INTR_STAT]           0x34            0xc8
>     [DW_IC_RX_TL]                   0x38            0x84
>     [DW_IC_TX_TL]                   0x3c            0x88
>     [DW_IC_CLR_INTR]                0x40            0xcc
>     [DW_IC_CLR_RX_UNDER]            0x44            NA
>     [DW_IC_CLR_RX_OVER]             0x48            NA
>     [DW_IC_CLR_TX_OVER]             0x4c            NA
>     [DW_IC_CLR_RD_REQ]              0x50            NA
>     [DW_IC_CLR_TX_ABRT]             0x54            NA
>     [DW_IC_CLR_RX_DONE]             0x58            NA
>     [DW_IC_CLR_ACTIVITY]            0x5c            NA
>     [DW_IC_CLR_STOP_DET]            0x60            NA
>     [DW_IC_CLR_START_DET]           0x64            NA
>     [DW_IC_CLR_GEN_CALL]            0x68            NA
>     [DW_IC_ENABLE]                  0x6c            0x04
>     [DW_IC_STATUS]                  0x70            0xd8
>     [DW_IC_TXFLR]                   0x74            0xdc
>     [DW_IC_RXFLR]                   0x78            0xe0
>     [DW_IC_SDA_HOLD]                0x7c            0x5c
>     [DW_IC_TX_ABRT_SOURCE]          0x80            0xd4
>     [DW_IC_ENABLE_STATUS]           0x9c            0xd0
>     [DW_IC_CLR_RESTART_DET]         0xa8            NA
>     [DW_IC_SMBUS_INTR_STAT]         0xc8            NA
>     [DW_IC_SMBUS_INTR_MASK]         0xcc            NA
>     [DW_IC_CLR_SMBUS_INTR]          0xd4            NA
>     [DW_IC_COMP_PARAM_1]            0xf4            NA
>     [DW_IC_COMP_VERSION]            0xf8            0x100
>     [DW_IC_COMP_TYPE]               0xfc            0x104
> 
> 2. DW_IC_CON bitfields:
> 
>     DW_IC_CON_MASTER BIT(0)                  BIT(0)
>     DW_IC_CON_SPEED_STD                 (1 << 1)       (1 << 4)
>     DW_IC_CON_SPEED_FAST                (2 << 1)       (2 << 4)
>     DW_IC_CON_SPEED_HIGH                (3 << 1)       (3 << 4)
>     DW_IC_CON_SPEED_MASK                GENMASK(2, 1)  GENMASK(5, 4)
>     DW_IC_CON_10BITADDR_SLAVE           BIT(3) BIT(8)
>     DW_IC_CON_10BITADDR_MASTER          BIT(4) BIT(9)
>     DW_IC_CON_RESTART_EN                BIT(5) NA
>     DW_IC_CON_SLAVE_DISABLE             BIT(6) NA
>     DW_IC_CON_STOP_DET_IFADDRESSED      BIT(7) BIT(10)
>     DW_IC_CON_TX_EMPTY_CTRL             BIT(8) BIT(11)
>     DW_IC_CON_RX_FIFO_FULL_HLD_CTRL     BIT(9) BIT(12)
>     DW_IC_CON_BUS_CLEAR_CTRL            BIT(11)  BIT(14)

Thanks for providing this mapping!

> 3. To clear INTR,  Read DW_IC_CLR_* reg    Write bit to DW_IC_CLR_INTR
> 
> As you can see, it's an entirely different mapping, which is why I had 2
> independent enum -> reg offset maps instead of offset -> offset translation.
> Similarly, selecting a CON register bitfield layout too.
> 
> Let me know what you would prefer based on this...

This clears a bit the whole picture and what I would like to say is that better
to have the separate driver for it. On top of completely reworked RTL I believe
you won't need tons of hacks and workarounds that are applied during all these
years against the old IP.

TL;DR: Make a new clean and simple driver, which is hack-less and done properly
(using the all modern APIs and frameworks in the kernel).

-- 
With Best Regards,
Andy Shevchenko


