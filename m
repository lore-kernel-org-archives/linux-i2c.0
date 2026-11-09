Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794202894;
	b=4y87AbWNe0nmARSpeT8xjgKqyCyKaPd9A4XRWH8cpo5R32Cf4DCk4Vq6o52oxhX9pfCz
	 7kaNFtY+p/lc1eWylXGwyu/BYHebgzfVpHQVoQp6cuJ5KUdkbMvCQ+f9QdI5P3Y1T1jBW
	 N68YOHF258Xe01Jy6+EgYN7trKAuozKebVq7O6P7Y7Z3HrVgxGyqz+7IoCllCXhEYZ+v8
	 TQip3w/IyDjDCIpPPGUmoY8n0q4rHCOSM1nneI0779lYDxu0BfuYjWCliPdM0D9GP8QS7
	 5nOW2JvePSnv2iSFhIhPeHROeDyr383hzZh9GCK0/8+nkM8gtA6OT1sPYOAmQibDX5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TrI0GbzOqH9Y+vNRVIA18oJVEvnOoZMEzsKGzGyq4VY=;
	b=cKYDfNl+LPcjL5ACgDslMft5pexvS8CEl3F70Jl48yFMHqW/FOxfMQ3gf6wdtoyJLuPM
	 Hf5MwWHCpSvcR/6gBVlVzd3z1AQe/zrcKEzSJBDCqe4PWrEHPMi6e8WzFy4N56ItmzRaT
	 VXW9SlPDY+SUOo8ARfXfXVizHPWlSNfdPVtOjQZF33wE7BZMS8E/mTsxJj634Y5mAKsp+
	 vbj206pioI1AsEE1GovGqwcs7uOWkQfqQ11S/jVOsR4xTIPiTsZrQYw6DBLuw5cNRYASh
	 1nPOuYaP0IzHVr40Xhy5SuL+ygwNIbXNlPTWe2s0lZxkq7ewDmNBfgZln+gCDk3Hwsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ixTT0Vsl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0689606A321
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 05:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0689606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ixTT0Vsl
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67c00f291e1so257037d50.1
        for <linux-i2c@vger.kernel.org>; Sun, 08 Nov 2026 21:41:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794202893; cv=none;
        d=google.com; s=arc-20260327;
        b=kf4OeQvsnXjhPLdkQb4qemfItMadK9FYsEeiuhLj4qzJPMmFNfMPQ2eDf+IjKRruwK
         YJzgQaOmXoLjBfpHhKL1clnLmITEgf8Egm3uycTWk1P6/wEiTKjpAjEVgtTwl56t1M3X
         Ioyn+BES+Xn706Aa/yBR07a6Um0ztzr9a5jfx16PMcYfyXhS7avrMfQdOMuJ20jKMTq2
         iA+njK9KHcVebrtsfSt3G6v1Q5OTYDQ9Br5W7kvxb0C/oK2Q++mVrGBtIS3930a1xJ7S
         piUA/UB9ShVrzl6yytyc+OHcElRQErmVOxqmwKocU9tpzYmqXGKzU0yNnIt80lWR38q9
         F9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TrI0GbzOqH9Y+vNRVIA18oJVEvnOoZMEzsKGzGyq4VY=;
        fh=6eIs1HPp/eb7SgfzoTGctvu6dXJkP9E9hhhZqkKKUHE=;
        b=IW3pCNia+5Czqzt+nYD98lZCz0wKYNR4wE7az0eMpT6Ug83AFhxOFo/MBHAGGwl2Co
         1WlxE3bT3QQb/nNCPNJ4hWyUQOFqyiVFBn8+gbTlE0cI2wQI6V5U5YObQSMi03K4972I
         8MSxn8mekGWi9sG1i4re0JHdr2hBE3IiLHKqj0j8ZI1rzVjiBfyjG4AIGfrOkwgxGSwQ
         GWXYN3OX8jJxZObJQyKwDIWZggWeGo9Dj44cwFDl3OjnoF34bAIC4/CIqXNZnwwq9XZC
         HJ1pIh3dSW0kCzaqxqBO1y70vDiHnwxElc9bHoT1dFiEEt7n5fl7n2fZDeqU78Jh5N3M
         n18g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794202893; x=1794807693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TrI0GbzOqH9Y+vNRVIA18oJVEvnOoZMEzsKGzGyq4VY=;
        b=ixTT0VslnQORGwqIpda8mBfOWdfApgIl4gRZI/m8GqCr9k4vgh64erx6ypah6o0/ei
         FQqLI8k1GNwoShoSH0KBqfUziMxq4Ouh2W2Y5bKDiFEJ2gweCdL/io5mWG/OmENupnE4
         dgOx6HmnuVCdpk4b220rL/apfUh5F5gOC4pc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794202893; x=1794807693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TrI0GbzOqH9Y+vNRVIA18oJVEvnOoZMEzsKGzGyq4VY=;
        b=MWa9TvbIlNBAN4HWPKS1yAH3QJoGCtLFOGs1hZ/96K2skNjYKqheRL71QtDAZZZurj
         RgZT6IB/zspO2zya7rD0DFwRKim+y73J6+G9Yxp6FIy7rZw9Fvd/BbcwwdnvHhciICuZ
         wvlOU+fa06jNXUUTX/JalpWf49N/nzakJ5tUK2b6U7NZX6KDyQuaumnM0cTrUpdL3CZY
         DYeOT+EdYK/XgPK6R+sfS6ACm9+fxVrZpBwyp+yW+mNJA2XhUZZ2Jimqc3EpWb7xPCTH
         1Aat4J5PYyn1LyV4WKdsjOnER5YYISg1eBahoRqt4F4iQk6VQ02MB5nTaLpPuvJSnzA4
         uD1Q==
