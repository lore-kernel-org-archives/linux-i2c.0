Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991913;
	b=eim/WjZFn+xBGs0Gzn1W5RLlQBh0vlQEPc37ULXbvxAnFzhAIeq0Qm9uImf/59crtf+n
	 groUJ2iB49Y8eci0gfT5f8qeSZE9149Pdry2C+o6T3S0aXTk+IhR5qXzOUtvmLRYyhlJA
	 ncEul/VPWLdGYyrsnW/H52TeFKumF/cNzfh4ulFfz4VN6P3NPhHDmKLWU7kaxTDzPr1zK
	 QlL+WGvTdVtlyxPZdx5sWglMGJ12LOOBK+KQC8XVfAfRHf15CNOE4cnoopA/9VOkcujwg
	 gsfyGgALO6HP56XvWziEgc8RJHP5j+zUlAW6OpI1jW0MVC+TrlY4nsUcLmfZnTiUxYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991913;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=t4vR+WC8rFJbXlWlq1Q6jj0G26iR3wDkfdA7X6eirWY=;
	b=hqGL7H5CkwzLkQFjzff2/z3YIEk53U3DsrYimUjW9UJQwLeL/+O/CKb/8QR/msxt1Ghs
	 rKM4DUxRNhjQ5gLC02U8sVUtFT3/PGYe5jRheJfVCxWP9ni/yGPERrUbhhd/52imfwiEz
	 Ntk1RHnM/9PiZ8R1LHCkPJJRc98ezKwyxnRrut9pK82XLpUbULzwl/wDKReM+xnG7GOy0
	 tv2jxJqVgcuwncuzDKC7rIXSzlymioTkG9iPbpr3WA3lBsgzXVRS1uy7ZpnqFpTIxC30z
	 pYSXZZ6Ntig/io2jrR2iH0UqvhY4Wv4Ri7lzrzPhN7Et7LRP2EKCidpbm3y/E3L2gKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YizacNon;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DAD606A31C;
	Wed, 18 Nov 2026 08:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33DAD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YizacNon
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794991914; x=1826527914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2h19q6YC68qXoxv5iA6/HRp6oHZLC86lJHld5ZlvhTY=;
  b=YizacNontEeqroPFGBTCHzbAx6NqxBc5hMrmwCaAOOBwNFbJb+amrzWE
   H4hC941QZ9q7/ZmQGeBimT1RSYq9CFt2a3EF3h1tsYKaOeUoABhT1E+rz
   HYpsCbWBnlrIVgV9ecuf3vHeeTPAnJuOXljC4tgCrQgUJmOzN7FpqLoXq
   Cvq6L5qYMi9Dx+/PaiGYEp15vZm3miJ+xTkfsaCrRL2Whdkkbn3WVpDEY
   oicKPgvUwny34pb7sZ329VKpMd6NYk5VYjT3zrD4APDIebHkgOMj/dplu
   CyszMB2akBLWsIlK5Zoyr49DL2qlF0Z4hg3X/rn0ojcHJXswJtYdGy98M
   g==;
X-CSE-ConnectionGUID: FeIlJH3oTpKA+UzhbYzQ8Q==
X-CSE-MsgGUID: U+zmLr2tQoecaHKHKygnBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3691351"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3691351"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:51:53 -0800
X-CSE-ConnectionGUID: Uhe02HQBTOKxewEgdIY2lA==
X-CSE-MsgGUID: 8ohxJE7ASvW7Wb7VqIz51A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9988069"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 00:51:50 -0800
Date: Wed, 18 Nov 2026 10:51:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	penhouse24@proton.me, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz
Message-ID: <av1nJE9cbXoTrpJu@ashevche-desk.local>
References: <20261118073607.297350-1-mika.westerberg@linux.intel.com>
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
In-Reply-To: <20261118073607.297350-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 08:36:07AM +0100, Mika Westerberg wrote:
> The Dell XPS 17 9720 touchpad has the same lagging issue as with others
> when run at 400 kHz as the ACPI tables describe. This particular system
> does not use standard ACPI ID but it seems to use "Windows Device ID"
> VEN_04F3 for whatever reason. Add this one to the 100 kHz quirk list as
> well.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Link: https://lore.kernel.org/linux-i2c/20261109104542.GL176724@black.igk.intel.com/

Unreferred link tag. What I read on it sounds like also a candidate for Closes
tag rather than Link.

> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=214597
> Reported-by: penhouse24@proton.me

-- 
With Best Regards,
Andy Shevchenko


