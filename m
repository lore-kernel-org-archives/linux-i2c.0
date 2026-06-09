Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B363ECBE3;
	Tue,  9 Jun 2026 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992687; cv=none; b=GQPzO5KJ9ZI9QIk8oRaCnTNo65oJS/kbSdCGEKy6W+Yl/mno0oPcPgLZjBE2yohH1R5DkZ0nHa5F1lUdmw0h/+fUaJeuDLInw2vf+ypFfh8yXVkx9msfpnWN3mhINJm3TUBtJ3Gm7fH/4jf4KN9FEnDVkw4IC2zdvK4v2N3NoU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992687; c=relaxed/simple;
	bh=QIJRVyWJ7NAGxDI1++Ls2BhJaJI3e225aJq0JjDly7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgiYYNDPNWA/iZbk8D7tY8vSWN63iUe9d55mZegNiFLEBMX6NzYvCHkm8SVD6zHUl5ftjrvjqGC5qvW19Z1pKDP8CVHUqHJL3tuIs+vMUq3MWDpJ9pIhWGDGgVgizJEjYuf3fpjKnLZa1ASArY0pQIhKSexwL0zpoBlMaI5dcco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/kRjuUu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/kRjuUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5411F00893;
	Tue,  9 Jun 2026 08:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780992685;
	bh=bbS5AVQI0dbtHdGaY0+UeROOcVD4gjcZeAVAo5egb4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q/kRjuUuc5C92qG4k5/ZKD3Ff6VMT3znFuXAwMVA9+6eRAByBFS47Ng2vF+p0r7dI
	 OTDTPGlyhdyP09V9u5i+2EL4Hg9NEqQSGITuMr1mtQR3h0egqDQraRQexKqwdYxX4B
	 pUoBarka3GJvqWjTcbOypYduDwz9pBX/hKpYS4r+E1ITA5+7Ll/+5ot0Q2/H5wBwEs
	 nvyWxiO6v1xCoYWpQmnMzdQ9tYRZ4Nw2HjWej8EVd3NmvOJX6vMNvZe+UBmZtnoSgf
	 qPxFnkIjNJgeuO0dVb51JTr8dL8P+RmVjNetEkBkfrCFLA5pmz9j2ta07UlrpReqfq
	 BERWazjA/VrMw==
Date: Tue, 9 Jun 2026 10:11:22 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jan Dabros <jsd@semihalf.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] i2c: Consistently define pci_device_ids using
 named initializers
Message-ID: <aifKiWZkIj4atLRx@zenone.zhora.eu>
References: <cover.1779481436.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1779481436.git.u.kleine-koenig@baylibre.com>

Hi Uwe,

> Uwe Kleine-König (The Capable Hub) (2):
>   i2c: designware-pcidrv: Consistently define pci_device_ids using named
>     initializers
>   i2c: eg20t: Consistently define pci_device_ids using named
>     initializers

merged to i2c/i2c-host.

Thanks,
Andi