X-Forwarded-Encrypted: i=1; AL+hErEd32u8+AXYoO6W6UVEFF6NtTS+5KktH7TECKfEh5fbBTBbbK37usXFiHMK+gE91UlJH4FsjqOCyZE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4HsSSuns5KSBeEfHWwpkOfWbDVvCoduiv9qqXpv2xQBl/ctpO
	tNvg7DLA/FokCE+EJZfJxppq4LuhZ84bUFf2Hw7dux7qj/0qdlSTQtSDEXAtEoarvvsrPv1NTkj
	zvPltZzBMXwUMbZ1SpjiInhN7aLiRexOs2HXYukXx
X-Gm-Gg: AYBFou2sfHBgxUkMLEM8wALkj/byKGhbmFjusVymUoJTeQLlACTTd4wnfGB8xvKDw6z
	GfPdRImGDeVFgo5CPXjO0lVHQKQ3rXyET4foHWhMXq7H+Fp9mzenYjP6gxw+hAeF85GuPF62jx2
	oteCx41VBxBQEkZsgzyDofIiKu53CWGaX8NNg6HpVcc8nO9bBMhIcAdKu3GplmWr9bDUP+GqdI2
	Xyz3hbnwyCy874ErqfEyTTKnHxDisWdhbF3eosRlIIkqUU1/3X99MgLm0OlpANziFDhV2asg8Qm
	2sHjS44eZMFyjO853hVid7G/ENyiLLXdaViTy5AgsQDUlsoV4rl+rf5pFDo/0zGAstm26NpJXz1
	buWoJc296iG9rYyNldFK26/PwRPreRu/RuecNhQ==
X-Received: by 2002:a05:690e:4393:b0:67c:10d:e377 with SMTP id
 956f58d0204a3-67c3d97b42cmr874807d50.24.1794202892850; Sun, 08 Nov 2026
 21:41:32 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103043734.2179858-1-wenst@chromium.org> <179406980914.3424803.6201831446824678583.b4-ty@b4>
In-Reply-To: <179406980914.3424803.6201831446824678583.b4-ty@b4>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 9 Nov 2026 14:41:21 +0900
X-Gm-Features: AclHuK9Uis4PjHZvlrrahSmg0-iKCJazl9kKs9oybOBLW0q8BipFSNFJ0jiQ-bQ
Message-ID: <CAGXv+5G1SozUuj8v64oD07wz6dFbY+bXh-Q3OVvieY7v41ZJ8A@mail.gmail.com>
Subject: Re: (subset) [PATCH v7 0/8] arm64: mediatek: Chromebook trackpad
 supply fixes
To: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	chrome-platform@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 7:25=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Tue, 03 Nov 2026 12:37:24 +0800, Chen-Yu Tsai wrote:
> > arm64: mediatek: Chromebook trackpad supply fixes
> >
> > Hi everyone,
> >
> > This is v7 of my Chromebook trackpad supply fixes and optimization
> > series.
> >
> > [...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git =
for-7.5
>
> Thanks!
>
> [1/8] regulator: core: Add "enable and wait" functions
>       https://git.kernel.org/broonie/regulator/c/9f9bcca6adc3

Thanks! Though I was wondering if we could get an immutable branch
or tag for the commit, as three other patches for separate subsystems
use the new function.


Thanks
ChenYu

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
