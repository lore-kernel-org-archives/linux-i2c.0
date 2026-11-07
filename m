Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061080;
	b=Sv/37TaacL1iROSbv6c6VS/DIHyyCTWrbyMel3kpukV6Zi9QTz//Ypbmoed5sEfhtqty
	 l8ZlFs13KRMH8loj4ZnTNjL5YPpHo5V/YzT3buJrSfNSuAqskuzYwEB2sGcsiBYkAVn+o
	 6g4GQHsyW61me4Y+XbM9tB7tkNJFa8YgIU/WkT6Aueeb5EVCEThyWLD4IV5kDf2jm7G0v
	 aItepNoe9hq7BJPyVwRC2xb4MkuCIVJNP7OueuTsnc9f3OZW+Wa4Wos6ICuHOmhVlSzjn
	 DP/je6/j/Cutlw39EDrcaYV/o9WO0SNipDM4oJr2K6p3v5RvtPRecKM4mB3T0IzExvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061080;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=dckQmDGK51xUYXkNanlmrWOkBlG7G8NjEFbm3i1p930=;
	b=yEmsN+qZi58dft6/gry6/2t1IWwDh+tT7EbUfqK+UaKJ/aQKp4y10nIiC14ox3upB6Pa
	 G6sB4PxkRB7gFYgpSYd7a6FbEPXuv96ENw8e57OVNqSw/wSKRThJKd3gQVmm9b9/Slpib
	 8mzGa7nnsHhinkJs3weMBXgsEKcSxxzvBLPI/E1Cdx0t1Qw9UVxzKdjbB2Hn0K+eW7YBr
	 AHfYd2GE3xLON6SvP94d1IH/Dkl+/HkZrJO9FUD5+q179NjuHxPjCx0fz67Eg182q5B5l
	 JxhEVjeL/FIPOooRTDFOmUI6WBiMFbtd2SdOw7A+Jw04d/Bl1pE/rmAH0wANzbB5E1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=B+p524o8;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8E606A33B
	for <linux-i2c@vger.kernel.org>; Sat,  7 Nov 2026 14:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85A8E606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=B+p524o8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=dckQ
	mDGK51xUYXkNanlmrWOkBlG7G8NjEFbm3i1p930=; b=B+p524o8hVD3mkP/wnxZ
	pI+Lzdcoftxh6e5lsWJxeI1PiOgJOh41R22uH8zFRCGxXbwnoBrZbRkXyRoqF6kd
	aQLuTHvOWZet7z6o0iqXZN/VWaAKc1MdAV/MlfveYZ0nf6GsyZjJMHUFJZgeX8xJ
	xafeKQI2DIuRLy4Sg4LXTKdSYsbiGgd3SsQJdvv0C5JvtPS5LAHdrf1VMKKdwTeV
	dc1KAXlzZufLrMOpYArulQlzqf7EsoPiCd/UFK9JSBE+3L3a4Vz1ImML/ZUWFf0K
	I5bOUACAqLrb4vtD/tcMs1jl7y7APAUL1NbK/2L5hBD/Y9TO4jfwifK4nuaqEtzD
	tg==
Received: (qmail 2529595 invoked from network); 7 Nov 2026 15:17:56 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Nov 2026 15:17:56 +0100
X-UD-Smtp-Session: l3s3148p1@U4cnZbBfNrkFFu4l
Date: Sat, 7 Nov 2026 16:17:56 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Suresh Vankadara <svankada@qti.qualcomm.com>,
	Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: i2c: qcom,i2c-cci: Add Hawi
 compatible
Message-ID: <au8zFKCFkO_KCdHj@shikoro>
References: <20261106-hawi-maili-camss-v4-0-d528c7a797b4@oss.qualcomm.com>
 <20261106-hawi-maili-camss-v4-1-d528c7a797b4@oss.qualcomm.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-hawi-maili-camss-v4-1-d528c7a797b4@oss.qualcomm.com>

On Fri, Nov 06, 2026 at 12:20:42PM +0530, Nihal Kumar Gupta wrote:
> From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> 
> Document the Camera Control Interface (CCI) compatible for the Qualcomm
> Hawi platform. Like other recent platforms it requires two clocks, so
> add it to the corresponding clocks constraint as well.
> 
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
> Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Andi? qcom tree?

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

