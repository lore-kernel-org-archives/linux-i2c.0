Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65181509AB;
	Wed,  4 Feb 2026 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770168589; cv=none; b=G9WQnQ8r4XtAk72o2HfmTDYCL/5cVrrGIPlkY4q8sbKsSKo92R+GS9nrK/ABwsw48Afqqr/i30c6PzKnbfCQ3yHDsQ98GyhHxemPH3eaTnVj0lEKCvSzXlBPzWb4yCwndvPrsiqHqoqGMmm7RukUnVHS/01ZbX7RSYxYCuXMCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770168589; c=relaxed/simple;
	bh=pcRF1SAQQ81q4UIjx8AqJMQ5ODjOXLDTavWrNXAFpZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1P/P+6zZ0cG97tnG7nAwavyN+Ya9QSYoAhGSnqABB1hsDPgI/+o/2tMFWUTC/ONGS+d1+4rvxptH4fl/ptHW14ZbHulzhgVPp2CqF5CMxP1lProoim5K8W6Ffd4867AlITiM5+Z2lC+lWoFl/Nm9LneOjc86Vjla6/vp1i9V6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMlwxql4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMlwxql4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD94C116D0;
	Wed,  4 Feb 2026 01:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770168589;
	bh=pcRF1SAQQ81q4UIjx8AqJMQ5ODjOXLDTavWrNXAFpZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oMlwxql4lyc7sEzShzTeIkbP/iHSbB/wk9+Z4Vh2ga8t3qSRe/t7uWOsjK8KsVOcD
	 s+8AbipsQO+SdW+HCXayFL37jA5zM5i6i9srS2uHyBtnNpIy4rOEvoYrTf7jx36aQf
	 ou/N4l1gXxaPHVfPTien/Hd9m96uQ8UgPlKoPjKuYaNOYaRn7hqBig+OPjqD74qj7K
	 HeaAaKsThBHPT9Sm5r5Nv9ya669Be09K81pGo1j98BNmpyU7C9f6bq2JSDvbmkAHbH
	 sBzRNIlZ/orlPyZjkkzTEBStl99dP0Le0ueKULV9Nmngd9ZE3uSi+2jawrfbHJPLxK
	 eRTqPPTRffpTw==
Date: Wed, 4 Feb 2026 02:29:46 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Pratap Nirujogi <pratap.nirujogi@amd.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Jan Dabros <jsd@semihalf.com>, Bin Du <bin.du@amd.com>
Subject: Re: [PATCH v1 1/1] i2c: designware: Remove dead code in AMD ISP case
Message-ID: <aYKg7-dfRa51vxe_@zenone.zhora.eu>
References: <20260129103439.187478-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129103439.187478-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Thu, Jan 29, 2026 at 11:34:38AM +0100, Andy Shevchenko wrote:
> The I²C bus shared with P-Unit is Intel only thing as far as I know.
> The AMD ISP driver has no relationship with P-Unit. Remove dead code
> that seems copied without much thinking.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

merged to i2c/i2c-host-2.

Thanks,
Andi
