Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AE03EC832
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791970536; cv=none; b=XqC/IjpEoWM03jW3ctSIw59hezLQrVzzo3DPsG+2JO6wMnBTLMqQ2lN2Bj1SA95ynq3xwwneMgX71cn9JxW0Jhqr3+9Au16rQO1xd3NX5JGX//0brfHPW4kJ/ekuw6SvuMR57yg7vRjMmbKbFF6eq3kwdP5BVFeUAFTdhStfjvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791970536; c=relaxed/simple;
	bh=EYa+RBPbeYiN3nxkpFWH16ycAxJKW6uP2elqjLvjqFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4+R49IdBcvrWjR048cHvUGw4N12erfK/L+sHQieOKW0qVqaa7ggjBJUzaQ/JxT7xNg4eN4MFdhq/9yVNsx1yZ1VFLsMfFgU43vEy7xBydpdaGTHC3czsBAxU0jT2luUMc0sLnQPLMAwQnT2FxWGPgJaz3h/y0DcTJdWEsrGtbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CcuwfIzK; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CcuwfIzK"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so5623240a12.0
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791970533; x=1792575333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kzIz0X6ttxgOxkC5LXT332DK567KH/TTx/ooIFt2UKA=;
        b=CcuwfIzKEcmfnSDgOAP1fH4Gqvq1aJwKo8ozVxlTGIsCdF8ftuieVFM0HigI3/2hdq
         8N82j7CZUlTKPP1eDAtGmR+k4j0TZ9TiVvlxoa+nb3egYr3nyEH18fza+g0bJM2ovUlp
         1RrTKQgVlj1N+oMDYeqP3wLxHinDfZYnG6sfsiuusTkWV0HEu4W2FusY3oKoyLwvdCLO
         LVNUepZ0+TE6/9t8Jq3vksMDJKOe5qRzl4FiQkGSRDmX1CK3dJNxBuLHGEO/MUZSPSRN
         4oHo3QmKYMUPkSm9EaOSDv8yTohbp56u5qVrVMsLCR5BzIBH5L3mXPOkgTuqfFvUIy1s
         XEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791970533; x=1792575333;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kzIz0X6ttxgOxkC5LXT332DK567KH/TTx/ooIFt2UKA=;
        b=NLI8y3HXKEjB/WjJLVOOse57tV8zPyb24TiPUd2nb2Skf9W977wOFBP3YplAo1bW/v
         6jTrA3ctVocSZF+iUDWZQTTJgn5gs7nPnPiQ3h8ojDosERG35HL+ASj1LzzEDdtTogxk
         AIGePttCZTyRHMGENwtvqSihaY5py/DQLFUB4na+qWu7DGm6ZnVbsmPbz8fiaCjJkVAE
         d9O0U61HcUIwuPo+Otkm5hO70uOjiveCW/OiovNGm/8jFlpc1gZ6qfbAo3Yr3TWUtmjE
         lKdZ2i9WdPfxu/OJXikFQtOxifjmCp2ogrq6fuNPMiZ/jLD/O+BZwGrSPTThfaX6/rsT
         sV6A==
X-Forwarded-Encrypted: i=1; AKwUvBxKwW1h2aLdOk/aEqK6BSj7gVQWhZgRDh+Au1XfCdL86ydEe67Q7QdMjpHSUbW1TTfmzxzIJOS49O8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRfwuf9XQNeHrLY98n9j70c1mnp18e9sf2x9antdyJjfrSw2Kd
	cGbsipq3LD9D6Hne3nKIQKxxMCcooMrvnsLvDudtIko5bmwB0FfK4QI0LqY6Uw3WtAQ=
X-Gm-Gg: AYBFou15Hk1nIlfyhyt/zo6PafY6jKAQs97yr+/zt79vueSSTzmZk7Na1TF/AjPOYRn
	yNVtwpb60Oquj6iitsjKUvCd3mtyuwnQ5F/yPXXsbYaT41uh/QpL+z3N49cndIdpmvXAcrrMm5n
	lI5xNj0hShiawHlGNpIbPVmrSszG11mvGph2fNAXcSu8L7gk7SOUbVlCy94880uTkHPqw/D5DeG
	gKwpNNkb42E3M0vYgipGh7dWO3Qb7xnFTUiHgPofaWPPj70S33ExTlt9Hr/eotl4qi5QuyFlEJu
	pv23Rnv8qfMEBmF8RRlHbI/Kooy8FK1k2It4jyjPUfPCyudSle4XSXACDsDfvBZ/l6QJzhjrq8P
	TcGZxx32s+ncjptOGTMpDCdXHl+p3E9Gp1gmn5BKfPXp3HMT5mDkGdbQAVRRsWTxQktSCi9VWt+
	Dre6qPAmU+2MfZkZdmRN8uZbnAz4h53NtyZL+XaiHfFhC1pz8qIW0SRmA9Jnke6MIfxAzDbqBNG
	6i4fFPDvDms
X-Received: by 2002:a05:6402:2351:b0:6b1:b626:5bd9 with SMTP id 4fb4d7f45d1cf-6b1b6265e2fmr7285065a12.0.1791970533495;
        Wed, 14 Oct 2026 02:35:33 -0700 (PDT)
Received: from [192.168.0.167] ([109.76.126.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b203839764sm943163a12.7.2026.10.14.02.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 02:35:32 -0700 (PDT)
Message-ID: <8cb5164e-9f27-4e19-9f4a-37da35fe0770@linaro.org>
Date: Wed, 14 Oct 2026 10:35:30 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add Hawi
 and Maili compatibles
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
 Vikram Sharma <vikram.sharma@oss.qualcomm.com>, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-media@vger.kernel.org
References: <20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com>
 <20261013-hawi-maili-camss-v2-2-fc93222da89c@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261013-hawi-maili-camss-v2-2-fc93222da89c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/10/2026 12:02, Nihal Kumar Gupta wrote:
> Hawi and Maili integrate the same CSIPHY IP as Kaanapali with an
> identical register interface. Add qcom,hawi-csi2-phy and
> qcom,maili-csi2-phy falling back to qcom,hawi-csi2-phy.
> 
> Co-developed-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
> ---
>   Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
> index 6e9eb8e265df93b631101ae13f31f6365b6239b6..627aebc7cd9b7ca313457d3f70f72796e9671e8a 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,x1e80100-csi2-phy.yaml
> @@ -18,11 +18,16 @@ properties:
>     compatible:
>       oneOf:
>         - enum:
> +          - qcom,hawi-csi2-phy
>             - qcom,kaanapali-csi2-phy
>             - qcom,x1e80100-csi2-phy
>         - items:
>             - const: qcom,glymur-csi2-phy
>             - const: qcom,x1e80100-csi2-phy
> +      - items:
> +          - enum:
> +              - qcom,maili-csi2-phy
> +          - const: qcom,hawi-csi2-phy
>   
>     reg:
>       maxItems: 1
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
