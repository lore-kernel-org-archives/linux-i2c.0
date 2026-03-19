Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3003630E0F1;
	Thu, 19 Mar 2026 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962115; cv=none; b=oJ3yOUL9GqXUq+8OK24Bc0rCOrjhL8GP9cbHDNcoJLeqsPOuoweRTMBLfg4WOcUM8IRUzAjYQG0WNLsaFp8K6nXjoEU0ElKZmcIgpoDpLCv+FkNtaY1IG01sB/ftvSVdOUUZ20EAeMGk9YeJyhuRxLWu5i5dHmMHhcASPAbulp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962115; c=relaxed/simple;
	bh=ykzcs1kIHC7HeFzO4sQnuPf9xEymI7+Cy5DsxqC7jQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4Kf0U6DE2Fz2ZFQfM3OyyNBsC90qM4g3UaCAAou3cT0Uc2aC5dYOkdovnhUu1MX0+Nq18blstkub61dEYljcvENBVjEYqngDsAuzoevruycxpjAsJVcCY2wGZ2Nu0h73ERQ5OSZ75sB1jBD4OWCFWTU/OsjegYtc5f0OhtkW34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NehrajKM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NehrajKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C13BC19424;
	Thu, 19 Mar 2026 23:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773962114;
	bh=ykzcs1kIHC7HeFzO4sQnuPf9xEymI7+Cy5DsxqC7jQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NehrajKMSFGpGnxRGsWhkazvNOwX0Aktu/wcEIC9/8OBL6uxiiDaSzb0mlUJwJx6+
	 WCcYPsouUyoSWQLEELbb4vWxVuctnO3Ur2yrwG2wUrxVxJJV0maBwdriPL9JJL2e0S
	 lHnJKoxixcpWaVEoyZx5E91HWWOr2HuGO9JzpDU4mg7q8yQW2IgoMybo+m0UfF350G
	 1Ij3Ycjc8s5W+oz9oemP2+J4b47QzZlC8z1yn7bllzJINPW8hLkdFh67AV4rrY/hbs
	 AhATMO1pKS70MXZ/6kNurWfVB+XZpgdCSIGaeueDUM1jHnXRSBhFk3+9v/AaJJbkjF
	 DhZwSOZUc3oKQ==
Date: Fri, 20 Mar 2026 00:15:10 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
	openbmc@lists.ozlabs.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: npcm7xx: Use NULL instead of 0 for pointer
Message-ID: <abyDR-UDvBbID_OD@zenone.zhora.eu>
References: <20260216085825.70568-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216085825.70568-2-krzysztof.kozlowski@oss.qualcomm.com>

Hi Krzysztof,

On Mon, Feb 16, 2026 at 09:58:26AM +0100, Krzysztof Kozlowski wrote:
> Pointers should use NULL instead of explicit '0', as pointed out by
> sparse:
> 
>   i2c-npcm7xx.c:1387:61: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

merged to i2c/i2c-host.

Thanks,
Andi
