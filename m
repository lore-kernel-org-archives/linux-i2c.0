Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DDA51A727;
	Tue,  8 Sep 2026 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863990; cv=none; b=K9amR/q5R+GyOWciQLK8BovQ/3WZEtGrUw9wKfjIiDmtuxlQ4Xg0RVdpUzd5BaC4eZGfpbng+UKsDQjOC+cJRjCdwKeJEkTMvPEjfGQs2r7BIyVlqQSVX0+YFe0ZwrWcaXR++uq9P09q2CBrCnwTYGT0vevTzgfpiAzbRmz8XGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863990; c=relaxed/simple;
	bh=RWMeNazOIT71LOhn6fhBLimBtabPM/3Sw0u2XTf8Jn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yqs7uT+DcFOk0Nea2v9Xy0W8mf0ynpdVlVu7GpTOl/oeCaKo/lqQanfs6ra5edFpI5RyB30QeworxQwfhDn/Pv0GfTNR/Aopdd+VBi4citUu9QvDS7+dRSaCpGEeeHulXzCauF+1lxDe5AtyDFPaBohO5TazG82h7nKe2iIzYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgDOUf1r; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgDOUf1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788863988; x=1820399988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RWMeNazOIT71LOhn6fhBLimBtabPM/3Sw0u2XTf8Jn8=;
  b=ZgDOUf1rQ7ISFzcvRwPr88kotciE8+t0rBTCevVpJcrfwJzePMJQxBYy
   ZASeSONC86UEdG86zNPfLn6MI37OHSV/AJ6Yix2hN81lZhdTAIA6l3ZbG
   mSGlSHNVz1jCZ+fplWnxjydjC4IKmJYB4TxnMu8jIyNH04CSHQCNWNMOj
   7AhBSM64s8msb1DMlZSiXR+pDufplfCZPqAGdfspYX/xB+d/hMPsQmI/8
   nxtjceaeuCWXPrn2fNDXkR4pUV/Q9A9bgy6rHyK/Hx+vqksjjZNNQu9wA
   T1GxkA9HU2PX29W5TNHFGIRokwMqAlMyWEcZZlMK2ux+t1FBAFuESbm9Y
   A==;
X-CSE-ConnectionGUID: 3phEKv1nRwG+/Q46Y6ws7Q==
X-CSE-MsgGUID: 9JS0cX/XTgmTWoKRqsHzPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="76822324"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="76822324"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:39:47 -0700
X-CSE-ConnectionGUID: XwFzMtXgSuefhrfVSxuGTA==
X-CSE-MsgGUID: DUKhoDDETiePFkoKYTyJKA==
X-ExtLoop1: 1
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:39:45 -0700
Date: Tue, 8 Sep 2026 13:39:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ahmad Byagowi <ahmadexp@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@lysator.liu.se>,
	Andy Shevchenko <andy@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/2] i2c: mux: Factor out channel node lookup
Message-ID: <ap_l76c30P1F66_L@ashevche-desk.local>
References: <cover.1788623619.git.ahmadexp@gmail.com>
 <adf12f66229d5faa0bc75571da1c3f53a1c81dd8.1788623619.git.ahmadexp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adf12f66229d5faa0bc75571da1c3f53a1c81dd8.1788623619.git.ahmadexp@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 07, 2026 at 11:26:22PM -0700, Ahmad Byagowi wrote:
> Move the existing Device Tree channel-node lookup into a helper in
> preparation for using generic firmware-node operations.
> 
> This is a pure refactoring with no functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


