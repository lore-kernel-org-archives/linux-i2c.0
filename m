Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D49F29C351;
	Mon,  2 Feb 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024086; cv=none; b=N6+zAyxjMJo/kOTgEoeTzblzdijcMr3uPckLO4kd7hBGYI7IsErm65SU+MUK3BfkZYYDLkusq6F0tC6OvBJyeKWnEYONwh628SiG2GfN/Bv3T3IFeyFwM1oxQg6PdM011+i6x2IG5VTo78V/nAn0nEw38ycFh5xuqT6u4rhRzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024086; c=relaxed/simple;
	bh=JqjVbh1i2VsQyWOYnE+Yp4pO/CGm8C3DDvcQq/Xfr8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQIMz3kzZ8z2oX/OvwDcy968/AN5k4T1caPNHsyJAaIJIEbqrSTjCnih4r7sWQHsDX1RgWia0yshmjY/LrMqSeUjWTR9wAuw8M6XU+vRyL1YHOUjtb0P06JwfRq3h/M/B4PyEhiqLHpdamTPq6sy06URPxuy93Pk9UEd50v/av8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMxaK+1v; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMxaK+1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770024084; x=1801560084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JqjVbh1i2VsQyWOYnE+Yp4pO/CGm8C3DDvcQq/Xfr8w=;
  b=CMxaK+1v+fYhgCrHmuCL5e3kXmpYelE5TShDhops1ori2Uj4UaoJ/aVs
   jIR5O+VXIXvCr/VZJVLPYMjjJylWOg2axhCbL/2L9Ts/Qnm9wzwOWgrlh
   QsbZiZwT+yjxPX4dC9NjsL8c+Q8dr/JMQJIp+EKntLRhn/3hX4pgwRZd5
   R8sgmQYG0q/a0D0NPCY7jvJkNunkSE8TEIZXfPzoHf7di7h4lDQ5wYUVp
   GlnpRWhYGaqzBKlGXLWmoDrLKFPxkMRDZcL3aKHu5K2bX08Kb4YlfTQMd
   tLcyO7RX7l53hgics6jSSorztdHZorugj7l7gW7uHJmVyANAslQd18V/h
   Q==;
X-CSE-ConnectionGUID: obuXR6blQXuN/4PhkyqDuA==
X-CSE-MsgGUID: hWAtlnzHTjOcZpUv1mRd+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="93830848"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="93830848"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 01:21:24 -0800
X-CSE-ConnectionGUID: 83ZfxCO4QiGA0xgXrB7tFA==
X-CSE-MsgGUID: 3Br6n2AAQNenJq9F5Teh5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="209469470"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 02 Feb 2026 01:21:22 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id CA5E195; Mon, 02 Feb 2026 10:21:20 +0100 (CET)
Date: Mon, 2 Feb 2026 10:21:20 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: andi.shyti@kernel.org, p.zabel@pengutronix.de,
	andriy.shevchenko@linux.intel.com, jsd@semihalf.com,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] i2c: designware-platdrv: simplify reset control
Message-ID: <20260202092120.GZ2275908@black.igk.intel.com>
References: <20260130111039.874548-1-a.shimko.dev@gmail.com>
 <20260130111039.874548-2-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260130111039.874548-2-a.shimko.dev@gmail.com>

On Fri, Jan 30, 2026 at 02:10:36PM +0300, Artem Shimko wrote:
> The current implementation uses separate calls to acquire and deassert
> reset control, requiring manual error handling for the deassertion
> operation. This can be simplified using the dedicated devm function that
> combines both operations.
> 
> Replace devm_reset_control_get_optional_exclusive() with
> devm_reset_control_get_optional_exclusive_deasserted(), which handles both
> reset acquisition and deassertion in a single call as well as
> reset_control_put() which is called automatically on driver detach. This
> eliminates the need for explicit deassertion and its associated error
> checking while maintaining the same functional behavior through automatic
> resource management.
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>

This is nice cleanup!

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
