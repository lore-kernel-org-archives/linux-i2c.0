Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACF3384232;
	Fri, 14 Aug 2026 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699117; cv=none; b=PUv38o1+5wK1m5JPxi5yvOra4LnDV8SteYKv/oXMDvgu4xYBU+DXH6cng0HiQPilolt2IB2xBXErK46F0e5T/SKPjfxfP28s3H+1/LUqD7+FV17I/brsQ7auHnGrHvKv97PIqlIbv1Qu/nMSKdims8HJFJs/lmXtkJHTNJ0kpQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699117; c=relaxed/simple;
	bh=MWm1KTHgFdEvYDHb8b3WNpdNZDj/tLLWWxJ9KETkDCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLmw3SorFMfDoC17rNGr82bZOctkZtaH0XRvMz/ogo65zW4cU4XR3OcnBXcnGhRy3qURCA2+QZLkLPeoa6ZFd/GmlOULBMzRp+ROe1wYRZpx32xTTOuzUvyQyRktQIy9kp02KUDen1bu50qJGy9M7sLTyRbcTmE9xeYpkHUGqeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBLccQcM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBLccQcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3752F1F000E9;
	Fri, 14 Aug 2026 09:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786699116;
	bh=cvRzWMrdw8JpHJQqJon6QPKNit+o5uZcUbJrMK2Xhu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IBLccQcMMInMF0uEB4olTFIMrkpWCNunyazG1b5pVYMp/mbV7m5QNWKKPUc/kfQUi
	 79cMiDbH44/lkp4ah0zbl2jVrxnTu2i37mpBr1YJhe4QOn7HEguFDtP4qSpLYEqWuI
	 yeJpGHUuPNMdXHRcHmXA0p0tVjYUlLA+X+T77+20FwPHG0wWuPmi7nGykwuS8tkm4L
	 1utaCIqstDuOoB5Uw/iOB1xdjIx0Vcy1oudlt5jmKOEaJZqzFr+O1WQCNNbEgM0V+E
	 cJ+4xz74CdJhhnlqvNTSIQAEAuPge6kV2KA0auENE1C0/4DvCCO6ucAKyE3IpGMzed
	 rqrChDyIq1w0w==
Date: Fri, 14 Aug 2026 11:18:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: i2c: Add Qualcomm I2C target
 controller
Message-ID: <20260814-fluorescent-solemn-capybara-f9dadb@quoll>
References: <20260813-i2c-qcom-slave-v3-0-1d3742e2ad47@oss.qualcomm.com>
 <20260813-i2c-qcom-slave-v3-1-1d3742e2ad47@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813-i2c-qcom-slave-v3-1-1d3742e2ad47@oss.qualcomm.com>

On Thu, Aug 13, 2026 at 09:22:32PM +0530, Viken Dadhaniya wrote:
> QDU1000 and related Qualcomm SoCs include a dedicated I2C target
> controller that operates exclusively in target mode. It is a distinct
> IP from the Qualcomm I2C master controllers (GENI, QUP) with a
> different register interface, so it requires its own binding.
> 
> Document the MMIO region, interrupt, XO and AHB clocks, interconnect
> path, and optional pinctrl states for the controller.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  .../bindings/i2c/qcom,qdu1000-i2c-target.yaml      | 75 ++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 

I think comments of Sashiko are wrong.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

