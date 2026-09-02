Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D84968E2
	for <linux-i2c@vger.kernel.org>; Wed,  2 Sep 2026 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355993; cv=none; b=EEidTPlFwIvcsyXka0UqIU8BByHOrFchXAj42hQ2Fozrrk+nZc4fSb9DDvUUcVklo5ilhoZTYkkbjacPmovmaFWPL2EZ6O/AmHTxp4COlUOVn18cX2YMT/vMA4l0gYGlVeYN1pMrjy7zCR8Wnw4jL0KYeoKNaG/0XSbpTG6RW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355993; c=relaxed/simple;
	bh=OeLjXQaJof9cn9SWsBGLACxYmVwrq+sg9byzWZUnWv0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PS3/hNmQHZRQ8CGmjWCzSqW9hxPORgnLETIUfplF+t2pMlArVvnsBg1wEThy+vSqqVL7WtxLvS2GjUI9aPuw9JmJsBxcX34cOJb6isnxrWR6rBp3epETYGS3yLKSYY1KSbSukzI+S7KgrrKaziSioqvYoh2Ia82OVRcU+DfRyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUK8waSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUK8waSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DAA1F00ADE
	for <linux-i2c@vger.kernel.org>; Wed,  2 Sep 2026 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788355991;
	bh=599mT+rvHX+FGFgJkVqdemxA7zxEQOOXFFVTp8OQd0o=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=NUK8waSDpjgxQFmt/jX0C6dbVwDWy3rqKoaHHCfpkIlwuySkBfh9aUotyoZ/tcu57
	 WyfgKt4zqPnGEm+ltrwIoIR5UFFdX2oGlRmNziX8rOMJv5QyQoM6QJBrHkc1gIbRvt
	 uqVAXy7vB3lBsv4UlxGLg3MTaawn4u2iipgkgoarGViD1wxl68BBbJ7Fdty7cZHoEm
	 wkLCFa4sC1Ytw0Sllg4iQLNbgtGrpOnh3C7jE4blGuwCSm3FBTl72yYX8m5KOwMAuQ
	 EKYJK6OvziuRfNw+68J7vnn7qR23u8i8kS4mfyH767e6ZTPuBdv5VF69zt8DXL2zJg
	 fSzW/iqW49ifg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b6036e9c70so935330e87.1
        for <linux-i2c@vger.kernel.org>; Wed, 02 Sep 2026 06:33:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx/AMM1XbrpAxInidj4o0tSRxLobkA0Rc3pekBsIZMat4BKPa/vwXCeuQsxto0pnM6H78oy6Oj+soY=@vger.kernel.org
X-Gm-Message-State: AFuF++nmyrxQR/SrosRW/jp74nfvvPFNfsvtQ5LPsdxPEV7thuoTMC8t
	o55GG0MzofniHntO2AoAjgxC2UL+Li492zbIIxiWGgB4nJY+pFcGFKLoLlcD5twCn1mkCs/1PKL
	M3TGluDqp2VBIQnpki1xxQM8XROizFSubDwpxt/yoSg==
X-Received: by 2002:a05:6512:b99:b0:5b6:4ae:5b81 with SMTP id
 2adb3069b0e04-5b6087ec6a0mr1637382e87.31.1788355990256; Wed, 02 Sep 2026
 06:33:10 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 06:33:08 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 06:33:08 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260813140047.1006478-2-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813140047.1006478-1-mukesh.savaliya@oss.qualcomm.com> <20260813140047.1006478-2-mukesh.savaliya@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 06:33:08 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mcz-50oyug8EMoK17csO=iT27LjQauwFCL+-WX7tHiD3Q@mail.gmail.com>
X-Gm-Features: AcwNN1WJ7CGhk-RqxOWGa60mRhcgGFh0R8ulmenFlNtS8WAYbCeB70-iP1e4ubk
Message-ID: <CAMRc=Mcz-50oyug8EMoK17csO=iT27LjQauwFCL+-WX7tHiD3Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] dt-bindings: i2c: qcom,i2c-geni: Document
 multi-owner controller support
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com, 
	bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com, 
	brgl@kernel.org, viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, 
	Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com, 
	zhengxingda@iscas.ac.cn, kees@kernel.org, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Aug 2026 16:00:40 +0200, Mukesh Kumar Savaliya
<mukesh.savaliya@oss.qualcomm.com> said:
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

This would potentially make sense as a property for BAM DMA nodes as well.
I'm wondering if we should make it more generic like qcom,controlled-remotely
and have simple qcom,multi-owner or qcom,non-exclusive?

Bart

> +    type: boolean
> +    description:
> +      Indicates that the QUP-based controller is shared with one or more
> +      other system processors and must not be assumed to have exclusive
> +      ownership by the operating system.
> +
> +      The associated GPIOs must not be reconfigured into a sleep state
> +      during runtime suspend, as doing so may disrupt transactions
> +      initiated by another owner of the controller.
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
>
