Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FFC3CE4B9;
	Fri,  8 May 2026 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234523; cv=none; b=QUlKtc1LhVIkAohMjsmIVnd77K8R3tp+ltclWLcWcXwhy7g4F7vt+TgiYTKKG0RYShvGBndxCexRJAJnhbkB41q3UtY1A1e+MkY4Av+BiE/kg+lZ5PMdQRi7SfvULsTHOnR7SWe/UJlboSQYgMUuXWcgvEC5xqDrNIKuz1WyvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234523; c=relaxed/simple;
	bh=rw/oCHIIgmqxBWLIj/ZP66ABxAjt6lng8sZbxJPxLWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmMewSpUk2oHn1AZKlFKu5lSLNi2asfOcHiwr+/uXZnWHQ6cTIsceVzwxLMve3d5eoBPAxqaizeDYHeCyFllEkB5v2564kWQvxs84kooRNyZnxv8lVjvljxuaj8jLnUfwqFW3ar1cpWnrY5B6yzgKwVJm3Z67tOGRJRZ1PORXlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XXMkWc/l; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XXMkWc/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778234521; x=1809770521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rw/oCHIIgmqxBWLIj/ZP66ABxAjt6lng8sZbxJPxLWw=;
  b=XXMkWc/ldv8gjNE3Ha6giTOCZElz32SXj5aJaefyamgO3nWGTVsa+J9Q
   qLkeUtwPGUhv1iHUWoW8dt6TnqKXoK+kb4GgUv3dqeakdRQNPIBkw6G/w
   Y3HNlIN0fb9UW87hY4YzYSBArbZbE70vSp31kM8SDa8Qi6mkAf981ZADo
   ZQcw5cZe8oG2OYHQkhn3lpbJqAt3TO3Nsx1JYvipHsgSgg+zJk9G8wRo6
   1bHp/G2puL4dMSt7krjSWxyQMWERRqWGQ4NtUZo+4VetBp+YKwML0r4qE
   fLe+Uw0JMeJj7OS/gsdscIw1nRy0UYFEbiysCxrdVvPJ7Rgx1YX8svGhC
   g==;
X-CSE-ConnectionGUID: YTGiSMcEQciQNkvBwEVTfQ==
X-CSE-MsgGUID: SLMeozkSTRWAFu/cOSiXhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="96624608"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="96624608"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 03:02:00 -0700
X-CSE-ConnectionGUID: FK2+Fl+3QjW2tffV4nHDig==
X-CSE-MsgGUID: 5YVJTx5CSzGMgyCLCQc8SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241073252"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 03:01:50 -0700
Date: Fri, 8 May 2026 13:01:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "William A. Kennington III" <william@wkennington.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] i2c: designware: Introduce shutdown exported
 function
Message-ID: <af20jKBI3deJf_bo@ashevche-desk.local>
References: <20260507-dw-i2c-v4-0-9a447b23bfdf@wkennington.com>
 <20260507-dw-i2c-v4-1-9a447b23bfdf@wkennington.com>
 <af2bAeuNx131OipX@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af2bAeuNx131OipX@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 08, 2026 at 11:12:53AM +0300, Andy Shevchenko wrote:
> On Thu, May 07, 2026 at 08:05:15PM +0000, William A. Kennington III wrote:

...

> > +	/*
> > +	 * We only need to handle shutdown for target mode to ensure
> > +	 * we NACK any incoming controller requests. Master mode cleanup
> 
> Master --> Controller
> 
> > +	 * is handled after each transfer in i2c_dw_xfer().
> > +	 */

With that fixed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


