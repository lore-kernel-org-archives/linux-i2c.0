Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAFE32B13E;
	Tue,  9 Jun 2026 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029697; cv=none; b=PPk2x47wtoYOY0sUIM/d6fjxjvMQ66ocEbaFAWC9hv1MHClzJ6lZiILZklarjCQ7RYii3ELzTbID777CHLuXYxAG0vdvvMmcaVZTUcJ/Kv7dbxJcviEk2hWdr/uy7olTV7nDEvWlklopbKx4zSRO1UY3uDA6sR77as3EWa0fj8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029697; c=relaxed/simple;
	bh=zbFmqKfQAq3wkEORBEOg52z7+vDcmmR1bAbp6NeNQv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfSki7Wi8bmgYbyhozzsyWn8y2l91NkBVkM8u5xJ+Xs542bxrsc4ocUZLvSyQ3iBO6hshtNETAW+U1dX9vkYg/NGGIwdmd7KT7TX9wKtIEzgkTZmG7MROIDRJpCVagW4OtC5R28EEh2ZcfnSDRHfdBTUjmphdAuHx+zD8W1APL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqmDTLWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqmDTLWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2BA1F00893;
	Tue,  9 Jun 2026 18:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781029695;
	bh=kn3N2mYYGUZSqN1nbkQv6n0uUW62Ml+CXOjbFIsr7Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cqmDTLWetSQVrX8VFAtNcVNal6iZ9ieLokhXmMpUgltW27XZzfSGTJLs3kAnUHtc9
	 zoVPtEGbTx9QgSos7JZepYTe/52lADn517Vabz79zFF39uAmebwRIykuDmCx0DcUie
	 8aoah9jemAir0fkqIH+iFexRZdDk3rKduDQOOj9lFi/KAQG1+Wfd28vIaj5uASp1Nw
	 hLL/wC9idT0JOkHxL5tufwvYSLkrpwpfDqbjbfKgMjeBHBfto3hGX/MlsGDf8zTYSH
	 JIOBRaPnw8ZCIXX31FTQmb4BUZMBBqNYgQFXvXTHUoqpfV0Jg/PgLQPMP1Zvn+gt6U
	 e7Z/taS1uiXag==
Date: Tue, 9 Jun 2026 20:28:10 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: qcom-geni: Use pm_runtime_force_{suspend,resume}
 helpers
Message-ID: <aihahOVIqpm83Guf@zenone.zhora.eu>
References: <20260520-use_pm_runtime_apis-v1-1-6a5238fc6cb6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-use_pm_runtime_apis-v1-1-6a5238fc6cb6@oss.qualcomm.com>

Hi Praveen,

On Wed, May 20, 2026 at 12:44:29PM +0530, Praveen Talari wrote:
> The driver carries custom system suspend/resume handling that manually
> tracks a suspended state and conditionally calls
> geni_i2c_runtime_suspend()
> from the noirq suspend path, then adjusts runtime PM state by hand. This
> duplicates PM core behavior and adds unnecessary complexity.
> 
> Drop the manual state tracking and switch to pm_runtime_force_suspend()
> and pm_runtime_force_resume() for system sleep. These helpers already
> perform the required checks, call the runtime PM callbacks when needed,
> and keep runtime PM state transitions consistent.
> 
> Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

I normally don't take these patches: Where and when has the
review happened? The reviews has to be done in the mailing list
and I need to be sure that they have been discussed.

But, because I know Mukesh, because this patch has been sitting
for a while and because it looks good to me, I merged it in
i2c/i2c-host. But please, next time I want to see the review
process happening in the mailing list.

Thanks,
Andi
