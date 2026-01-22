Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1595324B0A;
	Thu, 22 Jan 2026 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089672; cv=none; b=QIYVyq0lIz9j6FzOT98lHcqRgJtmv+qgbLhp6T18x+dgj3pc5ZTtQkfnqJuBcrw9Y5KGjm879PIuKGdupVrsX4SuO/4DMaOuBMbCj3ctKvt+Xt8sUJU4uMSiv6RO3ycieSR4ZZqSQCHSEPxorDczKJD2LQq8xG2kSEI36/pHwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089672; c=relaxed/simple;
	bh=5sxLBcLLEAhUKnAoUY8ex7HqACVGwT8+jM+70A1BFAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3tyfOu7KQ3Xhs4y1mzuUCN3vtm7IeS3zin37Klav2czOEzyxiObWOa5TQD17uQZRrbKDAJeGKuU8/4Drso8f+jDW/1zBq/tYYsCcaqPnNCFL0SV0eQpUQeCRs8kHucbhgQyCgDXkeXJ2wco36I7Fv8BGQ85/8qu0x8pWZ5Dl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH4aQ3ml; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH4aQ3ml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ED1C116D0;
	Thu, 22 Jan 2026 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769089672;
	bh=5sxLBcLLEAhUKnAoUY8ex7HqACVGwT8+jM+70A1BFAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GH4aQ3mlCOZOy1JL9qojrZDe5e6vKF38tzvNsOvQBAJ+8FwOql4qr1hovAV3Wgc12
	 m2HQimnoQntZ4uvrkFHcXDwT48Q7Ej1FoHOIKNpeNdvnIS/ZxCJMPD2FVvJGC0vzf7
	 xOmHoqDR3RzOkCpAuq8FWDQbSE1cZPNoorsitAKKvdHL1hVuQf1lTgvd2YaF9o4S+7
	 pGgV6mYHF44TEhhk/bUsQXL6f9nuinqHmAGR6xSmxAVDt/igUolJwDCvpPttTB5m1Y
	 d9MJIOm7BVVipea27OmMUIHR+F7+7IDfgT/cyqnNBXVeNLJoMJUcqeka3GqIB/yA+H
	 rnwmT39Jy47TA==
Date: Thu, 22 Jan 2026 14:47:49 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, Raag Jadav <raag.jadav@intel.com>, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] i2c: designware: Enable mode swapping
Message-ID: <aXIqb6VhH-OTB-zh@zenone.zhora.eu>
References: <20260120130729.1679560-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120130729.1679560-1-heikki.krogerus@linux.intel.com>

Hi Heikki,

> Heikki Krogerus (4):
>   i2c: designware: Combine some of the common functions
>   i2c: designware: Combine the init functions
>   i2c: designware: Enable mode swapping
>   i2c: designware: Remove an unnecessary condition

merged to i2c/i2c-host.

Thanks,
Andi
