Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875530D3F8;
	Thu, 16 Jul 2026 03:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784171698; cv=none; b=o/1XQM2GxvB7AR+VSfdv5Bu4WY6Ofvep8ThGKkW+SrDnuOdEv8Sl7ruZyJiZ5YTjhRUNzAKlsz0gkK32lqL0qNNLVYmIylTkJiOj32cWetELRL+bqWDbPt219VoZqrM6KjzyD+GHA4cRrL/O6vAurYkdiZs9xNMcrPKrzllXkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784171698; c=relaxed/simple;
	bh=DC42VY8M5Rz30fMkk4fhDuAVBNmfBGOEK3FIT3sl2OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+okVkTKnZHW49Zc+scdxiuErt8V14PkYYT0XEY5YwkJWKIW6wsH3I76ofXfRCNoWaLCldZ5cIBr08ZunZZ+qSa/A97BVRrFlVdwKNhCBQeQoJOW+n/AMPeqwPIFwkzBArF86P/vgJtVYljop7acJt6XevRW+tm6Jdb7xTPVaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ2EcvKn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ2EcvKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA911F000E9;
	Thu, 16 Jul 2026 03:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784171696;
	bh=0W7xXO4+qXUKNhB9seePVnIj9DoyYWkhRi03IqTkqjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dQ2EcvKnV5fxi8OpXTtHpoMHuU9q9XnCNffw+r6SxA72uRWSGflxHxyjmGVIN9xwA
	 xZk9YzXYlxGbzQUfULLVXEcdluhNS4Wb2tScFXhUlWStgARpNwGv6fvWjaxbblR9uJ
	 TJQriZPndqC7eUDio4EsnRl+crVCwGto4M435MgqK/XhKxjwOTJvNMxvFXHWInx0lR
	 kfvwxPti+4uEFrCksydiz5DxbP/Cz3R2HhQA1RiIUJqeefN7uCnHNA3Rt3a3NevdOb
	 P/7dvLmLhyqCyZ28BtWCJgOQqZAyIE9dAGb6HkKT18b1Yu1hNEKtMVLOgsD9/j585S
	 4pEBiNg9l9K0A==
Date: Wed, 15 Jul 2026 22:14:52 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, 
	Frank.Li@kernel.org, konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
	linmq006@gmail.com, quic_jseerapu@quicinc.com, zhengxingda@iscas.ac.cn, 
	kees@kernel.org, agross@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, krzysztof.kozlowski@oss.qualcomm.com, 
	bartosz.golaszewski@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Subject: Re: [PATCH v8 1/4] dt-bindings: i2c: qcom,i2c-geni: Document
 multi-owner controller support
Message-ID: <alhIzHVf8_RXNY4l@baldur>
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
 <20260708051023.2872304-2-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708051023.2872304-2-mukesh.savaliya@oss.qualcomm.com>

On Wed, Jul 08, 2026 at 10:40:07AM +0530, Mukesh Kumar Savaliya wrote:
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
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---
>  .../bindings/i2c/qcom,i2c-geni-qcom.yaml         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> index 51534953a69c..ed9b029603fd 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> @@ -60,6 +60,22 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  qcom,qup-multi-owner:
> +    type: boolean
> +    description:
> +      Indicates that the QUP-based controller is shared with one or more
> +      other system processors and must not be assumed to have exclusive
> +      ownership by the operating system.
> +
> +      The associated GPIOs must not be reconfigured into a sleep state
> +      during runtime suspend, as doing so may disrupt transactions
> +      initiated by another owner of the controller.

I think this should be made even clearer that this defined a requirement
on the operating system. I also think that "sleep state" is a misnomer,
it's not the sleep state as such that is the problem (what happens if I
define a sleep state with functional settings, or what happens if I
define an "idle" state?)

One way to handle this would be to declare that only "default" state is
allowed, when this property is specified.

If we still want this, I think it should be rephrased something like:

"""
When this option is present the Operating System must ignore any
non-default pinctrl state configuration, as reconfiguring the associated
pins might disrupt transactions initiated by another owner of the
controller.
"""

Regards,
Bjorn

> +
> +      Each owner is responsible for maintaining any resource votes
> +      required for operation of the shared controller (for example clocks,
> +      power domains, interconnect bandwidth, or other platform-specific
> +      resources)
> +
>    reg:
>      maxItems: 1
>  
> -- 
> 2.43.0
> 
