Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4485F38736D;
	Wed,  8 Apr 2026 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659146; cv=none; b=WlorT+ioDE5cn0A+p/sw/rYTMP3cxasQzG4P4r2HlrMuj5YGfq1Kz2KvgMiOz/1EwHkMQt5jZSZTIqReIl0nEN/qXuuCCkg+OvhBXYGxSwGhZANN6aUH6eqlZmvg75Gz07G8fZ/N1Dxn7YniTTHSAuElFjuwfxU96qdT5BIV9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659146; c=relaxed/simple;
	bh=CeKa+tVpqpJh1Df84JqTlJ0kNXpkqSuN+VXBpVRiYdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljlXdQHgwlIos0alOqReMwUSSsFg7OBSFjHGtgkRsN08w7anfj7WCLZJcTK3cbdXmWESV9bNpdEM67WqJ6sulKDAz3UJe0NYLOqaTCjiDddXmauj43rVzWtkQXhpF7m5YLggZEqaMpsM6uNEO05Dp/YU1TNOH3j6zSf/Ef0vYe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q22ok/Cw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q22ok/Cw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA57EC19421;
	Wed,  8 Apr 2026 14:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775659145;
	bh=CeKa+tVpqpJh1Df84JqTlJ0kNXpkqSuN+VXBpVRiYdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q22ok/CwxgC3Mx3Y9p7f+faF8L3dAIBVR21qu+oHpjjY9+0tO5wRx1+DHqfrjyY6G
	 2talI7pDTpbIOYkEAEiN/2DCYRour79UpbuGX4kypYq476xWTnj+80AWnBrGSONu2T
	 8i2ePRLm3lYGpHAGzR4WXzmqyxj3GyD9Uli7XIDIbaDJ/M1SN4hW2dgkrg8by//Yt0
	 t4lAS0k4gMYn8psRK93/snWTKDuRBwoqHpnzqoenySnaL7o0hwkvEGYio/J44i9e4+
	 Hig+kyn/lMO72xLLwl/EEC+80I/rGpXuWlX0PeXvmd4VHk5GiBlfYB+PeAC27gJT/N
	 LMIhR3RTI2u4Q==
Date: Wed, 8 Apr 2026 09:39:03 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: vkoul@kernel.org, linux-i2c@vger.kernel.org, andersson@kernel.org,
	linux-kernel@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com,
	bartosz.golaszewski@oss.qualcomm.com, dmaengine@vger.kernel.org,
	Frank.Li@kernel.org, andi.shyti@kernel.org,
	devicetree@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
	konrad.dybcio@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
	agross@kernel.org, quic_jseerapu@quicinc.com, conor+dt@kernel.org,
	konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
	krzk+dt@kernel.org, linmq006@gmail.com,
	dmitry.baryshkov@oss.qualcomm.com
Subject: Re: [PATCH v6 1/4] dt-bindings: i2c: qcom,i2c-geni: Document
 multi-owner controller support
Message-ID: <177565914313.2145268.1906120278635369816.robh@kernel.org>
References: <20260331114742.2896317-1-mukesh.savaliya@oss.qualcomm.com>
 <20260331114742.2896317-2-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331114742.2896317-2-mukesh.savaliya@oss.qualcomm.com>


On Tue, 31 Mar 2026 17:17:39 +0530, Mukesh Kumar Savaliya wrote:
> Document a DeviceTree property to describe QUP-based I2C controllers that
> are shared with one or more other system processors.
> 
> On some Qualcomm platforms, a QUP-based I2C controller may be accessed by
> multiple system processors (for example, APPS and DSP). In such
> configurations, the operating system must not assume exclusive ownership
> of the controller or its associated hardware resources.
> 
> The new qcom,qup-multi-owner property indicates that the controller is
> externally shared and that the operating system must avoid operations
> which rely on sole control of the hardware.
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml        | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

