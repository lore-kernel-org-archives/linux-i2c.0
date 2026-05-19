Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3313403E8;
	Tue, 19 May 2026 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200011; cv=none; b=L0SbaOwZrtplXqOZIAOqE8ButNh8zYRFpncH6Pe+ZIxOmUb/12t06eHOqci57Z1wyFzdaXp9erYFPrvkxINkEYfQu6zAbMYYEKvMSfWjwOHi50JU6L7Q+ukr237mipyljis829bF4LtC11P0nWKrM7ZJ5HRq7gUBOyLe5XA9+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200011; c=relaxed/simple;
	bh=YLOatiJEIX2P6B7SE7jVduihD9WrizQgDQbkSVsMius=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nJX/qy+T8MZfmvTiYNQiB3oaLTP6Z43rhzzQkMv8gvx5KN8l1q+DeZWhfag1L1gxZ2Rk/4XGta3+4hn34f8lhc/jY6nI/qg4vUiMjdsPQcqmKnUSqi6gyXOUrzfNkqlHN59sPpYBelo6tkY4LsFUYke12CGsk7YziwdI4dFgOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGDfDIAy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGDfDIAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69ACC2BCB3;
	Tue, 19 May 2026 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779200011;
	bh=YLOatiJEIX2P6B7SE7jVduihD9WrizQgDQbkSVsMius=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VGDfDIAy/KV18lDxyFSdxiikWtfC2zpefkRjFmZrBEr5WYVYSR0HwXtaxne5qeCwR
	 IbBZ2pTAqbh4S0BANSxFbDFwP1anLhforxtg/brJ1wpLJeXPJOIVhydtye1NiMdwQs
	 BxE7OKlIpCoaNnPvpedo2ZogUzXKSb6gm8eS2xhehVrQIS04bW00/p8A0PdO2nWiAt
	 AFndOxi7UzyXOuP9iLfsXoK1d0/GeQo/Fa3iL0EbZUzalfyLpMnkswKOfAIXoxEIG5
	 r/qo3GBdlgwFIDOqcTnEaHZ15FwXUbBc716yGDDEik49vQ8xOfK3Uabi8Zh+ittpbF
	 sa2U3/IreVh1Q==
From: Srinivas Kandagatla <srini@kernel.org>
To: linux-i2c@vger.kernel.org, Marek Vasut <marex@nabladev.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260508170032.560650-1-marex@nabladev.com>
References: <20260508170032.560650-1-marex@nabladev.com>
Subject: Re: [PATCH v4] nvmem: core: Default to read-only if wp-gpios
 present
Message-Id: <177920000942.22146.8730066369971234995.b4-ty@kernel.org>
Date: Tue, 19 May 2026 15:13:29 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 08 May 2026 19:00:20 +0200, Marek Vasut wrote:
> In case the nvmem DT node contains "wp-gpios" DT property, the device
> currently defaults to read-write and the force_ro sysfs attribute reads
> 0. Switch to the default read-only, which is both safer, and aligned
> with eMMC HW BOOT partition force_ro sysfs attribute behavior, which
> also defaults to read-only.
> 
> The adjustment of nvmem->read_only value to read-only in case wp-gpios
> DT property is present must be done only after the device_add() got
> called because device_add() does internally call nvmem_bin_attr_get_umode(),
> which configures the permissions of 'nvmem' bin attr based on the value
> of nvmem->read_only that is only parsed from DT property 'read-only',
> without any adjustment. This way, if DT property 'read-only' is present,
> the 'nvmem' attribute is always read-only. Otherwise, if the device is
> writeable, then 'nvmem' attribute is writeable, and nvmem->read_only
> defaults to read-only, but can be switched to read-write at runtime via
> the 'force_ro' attribute.
> 
> [...]

Applied, thanks!

[1/1] nvmem: core: Default to read-only if wp-gpios present
      commit: dc6e0711164504b5f0f858735cf973c965d16e6d

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

