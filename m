Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8E54137AE
	for <linux-i2c@vger.kernel.org>; Wed,  2 Sep 2026 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356156; cv=none; b=mvF/EFXzkpUgte5Tqv5X22rZ5wCUhPSMGkg7Oh+ZBdWVR+6RsEp7Uf0U7wtEEQOoX48ueXV1l64l8z4NpptZx/Lg02x0vdanxYg8VgzXxunczDwgEOQ5BvRPwZo5rk7APax9QaDiXp6fG4dk6O8AcvQvcrbZ8UvixrL49ltv5zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356156; c=relaxed/simple;
	bh=E61i7Ax7yFGiuPSUojx1E/ilksXaS2b/h/ErozEiu2o=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVAaj21c0O6R3R8U7wMVklyqlY+fVcw7GXFhydwyQ2yBqjIlkyFImr4I7+5CR5ULwdbIhPQAik2/K78KIaoiEP7sTkULvXXYSitdoqTEG7xLu7/piQlBvTTL7zbR3O3SyrFn8TD64F6oPHbgZTzMCGcqF212Znuqjtf3oNsnKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2yW1kz+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2yW1kz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A301F01562
	for <linux-i2c@vger.kernel.org>; Wed,  2 Sep 2026 13:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788356154;
	bh=E61i7Ax7yFGiuPSUojx1E/ilksXaS2b/h/ErozEiu2o=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=F2yW1kz+P1F7W9qHrJW/Z4SRgzkdkeyDlb5wir4UWChCBObUycWf8zcKxgLLwUpgJ
	 oTFmTj4g/TsJesCNFAgsJJ6doQHP9WVCfgDKHnlO5XUPCSuio7qESbd+CXoApW+8F6
	 cG9CQgfgK4ix0L3cAKTxqhfluFj67nBzpgRKmXi3vDCjwVjB2GnWqip7VxaQ+uF0oY
	 Y+k9+0XXQBVIjPVYyHXp+opPWykXwBPQLpUjOdIY3fJNxveT2BIb4ReDg16c2hpki7
	 I4EdsC1OD8QV4WKnOYcd9+QMd+aOWxgCcS88pK11hw5Xbn+UpjnpyLGVdphxj4WIx5
	 8z70NxYoQsVxA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a20d12211bso11389441fa.0
        for <linux-i2c@vger.kernel.org>; Wed, 02 Sep 2026 06:35:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxczZHp1q9LQNhciiC0UHcoeLPqfHq2ousYIF9oc725n+IZN64qIBSsRmia40d+YTK63NON7fFubk8=@vger.kernel.org
X-Gm-Message-State: AFuF++mILSG0snjqXfgMx+t5xuQX2OlgHlWDaBC8Vw1V3xew6ofuoqpK
	puyX/0BM+LjCmgZHGVcm+xAycNFAlIBlcaMJtOVjcJjCdXi/WRjtxb19yttn+dyTvHpnAYeRp7E
	hDgC6xYVeeYHb+9If4YXLRlaXIOU5H2slZzI0jvH3Pw==
X-Received: by 2002:a2e:9a14:0:b0:3a1:6a25:1780 with SMTP id
 38308e7fff4ca-3a3555744damr5831041fa.9.1788356153360; Wed, 02 Sep 2026
 06:35:53 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 06:35:51 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 06:35:51 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260813140047.1006478-5-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813140047.1006478-1-mukesh.savaliya@oss.qualcomm.com> <20260813140047.1006478-5-mukesh.savaliya@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 06:35:51 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mdze0tkTOOqvS6GOe1Bg_AMD=yw7P+VKa3T=Y=P=XXLXA@mail.gmail.com>
X-Gm-Features: AcwNN1W2S6Bmy9g4kadytdJBT7elcRN2iSHkGQ2tUZ88DU2ifo6wZz7UQUUDm14
Message-ID: <CAMRc=Mdze0tkTOOqvS6GOe1Bg_AMD=yw7P+VKa3T=Y=P=XXLXA@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] i2c: qcom-geni: Support multi-owner controllers in
 GPI mode
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com, 
	bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com, 
	brgl@kernel.org, viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, 
	Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com, 
	zhengxingda@iscas.ac.cn, kees@kernel.org, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Aug 2026 16:00:43 +0200, Mukesh Kumar Savaliya
<mukesh.savaliya@oss.qualcomm.com> said:
> Some platforms use a QUP-based I2C controller in a configuration where the
> controller is shared with another system processor. In this setup the
> operating system must not assume exclusive ownership of the controller or
> its associated pins.
>
> Add support for enabling multi-owner operation when DeviceTree specifies
> qcom,qup-multi-owner. When enabled, mark the underlying serial engine as
> shared so the common GENI resource handling avoids selecting the "sleep"
> pinctrl state, which could disrupt transfers initiated by the other
> processor.
>
> For GPI mode transfers, indicate multi-owner mode to the GPI driver by
> setting the multi_owner field in the initial dmaengine_slave_config call.
> The GPI driver then autonomously inserts lock and unlock TREs around the
> transfer sequence without any per-message guidance from the I2C driver.
> This keeps the locking mechanism as an internal GPI implementation
> detail; the I2C driver does not need to track transfer boundaries or
> message positions for lock/unlock purposes.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---

This looks good to me and much cleaner than what we're forced to do with
BAM DMA.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

For the DMA patch, I'll grab my popcorn and listen to what Vinod and others
have to say first as I may be biased. :)

Bartosz
