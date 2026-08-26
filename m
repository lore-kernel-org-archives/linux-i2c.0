Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3B3AD52A
	for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732073; cv=pass; b=QYlhwsG97nKri8KCxdf/OR/mbBH3LyoR/q0k1rzaPT30m0Wcul05LggXvuJwQ2oNNdZARsEK37kis/nO4X2Ay2iHV/Virql7LJECPsOA6PXWVXeqGpLDeaJYtOG3OXiwQGNouHc8TUF3S2CqmAZyjcalDheSwM9DtqTQa65qzvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732073; c=relaxed/simple;
	bh=R9amIzEFA8q5uB6W0hUHTDML7nWF8S2I9fUZICwpgSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIgZKbDFhZWXYV2RGizmxpdMHnZlQuGLK8272P4X66Oj5DReErl/jFT4Z2Pp9XpcIl3SLCiL/H7y3qmTjJKSVXSXuw1i59L97/x0fGVBAeanZRkRvc46jjpmSplh3Ylh12ncMSwBxT3EHoo1tJUzh6jYExne3tGRWC6roL0QWrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAU8Xm7l; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAU8Xm7l"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66825847b2cso854287d50.3
        for <linux-i2c@vger.kernel.org>; Wed, 26 Aug 2026 01:14:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787732071; cv=none;
        d=google.com; s=arc-20260327;
        b=PmhPlfQj3op5HoxYMVsOsFPpmOyY/FNGaAjE0Hjgf/6rtKfS+/8sPbyjE3TfRNpj7x
         +vDk8OYDaiQ3pfBX+Oudw8jbXaCKAcu4y8waOz9WQRcub+BIC1LvGoxutykoCAPd5oGk
         0SfOlNm10HfZGQR/08ONgOjLUfI/LZWCktIbFc9SWrHcaTLiml67/uuQtenJO6m5Rpol
         WHGN5EGPl3rB74RY9IBBYQ1IoVqNqCs52Hom8PHICYugoSY2SFEpGlVzzgZ74b5w7p6o
         ofD8K8kcxRAnsFq8Tm+Sy7Pq9M/367UCLM2DQCxpS7oLr6MOs4OBb9vuyg8O4/5Uh1cc
         NkAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R9amIzEFA8q5uB6W0hUHTDML7nWF8S2I9fUZICwpgSY=;
        fh=UzBgsd4/aNwGJ9MpYf9SmMR2M270SSYtIJ95ID3kclg=;
        b=NN9hvdBwvXybd9aFgUTL1tf1qHOs6NrG9JrpPu/LsgHuGFQG66jp90yOOOx00gsXTD
         QbmjR+wT7R8ln/qNEh7PwVDCBokzhKFYPmzUb/hUJ5yJIqKT2y1hn+P8IyleWky23ECj
         N+QoRQzTWDRe8qRRePKxP0OpV+RRyx95ryeh8B4qj0yxZIj0RIaD9eD4nJZ21W4P6dj8
         vJE73UQ8Gj8z7B85CV+pZ6eeBYegJw6kd0nzj949PivswYS8lk5/iA41V7VxAlGvqg/7
         Y9xx/SWTqk07iWOxAmFzkBr6DoBKZYx4SMFOoBw0C3JsSqWM7gMpzyR/1v8UNIVh/L/A
         accQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787732071; x=1788336871; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9amIzEFA8q5uB6W0hUHTDML7nWF8S2I9fUZICwpgSY=;
        b=CAU8Xm7lzdq1b1qO40sGEQasOMuOPt91pJDd62FxN3OIyDJXcmmUbpIqvRrC4QUuGn
         qpHtR1B2GKXZSckfzUt6vVW62uHCDOiWhJYzqkkZfmE+dyeGYdDSRNqa4LSzULwKgDIW
         pOMwN0VGK4ZNzUemiU9wI+5Y/6N9niw6Lp/r08lgrm6jiY4/2YdVAmBfkA1bcFUMXPna
         kiHzsiJjblwHgLoxzVWQSk6oVBrguHCoE2Sv/tnoR3LyaLyyatub1zPUGFcjvpmT1N/B
         11ihuug8+FLdBTQOpmv2oUvMTU/HXCohtBzpFEINpxiJOJ3Ym6DdftmfGJqXMY78JOyg
         XdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787732071; x=1788336871;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R9amIzEFA8q5uB6W0hUHTDML7nWF8S2I9fUZICwpgSY=;
        b=lZgbJw/v8CaFXDavuXdDxZ9zCfTaMVvI2Ado+Nzbi5IvqnMFuiOv5zUp4+zLJf4QJt
         LfbKGYeeEQEnqQ1kEaPg5If+Ef0ZsfbuQnvYeOZDLQAWwQ1xjRzMzb0ExwckKo22Yxdf
         xIxsfK+ciTgXsc/dATJV0OkRlAFa0EYVmW88jmA1YiOgKVwHN4+U12iTY2c3n/c3BPIA
         PjloL5LXJvJ6dU3KjF8/K9lZgn2A5rZhdhijxtEkXmoV3kKk3Ukeoe4NxQUPeIixD+2x
         G+8Htaag6OZv9/OwCIvqpTymum4e4WCB8Q1p6Uo7GQkjg1DWf4lNqgrvdMDxp5MeNBIx
         +GrA==
