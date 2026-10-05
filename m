Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C689637F8C7;
	Mon,  5 Oct 2026 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194919; cv=none; b=q5LI17+mI5/5CwMbaLgQYJtP6eqc5op6U/2mDrIZrZB+LVIFd+ESCwf44DzkJnUbYSDHuiZ97pbR1E1nooSBdQRiNXTU0lpjInSEQjsDStiCaFb2lKE74N2hYmMEVKnPYrR2EWitJFmHBW+jeolq6ma6/0gHCwUqRGSdbu+LLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194919; c=relaxed/simple;
	bh=7pQadklf6/mP4Hn4MnF3kioh9DzwPvMi3mzy+TgBOZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgFMe+ce77bjOh9pcNoyS5EHrQqK8WA3tqAWC2775S1e6fLeI6fywN/tkZwZAMwD+rbZ6IkxVpa04JeYWJEr66UivhlfmbcYjfwKoulJ1+j4+MC3W+Rfv4IsPbYrKbw6ThNpm/B6el6ffyeTOciLAFtII6gxw54cUT1WFf1ZPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy9114aO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy9114aO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48731F000FF;
	Mon,  5 Oct 2026 10:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791194918;
	bh=II3H39yUqe8qpCpMfAx8PjH5RINJYko5CoID5Kjt01o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vy9114aOj89memiU8jmtk6qFMtNu6BcjbsU/VvNeoAOfTpYi94KeijwBt6KbEkcWE
	 5X5YSK8yqNyiAgnUcZW2BiHqyIk23zqhdoj40PkboiWFZm9gvCy5EDkpfWJanww96o
	 +R5w/2XO4BNkuKUP3pLC7K9YC3V0t10Fczq38uVpjbNah61EcDFo5IWl3qunl9BPPq
	 dlV4YEvDigphwEfT+IkzuahH6mROS+QkD9GbV3LF4O2PfpLt9LOGRBJcj9/BpHbnrN
	 BgZPT9Uck5du92Wmu+onCqIPzg7Gvr5k9/tE7OoKfhJTx8BXr0g0lP4uURR3xuztot
	 JHpTNVYO/fpYA==
Date: Mon, 5 Oct 2026 12:08:33 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Robert Foss <rfoss@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Luca Weiss <luca@lucaweiss.eu>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org, konradybcio@kernel.org, 
	stephan.gerhold@linaro.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v6 0/5] i2c: qcom-cci: Enforce the required CCI clock rate
Message-ID: <asN3BRj7RyB1_Iwu@zenone.zhora.eu>
References: <20260929-cci-clk-fix-v6-0-62a268cccb0f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-cci-clk-fix-v6-0-62a268cccb0f@oss.qualcomm.com>

Hi Loic,

> Loic Poulain (5):
>       i2c: qcom-cci: Switch msm8953 to the CCI v2 timing/rate config
>       i2c: qcom-cci: Support per-mode CCI clock rates
>       i2c: qcom-cci: Add 19.2 MHz timings for the v2 CCI
>       i2c: qcom-cci: Share the timing table across CCI revisions
>       i2c: qcom-cci: Enforce the required CCI clock rate

pushed to i2c/i2c.

Thanks,
Andi
