Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D333C7DF0;
	Tue,  2 Jun 2026 22:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440265; cv=none; b=KHHiXGsC3c7fRk02gz6EUAjj1MoDGDoOamjj6NrLHsJDiBe8hdQ40FTrPublVeFv7aYpSXrd2ICHc0AOM/u5TgiEBI+tnSdj6gbJXnICgDqHHMsxfhgeF+ueuoxV8SQvjzZueRNz85RzWxOsndV0w2wUhgFhSa9YMd0KnJX8lE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440265; c=relaxed/simple;
	bh=aO/4yNOFoUs6kkitlfJEe7lx34uVg+SUbehW23yKIxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rw3q5Xs5Ysnb3/KHwwllURt8wMIc1yz7hACDxuKJqqkLIdE5KklUO3GPdHbJd503Zz0mFHyEqytrBT9OiFZMuLxlfCXCHDaUXREytmKWnaukxbZloVEnjgwSAwDiX/A5sRZkcyv8+BJvPNtHqnwp0z4HSyWhSHQUjGBNy56pxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBnNV9Py; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBnNV9Py"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780440264; x=1811976264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aO/4yNOFoUs6kkitlfJEe7lx34uVg+SUbehW23yKIxE=;
  b=ZBnNV9PyUupQwX87207tJLzKSaPZV3cmqtoUDkcesWrSfH8r7R8OBSWZ
   pqvs+ytP9jcYVpkeipT8k6Z0BoPfd3SteI7v4Z4SzvettM3kA9CxqopIt
   xeQJPiaPrvtQbvqbfZXT8ymwKsuSnJzGUEKimzko7kT9YtZAm8j0mA7dJ
   JLB7zXWtb8gWd4mYApoD6kSbV58gUSA6D4jv65ov9TblTj4egM+qZ5HxB
   dcCT7Ge2+Q2llMpWbN2PgrHtFaL0wV36vntm9Dpll2tNbh7yJSWxiyOvK
   mEGDklVS/tswK1pSCu4N71HkdZDtueJGw6JHOILG/cN+D4TqTGIPulKsy
   Q==;
X-CSE-ConnectionGUID: wynlLifjS6SjzXjiKpuEDg==
X-CSE-MsgGUID: LndJjlSsTdyJP+/pyKUPAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91550795"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="91550795"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:44:23 -0700
X-CSE-ConnectionGUID: CFrGlM0XTi+tqubn5f5nww==
X-CSE-MsgGUID: fJI9yUgDSZuV/MGAkfa49w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="267908588"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 15:44:20 -0700
Date: Wed, 3 Jun 2026 01:44:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Hardik Prakash <hardikprakash.official@gmail.com>,
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
	wsa@kernel.org, mario.limonciello@amd.com, brgl@bgdev.pl,
	basavaraj.natikar@amd.com,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 2/2] i2c: designware: defer probe if child GpioInt
 controllers are not bound
Message-ID: <ah9cwsENUe8cK6wB@ashevche-desk.local>
References: <20260529100838.8896-1-hardikprakash.official@gmail.com>
 <20260529100838.8896-3-hardikprakash.official@gmail.com>
 <ahml-rVa2PIA5DDC@shikoro>
 <CAD++jLmWV9WizdqXfwvTUCbJDisurLBa7sAC6DH1BehDTHZDYA@mail.gmail.com>
 <ahn9Q-9eHjBSj39h@shikoro>
 <CAD++jLk7L-XPTpThNbvxzYSuw=Gy-dDci1eTy8wLo9O0o4_uqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLk7L-XPTpThNbvxzYSuw=Gy-dDci1eTy8wLo9O0o4_uqQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 29, 2026 at 11:59:24PM +0200, Linus Walleij wrote:
> On Fri, May 29, 2026 at 10:55 PM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > > > In case this goes in via some other tree:
> > > >
> > > > Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > >
> > > I queued the revert in the pinctrl fixes, you can take this one (2/2).
> >
> > Is there really no dependency on patch 1? I'd feel safer if you'd take
> > this as well...
> 
> OK then, you're right. Let's keep it together.
> 
> Patch applied!

Can we drop this patch or revert? I would like (as I said earlier) to review it
closer, I just returned from conferences and vacation and got a ~16 hundreds of
new emails to go through.

-- 
With Best Regards,
Andy Shevchenko


