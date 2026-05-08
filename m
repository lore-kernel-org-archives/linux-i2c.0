Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF953E277D
	for <linux-i2c@vger.kernel.org>; Fri,  8 May 2026 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246077; cv=none; b=QF/1FWG13ucwZzJw2xNQJb0S2ugsu0w5BexjgX//3dLTHOrALVtKotC8/ghDpjJHOALhRX3OnTL1yg3BYrVEc2hvxawYzeDXMwSi+YK3GilPwEk9KMVDl0mq8fJXy5VPiKdoZnW9o96kO2/nkz7o8JcB6GE1IW2QXXswP8/HaLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246077; c=relaxed/simple;
	bh=s9Z0tLT8SzOsO7em8Q3C4bP32B+Hxk35n24bYsnKKDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEDz5K29PGKvtnzRCY9UKRSBJ0EaSmufJuIpu4sf/495WHtG6KOUMMQdn89hWpsd8bg/EtubHA5jK8E/LUGJNp8gLJ9EAbZ6CHTYgppORVk/F8Xwaar2FSBzozgqQYqjgkpXB+GCoBfAyGN2jFrMynI9GLN8bFbpZTAkaq/odrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChueBdVn; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChueBdVn"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a87edf88b3so1603851e87.0
        for <linux-i2c@vger.kernel.org>; Fri, 08 May 2026 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778246074; x=1778850874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Jyuo4pdqxp+5k2cLL5SvSNM1ufmKJNN793e/W3zYnw=;
        b=ChueBdVnZk7zm0eIwf+OzuyZ7CiQ3VRnriDS37L46hYXoXocN3NJwJI4vTv/D3wNL9
         Djx5EOvNVRR0NQY43MnqitLuMuziU83QBtAKko8obj/4lmWTlqFOfGQfTPJdwSQisC0N
         lZIpaCcyfBKZwBiVKgmwENHi6gn+4uIkWfF0wM37JPxVzRCYZtzW1sZjQ/MY9Rm0+qO3
         EBNUeYhsKnN6rkIqScxfvpGHQBvEYxfOy3EQQ+JKeQGoM9qVjFO68VaaBaUiuLYBzaIq
         nqlD7KvX8ogswCdeoPtAP9niIIJMYDjulm5Ib8lM9fohfn3o2CQY/gDjLUO7jj8sToWw
         dXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778246074; x=1778850874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Jyuo4pdqxp+5k2cLL5SvSNM1ufmKJNN793e/W3zYnw=;
        b=OwomKzpntfyxdTUd5MhadiBAKSqZqfoNdnSEoU5vOkDaZSQVU6B5moRqZM14zNkWwp
         acr4nrIq+2RKs5qFTA2N/zX57M1Ave7J+s+yLaaWc69sRGlspEspZcS7I0S0yegZEAfI
         dPA03k4FHdQkji+xHl3+En8Fhjx8LZMP00tzErC2e5mImJ/kTJ+FxIn7u9NGym08vzSK
         DXjbBNaJ6mvEMlz01o0Ya596RoZbt8wURv/NZoMwjfMD7uamAeJoN0qYEsdEYusVzkcV
         bCczvOVsji/ejUii7gsBTTyimZCKOFKD9vfTaTec2h7nfWS3gXA6IqtkEDJyaMnEMODW
         h1sA==
X-Gm-Message-State: AOJu0Yw+rX6MKNCEonZvPZMl8U8Z+ZJFsLXQbLtnVTBvqeLHzB2umCho
	tj/lJGp859Fg6Atrk+p1h7XjED/Eh8lhKWGGTcx3mzjlmLsiS50PTmFI
X-Gm-Gg: Acq92OEJ8HpZq5u092nft9AcHIgE3EmR+7iPU3wZjx8ODCSpN0SgxmuwjItPNqy79NM
	svrgkZoDLGIVRgKebQWygesgzu+yAHxgUg2gNF/sFrvrj1ggdxRZcdg9qzfBCD1ozvMPKm1nsrL
	53JnxVbnAqjWzDVVMHgZNxJKh+h7OLNiFyHDskLBSBhngi1uGxZtrftZLNSQAhQ6FG+iII/qVWP
	bzgSvzdOBJO8DSkqa4IR8ss6UeOYLLZmu5yk1L8VZm3B87Xh7624/omlWzYipI9JLt/TgrWjgtd
	kwJa35/XJK8ihvLkTK4VvsNs70M6KsRBEldZ05soihoffQCKVY1PZGiFbjdrGNqtOC5Zsaa1xGt
	eNnTABLB5lhbkohWgQ5lxGiQ6n+lFwjfGzL0T5H4NAWLDqUyupKRulIo1Y1jPVU9+fi6Vkxn/GV
	lTuWSZmt9DFS3C09fXQRsIXUU/yp6WAVfLmmJbxtaDjrvP2S3bnIvG2JTcb+HG
X-Received: by 2002:a05:6512:2345:b0:5a8:891f:388 with SMTP id 2adb3069b0e04-5a8891f03dfmr4959267e87.29.1778246073843;
        Fri, 08 May 2026 06:14:33 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a951cfb4sm502098e87.20.2026.05.08.06.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:14:33 -0700 (PDT)
