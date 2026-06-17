Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30567EEA8;
	Wed, 17 Jun 2026 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702119; cv=none; b=HhxH6iH0s0vCQw9oc/AxvBgHAwXc1Ao6W1fs4rQhwki8VfHoXLbB+PpCXrCG5a1DQA+YE39zBuiV+iNCm4wWuyaz/4kYJIQx4nRThyJ2HjFOdghYeEjmOmTn8RTY8ib/Ur3CheW2aBOCuA+phTMumaktwWuyHEf9456+NZ4L5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702119; c=relaxed/simple;
	bh=aIlDLMkkNHtsDElYOHx+iCX+qfTNktD94VrGYo6P2ds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JWpyvT9ic5fjxSBoQkDf4V8fXgrngSFMpHPMrChIOQBqDAii0bkiZkOLFKzoAD0KYOYjoEGQJkYoayD2lViTc/aGOfMElYEwOJ+cgA1TN167if/KawwNiyrrHE6v9J1PBpYQ7wdZlrS9px2GIDHk+3NdjfqV4ORvMYMnWDIh5AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRLSFxXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRLSFxXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6901F000E9;
	Wed, 17 Jun 2026 13:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781702117;
	bh=RecN5ZtDRcqCxYcd/2RjkSxa7a1qN8tkR8fOcVntLnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jRLSFxXcuguZjn8k9T/6YsLlp/PLbF+S//JuN8QuD5ZsNDQ1qAo9EvcABxcZgjxdM
	 yOVi1Jmtquis6KE2gafyzTflGkN8B1qrZnfGgYCFyPV59sc+tPNx47TsJmVNDOFc5E
	 uRFaoMJtSpf/ExA3v4QoD2/jcz70Rhb55v3XgHg/kYlTV7IJPrhwy1UqIvLS4aCi2R
	 G9v4SQKLQSB48wNn2cyw03ceQ9xy/vVu/joOZ9X2DHtTes4g+5JfpG+EgwMRDyJMaT
	 L0x9QSEqQ2W2tc3KmTN0zfIWd5h5yNqBGjyxkVMCU0n/8vTDEXzUHN9upwVpkMdkBv
	 /3QSKWsqk3M+w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>, Andi Shyti
 <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Konrad
 Dybcio <konradybcio@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, Viken Dadhaniya
 <viken.dadhaniya@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Praveen Talari
 <praveen.talari@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
 konrad.dybcio@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
 chandana.chiluveru@oss.qualcomm.com, prasad.sodagudi@oss.qualcomm.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Nikunj Kela
 <quic_nkela@quicinc.com>
Subject: Re: [PATCH v7 0/6] Enable I2C on SA8255p Qualcomm platforms
In-Reply-To: <20260617-enable-i2c-on-sa8255p-v7-0-ad736dbeab57@oss.qualcomm.com>
References: <20260617-enable-i2c-on-sa8255p-v7-0-ad736dbeab57@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 15:15:15 +0200
Message-ID: <874ij1gvfg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jun 17, 2026 at 10:20, Praveen Talari <praveen.talari@oss.qualcomm.com> wrote:

> The Qualcomm automotive SA8255p SoC relies on firmware to configure
> platform resources, including clocks, interconnects and TLMM.
> The driver requests resources operations over SCMI using power
> and performance protocols.
>
> The SCMI power protocol enables or disables resources like clocks,
> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
> such as resume/suspend, to control power states(on/off).
>
> The SCMI performance protocol manages I2C frequency, with each
> frequency rate represented by a performance level. The driver uses
> geni_se_set_perf_opp() API to request the desired frequency rate..
>
> As part of geni_se_set_perf_opp(), the OPP for the requested frequency
> is obtained using dev_pm_opp_find_freq_floor() and the performance
> level is set using dev_pm_opp_set_opp().
>
> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

I've retested this on top of linux-next-20260616 and it still works fine
for me on the Ride SX (SA8775P) board:

/ # uname  -a
Linux (none) 7.1.0-next-20260616+ #2 SMP PREEMPT_RT Wed Jun 17 14:58:42 CEST 2026 aarch64 aarch64 aarch64 GNU/Linux
/ # i2cdetect -l
i2c-11  i2c             Geni-I2C                                I2C adapter
i2c-18  i2c             Geni-I2C                                I2C adapter
/ # i2cdetect -F 11
Functionalities implemented by bus #11
I2C                              yes
SMBus quick command              no
SMBus send byte                  yes
SMBus receive byte               yes
SMBus write byte                 yes
SMBus read byte                  yes
SMBus write word                 yes
SMBus read word                  yes
SMBus process call               yes
SMBus block write                yes
SMBus block read                 no
SMBus block process call         no
SMBus PEC                        yes
I2C block write                  yes
I2C block read                   yes
/ # i2cdetect -F 18
Functionalities implemented by bus #18
I2C                              yes
SMBus quick command              no
SMBus send byte                  yes
SMBus receive byte               yes
SMBus write byte                 yes
SMBus read byte                  yes
SMBus write word                 yes
SMBus read word                  yes
SMBus process call               yes
SMBus block write                yes
SMBus block read                 no
SMBus block process call         no
SMBus PEC                        yes
I2C block write                  yes
I2C block read                   yes

Regards,
Mattijs
