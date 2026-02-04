Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5440FD98;
	Wed,  4 Feb 2026 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220721; cv=none; b=YaZQWPWPbysk3LPmBvUH/jKcGrvyO2Xf+S/wcuT0jxgWeCvNlboVsb8A1DxmxmdKDk8BOuTXJupFytfxSrcVWVhQDg9zReD9t2XrNTxPVwgPDsgPf4b6yfjwoDS6fHnk4pr1YEwkgcsw3i6/fMJRiV1IBZWqJeJxJ3fdDCa1wuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220721; c=relaxed/simple;
	bh=fXIO50BxCOvj19SX/PYIBMX1v096vG7DR657MgvfepU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpmd6kM77PVlgZzxTkhpABbBcqUs4GJa5u9FxcFvZsWlO6uAUWVYACKz0/gMjF1HP7UosEAohxUBd+qgCWLvt5rgoiMFk+lAXVlHCuyEDPBcK3csmOOtveMokvH9PNiZekHtVlcuc3Sq1cI4YJCEM53vr2bPI+Ej9s/oP99+daU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqnwv+C8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqnwv+C8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC44C4CEF7;
	Wed,  4 Feb 2026 15:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770220721;
	bh=fXIO50BxCOvj19SX/PYIBMX1v096vG7DR657MgvfepU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqnwv+C8nMWAHhlk9ovqaF5hQpA6Io/TvuR1dwDelYJR7xE8KrwKmq0Zt7FQBrhhi
	 Bz4zOOqg2DqMFGZ3kw2qKMhpL3RoyLNnAICEyGv9O6X1gmJ0dIjlhGsAOVj96luc+/
	 QwsIwKxk35FnOYujaeJIStWhMwUZ+q2nzyUVBIyIVsGp05AkWVHCs1yhNFVH1VMXY8
	 6czPwUV4KfiA189stlhbQ1bhMQfOzRyaKGeey38pjBVGg/34w31WnprdOzHeQQq9+V
	 M+O8LP2v/0FTfHRSJRt7Y0NaR8kVPFFuBD7XBgIfQ8c2UCsd2UyaIGYuVLw2OvijbF
	 +de6EYCBdh06A==
Date: Wed, 4 Feb 2026 16:58:37 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
Cc: bryan.odonoghue@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	hverkuil-cisco@xs4all.nl, loic.poulain@oss.qualcomm.com, rfoss@kernel.org, 
	linux-i2c@vger.kernel.org, cros-qcom-dts-watchers@chromium.org, quic_svankada@quicinc.com, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Re: [PATCH v9 1/5] dt-bindings: i2c: qcom-cci: Document qcs8300
 compatible
Message-ID: <aYNqLdPid_GeTryc@zenone.zhora.eu>
References: <20260121183142.1867199-1-quic_nihalkum@quicinc.com>
 <20260121183142.1867199-2-quic_nihalkum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121183142.1867199-2-quic_nihalkum@quicinc.com>

Hi Nihal,

On Thu, Jan 22, 2026 at 12:01:38AM +0530, Nihal Kumar Gupta wrote:
> The three instances of CCI found on the QCS8300 are functionally the same
> as on a number of existing Qualcomm SoCs.
> 
> Introduce a new SoC-specific compatible string "qcom,qcs8300-cci" with a
> common fallback.
> 
> Signed-off-by: Nihal Kumar Gupta <quic_nihalkum@quicinc.com>
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

just this patch merged to i2c/i2c-host-2(*)

Thanks,
Andi

(*) The pull request for i2c/i2c-host-2 will be sent in the
middle of the merge window.
