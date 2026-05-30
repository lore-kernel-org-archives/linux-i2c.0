Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373643B0AC3;
	Sat, 30 May 2026 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780143945; cv=none; b=Chy6ov7LRcPF3GgFdpIE7KLV4OIOdlF7vTL5vJ5zft2yf+1Ba+WRUobtRQwEfPiatJ/eJCATtO2zLXYgyyK6Ti27Rv1fe2B/gojKuJiJzlHIMroZtOKP1oXGwAbmdu+fSkqV1utDqBodadM5R1hGnz+OJi5tsFYn+3AXHUq1CBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780143945; c=relaxed/simple;
	bh=HzEM3vtoLqD9NlmQx86l7i0cU0WE1JEoFBCcPrdQS7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx970+3yVyyB4JZHI/c/j+Q4i7uZroO/n6TmpVDKV5MK1U+fbA4ejoBtLNoyv2JN7O0HX7ounLi2EfcxNpo8/3lo73CHLH1vh52PK5lZMHzsKeqraT+8hgCJbBxIp10pd1MYPvzdoLui7McFiXEPWkzpfffEGJNo49nU27jwwyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFHhmvEM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFHhmvEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3621F00893;
	Sat, 30 May 2026 12:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780143943;
	bh=RlOA3FX/Gdn2PEJwcJZLIsKwlzYCgXya4TfvqliyjpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dFHhmvEMPfpmtv61i8LFehWVn0RsWcVM9XzW5qQP6rAPvd4DLZe+P5islkOj4akOM
	 IhS3SvxL2uFpS18F6KyNH79QiUpZzY3nsBroqdYU2XQjhZwlMR6W4Bt/xJKre4uRUP
	 +928pwwmsZVBIvnlbA024IsXijVwo5D9dHqlG9pICYiflMEQG++4hEVgSRYHJy30fT
	 UZB7blzeNHXSagbJfkI0AFK3KCJLMAA2ej/R1vo++e3nhnAMPxAnentXD5DlPOe83+
	 uvdeFGAi61jigN+rWaKP2eGZmmZo4ee2TP0dLdLfRrBhhCtithYTQVdHBWH9mJr/n+
	 OWuUy/jGGh3ZA==
Date: Sat, 30 May 2026 14:25:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Suresh Vankadara <svankada@qti.qualcomm.com>, Prashant Shrotriya <pshrotri@qti.qualcomm.com>
Subject: Re: [PATCH 3/6] media: qcom: camss: Add Glymur compatible
Message-ID: <20260530-imported-petrel-of-influence-59bc6b@quoll>
References: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
 <20260529-glymur_camss-v1-3-bee535396d22@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529-glymur_camss-v1-3-bee535396d22@oss.qualcomm.com>

On Fri, May 29, 2026 at 08:07:23PM +0530, Vikram Sharma wrote:
> From: Prashant Shrotriya <pshrotri@qti.qualcomm.com>
> 
> Add CAMSS_GLYMUR enum, Glymur compatible and Glymur camss driver
> private data, the private data just include some basic information
> for now, later changes will enumerate with csiphy, tpg, csid and
> vfe resources.
> 
> Signed-off-by: Prashant Shrotriya <pshrotri@qti.qualcomm.com>
> Signed-off-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/camss/camss.c | 6 ++++++
>  drivers/media/platform/qcom/camss/camss.h | 1 +

Incomplete. Apply this patch + DTS and tell me if camss is working.

Best regards,
Krzysztof