Date: Fri, 8 May 2026 15:14:31 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 0/5] I2C Mux per channel bus speed
Message-ID: <af3ht8OX_VUYVAgg@gmail.com>
References: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260324-i2c-mux-v9-0-5292b0608243@gmail.com>

On Tue, Mar 24, 2026 at 02:54:14PM +0100, Marcus Folkesson wrote:
> This was a RFC on how to implement a feature to have different bus
> speeds on different channels with an I2C multiplexer/switch.
> As no major complaints on the design came up during the review, I
> decided to submit the series without the RFC tag.
>=20
> The benefit with this feature is that you may group devices after
> the fastest bus speed they can handle.
> A real-world example is that you could have e.g. a display running @400kHz
> and a smart battery running @100kHz using the same I2C controller.
>=20
> There are many corner cases where this may cause a problem for some
> hardware topologies. I've tried to describe those I could think of
> in the documentation, see Patch #5.
>=20
> E.g. one risk is that if the mux driver does not disconnect channels
> when Idle, this may cause a higher frequency to "leak" through to
> devices that are supposed to run at lower bus speed.
> This is not only a "problem" for changing bus speed but could also be
> an issue for potential address conflicts.
>=20
> This patchset has been used and tested heavily the last months
> on a custom board based on a da850 (DaVinci) platform.
>=20
> The implementation is split up into several patches:
>=20
> Patch #1 Introduce a callback for the i2c controller to set bus speed
> Patch #2 Introduce functionality to adjust bus speed depending on mux
>          channel.
> Patch #3 Cleanup i2c-davinci driver a bit to prepare it for set_clk_freq
> Parch #4 Implement set_clk_freq for the i2c-davinci driver
> Parch #5 Update documentation with this feature
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> Changes in v9:
> - Fix stray blank line
> - Link to v8: https://lore.kernel.org/r/20260314-i2c-mux-v8-0-fb1738a4df0=
a@gmail.com
>=20
> Changes in v8:
> - Fix gramatics and change %d to %u were appropriate
> - Link to v7: https://lore.kernel.org/r/20260223-i2c-mux-v7-0-ec75b214718=
a@gmail.com
>=20
> Changes in v7:
> - Remove code for finding first mux-locked ancestor
> - Introduce a unlocked (i2c_adapter_set_clk_freq) and unlocked
>   (__i2c_adapter_set_clk_freq) variant
> - Let the locking be handled in __i2c_adapter_set_clk_freq
> - Use I2C_MAX_STANDARD_MODE_FREQ instead of magic numbers where
>   appropriate=20
> - Link to v6: https://lore.kernel.org/r/20260216-i2c-mux-v6-0-9be28ecfd7e=
3@gmail.com
>=20
> Changes in v6:
> - Change logic to find which ancestor to lock with I2C_LOCK_ROOT_ADAPTER
>   It now find the first mux-locked ancestor and then lock its parent.
>=20
> - Remove bus_freq_hz in i2c-davinci and only use clock_hz instead
> - Mention in commit message that clock_hz can be used to store frequency =
in an uniform way
>=20
> - Swap order for change freq/deselect to keep symmetry
> - Only allow bus frequency to be lowered in select()
>   This to not allow an intermediate frequency to be set when it is not
>   supposed to
>=20
> - check if(ret) instead of ret(<0) where appropriate
> - Fix typos in documentation
> - Change i2c_adapter.clock_hz from int to u32
> - Simplify i2c_adapter_set_clk_freq() by removing 'ret'
> - Link to v5: https://lore.kernel.org/r/20260213-i2c-mux-v5-0-fb2cbf9979b=
3@gmail.com
>=20
> Changes in v5:
> - Take the lock of the top-most mutex locked mux to make sure that the
>   root is locked
> - Link to v4: https://lore.kernel.org/r/20260128-i2c-mux-v4-0-dee49ce276c=
0@gmail.com
>=20
> Changes in v4:
> - Rebase on master
> - Swap order for printing warning about "channel %u is slower than
>   parent on a non parent-locked mux\n"
> - Fix typo in comment, adaper->adapter
> - Link to v3: https://lore.kernel.org/r/20251020-i2c-mux-v3-0-908ac5cf922=
3@gmail.com
>=20
> Changes in v3:
> - Return -EINVAL if channel is faster than parent (kernel test robot)
> - Link to v2: https://lore.kernel.org/r/20251002-i2c-mux-v2-0-b698564cd95=
6@gmail.com
>=20
> Changes in v2:
> - Changed bus_freq field to bus_freq_hz in davinci_i2c_dev (Bartosz Golas=
zewski)
> - Removed idle_state from mux core (Peter Rosin)
> - Link to v1: https://lore.kernel.org/r/20250922-i2c-mux-v1-0-28c94a61093=
0@gmail.com
>=20
> ---

Friendly ping on this series.

Thanks,

Med v=E4nliga h=E4lsningar / Best regards
Marcus Folkesson
