Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822D21FF21
	for <linux-i2c@vger.kernel.org>; Mon, 13 Apr 2026 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066777; cv=pass; b=QbynxHBqVArpghlWYM4wlBkL2xaymgxmAoHBVMqXH+6heAVUMfAniI5RS750HcoPfIXAdP1ecNr8/j2Rrmm/bScWuxb44aOWWHRSbXX9rgEFqPSZEFdLHufLEt+yogAKhjoxA89d+WYVI8fAYSWqIVsX8GuzvFXYhF/rWMJF/Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066777; c=relaxed/simple;
	bh=8i76hr8Gj+RtGUBroSxVsQfLVKIuEs9W7G61OYrNzFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxPQtIjUK/+2v7P0WTbGmnWtxocjo8oPPBtbVWl460zoR4Taoa5UHxCIGUWdUpXWbpg6ngur31bZAnjZxptdI4fIpfQ3Kzmk74bwCvBVmkvL3x0RgWFTVb5SFRQrGd1koqN7Dymg/B4DrmsAVSAAByCGhss3UxD/eVpvW/S6F74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB/+J5fu; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB/+J5fu"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9825ba7f9dso586822566b.0
        for <linux-i2c@vger.kernel.org>; Mon, 13 Apr 2026 00:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776066774; cv=none;
        d=google.com; s=arc-20240605;
        b=fZFFQy8RwdfXNWs40mVVZNTszx1+GjrrMpFHYAdnwQH5lCbE6jz4Oql+oP13NXIeNr
         DKu5G+iCGG516fYoEwOfdeDXv96fh5L4ytIwp7t3lcrthMJCE8baTWqFjd49niHL6NvE
         VXrAndJsRSo2Eqljxn0mMVGouoCLLQN04iAOuUcvc+mfGfjwPpY4kI2sRZ3c8FWUfNQU
         nSt3DN3OM2EUZLMQeyK09hGAMyTNqTehgHMsXQ3FQC1cSsrvZfnmXL/9Q6CIdCLBUycA
         wyLMBNZgExcSe7NeMLle32xcm1G/aHt91Mx9fcXIjnscftVGoXLmmkJlcNCmA8lYrLE1
         x1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sTeLoPuL69qtHikGrHVR6h29M/vzfp4S7SUKcSWz2wU=;
        fh=76qyl2j2E+uc+rXDrKPGCLnHR0tZdRSupKiU8i+6GEk=;
        b=RJ6kCJcH4jrBUXMzxCSWUPOBSrqEyg7ayt34pIyBCBva1kppf4MNJwgIYTWirgHWgN
         EB9DkrmnLwFeCpMUuE4Tgkyxu2PQ94m8k/phvXUH7lLxIMAAO8ponhFiNg18s15E0JAz
         Ft+64NPnFZ/x5X6VBF7K3I9jRmBRXtg+umJz3Tg4tiekLwlTuh/MY5hAuA0xU1gtZlmC
         NafnWFH8Z2wenRkN0KxuE7xwvzLoOK3cobKsiV8LTEiPHUZlEJZeW/BeNSGqkDyszKRc
         Qj8xXhWJUV4UWHDublbiYl2Gkrs04u/dhHlGaDwpLDnY5cMDAg0/Ozerv7jZxY/DD2/X
         Y20g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066774; x=1776671574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTeLoPuL69qtHikGrHVR6h29M/vzfp4S7SUKcSWz2wU=;
        b=EB/+J5fujPLcNsgzTuRVpKGVkkNM38PYAGDlDvm3P/R02BQ4yxtw7cNpjBT4LzK+7Z
         7tMTAh6PEx+Pi1i/XJM9fFoxKm+MwBG/QnZ+gnT3F0uEciUzMDzW1cWpwj2Kx7v3nCoM
         f5NG2o0D8UtUV406I7K/80ol3+N2JRKHCrHjDG+ZKxeOH84V1iXoYrcAJNhumTqJTQ4F
         QSTVQQgqrXwq4qWKRAQY2qJgcrAogxLTL+Ox+o+gmiOb/BmJ7rq1S+I2EV8RSz1vPgax
         v/O7Zi74khPejszE1K5d5mLgrqFiZ3PvQGrWT/PKG7Rc2YhVrHT0iCTQkuCtK3Rxql+I
         k3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066774; x=1776671574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sTeLoPuL69qtHikGrHVR6h29M/vzfp4S7SUKcSWz2wU=;
        b=HvPfhAufvazi4sy6FX1TfWKZMsZHIizy+kMpP/7pDPxATE+MjBWCQlK0hfafQPf4CL
         xnbY1jKi4lKVgKy0M30Nc3jBy3i/TOKGiMO7DR0fkhV2EabQRORqwpOo6Mj2bWHEzwrB
         Y+rnfR5BeYmFQIju4adpG6Ghfqc1yz67kzgAbM8yWdkQ7IenI6OuIAYNcoISCgfCBcXi
         3sII9HZSX5PeRXMfZC424wxs924APqFAjTEqnIl3ifozYzA43WeNKr1Esnhj88JcczDi
         WAWQe4wYatPVhEoUOi865aplAt8piBpk+G3ON2wZCPXDLi7ZIxuN3axiH6VY+a78V03j
         HrdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3/Phvir4V3la1pa6xk4AUw4Zk6O/Wx0ILmRwYUvhU/MJ++jHD3uDYaMv4Kg/VRkzwF8AQuKbm9dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNys4iY+gH8cn4ChXJaqLRYJmFJTyVCxkHz+RQtC5NCEKQi/Qr
	B+kCeJI9Nx8iPB46+1Yzkb4NLJFMnccqR19SaniwzB5jqNmgPy42dnqsEHOASUVQfaDK0b1DbRW
	w0MLNAXbpz40DJikDGY8HblqyR+1vWWs=
