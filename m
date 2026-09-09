Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE7E3446C0;
	Wed,  9 Sep 2026 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973448; cv=none; b=hXjiIXWjI5BIi0Py/cBAda2fbmUuCWn0tB8cfO893FUxphxIwonOr87065s84HekBvY1Ba4f5xU+A4tfBu7lfSOu/EOnKCRDPTUlxF3izV+gQCjP+zuKOfD/Qy7WzsKrzdvcG6jc5vUokDjuFLKEcTjBXEbmPF2ocKBPEz0v/dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973448; c=relaxed/simple;
	bh=cbdZD9bFtq6TA//griZ0TZQRPRKrWpPTgWfubKDbJac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jx5XwVOK01moj2r+LX5GxBbIApw+0GopUcSO8wfcno5C/xQIPfjWBdogefRcfX12kcVr/NeDX/bI6XnGxXav8TLdL3Yd4IsQnLM1nnc2zTxsU4apbOy8pjyiR2KHBqi83ZuRnJwA9r6avXOj5wFwsUGT4LawSxyxpT+wocNsRXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJJS0YOa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJJS0YOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC74B1F00893;
	Wed,  9 Sep 2026 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973446;
	bh=nxFbAm+eBK61ABEhQTTNhlmdJEJCjImvyw02B1Ybsc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iJJS0YOa4PrGg8ukVfe/AOdlU6SrmdAE2RFO/tvHHzU9LplCB9eucwJy08lByDxFY
	 Mt42IawcaRh06FonO0L8xwOxbtkdMG4JX0jYJ//SouSKisHynu3lhPFoakxcwFCyFT
	 cByJRZKf519Nv7G8hmXL03cHuTvGKfvxnMGcIhJeJstDzR9+ZTzFOnsI8GJBPHJ5lc
	 ANXtCDi255qpOEm7NMhGGn+sh0OT+6b132mOZTJQHq0v2QIafs3/Oo9tZUr8kr9mmj
	 HBZms1Wp3rXAZ+uUTL1AOjuFGmc/NOXOgRos7I+KNxnbyNikZkPDxza8TNNBRReOj3
	 5Zu2F/5wGRKXA==
Date: Wed, 9 Sep 2026 19:04:03 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: viken.dadhaniya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: qcom-geni: Use modern PM operation macros
Message-ID: <aqGRdE3jXQT3d_0m@zenone.zhora.eu>
References: <20260729073040.3227692-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729073040.3227692-1-mukesh.savaliya@oss.qualcomm.com>

Hi Mukesh,

On Wed, Jul 29, 2026 at 01:00:40PM +0530, Mukesh Kumar Savaliya wrote:
> The driver uses the legacy SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() and
> SET_RUNTIME_PM_OPS() helpers to initialize struct dev_pm_ops.
> 
> Switch to the modern NOIRQ_SYSTEM_SLEEP_PM_OPS() and RUNTIME_PM_OPS()
> macros instead. These macros keep PM callbacks referenced by the
> compiler and help avoid potential unused-function warnings in
> configurations where PM support is disabled or partially enabled.
> 
> No functional change intended.
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

merged to i2c/i2c.

Thanks,
Andi
