Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581202;
	b=T92S61w4TKdUd50CMtLCdrFq13fSA4sFv6CJtMjU22jXBdGsKcHuS7nhuM77tyQYEn7k
	 BlrBDCO3hEx+i9IVSCx47CGVePOHrKiDxnPUoRAMd2cCGfyTsJLrmAyJBAkKYB0R7gRdt
	 7dGmA1Dy9jJ+U5OJ3FNfs0KQBaBq40aOuBsnzxuaMzB2C3Zqif6Fvc2q/YUosMQH2uq1S
	 XtRjFJVocMtB+8/E1kMRjjdrTGS7HJPM+VC/zDM4m07X57L4f7mtzBFnaxuDQena2As0j
	 Xd33sQSkX0V6fXs8QY4cJ8FQT7ep4t6FVm/Cpi6D68Q67Ri/mfLED3BxbLdNM5VyzHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581202;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=eFdURxg1ExgwJyMy5pVtoIk7ER5zKiuVuR5kjNIKldg=;
	b=Nvvft9PpOzSgLjUvGjfqgnEmbVmD+4VNuKHPNLaXWceqDTrPZBK6WlGXmOXVmi6FeO/3
	 WD6kzylhMUDS+jh5KVcE2K5HzT0/GQdIg9i340G18z+1YQxEx7G0x+B+GMutUkO6TQu4R
	 Xj/IIXhgPfBg/tIRlj+xqzPB7YH0gvhs5lLZg3qGoNdOMexQgQuyDkSQc5crqfeXP2U/C
	 fzcop8A4U8vBG8XAbUYTMHaJUlLPH8wk7LShm2RPoXnIu9g1O6dY6Qs1FjT6D+hixm+/O
	 VHr4+piNwHkScZAuLyicZEHeuQr4q0asE4d+wQOxaZZ1r2MLyKkdYHzlpK5jZ8P3x1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="PBB5Xzn/";
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBAC606A88C;
	Fri, 13 Nov 2026 14:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BBAC606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PBB5Xzn/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794581201; x=1826117201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CtnK1QwBbhYjABQLuei6P7Z+yLRVqDIHpc6xOj09bS8=;
  b=PBB5Xzn/WR0wtz8p6UHxxZ3xCPJ/++wKdKvqbU7dZstesrD6dBgF/r5+
   jwq+RvXzPIauCjRsqzx2+blOXlcxPYXMqsf/baIed6Fp3Q7bG4cRAqkOW
   Zrd3FYl+YsyGAs4bqfQyrgBIC1oU3Tc6uli5tTWetsxU38t51AjG+bzT0
   CIyQh1yKJCfX4nm2wwaSpQ+sMIqVi6D5chD00nm2gY/ymRqeit1xHYSpD
   Cv3K7Se0Lh7CckcM9N3mi51d+YsGEoKm3UnS5vXmP4FfjAneDmpEZ1g3q
   9Zn79mMMH1wL/aiWsR+yHuOmDq1ZwzuRKzpZA337M5n+lYS6y7VXgx0ZH
   Q==;
X-CSE-ConnectionGUID: mmu2IbcKTZyuGiZIcfka9g==
X-CSE-MsgGUID: 1QpwMW0uS0yYejyKeC0a8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3397718"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3397718"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 06:46:41 -0800
X-CSE-ConnectionGUID: bPCcqvO2T4W5p7PWVtgPyA==
X-CSE-MsgGUID: w5CvpsjMS8aBnCpBVrLjJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9258228"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 06:46:40 -0800
Date: Fri, 13 Nov 2026 16:46:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: penhouse24@proton.me
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz
Message-ID: <avcizZOPWqA3r_qA@ashevche-desk.local>
References: <20261113083940.2583439-1-mika.westerberg@linux.intel.com>
 <avcBBe428-3Fdonb@ashevche-desk.local>
 <oyP4Jwe9KmZeViSughKaFgfxdsCa4bOmWguiI5_JlkvEHQ3lSwRAgU48s260tgGXfueLHta38-Zlhq9LQ-oB4aEObhQdAH7mujrH4BFSQ90=@proton.me>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oyP4Jwe9KmZeViSughKaFgfxdsCa4bOmWguiI5_JlkvEHQ3lSwRAgU48s260tgGXfueLHta38-Zlhq9LQ-oB4aEObhQdAH7mujrH4BFSQ90=@proton.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 02:17:23PM +0000, penhouse24@proton.me wrote:
> Hi Andy, 
> 
> Yes this post explains this exact problem (I even posted on it). 
> 
> Since applying the 100khz patch I have had 0 issue with the touchpad. Not
> sure why the Dell XPS 17 9720 is so unique in this issue, but amongst all the
> firmware updates I have received since purchasing this computer, there has
> been 0 improvement to this. 
> 
> I appreciate you all working to resolve this issue. Is there any further
> information I can provide you all to get a fix pushed to the main Linux
> kernel?

Can you comment on that bug with a link to this thread that your case is fixed
by this patch, so others also may test it?

> On Friday, November 13th, 2026 at 7:22 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Nov 13, 2026 at 09:39:40AM +0100, Mika Westerberg wrote:
> > > The Dell XPS 17 9720 touchpad has the same lagging issue as with others
> > > when run at 400 kHz as the ACPI tables describe. This particular system
> > > does not use standard ACPI ID but it seems to use "Windows Device ID"
> > > VEN_04F3 for whatever reason. Add this one to the 100 kHz quirk list as
> > > well but since this is not a standard ACPI ID match it also via DMI
> > > strings just to be on the safe side.

...

> > > Reported-by: penhouse24@proton.me
> > > Link: https://lore.kernel.org/linux-i2c/20261109104542.GL176724@black.igk.intel.com/
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > Isn't this https://bugzilla.kernel.org/show_bug.cgi?id=214597 as well?

-- 
With Best Regards,
Andy Shevchenko


