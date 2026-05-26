Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FFE3C6600;
	Tue, 26 May 2026 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837869; cv=none; b=LpUZ/2NR+SpY2uPwb/Y8AeMb/IvQiFjOJHKYO4HAdQJm6+uOQWjkCLP8nEBtNu3krWqc8j5MxzZufyEDQQZCO6eU5GnRt5yLvhCphE4HK9IWCZukpKHsrq3/vSpP1Ubla1jcNVBXN+/1owSd0TrQB2eH3lhbDrPjWufi/8S1ZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837869; c=relaxed/simple;
	bh=+c5u7q80dkuT4gPv2heinAcNeboxCdnq7MCC6Zruh+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8TZEzC+3ugBhybT7TpJaJJ941NByHNIvPh2R8DIFeUd5sLQa4ksnv36+hnqGn9DvO/dqIkiy3Lk2x6ntc6Oi49YNVmcaNew3mILx+HF+7Ki/lVTuXTRXCp/CPCNAqIf4+OhGODaaYEWh+Sd47TXb4qACZ37rKBA1qiHftId1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eS4FN6v5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eS4FN6v5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B99F1F000E9;
	Tue, 26 May 2026 23:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779837868;
	bh=Evk5EyspxzR6ZavlVSKWDIaFwkdiVPIwBA4H+nbGGoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eS4FN6v5uZF6WQYUBPar9j7uTNCbODjlFVd+n3nx3EOeWEwfxSXhTnUC57RLoJELO
	 xJoQsD5GkXSt7c9KJRLR173aW/6bzbOtj6G9+AT6Ua3AdySnAXf9tImtIVWrlBuKP+
	 vFN0AK/ITu3cr15Sxw/jvyWHWGS1HCFENaq9HflT/Qoj3Hu88Sp1zG2xsxID1IE9lF
	 trcXrtalYMk7KacS7ArR0Wqh2XVMkjK4gPVKvuIVYDS7zxIuVonyHC9xfVujO9JwN5
	 Io5iKxMUkW4YwPaiWRJ62by6oGvEoa+4vUMFj7vp6xmHLdnKWJBYcTuPUaMIAw91vN
	 hmgSSA9TtzPYg==
Date: Wed, 27 May 2026 01:24:23 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Cc: brgl@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v4] i2c: davinci: fix division by zero on missing
 clock-frequency
Message-ID: <ahYrkrqk4WzA4QNy@zenone.zhora.eu>
References: <20260526102240.4949-1-chaitanya.msabnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526102240.4949-1-chaitanya.msabnis@gmail.com>

Hi Chaitanya,

On Tue, May 26, 2026 at 03:52:40PM +0530, Chaitanya Sabnis wrote:
> When the 'clock-frequency' property is missing from the device tree,
> the driver falls back to DAVINCI_I2C_DEFAULT_BUS_FREQ. However, this
> macro was defined in kHz (100), whereas the device tree property is
> expected in Hz.
> 
> The probe function divided the fallback value by 1000, causing
> integer truncation that resulted in dev->bus_freq = 0. This triggered
> a deterministic division-by-zero kernel panic when calculating clock
> dividers later in the probe sequence.
> 
> Fix this by redefining DAVINCI_I2C_DEFAULT_BUS_FREQ in Hz (100000)
> to match the expected device tree property unit, allowing the existing
> division logic to work correctly for both cases.
> 
> Fixes: b04ce6385979 ("i2c: davinci: kill platform data")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260514044726.57297C2BCB7@smtp.kernel.org/
> Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

merged to i2c/i2c-host-fixes.

Thanks,
Andi
