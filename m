Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170604EE870;
	Wed, 16 Sep 2026 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555828; cv=none; b=G8ypr13nlCRY8KtNoxClO5dY59SzqaFyRtup482xYW4viC8bHcHcM5epnckSlwupNEpqL8e2AJvmoq8uTCVBJ81DBUFt7OGUd2EXdEg1dF+n/20wtIIzzbYNpxbfl4FzZt+wc6MKq+/xGmgCMBoXtHjlRwl9M8zJQWpSmjEsLpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555828; c=relaxed/simple;
	bh=oKnSrfb9wQ+qPiOvdu3h6eRcNZm6AQQtFPvsazWKfSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHG3fZG4I3GTa6Z813IT/ojBGfgZPYbGtcZcn2lKSmrqxxCCl/pcPq66sJQFObMl3E0JTcD3clKebGTI5zrck3X7vNtkJr50/IoEouay8BbV8TnbW0Rz8Yvr+3TMWxu0faiBuUVtaRN6Y9lhMNV7t6YeWR6glBrn8FNCMrJiGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWFjyEHr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWFjyEHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B5C1F00893;
	Wed, 16 Sep 2026 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789555812;
	bh=4PGsIKzW1IoGdcPTrwqPQxWqIDOUnE5dIHeJGa9vznQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SWFjyEHru+wdTvGb0lZBv4a7BO11OZNUW8elQx5B+Se3Qmm7GS/wBEuQMzG79PTdE
	 nqRud35Vn+1iA4DxAd2woetUFlAK2B/XQUpEorRGESxGENRW2med2tGu+adO19pDHL
	 xk65TQxYJJsQ3wBT2lCrOE5tVUsG2TfluURKkK/gY772k9Oqeh6gCeophyBb7ABXvB
	 ETyVMvWu5+8nKJBEKzhSOwbspTVEh76KiAd2HneqmiLZgZgOGbxyCRYvVmcwHqffEr
	 D3Cm1s/JgWvuRKXQW7I6MFILjq1w6lmrUHrmhQbUujaIpTU7CUaSTOalC9KrsefLUF
	 pHHiHNIdNtuiA==
Date: Wed, 16 Sep 2026 12:50:09 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: i2c: renesas,rcar-i2c: allow 6 DMA
 channels
Message-ID: <aqp0Riqi05WGc-_v@zenone.zhora.eu>
References: <20260909184200.3319-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909184200.3319-2-wsa+renesas@sang-engineering.com>

Hi Wolfram,

On Wed, Sep 09, 2026 at 08:35:32PM +0200, Wolfram Sang wrote:
> R-Car Gen5 can make use of it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

pushed to i2c/i2c.

Thanks,
Andi
