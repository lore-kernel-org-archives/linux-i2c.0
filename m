Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033BE2772D;
	Mon, 25 May 2026 04:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779684295; cv=none; b=YcJOOq0eMvftuVcdHn1d97RNzn+yibACZDMpzBwqLWgPsK1tz9wFzZmfimnUkiIe5YzXRhtlvdJLrMNRMytVbunqsRnV9HMKUKMLjpB1uf5bQEunPpQHzrSug9KHL70Pxiw1PIvpHmw98T4cLwrzsxUhVTNYmMcbJyP9unWXIDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779684295; c=relaxed/simple;
	bh=yziXN8nyzdOeHLvTvXteAAPFWez2FTDmLp4cxhaxQ8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxKauSSq7IFJPZKK1Ru5akRtB/CxhveMNjoKUltQiAh6k/Nag1TXqLoL4OrO+QExPFcBp2btZ+wu0Rw6Qf8ZYR8i6mrum3kPyq2LdSkmhtsXJxbgZmbaFRT9FaXp02JI2TDtEnYusDPYJbWVrc7ko+WO5MPKG6d1XC5mU9Nnj9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVBiDQh/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVBiDQh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779684294; x=1811220294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yziXN8nyzdOeHLvTvXteAAPFWez2FTDmLp4cxhaxQ8o=;
  b=eVBiDQh/+nvCxfR+zDCqfxmimqdeZtTUPFp/Q19BKX0bYdIQHmy5XZHr
   0wkHSd6HzZvC0Efbxd2ZNwB5G8sp4T+I3bdzM77944BZS9Cr74/ImlbeK
   Cg6TgdvlvDVE2YiPmXFVK/z9wB0TxCZlp4+JBdEm7uvjgfhp0f/8CZojY
   D2snSfD3wAnWc5O4wCLuxWmT+0bBp91A2xM1p0B038Cbzv0S+zLKiMubu
   gxh6dZU/EP9djBEGnsUPvMtEg+Ldmwa83TmxvImQtgAbPOeScF47zbiWT
   am8Jyq71wtTUes47rQ+exNtc3G8m5Hbi3GPs/fmeRn+yl23c7xvBiT3HZ
   A==;
X-CSE-ConnectionGUID: pA2czT0BSHq0Fv67Kp4EfA==
X-CSE-MsgGUID: JscDDarxQmyhuEdN7o+9gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="84389725"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="84389725"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 21:44:54 -0700
X-CSE-ConnectionGUID: f+Q9jSxuQKerqT8LNKMc3Q==
X-CSE-MsgGUID: zGkk1OmsTm27KVOArqLOJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="245769602"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 24 May 2026 21:44:53 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4C93895; Mon, 25 May 2026 06:44:51 +0200 (CEST)
Date: Mon, 25 May 2026 06:44:51 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i2c: designware-pcidrv: Consistently define
 pci_device_ids using named initializers
Message-ID: <20260525044451.GJ8580@black.igk.intel.com>
References: <cover.1779481436.git.u.kleine-koenig@baylibre.com>
 <68667c4ab85716b190d8b705813b610e21a386f6.1779481436.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68667c4ab85716b190d8b705813b610e21a386f6.1779481436.git.u.kleine-koenig@baylibre.com>

On Fri, May 22, 2026 at 10:35:13PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> The .driver_data member of the struct pci_device_id array were
> initialized by list expressions. This isn't easily readable if you're
> not into PCI. Using named initializers is more explicit and thus easier
> to parse.
> 
> This change doesn't introduce changes to the compiled pci_device_id
> array. Tested on x86 and arm64.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
