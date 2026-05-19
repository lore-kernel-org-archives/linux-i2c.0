Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3B0480340;
	Tue, 19 May 2026 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188917; cv=none; b=M2kC+xz1GEXOtu/0Y8n9K82t/XlNlaQaeNJMVmXU1Vr3dKC/4Htw08UHhyKa8eefBO3xE8goWPleztiZEd7Z1rD+pIkmr1Gp5y0u+ryZugerfyZ9i9VSyoq4B85GkR8xWt6OrFNtuH3ebFYoNz4hnEC2XoomYt49g90XPLpwmjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188917; c=relaxed/simple;
	bh=ifJJXAeLAe3zMy7V0PXPb3/XJ7lyTDwoaXHc5ZMOaHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBHdEILQROtxgu5ehs7ya9+kmUCk8wsPlQPLOgt3Ehwczdh/ex4d0QT/0m0CvqvMJgZWnBnFC6JLw5tTQ6+lb78l7bz4T6AEaJ6k7UKH1+YQYeG6gSwGrhX4dhboukYU7tHlsTf4ICKYwaGa0IkBA+1tto12noe/MOq4D8Wd5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5Rgy6YW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5Rgy6YW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779188914; x=1810724914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ifJJXAeLAe3zMy7V0PXPb3/XJ7lyTDwoaXHc5ZMOaHU=;
  b=i5Rgy6YWIEeFmtNjZwWK5NEFhREo8U7b6fKKt7po6/Tkiz2pZVqzGmYJ
   MMe/++nqEM8yH05u3+ewXTLW8elsWDRKHy67e/ZmVHHJmcQez1z08zOwr
   Kob+Ljw5Qv5BL9dsXrgLMKOK4kuDNLn58JrBM5JQfqFV+g9ZPF/ZQbgV5
   YsJSC8zwdXFyYdLolYH3pZOhD6tOwloNr2T5OJxKf4KkCI3d+RM6/mdE4
   /xrGI+4EShZNm/piNzKzNoJ6QgXJ7ifBjwapBSBjPlTF0vFry6FmWr33D
   Mmn6ewW/dYTMGhwjfy6HNAGOJuJx0ajUnXCNfWvabQCDMnnKuuuRXW+5i
   w==;
X-CSE-ConnectionGUID: fe5MZ03eQdmJjeoZdi/7ow==
X-CSE-MsgGUID: 41+1g/Z5QmCA0PV69y2MFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="97497042"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="97497042"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 04:08:33 -0700
X-CSE-ConnectionGUID: cFXXX3eAQeOXZINHfepTtg==
X-CSE-MsgGUID: Fnf6jETUSUiXXIlt/mTSZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239604216"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.150])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 04:08:32 -0700
Date: Tue, 19 May 2026 14:08:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jacob Bazata <jacobbazata@gmail.com>, wsa+renesas@sang-engineering.com,
	westeri@kernel.org, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Add VEN_04F3 to
 i2c_acpi_force_100khz_device_ids
Message-ID: <agxErb9VB_T7SLCA@ashevche-desk.local>
References: <20260519052424.7591-1-jacobbazata@gmail.com>
 <20260519100529.GA8580@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519100529.GA8580@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 19, 2026 at 12:05:29PM +0200, Mika Westerberg wrote:
> On Tue, May 19, 2026 at 01:24:24AM -0400, Jacob Bazata wrote:
> > This model trackpad (04F3:32AA), found on various Dell XPS models
> > from 2023 including XPS 9500, 9510, 9520 and 9530 is well documented to,
> > at random, exhibit excessive smoothing with no obvious cause, similar
> > to other trackpad devices listed in the i2c_acpi_force_100khz_device
> > _ids struct.
> > 
> > Forcing the bus to 100KHz eliminates this behavior.

...

> > +	{ "VEN_04F3", 0 },
> 
> This is interesting ACPI ID. Adding Andy just in case he has any comments
> on it.

Yes, it's simply bogus and not following the ACPI specification [0]. We might
add the bogus IDs, but that has to be justified in the commit message:

- Is the device available on a wild market?
- If no, drop the patch, fix the firmware (I'm here to help with ACPI process bits)
- If yes, provide the Device name, model, year, et cetera to unique distinguish it,
  provide an excerpt from DSDT to show how this device is described there
- Also browse the MS catalog [1], duckduckgo, google for the ID to see if it
appears in some respectful sources
- Additionally, try to submit a bug report to the vendor of the device to point
out that this is bogus ID and must be fixed  (in a new BIOSes)

The more information you find and provide the better. (But distinguish the
important from secondary info,)

[0]: https://uefi.org/specs/ACPI/6.6/06_Device_Configuration.html#hid-hardware-id
[1]: https://www.catalog.update.microsoft.com/Search.aspx?q=ven_04f3

-- 
With Best Regards,
Andy Shevchenko


