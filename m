Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFD53A6F09
	for <linux-i2c@vger.kernel.org>; Mon,  9 Mar 2026 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057826; cv=none; b=u+Blawg1BF35XXkoDmEO5gSw3LtzpoanzAzngEYM00x/IKCRASx/7mj4TirCNokkQf9XgYVkWNIVZGGPjgr6nb7jQLpIMpT2MCBmS480PFcg/tqFsjNcCs/58C8FcSyxUpvgKwHDpMYbPGcsjuiccq91y6jZNF88KMTmUyjQlB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057826; c=relaxed/simple;
	bh=NiK8MRrU9mmhWnRLZrWMpHFRgYCXGL5HTcShy0Upx+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0SikeUEVtAIlsZMdp9iwPCjt3bLtSFdYb8cOyvMQtqbKAyRLp6HkCm/EjfOGYW8mdFi89whr6/k7AiLSOXM4Tz1S0gKWToUlAPMT9Al6fzlsHMhW0s5YVztsDwUWY+TgnoqdUhoyiSvAImjlsq1ovSm56TrJRQfqnfRr5nCn2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VRKOuSUt; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VRKOuSUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=f+fn
	zdLenOxl8FVGQ4E/5kZT0BQqraghF68fO9hX+Bs=; b=VRKOuSUtgRBegn/KTmy0
	I8OFl0pm+3pAgok2LydCO7dWwqbmkOoIHnKwPp5gu/56FuMijw5CjcvpDkSSPFOL
	2Wqk2XCwjVtE2xU3gdOUEdFNCHHY59hupnK0aFNVIvU7GINzG7OE1/0lwUssOSmW
	ze73u9NrPCeRlGiLJOSoqF6yOhxup6Y9uK2qXRite6pc+x7hcS+ZurooDc/rPy7a
	STxkGFjlEIYkL74GhQq+5/D1YqRZIS7n0tjaixwUNfNSOVCDqXIhykb1WPN4yOg+
	kIo7RVx8GG2WDBNe+t6B53yFSA0u/WvuBHpeu9Bvy8IbxfcFPK0uTE0ivhay5eJN
	wQ==
Received: (qmail 2766003 invoked from network); 9 Mar 2026 13:03:43 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Mar 2026 13:03:43 +0100
X-UD-Smtp-Session: l3s3148p1@dGS2MZZM0oIgAwDPXzF+ANZpdrMKUeLI
Date: Mon, 9 Mar 2026 13:03:42 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Till Harbaum <till@harbaum.org>, Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: tiny-usb: drop redundant device reference
Message-ID: <aa63HurhJ_njahjh@shikoro>
References: <20260305125403.11132-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305125403.11132-1-johan@kernel.org>

On Thu, Mar 05, 2026 at 01:54:03PM +0100, Johan Hovold wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop the redundant device reference to reduce cargo culting, make it
> easier to spot drivers where an extra reference is needed, and reduce
> the risk of memory leaks when drivers fail to release it.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied to for-next, thanks!

