Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81DB3B5F48;
	Mon, 31 Aug 2026 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161151; cv=none; b=QKtbF4e4n2ypywUlpmlHb6bMd3L665AeP9KF5EWQlG4BQVyvEyiCSclGiRuS/WObxo5JWlaeo0io6yAMKXnkW97OuDaGpp/AelQ/YEaSrBo2r2jhLPZBt1JZqBgAuZJRTekkbdd3J5UjTwNF+N7cD+hrCSGeXwX6cpmmPLf05PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161151; c=relaxed/simple;
	bh=SdiIsDKqe8hcrPIgrmOBuHiL++GVKXFAtA5n318UKzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fACnZdmFLzOf0nImWZDHgBfUsnS2Xi2UxOUoEshIL0HH4epCpKu0XTaPLKN6SfPrgvHSqMnXs1KAV/QjG+66MovwrCj3oqrJeLPEafWu1ZNunbC3cjKt/7VuPWW8RdalYB6hVdW2F8s4pgIkOIGLWMlN2uqDLIRWfPb6iXpi42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHhJxFTg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHhJxFTg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788161149; x=1819697149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SdiIsDKqe8hcrPIgrmOBuHiL++GVKXFAtA5n318UKzk=;
  b=DHhJxFTgksBuQCEFNcFMpTn0narzYGLEltDrjC9zw0k+f8OPcFuopdYJ
   lfJtTn0cW2pCPCWHYPVOY8btXGjnYQMtFUWjxF5f+D72ohF2dz4+YkCHY
   YPKpz2M8r+sutR0beGvTDJWU+EBn7iGuSVbSyX55Bac2ooDnUWQGFJW7c
   1vTLABgRxPsWKOiR7WeoNdp3Eg44pxLoVV/oVoNA8ZaQLXT+7KBgDlXZX
   XJOjxJ1pcGTGov5X/oh0y+AvWPplBom2SK1GVOPpLxTpsHTU0wi5DlFyx
   u7fEIWoJcy2yYD/WYfQUsZJXv+s1WCa3aKoIzHywNMcLjQRaXXUtR7KqM
   w==;
X-CSE-ConnectionGUID: i1dh6ZG6QoKjaszhMDRUHw==
X-CSE-MsgGUID: wAd0Vl0nTbiTIZEE1+KXAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="87694635"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="87694635"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:25:48 -0700
X-CSE-ConnectionGUID: sGegloNkS9mb1YV6QZjH6w==
X-CSE-MsgGUID: 4VutpvRWQNqmU8RO0U1clg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="272911626"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:25:46 -0700
Date: Mon, 31 Aug 2026 10:25:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Peter Rosin <peda@lysator.liu.se>, Andy Shevchenko <andy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/3] i2c: mux: Propagate software nodes to channel
 adapters
Message-ID: <apUseMqUa6_mL2If@ashevche-desk.local>
References: <cover.1787502619.git.ahmadexp@gmail.com>
 <a4abcd31c3a6758e219f5edcdd4acd307e674f18.1787502619.git.ahmadexp@gmail.com>
 <ao0tPhBvK1Er_Vs0@gryt>
 <CAOQiBWNVvHpO7X8yWyZEa3-nV76YJfRbkzo+_4U-upEj4VNfow@mail.gmail.com>
 <ao_VE0W-FohWqPPt@ashevche-desk.local>
 <apO31ydKoiqWCEKo@gryt>
 <CAOQiBWOZd+NVRqzRzJx9HP+B21JJXBUTy_OxAqDw8X7tvWeY+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQiBWOZd+NVRqzRzJx9HP+B21JJXBUTy_OxAqDw8X7tvWeY+w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 29, 2026 at 10:04:13PM -0700, Ahmad Byagowi wrote:

Please, stop top-posting!

> Peter, thanks for clarifying.
> The check is intentional as without it, the generic traversal would also
> inspect ACPI firmware nodes and could match _DSD child nodes carrying a
> "reg" property, while the existing ACPI path below uses
> acpi_preset_companion() to associate the adapter by channel address.
> I have not established that, changing the ACPI lookup behavior is safe, and
> that change is not needed for software-node support. With the check
> retained,
> OF and software nodes use the generic lookup, while ACPI continues to
> use the existing acpi_preset_companion() path exclusively.
> That being said, I will clarify that in the commit message for the next
> revision.

Also use proper check then if (!is_acpi_node(...)) or more granular one
(ACPI device or data node in case you we are talking about certain type
 of it).

> On Sat, Aug 29, 2026 at 9:55 PM Peter Rosin <peda@lysator.liu.se> wrote:
> 
> > Den Thu, Aug 27, 2026 at 09:11:31AM +0300, skrev Andy Shevchenko:
> > > On Wed, Aug 26, 2026 at 08:29:47AM -0700, Ahmad Byagowi wrote:

...

> > > Wouldn't it be possible to use some kind of DT overlay to have that?
> >
> > For me, the above is a bit unrelated to this patch series, which is
> > about converting i2c-mux from of-only properties to device properties.
> > That seems like a change that stands on its own.
> >
> > I probably wasn't clear enough with my original question, but what I
> > wondered about was what regression risk that conversion might have
> > for the ACPI case. Specifically, there might be ACPI properties that
> > match what the code is now looking for. It seems unlikely that such
> > properties are actually deployed, but I know next to nothing about
> > ACPI...
> >
> > TL;DR
> >
> > My original question should have been: Is it safe to simply remove
> > these lines from the patch:
> > > +     if (!is_of_node(dev_node) && !is_software_node(dev_node))
> > > +             return NULL;
> > and let the code trawl all kinds of device properties?

-- 
With Best Regards,
Andy Shevchenko


