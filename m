Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B4632;
	Fri, 28 Aug 2026 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875330; cv=none; b=i4gqsy5rq0Z3mxca8X7XTY0FD/xV45lJDR/og9Cv/C52e15N2OlJJG5a1oaOxDYvK0ZTSEhk15kkRjF8LpvP0fp1Be6iIQx3ts5NyE6QerEXHmCp/rkrIulG2ZFKJyoDipA8ESszohsIv4eTr8fHs/vLwaPFkTBUovPzH7n2sNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875330; c=relaxed/simple;
	bh=Q2EApNucrjQCycJCwTJJ7KSLBvRHP+dkVje3vtRbMEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRzX4RCteaFLLeJxBaIS9veo1p7lS/yoC+sNRNl/POxtmBvfEkoWctFY9HQp9scGT0kt1Y0ZMD5QdEbGdKnBujuww0xCoGdijOZ/35q/BYfr9zS+lxTf/zyaJQ4JZ+YVJNLyTFMVF+TZuVo8z3sm7pR6Gg7XFRyj0LVCl0FWzd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD9oxJZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD9oxJZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDD71F000E9;
	Fri, 28 Aug 2026 00:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787875328;
	bh=uP8PzH06X2d2GtT40EhpNuEEHZf3jPKOe/5hko2G++g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TD9oxJZ10Esj3gThEM9WUy0RExJWT2wSJfW91pFCsJGYmVeq6H8oT50OIgQgeHoyR
	 GTxR1TX3uVFIyip+MHPzYWFZQ8c/aoU40KMaCKa5OSa5IKwdKwmoSO/PwGFCcbym6Y
	 Fv+m7HpbI+pP4k2YQtRFJceaJgk1EMpAtLEBBp1dHMEKatMqc9La5h/ZlH41j7yiX3
	 vny/SMuUZbIdyI17YhNdWkRA/19i8RomJdqomh9pkKG7YbW/HtK1pL6Reoot1Vh9Jr
	 KGh6zyUFqsFiS3X8ZKn+aMkcQKcFdv+UVeHQ62//3jadLasBiG9F7PCJ7ZQ2YKoCt2
	 GufWwQh0hbThQ==
Date: Fri, 28 Aug 2026 02:02:06 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] i2c: qcom-target: Add driver for Qualcomm I2C
 target controller
Message-ID: <apDPu_uJBTT9GPmZ@zenone.zhora.eu>
References: <20260813-i2c-qcom-slave-v3-0-1d3742e2ad47@oss.qualcomm.com>
 <20260813-i2c-qcom-slave-v3-2-1d3742e2ad47@oss.qualcomm.com>
 <ao7vB8cDufnJZKAI@zenone.zhora.eu>
 <5c6b120d-f791-424b-a41a-6c82de73000f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c6b120d-f791-424b-a41a-6c82de73000f@oss.qualcomm.com>

Hi Viken,

On Thu, Aug 27, 2026 at 06:44:21PM +0530, Viken Dadhaniya wrote:
> On 8/26/2026 7:27 PM, Andi Shyti wrote:
> > ...
> > 
> >> +static void qcom_i2c_target_hw_reset(struct qcom_i2c_target *target)
> >> +{
> >> +	/* Clear error bits before SW_RESET; the reset may not be instantaneous */
> >> +	writel(BIT(ERR_CONDITION) | BIT(CLOCK_LOW_TIMEOUT),
> >> +	       target->base + I2C_S_IRQ_CLR);
> >> +	writel(SW_RESET, target->base + I2C_S_SW_RESET_REG);
> >> +	/*
> >> +	 * I2C_S_SW_RESET_REG is write-only so completion cannot be polled.
> >> +	 * Use a conservative delay to allow the reset to finish before
> >> +	 * reconfiguring the controller.
> >> +	 */
> >> +	usleep_range(10, 20);
> > 
> > This is also called in atomic context from the irq handler.
> > Please avoid using usleep_range(), perhaps you can put this in a
> > thread.
> > 
> 
> Thanks for the review. The delay is only 20 µs, so we were
> thinking of replacing usleep_range() with udelay() instead of
> converting to a threaded IRQ, to avoid the added complexity on
> all the normal fast paths.

perhaps before sleeping you could check the context you are
executing (with an explaining comment).

Thanks,
Andi
