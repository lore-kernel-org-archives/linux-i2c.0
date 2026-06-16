Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE70C305688;
	Tue, 16 Jun 2026 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781652600; cv=none; b=jD75XBI59I1GZgBdvbhep56dVdhx3nyciaXz0K7b3LqkjEP6Ip5DMaTT9w3GbpLv9IT+yajYjNxL3gX39FQB0LPCmG0TdKoVnXGvv9JRaCIkOHbLDI2bKTiPaBEs75wNSW3SXF+BhtuOszF1ZHcivcF1TWjQhyzyA5gDnVasaWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781652600; c=relaxed/simple;
	bh=7CY3W6QW4QbyrNIEnnhsSjZhwAo5bGvn+JcS54OtcHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOKpt0y7aeiVcXWwm9XQNazweHmV4D1Kzw8yH+2OyTT/D8HrmE2TYQNUC6g31uLagXSqpl5X+e0vDaZk/kq6Gdg/hvWwkUg8JPNwKUWdHozD4hU+JZ5LSUCMY4RS1v827V0r8e3nzqmibRVNDssP/91LnlemYMoynADNDdXXoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OG3EPA8x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OG3EPA8x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141B01F000E9;
	Tue, 16 Jun 2026 23:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781652599;
	bh=r4IoNwHoTnEmG53kaXwe3DNjPHkKDu0Ki84EcbgZzgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OG3EPA8xYjcflG010VYBLS6Ps/mOqipg/R1jNcsP68WV6ijdc8RUz+gyQsr69Ynl8
	 vge4K10D9BPBlNOQE1bp0B+vbY48hIPgO/YMqZCEp5WPKL0hD2y6qFWjuPRqnOZT9s
	 zRFAtL4dLliD4DkXV0NWKd0vGncMvyk36vy6AOwHWudhinSf1ARwUQg17KIHpj+kdY
	 ho6uUBcAxGY+qVJcMbvPgwol2GR8YonY3fayvhgC7dnMPIQ3ln6nts6dn69O9gWE0a
	 TalN2h59StQO/6WKAcTcKQac5Y3sdVGDnRj8TBEMFbIWl2SIy0pY2S+kSSHdOPdAA5
	 xiXmteK/eASeA==
Date: Wed, 17 Jun 2026 01:29:53 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] i2c: qcom: Unify user-visible "Qualcomm" name
Message-ID: <ajHcYF42Qp7L-qE2@zenone.zhora.eu>
References: <20260423173550.92317-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423173550.92317-2-krzysztof.kozlowski@oss.qualcomm.com>

Hi Krzysztof,

On Thu, Apr 23, 2026 at 07:35:50PM +0200, Krzysztof Kozlowski wrote:
> Various names for Qualcomm as a company are used in user-visible config
> options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
> "Qualcomm" so it will be easier for users to identify the options when
> for example running menuconfig.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

merged to i2c/i2c-host.

Thanks,
Andi