X-Gm-Gg: AeBDies5q1LMgI8HxQH4lVCnPVZ4IDIwNmvFdLk/OZYjs1/lWgfkNq7pQfAWipniskd
	XHeyg7Yo9aDjBpbRdX0YA0vWBnO5IlGyK04UfsLEOQfu2iDyuRDEB3OiyWtC43wIQn4Mil4ZX5k
	9VhFKbkyPqFduT2BNQKFZTrzqtPO/MloqlaUQ7OrGp4blJC5Zv8Uv/UN41oBiJ3lu1qJqpKqnz+
	6UktdiVMYR2SvmitxUheIU0RwsPs1mk538aZkSMPs2lYMPft05dFy0Eviw0jfRcKUwrh8kH3vDM
	xejFnsDtZRGJibrkcAvlgwpyjM35TADvDg61NqYeVTkE7it69k8ydmIeGu82NMp1FjPdOgIEBC4
	SLnPqtLs=
X-Received: by 2002:a17:907:3da8:b0:b9b:3b90:1047 with SMTP id
 a640c23a62f3a-b9d46381020mr686807966b.30.1776066773845; Mon, 13 Apr 2026
 00:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775900045.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1775900045.git.zhoubinbin@loongson.cn>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Apr 2026 10:52:17 +0300
X-Gm-Features: AQROBzDd7oISg4nKnjr8XlrN-YmlCPDBGxSBhjMNA29ixq3SfKpY3ltSGMuX2Jc
Message-ID: <CAHp75Ve59GPAFvKM6yOkPmr=kmHBjVL-Vz78X0WDikiWd+2arQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] i2c: Add Loongson-2K0300 I2C controller support
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 12:58=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.c=
n> wrote:

> This patch set describes the I2C controller integrated the
> Loongson-2K0300 chip.
>
> It has a significantly different design from the previous I2C
> controller(i2c-ls2x), such as support for master-slave transfer mode,
> and  DMA transfers (implementation in progress), etc. Therefore, we try
> to name it i2c-ls2x-v2.

...

>  - parent_rate_MHz -> parent_rate_mhz to avoid CamelCase.

Was it a special requirement from maintainers?

Note, the physical units are special. The m and M have quite a
different multiplier value. So, even if asked by somebody I think it's
still arguably should be kept as MHz.

--=20
With Best Regards,
Andy Shevchenko
