Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F943D904C;
	Thu, 18 Jun 2026 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781929; cv=none; b=TtX8IpJotx7XoYfDO/WFOtDNFC61dTMyAeRZCD2krZxxYw153tfz1KUc+YZ9BHlKu8lgZ4ihjbfS8oL5BLeD0daCHp2EdFI1Tf3vBsk2PibTVGjZC5O8Ji9z+hjHESAfWRbfYS57amcMosuF0NGLsl2iPk8Ag0eg73VzmIZV0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781929; c=relaxed/simple;
	bh=RQS8wB6VSTJQy+60gnzha79t8hRK65kV5eb6mC4rOPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVe1bqC+3x513JYVwIfts8SZzNL9YZz6dNYiQcZmmfJzDx8XBgroQP7K86XYPcqNXtZDt7cV3Ibv5rj6ySJrieKK2aDAODS599ko9n6Ds5HICUpe/YWyaoPX/Wlq+B41LsbZPY1xGCAS47IJIWPGrmWCltpHTTxxu/A96rAwwGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzM5JOzj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzM5JOzj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06BC1F000E9;
	Thu, 18 Jun 2026 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781781926;
	bh=uqc6HL3wgT0Al3nfUEKW2X0HTEsb7gSE8Bs2eGkNWrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SzM5JOzjvg9qE65fz2yBJiW20gpeSbkAyx/H9CbQMyjgEksgVKM+f8kIqzpgiljKP
	 M4IZ4H3fDp+luP8rwD+0bflHt6L3wA13IT9lzq1jv+dEU1/rgm509yZ/YX4N04Sq5/
	 esk2oYtxbtpfOPZ01r4pCkx8tFSnck+JRi0Y4tjahwNOEuFT+Ksy1svhlgS+ntx9WV
	 QiGxPVJE4ge1MTXuUJ7fO1srjbA9EVXVYIOnemyZQ8OoKq8X5Svn4wsWpqPDD7cG4q
	 YQCDDsLO8T5kAGa2dsLPMHeC0D1ohSZ5e4m9l8QDeP/9PSVFg0ETBI1pKHDD1Z3gG5
	 PDYr/wMIukHBg==
Date: Thu, 18 Jun 2026 13:25:21 +0200
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
Message-ID: <ajPVVacuswonBfZk@zenone.zhora.eu>
References: <20260617-enable-i2c-on-sa8255p-v7-0-ad736dbeab57@oss.qualcomm.com>
 <ajNLmO9UBH_Xs3W2@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajNLmO9UBH_Xs3W2@zenone.zhora.eu>

Hi Praveen,

> > Praveen Talari (6):
> >       dt-bindings: i2c: Describe SA8255p
> >       i2c: qcom-geni: Isolate serial engine setup
> >       i2c: qcom-geni: Move resource initialization to separate function
> >       i2c: qcom-geni: Use resources helper APIs in runtime PM functions
> >       i2c: qcom-geni: Store of_device_id data in driver private struct
> >       i2c: qcom-geni: Enable I2C on SA8255p Qualcomm platforms
> 
> merged to i2c/i2c-for-7.2.

sorry, 7.3. It's too late to send it for this cycle.

Andi
