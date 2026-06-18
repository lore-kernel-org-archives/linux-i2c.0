Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2419539F;
	Thu, 18 Jun 2026 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781746619; cv=none; b=EjNbDGkQUGnuoroMQP596EeVRdvagTRpFdJvC5vGHgBsfvx6woYDA006Zfvb5MmsJY8lPRDQSSmxdPgkDLLPobTwml4jIU6ph83P+Wz+TEerpzduvjARLF1pM1uw1ue44HobrWchTNmD2GTm99avblFOFqmy4kFc4aUIhhf6hq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781746619; c=relaxed/simple;
	bh=OtrEK/S3KL9f3bN4yUf0JDAXx1hAr2YNLqXUgkLRvsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvPN00a/Wg7irdnEzjS5u5SwBNcBdh8Mx9W07wwHKAKUeqlIsildOK3jaoSYjGfgC8iTjuFGZ4lIUX/u9ysqbR2icK9GXB8/9U6kyGv5IAZ0V78gj44qv3SZpGRb6XIvfkzGYgq8L7q3JgC8QWhmsxE1IB2RxCSiBoB1KCIFiuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS+uh22b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS+uh22b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4371F000E9;
	Thu, 18 Jun 2026 01:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781746617;
	bh=iEMUbmDbPRVGmmZUsmY+bAPeDIkl2GD/lKD9XAcKClA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nS+uh22bdLmsRXRLHnW/NLPMzbM2bDxsKUV/cWISpjfnvEF/aum7QUt5H8PBqkDoL
	 4GDBQ5Fw91uoX6DjNABGzDCoWRNAEMP24hMdYaC+9Zcr2fBP/3HrDiNKkBqjFGwLtg
	 H58xP2fTz72vvr5HNTb2FhxXlxGauVkkOp/GRozBmzSwwTnlYe/sVmmiwcBu0PBvog
	 0aZOiIGvovOuHCu7MwJiGgWXoeMpNSzI4MrmIB+7mSPJNavtH1/xAeN0bgyfx7uFdR
	 xJQ12fN8KhCpi08hJVIwPh1CuFXwV9rBhMKKaDlD7SHD46J33FOkDrj7wsqCBki6jm
	 0bDczPuqBc5Yw==
Date: Thu, 18 Jun 2026 03:36:52 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
	Mattijs Korpershoek <mkorpershoek@kernel.org>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com, 
	konrad.dybcio@oss.qualcomm.com, aniket.randive@oss.qualcomm.com, 
	chandana.chiluveru@oss.qualcomm.com, prasad.sodagudi@oss.qualcomm.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Nikunj Kela <quic_nkela@quicinc.com>
Subject: Re: [PATCH v7 0/6] Enable I2C on SA8255p Qualcomm platforms
Message-ID: <ajNLmO9UBH_Xs3W2@zenone.zhora.eu>
References: <20260617-enable-i2c-on-sa8255p-v7-0-ad736dbeab57@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-enable-i2c-on-sa8255p-v7-0-ad736dbeab57@oss.qualcomm.com>

Hi Praveen,

> Praveen Talari (6):
>       dt-bindings: i2c: Describe SA8255p
>       i2c: qcom-geni: Isolate serial engine setup
>       i2c: qcom-geni: Move resource initialization to separate function
>       i2c: qcom-geni: Use resources helper APIs in runtime PM functions
>       i2c: qcom-geni: Store of_device_id data in driver private struct
>       i2c: qcom-geni: Enable I2C on SA8255p Qualcomm platforms

merged to i2c/i2c-for-7.2.

Thanks,
Andi
