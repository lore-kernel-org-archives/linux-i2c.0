Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BEC31987D
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882492; cv=none; b=qcLHyoljqHRv6wktdvbc37/JWQOMtepSde4mvJC7Eb0RovVOFSGcjs5QBN6DPVOgVQt5aet/6WRwMTzUjym6RE7aY48wgsxfLEbm6kj8OTppPAWha40aaA9nc1BI7ATSPhdreelsViq6jaAjioj9IayifL2yja1J27ZJ4RXXWWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882492; c=relaxed/simple;
	bh=nJGRI4A9ewklJIIthuAAUh2rLQmjoOyuyca4mqU6DT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsjnZynoPoC/J1m+O5fQxvBK/bn5m5QBxpxATwtjfQFSwgoJIIK4WA4ewSPFeM4MJg47BKBBHAbQNFYtPn/kQB57cAh2j6+BMHTa8hS9A0yiuHxvpZqlU+1Mqrivqd0UOtEVIxuxqlS/kH3Wqz80vqjrJwxt/KIjfnO/PtibDBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=igzrGHO2; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="igzrGHO2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=oho0
	sC1jSrwodOAVxU/5tmS21hFCt2D3tgPiKyJNKTM=; b=igzrGHO24jzc/UsTN0zg
	k6cmg1FvLo8lJ3A8miK+pZaAKKpQ6uu19CAO5iy6lHLUinLwxeyCfVe5rDMlcWnF
	/s++sfHoy01OHEpo/r0RxwncmAj8bEieyUC8XQkD46/L+iMfdzXAHXKFoSn+CIFm
	NtYPBYc4veraWVbhILTzpEvTAp8RDkh61btSRLCkJnzpYs8lLudJxFVJxyL9lXu/
	wF1mqDfHgSKgTaXbj0aq4E3+LNKqGYPg1LtPXRJA1IERYVO69lBnaFa+FFZ1BRJW
	YZXDOwxaO2KRtXfbOlhAk4wxuISVDWtZuuW7j7jw8oQfr62f+2JzhocJI6wOH4tU
	ow==
Received: (qmail 2098934 invoked from network); 4 May 2026 10:14:48 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 May 2026 10:14:48 +0200
X-UD-Smtp-Session: l3s3148p1@lQYthvlQEIsujnvR
Date: Mon, 4 May 2026 10:14:48 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel-dev@aliel.fr
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/8] dt-bindings: i2c: amlogic: Add compatible for T7
 SOC
Message-ID: <afhVeP3Y8D4pfkAt@ninjato>
References: <20260424-add-mcu-fan-khadas-vim4-v5-0-afcfa7157b23@aliel.fr>
 <20260424-add-mcu-fan-khadas-vim4-v5-2-afcfa7157b23@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424-add-mcu-fan-khadas-vim4-v5-2-afcfa7157b23@aliel.fr>

On Fri, Apr 24, 2026 at 04:17:33PM +0200, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Add the T7 SOC compatible which fallback to AXG compatible.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>

Applied to for-current, thanks!

