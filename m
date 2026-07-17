Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA873271FD;
	Fri, 17 Jul 2026 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270183; cv=none; b=GNM8E3WUoIFMVvo9NgP7vvtM83O6xqQS6HKXd3cR0hmYx+KRLjwIDbXMxv/lt+Hpk8Gf8nCESvGDD9MtFp4+U5tkeF5JLuwJ7WSmc6FactgmRyconugU1gFPbTUANqTOWVH/8kPMOSwO/4Pv/bwwzhiaPBbzf37sTt5UwB6k9uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270183; c=relaxed/simple;
	bh=rjl7eH0SjxnHywWD1iCcAg52I/wCkOiiFgnSzicmG9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3THXe5F7vi5VvH+Tkx+RY03LJD0vRcFR2Y+ALI7+kcm2bce3ZfJTY6kOSxYcd4i4oNrBiXIqPqdkXWT4AeSJpAtBYt0SnknW/X2NvDxy4WbJLbo4q+ScfBnkcCzt/WFRQDx0Zt0MGZPY3is8IGKQCce8EjGRNyjBmJhuBdUl0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLRS1lbT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLRS1lbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784270180; x=1815806180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rjl7eH0SjxnHywWD1iCcAg52I/wCkOiiFgnSzicmG9g=;
  b=HLRS1lbTyxarByUrfVmxeKHkR31JobKy6u40ZcJ5JWdK4Fc2mSZEuPCU
   rF248BuMXo3QbtOv8RTM/fHnwd7NLaIZI8rCRADKiX7QBKdhhL/cyoGp5
   ojPCegjaBb5vcKgNU82w0jnuAD2Osm4fdPENrtoKAehC0iWEFqCFHOXF8
   Q6MxAYUwLzF7u/KRMTLAKIOtw0PG4fpjg8g0SMzbTbrmJyRSfBzVXTNFq
   gk0J/6hgi0QHBmKnpwmf5ZWXerb1OGPc947V+Jf4p6SdMewAlqVZXNMCG
   KSOgOyV/PsCKuX9d5vfoNq7DKcccUX3JWwNUvoUhSnrSyErtZ1b6WpJJj
   Q==;
X-CSE-ConnectionGUID: dhnRomo1QhCuAt7Bs8Scjw==
X-CSE-MsgGUID: 4T6ZFVH+Q5KmWxlwP37ZKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84817391"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="84817391"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 23:36:20 -0700
X-CSE-ConnectionGUID: g2A86zBcTIqgdAvZuAS+Vg==
X-CSE-MsgGUID: gHquvPoBRJOuaAhv8Q7lFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="254934785"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 23:36:17 -0700
Date: Fri, 17 Jul 2026 09:36:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org,
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com,
	linusw@kernel.org, nathan@kernel.org,
	chaitanya.kumar.borah@intel.com
Subject: Re: [PATCH v12] i2c: designware: defer probe if child GpioInt
 controllers are not bound
Message-ID: <alnNX_Co_R2egGBv@ashevche-desk.local>
References: <20260716113055.41319-1-hardikprakash.official@gmail.com>
 <alkpHdM0wBw6_DiX@ashevche-desk.local>
 <CANTFpSVGQikgNUgwPW6hCEvCP+FWRJ3Me1jg-Uea=K2JZ4tc9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANTFpSVGQikgNUgwPW6hCEvCP+FWRJ3Me1jg-Uea=K2JZ4tc9Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 10:18:33AM +0530, Hardik Prakash wrote:
> On Fri, 17 Jul 2026, Andy Shevchenko wrote:
> > It's utterly wrong patch. Actually this whole saga shows how AI wastes
> > more time than gains a productivity.
> > ...
> > So, make sure v13 is a real patch.
> 
> I am sorry for the bad patch. I will take some time to ensure all of
> the feedback from v10, v11, v12 is properly incorporated and that v13
> is a proper patch.
> 
> On Fri, 17 Jul 2026, Andy Shevchenko wrote:
> > But this is wrong. It's a patch over v11 (basically it's a diff v11..v12).
> 
> For the next patch, should I carry the Ack over, given the underlying
> content didn't change?

I think due to this mistake you need to reset the tags. Let people
review it again (and explain in the changelog why that happens).

> On Fri, 17 Jul 2026 at 00:25, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Jul 16, 2026 at 05:00:55PM +0530, Hardik Prakash wrote:

> > So, make sure v13 is a real patch.

-- 
With Best Regards,
Andy Shevchenko


