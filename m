Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8053B1EC6
	for <linux-i2c@vger.kernel.org>; Tue,  7 Jul 2026 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453481; cv=pass; b=GR9RZO3NkyYJi4ZBNCwmL7tRRJo0bLfHH5AObGL/wBiBOJeTaRJJUYz9fceZFHCCzb7GWVF9ZbQ5Wzba/x03fvcBKuQK5vv0lM5LStEEcdSasOKvBu9G6vnC2NRZVSeLb4K+cqB478LLJqBGQreu0za/MU+3ZEeBpuqGQz6fsCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453481; c=relaxed/simple;
	bh=HtfrFM7rpGnX8vGtZgY4JOSL1xoMsykPlMzTpKQpNPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYzfRWrYEu9AzCBWrKUwB/Y9lPlJKXxHAgNhquL9yCSTSpJZGMFMnG6gm7eNdz1NGAs0XlFNao28OXHOv+yVpYYvkzUCw/La83ZjgulwC+E+H5UTNPLfAC7KNqxPXr8r9EqKrdlROBAK/qrtEX2xzu2WGFU8vWMtoyv/PvR6HRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WE+3jIY4; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WE+3jIY4"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cca24023edso36253505ad.1
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 12:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783453479; cv=none;
        d=google.com; s=arc-20260327;
        b=bbKckVs98m/7pK6FZ9AKZ+r/wu2gLvk778RM5oO/Ddi92/cfSv054ECFxw6A54BhQO
         u4/BLoybMbWOpts5Bu7zrJsP/EZpYDrBGCTLQ19XAoWlDrhmO34kGKFgd2gXJ0g/igLW
         UI9ajeCzcpcft09Ujzd9UR1YzyQYi9RLXEjRFBl1LNRgspGkwf5eRpH3mzVCLRW5ZM3G
         latWLPqZSfa6XRk6m6cMSNuJnlp31hxSj6+oEl/RCm9KF3QymOFE4PF4lwcQ49dXbjnx
         OLiGD2xLVG2oFgSFj8SXfeRbcm/ajwUptlWJOISUgepYrjDO7OLDnAG8uOhDRkJb+NHl
         UC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HtfrFM7rpGnX8vGtZgY4JOSL1xoMsykPlMzTpKQpNPs=;
        fh=Sq8NAbPKAKcG/qT8w1NpfcAP9u5/HRgbmdHreF3i1d4=;
        b=HoBcP2UqWq7P0v/gjEw+qpnuYgbitju40fmekeMSw8pEJ9jYumhtwrvpRzR/7ML+3n
         Y4Zaf3tVX8ab4v/JWn6ea1GPcKzqmlmMdcl8wuNCZwQYNHrIv68xd9jC2OmKEAlCc/8/
         Z6vIzYat6GcsmJvaBKR9CF9BJJhvhFjGAYd/ro3+BKVoc3Y3+Nz3qk2kGE9AU9uV65t5
         ogTEUXx0TeMjufflFRwSciR23pA8SbNZjnhK3ydEYsNtbvjdR0BKC9pjmYi3bZUDrDMm
         G7RJ9JYUI1RRfGLv9F1Tl9RxFQX+VqVYjcFVGseIiQXaTarrFjUleP3PA2ONk68PU1gV
         eDZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783453479; x=1784058279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtfrFM7rpGnX8vGtZgY4JOSL1xoMsykPlMzTpKQpNPs=;
        b=WE+3jIY45ci/rBMurJZg2VwgMrWEbxYXopp5BltcxQEDx7iv/3KqBhQ2lt+uWEVL4d
         f7kxbXq0icZoDmFobfF407EC0zL00Q4vBUuTM6Qup5q8EPZg48y9qWZ7aG59ZEgkrPM0
         vT4vNuUbDOw5KPTKjpWp3uRtfsN7A60o21VtnxmrFv49zxTSHJcZdRa/4s2KJm+L0dtv
         SyWe7mu2Dh10HbgRdTFxaGgNYqpxFyFLzzbw99OYwO3GuC0bt3yWXYqDxxfKsdOu8Fy3
         75prGzK+xRqO/YOwHRSel34rT4ynFi5fEhp0H5WTv5BBap0hz+KR2TipZB548MDd3+MK
         Cg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783453479; x=1784058279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HtfrFM7rpGnX8vGtZgY4JOSL1xoMsykPlMzTpKQpNPs=;
        b=EpKCU1+VLOEogABr753mvaYmCa6K/AiAslXkR2GfNHuYynxcaJhuZoiqiTiy3gl1PE
         kt9ybC0L1JIA6lHOXItPlMQsah4ISY1/vgRBChWbZn4dVEUxjtMnK9PBLeMYeVy0wFVQ
         /OSB6YBrztX+waJDbYn0FqtyYBHjxdN3pXRxmVg//hrKTLih1S0qR73vB/vm7QNiZIhR
         L+GjZue90Cuy7nkBudBk2Mw1up10jXlTg9EHxCFLVuxJFwgqUc70u/9/dewBE+7XljPe
         cNwHRultXqYc7vYoT7gblcZq1UczmhZitJpDlPSKR7uztHQRoos5o/tld1eQzn8nNShM
         me1w==
