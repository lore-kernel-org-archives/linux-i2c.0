Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D93466B7D
	for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137403; cv=none; b=Ihkofhnif4YH1uXcAw+S5lAeM3XO/1ZW9dZDhD4Hu/6J33FUvH06bKgrPhmEJ6Z9CLaP/r0ezUMiEFyQ732V95xY0vZ6zHthaUvjIXs5qVLUuG+TYZOSVEOcLGjgQyY7A0dm5qHi5wZF6CZfcoowBUibiw9NtzVs1fNhlrEK8pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137403; c=relaxed/simple;
	bh=3wmuF/fxEWZQwBZ8WHojwu2xkwzDmFAKtWlFi9WgKmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqOoG3kyEhhbUy4ZTToDC9+lQXrplZc1afgH6hE6LI3wRUc5LUqXp0ucr2TvEsCZlxQauJcOK8xXBKYKY46meOhee/8Ir+xR8vA9ofNn6E5TPf90QlpbuuQW3lEKA8mOiHSINfAyuWRYd4GqIiSPkrJbZ2NoF5fEJk049GHgmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bdEwtGmm; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bdEwtGmm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Xbgl
	BQeJSkLehsWeb80bfzv3OZadjgSR6O1tXfRogv8=; b=bdEwtGmmujKEB/NEwaAh
	yTkp7di+ilP9+aWhR4ZWZzRamVsE4wAdPC2mDeR2pKtTvoWUQw/Di1axGmpwI1UZ
	6PioQZ6vvfMmxZKBxs+utKxzzvuAwH1p794JFOFcrf5kw/hWuG9tc1eBQTKIYY4+
	m47BoFV9ID+LyyqByvn8lUOhqG53SRRh3e5SNckyoLO+G4UuSMnE5RMPdsAcTt/M
	lfXsDbKyCAFLsWK8r2x3rdc5wVvwCTj39i4cj68fmeoUbp+GWaRXfhvKDp73s7tQ
	/rndF7T5eBkNrtK9TOJITqf1w4tkhJAUSH265n/6cNXQPSaKBAA5FOklebLIuxMy
	wQ==
Received: (qmail 1209802 invoked from network); 26 Feb 2026 21:23:18 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Feb 2026 21:23:18 +0100
X-UD-Smtp-Session: l3s3148p1@tb4g5L9LpNgujnuU
Date: Thu, 26 Feb 2026 21:23:18 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Jean Delvare <jdelvare@suse.com>, Andi Shyti <andi.shyti@kernel.org>,
	Shyam Sundar S K <shyam-sundar.s-k@amd.com>,
	Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Hans Hu <hanshu@zhaoxin.com>, Bartosz Golaszewski <brgl@kernel.org>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2 0/4] i2c: provide and use i2c_adapter_dev()
Message-ID: <aaCrtsNpTPeXDYnT@ninjato>
References: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-i2c-adapter-dev-wrapper-v2-0-d02946569773@oss.qualcomm.com>

On Mon, Feb 23, 2026 at 10:02:48AM +0100, Bartosz Golaszewski wrote:
> It's been another year of discussing the object life-time problems at
> conferences. I2C is one of the offenders and its problems are more
> complex than those of some other subsystems. It seems the revocable[1]
> API may make its way into the kernel this year but even with it in
> place, I2C won't be able to use it as there's currently nothing to
> *revoke*. The struct device is embedded within the i2c_adapter struct
> whose lifetime is tied to the provider device being bound to its driver.
> 
> Fixing this won't be fast and easy but nothing's going to happen if we
> don't start chipping away at it. The ultimate goal in order to be able
> to use an SRCU-based solution (revocable or otherwise) is to convert the
> embedded struct device in struct i2c_adapter into an __rcu pointer that
> can be *revoked*. To that end we need to hide all dereferences of
> adap->dev in drivers.
> 
> Other series address more generic problems - like printk helpers and
> parent/of_node setting - but there are still some more specific
> use-cases of drivers dereferencing the internal struct device of
> i2c_adapters. We need to hide the fact that the device is embedded in
> i2c_adapter before we can move it out so provide a helper that provides
> the address of struct device without showing how it's stored and use it
> in some drivers.
> 
> Link: [1] https://lore.kernel.org/all/20251106152330.11733-1-tzungbi@kernel.org/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Also applied to for-current and squashed everything into one patch...

> ---
> Changes in v2:
> - drop two patches that can be addressed in a different series
> - rebase on top of v7.0-rc1

... but why didn't you rebase on top of rc1 + plus your previous series?
The merge conflict was easy to solve but kinda unnecessary in my
book...?

