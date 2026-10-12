Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F5425898;
	Mon, 12 Oct 2026 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791844009; cv=none; b=Z3uF8qv+ZYx4nkfIgVVwmZqdI3ztIWisQ5y20nr4KgdfNdHDT0lvW+D1PBbzTXmLJTuGR6E+GgoGNcb56VQsaTThpGX/P9UjmbA/RRBF7k90euoF76w8REyOaFjo/rmFLlafGeaWYPBf4erKKlL+FRwI4FnDvkDRSYPSkU7CoEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791844009; c=relaxed/simple;
	bh=PXJFtXBE6GBu7SYnAql+0hD4YXSqEEHuwYWAKznrdhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw6DuOHmwEobmL8yPM/7pdppjJOsKvRfNQShjOguq+e9E4AQj11IoEJZXJWzwCCSAXW6JoRyOOwvGNV+RNxJOGeI/T7CNvzPWMSWQB++1q66UprVpsXRrleDCic+In+psVuoey3vXNSRvWNtIUhZs+8urCKysjovmf6pTCq5A9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxKsiGAW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxKsiGAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBDB1F0089B;
	Mon, 12 Oct 2026 22:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791844008;
	bh=eMeFcr8n3WUgRl/2JwHyab4Wg6+yNQoJjTs/G8uhH6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZxKsiGAW/eNAswqo6KFBVp7NZ+QcPk4wQljh8smKspXX8cMe8jgIXF9sycUs7EECa
	 EeZUUFwJ2Armkx1klEHwIeuNLXJVz6e8KnUqUy6c56GaVrCgWREErI2XR1b7yqL4RN
	 6IlwPR2v5DL4vtrNSYNB36SjUcazFaiBVRALH4Z9ZLZLbOqpHBuXbXzb6p/8KLqQrU
	 PhgcYjPJa11vUqIx6gvL+aJtH1/N0x9d2QqUFAcFwfLUZY8xfLzxqbdSc8xMkwClZO
	 oAio85UTP121Wb1ggfMEV3PvcwNJamjJCrJXqvmg0tpRj2U9+YpZp154ymLQOBbIF8
	 pgOBwXTMoRPOw==
Date: Tue, 13 Oct 2026 00:26:45 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: qcom-geni: Restore the source-clock selection policy
Message-ID: <as1ekTqIywmjqZD6@zenone.zhora.eu>
References: <20260928-b4-i2c-qcom-geni-preserve-source-clock-v1-1-9aded7552a76@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-b4-i2c-qcom-geni-preserve-source-clock-v1-1-9aded7552a76@oss.qualcomm.com>

Hi Abel,

On Mon, Sep 28, 2026 at 04:58:47PM +0300, Abel Vesa wrote:
> Currently, the source clock lookup prefers 32 MHz whenever that rate is
> available, regardless of the rate configured by the platform. Before the
> switch to looking up the clock index, the driver used the 32 MHz timing
> table only if the current source clock rate was 32 MHz, and the 19.2 MHz
> table otherwise.
> 
> On X1E80100 CRD, this results in switching the source clock from 19.2 MHz
> to 32 MHz, which causes intermittent failures when probing the I2C HID
> keyboard. These range from corrupted HID descriptors to failed resets
> and transfer timeouts, which also affect the touchpad on the same bus.
> 
> Restore the original selection policy: use 32 MHz if already selected,
> otherwise request 19.2 MHz. Look up the index for the selected rate and
> keep the check that rejects higher-frequency multiples. This retains
> the dynamic clock index lookup without preferring 32 MHz on platforms
> that previously used 19.2 MHz. Report the requested rate if the lookup
> fails.
> 
> Fixes: cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL")
> Assisted-by: LLM
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

pushed to i2c/i2c-fixes.

Thanks,
Andi
