Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E23C1D5E;
	Mon, 31 Aug 2026 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161291; cv=none; b=NHQSEpmN3n8J41KcEF7fK6MEmC0YXK1hJDSSMY+JhoFVgnY8G/vg/U5xA1nISb4VdGyUTUhAc8I+OkFB2Qojlra0T90J6XOza5S37NYb/7fhRPpp+B5oQEdU4AqkJNlyo20CmTfywt/ZkqdNug0bYYEzQX4GhUXypT0J8pi/5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161291; c=relaxed/simple;
	bh=FXtZHMaUyuz6tloPARhW1tSsICenfu1kk99C0DJp/Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pP4oEYz5TPiCVfrf2BuJiAf/+WDe88C6zuApDrn+iLZiN+JBI+H5akzUO6i7j1dsDVGQ0+NSm421I7yTpt6w++fGeGY4gbPqFDSXIj20zQ1Qo+3LxHKAftQZOtBnwujIHaGMFsz+docGfepAkdID/ddvSO/xs95yApAaPQerXFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhTdb0yy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhTdb0yy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788161290; x=1819697290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FXtZHMaUyuz6tloPARhW1tSsICenfu1kk99C0DJp/Sc=;
  b=WhTdb0yyrFf6b/BMVpAuQXlbL9rP27wPq6Um4s/2zD6mWNJbLr+3YNsl
   LjMCNaTasFlrcrriA1Ef2HhFzPPrZldFKSXAymH6oYvmWg3syvB9F6xhl
   2oxYSOEbtsNOSz/0sG4XjSqiElhYnKydiGtvf0rU6nuqEDalWl3nLwFgN
   bMTTzoRy6V6FUw5jkAW4AN1zA58V899aGiAvpVsZzDiFEW1VKVnyO1IcQ
   DRug0rE/f/aBuihehFuAYdyQ0xremMgXzRAE0AzBDVhYJXpYRkRBACL2Z
   dzYrvMnvJ+C/2eQTm7DGL1kPXK9W0NPW1I3yXF5ekhYjC0e1K4am2597q
   g==;
X-CSE-ConnectionGUID: NBcf8krJRrmfGQ/XbVOuRw==
X-CSE-MsgGUID: c1TRNln1Q6yvSmU0iFTjPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88322656"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88322656"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:28:09 -0700
X-CSE-ConnectionGUID: pXYTBenFQ0yxxjo+9nO0xA==
X-CSE-MsgGUID: sFv3dv+eTLm3/gTPVzkoMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="273989107"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:28:07 -0700
Date: Mon, 31 Aug 2026 10:28:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Ahmad Byagowi <ahmadexp@gmail.com>, Andy Shevchenko <andy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] i2c: mux: Propagate software nodes to channel
 adapters
Message-ID: <apUtBFvuUGiP4QCE@ashevche-desk.local>
References: <cover.1787502619.git.ahmadexp@gmail.com>
 <a4abcd31c3a6758e219f5edcdd4acd307e674f18.1787502619.git.ahmadexp@gmail.com>
 <ao0tPhBvK1Er_Vs0@gryt>
 <CAOQiBWNVvHpO7X8yWyZEa3-nV76YJfRbkzo+_4U-upEj4VNfow@mail.gmail.com>
 <ao_VE0W-FohWqPPt@ashevche-desk.local>
 <apO31ydKoiqWCEKo@gryt>
 <CAOQiBWN5DgOcJ9Gg7s2GZmpQguJUh121Jn9yUzxxm=D530c8dA@mail.gmail.com>
 <apUpnqAQQfWaflS8@gryt>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apUpnqAQQfWaflS8@gryt>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 09:13:34AM +0200, Peter Rosin wrote:
> Den Sat, Aug 29, 2026 at 10:10:40PM -0700, skrev Ahmad Byagowi:
> > Peter, thanks for clarifying.
> > 
> > The check is intentional. Without it, the generic traversal would also
> > inspect ACPI firmware nodes and could match _DSD child nodes carrying
> > a "reg" property, while the existing ACPI path below uses
> > acpi_preset_companion() to associate the adapter by channel address.
> 
> Yes, I got that. The question is if the precaution is really needed.
> Are "reg" properties common in ACPI nodes?

Nope, and we have documented how ACPI DSDT is supposed to be constructed for
the I²C muxes, but as I answered there, it relies on a human (factor).

> > I have not established that changing the ACPI lookup behavior is safe,
> > and that change is not needed for software-node support. With the
> > check retained, OF and software nodes use the generic lookup, while
> > ACPI continues to use the existing acpi_preset_companion() path
> > exclusively.
> 
> Yes, I figured as much, which is why I directed the question at Andy.
> 
> > That said, I will clarify this in the commit message for the next revision.
> 
> I'd rather tweak the check to exclude ACPI (instead of including OF and
> SW) with a code comment about why ACPI is excluded. That is, if it can
> be determined that ACPI actually needs to be excluded. If it is hard to
> get an answer to that question, I'm inclined to just attempt to not
> exclude ACPI, and then be prepared to exclude ACPI in a follow-up if
> there is any fallout.

Agree (and also answered in the similar way earlier).

-- 
With Best Regards,
Andy Shevchenko


