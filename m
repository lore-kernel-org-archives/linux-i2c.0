Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C33385D69;
	Tue,  6 Oct 2026 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278663; cv=none; b=m2KXM79B75Wz7JunvZTTowQJ9kAnlYoOoHghq9mAuZ6ht9kIRohbqb2CSPpH4oz00FV+LsNE635j0pJK+dXUjp4dIzYt1YZUrLVArpqSOCYbDT5IrrvTKKnQgUiD8gs6b2rblfGPLSiMZWfcN3EBnhzKbkekQ0aIOMxneFMsC1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278663; c=relaxed/simple;
	bh=a63i4kWwmxjKPmX4Km54AeOSOflFTOpy+2xeR9DaX0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxfVtzQG+3JlChP+CPObZlYarFPPap7/f865gosGbpNqaS3mtOuEabZioL0BCy1E6QdAsx8mO0bN1SDtqaCVBDfvwpr4ZV2xfTNAyONXbXZbV0oPmC2XRiIMZcf7tRbuiKI0X7JRfCR2mDOy1RT3iTFKfc0LyAug50QMSe9IkDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JO6C8fkX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JO6C8fkX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BF81F00893;
	Tue,  6 Oct 2026 09:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791278661;
	bh=ECGd1b3tYlACr4Cru7WEP7wz7lI1y8b9OHkGO+y8tn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JO6C8fkXupBdHHbzl7gfMFDk1dXMbXAZQK5jQbHg0cROBXz0Yv+NnDneDY3Zj2tDD
	 lamEEwR2aNJOLh8NQJtGOuJmeKf7Je70ksbMpgbiLKAOQJqGtSM4Grk64H7WoP90hX
	 fruMeJgU1EJ2RuxYKLyp7yO+7CCzpS30wYNYSXh+WFvw9tGu1P/UJZC66t6zEtl/tw
	 NO3biiHXKnISiPeQsbLOWmIE3afJndh9uwMgyIM6jGrLsg5Z+u/Cl7iGMsTHfDG/mU
	 CWk2dLLYHneA4aROy5jeSVvUthAOid8r8wzW6UmmqGkv3WvAXxep7vqAYAs3dxAtNJ
	 6m4A+7PziEqIQ==
Date: Tue, 6 Oct 2026 11:24:18 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] i2c: qcom-cci: Factor out write command queue
 programming
Message-ID: <asS9_rTnD43_p0HG@zenone.zhora.eu>
References: <20261004-cci-imp-v1-0-227d12cb4829@oss.qualcomm.com>
 <20261004-cci-imp-v1-1-227d12cb4829@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004-cci-imp-v1-1-227d12cb4829@oss.qualcomm.com>

Hi Loic,

the patch looks good.

>  static int cci_i2c_write(struct cci *cci, u16 master,
>  			 u16 addr, u8 *buf, u16 len)
>  {
> -	u8 queue = QUEUE_0;
> -	u8 load[12] = { 0 };
> -	int i = 0, j, ret;
> +	void __iomem *loadq = cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, QUEUE_0);

I'm not a big fan of "heavy" assignments during declaration, but
no need to resend just for this.

Andi