X-Forwarded-Encrypted: i=1; AHgh+Rpz9FxbleolgO6w3WAl/2e76UmDJ+iN2k2MmrxbTI5O0LaZjdxaQ977Ly9dgzBhs3Bv1JRZoVekxs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCNu4DniSwoj1qEF+qTA95pbxIeGEmPmI4uh+mvoFNMZ4IJqu0
	6aBIu793iAo/H6TEuk26gMiFhm1MzvMXFGG5HQSx9JKDuLKpu96fHvKGDCm9aLtTZyJbkzK0T6V
	SS4bc4dg6cNbjONHBf++46SRg7+dgMIE=
X-Gm-Gg: AfdE7ckghVGrA46ECgHXlmu1w7VzrOkcTqII+FvN5ZmPFomMpHh8tpHV5YIZKdWWHDD
	Kh6+KiGAa2i/fC4BOtK5j3v4up1VyuS7CDhRUIBL8niiMVagFXRzYmJ497/zdX06tkmlzzGLxGQ
	Q8+kinIyf7Rtm0upPqVrqNPkrn3Xrb1i6DhSfJsXuEfivLyrceGhg0rWemGOVYg82nDEvz0fVZ1
	nyS9Vp93MEWLFBuaC4smChcjkRELGEa21a/vF8BLfpK3GGyKnJVYiMo4dwvpMz5J0O004AhwZsb
	QQ6n07ilbsaJqj+lzHSiw94oOQ==
X-Received: by 2002:a17:902:f645:b0:2ca:9d5a:8b6c with SMTP id
 d9443c01a7336-2ccbe3fcc82mr64122445ad.5.1783453479150; Tue, 07 Jul 2026
 12:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr> <20260702-add-mcu-fan-khadas-vim4-v8-8-244feee91a36@aliel.fr>
In-Reply-To: <20260702-add-mcu-fan-khadas-vim4-v8-8-244feee91a36@aliel.fr>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 7 Jul 2026 21:44:28 +0200
X-Gm-Features: AVVi8CdKrhqOEXxfOyDGizCGSCM2_7htBspGi7RIbYxEuj_pMgbN59CYzvH2GP4
Message-ID: <CAFBinCCkpgta_QfqDzye2cD46_Wad=2FO=oBcw9_zkxzQp3OAA@mail.gmail.com>
Subject: Re: [PATCH v8 8/8] arm64: dts: amlogic: t7: khadas-vim4: Add i2c MCU
 fan node
To: linux-kernel-dev@aliel.fr
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Beniamino Galvani <b.galvani@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 11:57=E2=80=AFAM Ronald Claveau via B4 Relay
<devnull+linux-kernel-dev.aliel.fr@kernel.org> wrote:
>
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>
> Enable and configure i2c MCU node to get fan working on Khadas VIM4.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
