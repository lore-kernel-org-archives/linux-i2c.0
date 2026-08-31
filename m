Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521193C3F5B;
	Mon, 31 Aug 2026 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160981; cv=none; b=Bi2O+8L/1c39gd/UtoVb25ipp1rekZmZsKaTkI+DZNFOtb44E5R+69H2xFRLkIgfWtbA0guzKTqNU6kpAlDRFmspzzvHx0kVZFU8xE8RbYTBf6Jgtq1IWldC4+YOitjK6Y6zs28eawdQjBPQlqjJaWLYGVRJNMStC9jLqAPJq+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160981; c=relaxed/simple;
	bh=SP8uKDhSqFzjoxUA4LVWk+SQL0x7ZDHcGG98kPcrOFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgvN7gxFqwMxjr4pfBKtEpv91puf8EXX+fxE+Ao3y5QsNu0ZJnnuCtbp9WksVXj72/UqkSkeNONt872cXnAsKjpWvFuDf96zExqPfE49qdHaOhdKm1Xl4jjQfhL/cTusyQjqNB1fUI1vLct71Ncq22ysqs6DRu2Xda3Nr++2mdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2qP1Ck0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2qP1Ck0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788160981; x=1819696981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SP8uKDhSqFzjoxUA4LVWk+SQL0x7ZDHcGG98kPcrOFg=;
  b=M2qP1Ck0oIaGHOYoXLEP/5as+pSDGs4n/AYXPHcYyWzpgAf0Py4DSd8N
   Pjrl7M+Ud++W6zzs7KUP/SXHvx1bqS8Ls80VfMuAxYhfILpb5EkqEwHdh
   rionNH5sxFzT/4FhZ2svkjmqNI+WbaKWgHnKFUHTEdGjKofDpZvTs1P5k
   oYQbIHwH815GpkOOg7ZAsGlMXJext3Pvc0Ny/lEImpukoft3k+IGas24x
   1DZuFGnEAuYnjI/QfkWjeCmwPSInjQQVYOA2qL9utRc+IWWY4p1Ql6/+k
   EjHbtrfOLlAmq5J1q5PyvMUcRWHbT3x/D2D+j3KbtTYFguV6Y5HpJrDuI
   A==;
X-CSE-ConnectionGUID: qXjpE+yZR1amk89Ne1sV+g==
X-CSE-MsgGUID: Ydm6nf+4TqOfrbanK2Ek/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="114097203"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="114097203"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:23:00 -0700
X-CSE-ConnectionGUID: fXdhKB+5RbuaN7lqU1bYXQ==
X-CSE-MsgGUID: pL2Nq5nQS0WeSfO8yp0AIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="306964250"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:22:58 -0700
Date: Mon, 31 Aug 2026 10:22:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Ahmad Byagowi <ahmadexp@gmail.com>, Andy Shevchenko <andy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] i2c: mux: Propagate software nodes to channel
 adapters
Message-ID: <apUrz0iqOL5iEQuy@ashevche-desk.local>
References: <cover.1787502619.git.ahmadexp@gmail.com>
 <a4abcd31c3a6758e219f5edcdd4acd307e674f18.1787502619.git.ahmadexp@gmail.com>
 <ao0tPhBvK1Er_Vs0@gryt>
 <CAOQiBWNVvHpO7X8yWyZEa3-nV76YJfRbkzo+_4U-upEj4VNfow@mail.gmail.com>
 <ao_VE0W-FohWqPPt@ashevche-desk.local>
 <apO31ydKoiqWCEKo@gryt>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apO31ydKoiqWCEKo@gryt>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 30, 2026 at 06:55:51AM +0200, Peter Rosin wrote:
> Den Thu, Aug 27, 2026 at 09:11:31AM +0300, skrev Andy Shevchenko:
> > On Wed, Aug 26, 2026 at 08:29:47AM -0700, Ahmad Byagowi wrote:

> > > Yes, software-node handling is needed for the ptp_ocp use case.
> > 
> > That driver is a mess. I'm surprised nobody told to the authors of
> > the respective changes to look at the auxiliary implementation.
> > 
> > > ptp_ocp is a PCI driver. It creates its board-specific I2C topology at
> > > runtime with software nodes: the mux, its channel nodes, sensors, and LED
> > > controller. Firmware does not provide ACPI nodes for this topology.
> > > 
> > > The existing acpi_preset_companion() path only associates a mux adapter
> > > with an existing ACPI child. It does not associate the adapter with one of
> > > these dynamically created software-node channel nodes. Without that
> > > association, i2c_get_adapter_by_fwnode() cannot find the channel adapter by
> > > the channel software node, so ptp_ocp cannot instantiate the downstream I2C
> > > devices on the correct channel.
> > > 
> > > Does this address the concern, or would you prefer a different way to
> > > represent this dynamically created topology?
> > 
> > Wouldn't it be possible to use some kind of DT overlay to have that?
> 
> For me, the above is a bit unrelated to this patch series, which is
> about converting i2c-mux from of-only properties to device properties.
> That seems like a change that stands on its own.
> 
> I probably wasn't clear enough with my original question, but what I
> wondered about was what regression risk that conversion might have
> for the ACPI case. Specifically, there might be ACPI properties that
> match what the code is now looking for. It seems unlikely that such
> properties are actually deployed, but I know next to nothing about
> ACPI...
> 
> TL;DR
> 
> My original question should have been: Is it safe to simply remove
> these lines from the patch:
> > +	if (!is_of_node(dev_node) && !is_software_node(dev_node))
> > +		return NULL;
> and let the code trawl all kinds of device properties?

Technically it's safe. Administratively, it might be some "creative" ACPI
firmware author (who presumably hasn't seen anything than OF in their life
before) may assume that it's fine to use OF approach (while ACPI has even
documented "binding" for I²C muxes). So my answer "yes and no" :-) It all
depends on the human factor. If we trust people enough to read documentation
and follow, we are fine without these lines.

> Sorry for the confusion...

NP, I'm glad to help with ACPI.

-- 
With Best Regards,
Andy Shevchenko


