Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527192;
	b=XaR8SPtO3ifTQhYAkuMaOq4HgJcpr8woAPkZA+OpYFqQN9rUqyM/xeztpsoDq0ulp4vt
	 jR6zgJ12HtT0wrAKqlebjArLOxof9y5wgZP7F1YL9rWqlGlvCEj2xyJkAQW2iQ/LAjVRJ
	 7MQKOo4+fkzCAkYS/varnY5kxNKghcVBLPA3MLIZ+pSpC8VRFFnAxYf+eTIcqvKqQOtdN
	 MQmzXWM5tMrp995T+VuGfK8mJ+PydcOESVvEYNgV46h0Q3pfFFtJZ0H+O/9iycnULr4TE
	 BmLndkyLlereIWmBqlP7zxLGWxHpBytmr+emxwhKnbhQ+ukwNHW7ImK7yjm4JXPaSKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527192;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=599vSAb1qpW+ivOrvJ5DYuGSGKJSCi2Fy0I3YlD0SOY=;
	b=kH0ZpRhWEfteHWlibFy90RU3/sJLe94Kc/9Vyg+HjIe5Z/XWWda3Q79n4SGrMNZ8nPXF
	 x4thsD3M139HeIVgOgrylf5lRFiqq2+FtZvbAxc4pVwXQuOmFDVxihsL6hmEaSW60+gUB
	 SaitGmlMwsXLKwR0xrwyJc6vcOzuguQ9eFA5zAX9LyvvJVGa+Iw3nkKM/dSIANnl11bgy
	 /SOr9N782uBHwAeiIM+b2RYAFni1iUhPNmIZP5OhCUTmKVg5LKYVreNypcCDyqrz3k6SU
	 9HvxJeGbRVUfmTOiA3/mNp6UGm/qqjbpU24VqQ6GA4MV3+O42sFW0WosPIQOv+979Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JcxABt8m;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF77606A699;
	Tue, 24 Nov 2026 13:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECF77606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JcxABt8m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795527193; x=1827063193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=599vSAb1qpW+ivOrvJ5DYuGSGKJSCi2Fy0I3YlD0SOY=;
  b=JcxABt8mMpPSHRsnVhjaJIT/Vc/v5QwjU2yT5XxeLygHOKS/US4s0xwS
   gggvtwzdstmImeAF1ER21G2b6vYSxz+pJ+GgzSPrxaqsg3hgzF841wGrW
   0voWpIihtrYaglIDaDlpX+wlokGbw+8ylTXhHpYLBHsfdGO7iGMKH5HlH
   7NAYmfy56IROcCYNBdJP43dwjwpMq64i1kYtN159ylScrnl8nd4cKGcq5
   lNvCvQl8DGWFgTHNDnx3VyGqIMNAfcjrjqmBeYByDgVSusvd+PJd/HYUQ
   5QGbtJYrTXiH6I26JpmdMFY3mf6c9uJlIlg0RsRmrIjG7mbR4Gi68Kkhk
   A==;
X-CSE-ConnectionGUID: Xd3dT05kT2C/g3/NCRfM5w==
X-CSE-MsgGUID: qBDu2pdsT/KNCVWq//YNPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4242995"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4242995"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 05:33:12 -0800
X-CSE-ConnectionGUID: acne9dIBRrufqDVaT4Aycg==
X-CSE-MsgGUID: ihL9+qSLTqmuwiNpyfOShA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11920759"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 24 Nov 2026 05:33:10 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id C584594; Tue, 24 Nov 2026 14:33:08 +0100 (CET)
Date: Tue, 24 Nov 2026 14:33:08 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: penhouse24@proton.me
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz
Message-ID: <20261124133308.GP229695@black.igk.intel.com>
References: <20261118073607.297350-1-mika.westerberg@linux.intel.com>
 <70618789-f82a-4cd7-953a-a97f555fa98d@oss.qualcomm.com>
 <z-Mjt3eV50ZiycWjeVe9dfla5WKoCPC1UXZdFSx2V8YVhr77FH3eKc-WLQgGT_gu1l8NS_-IUcw_-ASU1x_al7IzQuW6FhccBUylTg0yZqM=@proton.me>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <z-Mjt3eV50ZiycWjeVe9dfla5WKoCPC1UXZdFSx2V8YVhr77FH3eKc-WLQgGT_gu1l8NS_-IUcw_-ASU1x_al7IzQuW6FhccBUylTg0yZqM=@proton.me>

Hi,

On Mon, Nov 23, 2026 at 03:03:29PM +0000, penhouse24@proton.me wrote:
> Is it safe to say that this fix is going to get pushed to the main
> kernel?

This still repends on Andi to actually pick it up. Once it is in his tree
it is likely it hits the mainline as well unless something catasthropic
happens.
