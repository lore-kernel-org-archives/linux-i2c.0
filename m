Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7263793BE;
	Thu, 29 Jan 2026 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769669922; cv=none; b=m7t7u0aS7J9EI3iNJ5G65kZBMY8OVaVm2dIVFq35Mnuoolc0Bx6+vNnzM/zgMZPGuFlX+eO9y6g14Xvs+VHBMaPF92111wejWvFXQsRlFFhxHQU1U1nTK4FXUdMMNr9wwq5CvhBbuSgEjS4pw6NmxfVDGjGcEVBmUSIoHAxTXlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769669922; c=relaxed/simple;
	bh=NC0+OcRzP+AVBy98SkeNzAlssPATsY1S1u7tCrN445E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXkp+Y11O1sdzglxUAoxV12Q0IRENDp8dXxw5HKuNw5NMScMOGYJoTBbbBbD/xH+Wo/ILJUd6AYGTww1PEDzkTHqZslavHpbE/hoCd11XQlV+4U228PC7yV7lr0fZ471KS6RpzacT/up0NBHsDCbJ/7Ud/0TLOLPIkOnJ65YpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3zJcoOz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3zJcoOz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769669921; x=1801205921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NC0+OcRzP+AVBy98SkeNzAlssPATsY1S1u7tCrN445E=;
  b=f3zJcoOz3j9l0Zs6xt5PknBhrsWpgo7GnSgJvrdfnX8jIfYVvC49q59O
   iy+G93eGLjkukSNbd0bHeGj/3ag54a/Ijl3yDASy++v3EkXprKVF0zKYR
   BWes5sggGjiZlR8rWijVZpaqwx65GzLO/41gzoZ7On5GDaUfMyBRoFLcw
   NCLf+XkSx+30gNzsWruI+kEDDYDG9gRy+31jV2Zx+uFIwYhIffObcFTgt
   Mu8cHGq73gPLyshniMSdUStG0+/veESRNclQABnh8segcLf2M1gzsWpVb
   rQqRaGx+5dFwJ+GuuOvM4y/4vl+8jS9XAtXJMtAS8If4eQbgZRpBuqkAF
   g==;
X-CSE-ConnectionGUID: OkMqfvy+T760MAH/XnK0AA==
X-CSE-MsgGUID: kAW0W6FtQZ6b7tYmeJ3pqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70936292"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="70936292"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 22:58:41 -0800
X-CSE-ConnectionGUID: EVP66ZqHTMi7moys8AKwbg==
X-CSE-MsgGUID: 9IDuY5EVQQC5gHwKzQ1Rqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="213038313"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 28 Jan 2026 22:58:39 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id C46D295; Thu, 29 Jan 2026 07:58:37 +0100 (CET)
Date: Thu, 29 Jan 2026 07:58:37 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: correctmost <cmlists@sent.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org, regressions@lists.linux.dev,
	vkoul@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] Lenovo IdeaPad touchpad does not work
 when idma64 is present in initramfs
Message-ID: <20260129065837.GT2275908@black.igk.intel.com>
References: <aWoUc_GJuZ8SuYCM@smile.fi.intel.com>
 <e5ee42bd-0d17-44e7-a306-61d19f1d24b2@app.fastmail.com>
 <aW4J6bmHn2dLuOxo@smile.fi.intel.com>
 <aW4MUisgI6d2Efbr@smile.fi.intel.com>
 <aW9LzBIOIePu59zV@smile.fi.intel.com>
 <d7627ea0-0965-4469-83c2-e2a15edd58a9@app.fastmail.com>
 <aXnYJQJW4wypkkPC@smile.fi.intel.com>
 <0d93a56c-e452-4cd0-abb4-09c9f916274a@app.fastmail.com>
 <20260128123135.GM2275908@black.igk.intel.com>
 <e94cc7af-4696-4ea6-8231-26f693272004@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e94cc7af-4696-4ea6-8231-26f693272004@app.fastmail.com>

On Wed, Jan 28, 2026 at 11:54:50PM -0500, correctmost wrote:
> On Wed, Jan 28, 2026, at 7:31 AM, Mika Westerberg wrote:
> > On Wed, Jan 28, 2026 at 05:21:20AM -0500, correctmost wrote:
> >> On Wed, Jan 28, 2026, at 4:34 AM, Andy Shevchenko wrote:
> >> > On Tue, Jan 20, 2026 at 11:56:15PM -0500, correctmost wrote:
> >> >> On Tue, Jan 20, 2026, at 4:33 AM, Andy Shevchenko wrote:
> >> >> > On Mon, Jan 19, 2026 at 12:49:59PM +0200, Andy Shevchenko wrote:
> >> >> >> On Mon, Jan 19, 2026 at 12:39:41PM +0200, Andy Shevchenko wrote:
> >> >> >> > On Fri, Jan 16, 2026 at 07:25:54PM -0500, correctmost wrote:
> >> >
> >> > ...
> >> >
> >> >> >> > My understanding that the pin 3 on GPIO might be wrongly configured
> >> >> >> > by BIOS.  The difference with the original case is that your GPIO device
> >> >> >> > is locked against modifications and until you unlock it (usually
> >> >> >> > it's done in BIOS in some debug menu) it may not be fixable without OEM
> >> >> >> > fixing the issue themselves. In any case you can try the workaround
> >> >> >> > (see https://lore.kernel.org/all/ZftTcSA5dn13eAmr@smile.fi.intel.com/).
> >> >> >> > But I am skeptical about it.
> >> >> 
> >> >> I tested commit c03e9c42ae8 with the following patch and still saw the "probe
> >> >> with driver i2c_hid_acpi failed" error:
> >> >
> >> >> +	{
> >> >> +		void __iomem *padcfg0;
> >> >> +	        u32 value;
> >> >
> >> >> +		padcfg0 = intel_get_padcfg(pctrl, 3, PADCFG0);
> >> >
> >> > I'm sorry to get you back to this one, but can you replace 3 with 82 and try
> >> > again (keep the kernel command options with HID debug enabled, etc, but no
> >> > other patches applied).
> >> 
> >> I tested the pin 82 patch by itself (no other patches and no config changes).  I received the IRQ message and the touchpad didn't work (full log attached):
> >
> > Okay let's add some debug to the drivers involved and try to figure out
> > what is happening.
> >
> > Can you next apply the below patch (only that one) and try? Any test case
> > where it reproduces is good. The provide again full dmesg. While at it can
> > you enable CONFIG_PRINTK_TIME=y so we can also get timestamps to the dmesg.
> 
> Full log attached with the added debug prints and timestamps

Thanks! Okay so the interrupt is active immediately when the LPSS probes.
One thing that could explain this is that the IO-APIC is misconfigured to
have the polarity reversed. Can you boot with "apic=debug" in the kernel
command line so that it dumps the entries and provide again full dmesg?
