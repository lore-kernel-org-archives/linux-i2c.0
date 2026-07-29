Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D0E379C50;
	Wed, 29 Jul 2026 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356516; cv=none; b=Qz44kUYkTkQwUiZ1Ivrh0INrA5fNPclayYAx3RWvJR5TnhOfKSpI1PVEoFjHN2JKCq0gDmlBklUE2N2LbqDEMW+9L/kMu+GcAlwy686z8d3fnNeqFZ6nmJcIRHhhmHL5KAoFEiEjeUZ9x1OeT8jzRFI77td7uDRk2wJQmIu5tGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356516; c=relaxed/simple;
	bh=+D5JOIhDELp1hMDGb2KCJz6Ajsy+gHStMYE+vOP0GnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPQSbQZrHJ6/1io7jGqLUGkxrV8y7zbKi/rUBCeCYaaJPimuBP+8KAgvKb7rmtuMISSKrpQsmGWSGwWdHiYQpV5iLYxgnlW6y6YQpkmNhZQJCDNKlNnM/RASCiMNcedsCZl002+L6XVyk8+44MsPxQ1951c98kOSTDAC8flngME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o28N6EWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o28N6EWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877041F000E9;
	Wed, 29 Jul 2026 20:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785356514;
	bh=sPBAE8oAf5SO0c8jbbpLy8cuikYGnw0Lcl3dX8lPQgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=o28N6EWpBUz8/2azsvx09Xod4ch7KOk43defLiE3QkxJ+97nfPl1qYjO/JF4PB0pZ
	 ONRdyKxqK9KKTpa1hWmHUU+V9mXx0NFqYbrbAH/qnSLrD2MTx7jtS3viW4/rm8Ire3
	 02a57byL1/Gy8XyaGC/Ufb+Yu6BmCO4s3RMd65qoO9zwRykP4yLafowMt6492dh2aU
	 L291KEKEIA5S9XXpZqsx+odWaiTdTw5jTOEmlFW6+NfqQejcq8wMZEBCvv4YU1co6J
	 gODLitjoeKwWAKqGWQiCSCW+teHG+z0Lv/CeoppP8m3MT0AjZeofgxaaNFmD4vUWBM
	 W6FY4MykVWzQw==
Date: Wed, 29 Jul 2026 22:21:49 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, viken.dadhaniya@oss.qualcomm.com, 
	dmitry.baryshkov@oss.qualcomm.com, zhengxingda@iscas.ac.cn, kees@kernel.org, 
	quic_jseerapu@quicinc.com, linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, bjorn.andersson@oss.qualcomm.com, 
	konrad.dybcio@oss.qualcomm.com, Aniket Randive <aniketrandive@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/2] dmaengine: qcom-gpi: Keep GPI interrupt active
 during system resume
Message-ID: <ampgw7SerP4d_hQ0@zenone.zhora.eu>
References: <20260709134623.1724212-1-mukesh.savaliya@oss.qualcomm.com>
 <20260709134623.1724212-3-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709134623.1724212-3-mukesh.savaliya@oss.qualcomm.com>

Hi Mukesh,

On Thu, Jul 09, 2026 at 07:16:23PM +0530, Mukesh Kumar Savaliya wrote:
> GPI DMA clients may initiate transfers during the early stages of
> system resume before the normal IRQ resume phase has completed.
> However, the GPI interrupt is currently suspended during system
> sleep, preventing transfer completion notifications from being
> delivered until later in the resume sequence.
> 
> Request the GPI interrupt with IRQF_NO_SUSPEND and IRQF_EARLY_RESUME
> to keep it available across suspend/resume transitions and allow
> interrupt handling to resume during the noirq phase.
> 
> This ensures DMA completion events can be delivered to clients that
> become operational before the normal resume phase completes
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> Acked-by: Aniket Randive <aniketrandive@oss.qualcomm.com>

shouldn't this patch come before patch 1?

Andi