X-Forwarded-Encrypted: i=1; AHgh+RrtqUNmXD+a7ptZgBGCsaY7xmlftZuWQjqPXhSRcG7XzPtRxFv9z/xZwWIvdGZWzL9OPL9NrRvAOrs=@vger.kernel.org
X-Gm-Message-State: AFuF++kpk99IvSG23Ct+FhorLVMhDh9VbgIaxVS2dSH6IVP0hqvhTLVj
	DcFwixeNgH1FmDl7WPAnGp3VJCt3BDZB+BRN050e6Ib+HuXI6P7dOg1Ntv+6jnUW/TXutveWrWD
	kbWXTUJLcOCI+15Ma4/+rlOay845EgrI=
X-Gm-Gg: AR+sD10JLML+O5pj8ysFpeiL4PvWrrdeUFsrlnIshJC+L40Q+JPd4irhUr9cSm+nddE
	7yxrnZ/l87ib9dTQmfMmylKO7aEhZIQLNdm9snmnu6q59tFw0xqRL6QkJ05ExdqpVH812Ve/SrP
	+CpqImcXRjnWjRselKSP+GGTelr8S6+6XNwpRP2PjNHJPBOOxczLC97fR6K+6gJ+yfKOG84p96e
	sVpRw4v9UAhIfBvr3PRpmuOZUweyvY5uSfeX4MxcGMXl7ZeOIPShPk/8xQXgee6KlHreIwEqMGd
	nrfUaN3chqblaNpNmYE7/nwxsWEfX3Ggbt0FxAmc3bv1ZE0=
X-Received: by 2002:a05:690e:e8a:b0:66c:d6f6:eaef with SMTP id
 956f58d0204a3-66d25694eeamr1750611d50.18.1787732071154; Wed, 26 Aug 2026
 01:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812094425.3515179-1-lgs201920130244@gmail.com> <327de6a8-6c67-4328-83a2-bfea332aba7c@kernel.org>
In-Reply-To: <327de6a8-6c67-4328-83a2-bfea332aba7c@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:14:19 +0800
X-Gm-Features: AcwNN1WbmUut-7AuuFCqwoZdX5jzcjMrvGCq4xDXrennGXYAL0ALsEP7Epy-Qzg
Message-ID: <CANUHTR9+a8OYmsezZFWMvm+a7DQ980sjiVOjynyjv3ChyPSTLg@mail.gmail.com>
Subject: Re: [PATCH] i2c: qcom-cci: fix autosuspend cleanup
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
	Wolfram Sang <wsa@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:01, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 12/08/2026 11:44, Guangshuo Li wrote:
> > cci_probe() calls pm_runtime_use_autosuspend(), but the remove path
> > does not call the matching pm_runtime_dont_use_autosuspend() before
> > disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without undoing the autosuspend setting during
> > teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Use devm_pm_runtime_set_active_enabled() to manage the runtime PM
> > state. Its managed cleanup disables autosuspend and runtime PM and
> > restores the suspended state on probe failure and driver removal.
> > Remove the now redundant manual runtime PM cleanup.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
