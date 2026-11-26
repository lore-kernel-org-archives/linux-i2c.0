Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715273;
	b=N3bQqhfVFv6X7RgFhlujBdgkoWSjKooXQEvrDg3tjQy7SgTv0UJzx9KywgBTjFxSN7/V
	 PkLd4Jb+ww+uS+e+zR3Myv5ODzzAlhZKH74TtT+G4cEO4FYBQcslz0evroNs3SWxEdCfZ
	 2AB4Eex3CZFAcyCxIHLYf0Jnkbuxp2tzwf3Wz3Kb57UoP5CWhAAh9v8hJ51cbJR2XPT7v
	 YUhPA1/l+WlvbJSS8gYvNvmnz5XbQZr0qo2Isl/4x6BIzZRKW8cRK3fWw6zYvP2FvXs4k
	 5nzyyC8NE8Q1+FFlDE5giVq+8YqRgnc0HEomUeAAHMNxM2SJqRpl1kGyEb0dAnSrMtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715273;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4RF2eH0e7xWbgvaos9fwTWu3mXTmWcfIqp3gKOpY418=;
	b=n+7Qenj0PAXy0VhnNxpYHErgprphjYgsL92WFm/ydAW84HgJ46i1kZoMYi/yOEAybvCQ
	 Uczwkq87W6a7v2bpaD05siKUDc7ltC6VMIgi/oTpCVm7Fcr5A0o+WuemSKAiSK8YfqlKU
	 Z/B18PxlBtjNxRGVjNXHcx1/v4WiFNnB2Mza5wG1SBgCUR5dNoiq6+/bCePB9X0jwAmoe
	 Fr/OwXXqnP9yOerMMPRAfrRaW6I+zm1y4vqIeLkWoK9vEVsJvfg/nRxlHzCNaGGOMSOzL
	 d9/mxAFYudyZaAVoLnSgwOVPccEm8P3TdceFWmiPAmFHECiAyfP2HCc3AiR5dWaqZdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrg5+hTX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4E606A31C;
	Thu, 26 Nov 2026 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrg5+hTX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEB01F000C4;
	Thu, 26 Nov 2026 17:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795715272;
	bh=4RF2eH0e7xWbgvaos9fwTWu3mXTmWcfIqp3gKOpY418=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mrg5+hTX9HVLzhnrnl7ZzFK56BtlwoC9uSYStkvTSE4kME8V64xOd6ee0Sz+JorZP
	 HL4/sIKP3eMyWE3DFl0T8PfjGLgh6eUOPo5hvBnmmI7qFfn/whhrFgsFc/zbWDI6YL
	 cTgSAUJt+52+YMZbD9YrK2qU4zmtyKAskCBT7deqgclk9QkshlbjqH3MBlMPKtyXv7
	 8sv1g++zANwOY0Sawtwpr0BvzO1tUD5wcIMcY8do/Tr/JykDgsmI1XYxi4rcNhix7D
	 EDb2z3nXGEN68pcx6OR6HRNjxGo85oiMuOzaFauyFm9VQoeg1u2nAAo3hKFw87lCEb
	 Th/3YnUdG9URQ==
Date: Thu, 26 Nov 2026 18:47:49 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Werner Gartner <Werner.Gartner@congatec.com>, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v6 10/10] i2c: cgbc: Register known I2C devices on the bus
Message-ID: <awhwiHGeUFnTvxzg@zenone.zhora.eu>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
 <20261117-cgbc-i2c-storage-devices-support-v6-10-bb070ad3e9aa@bootlin.com>
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
In-Reply-To: <20261117-cgbc-i2c-storage-devices-support-v6-10-bb070ad3e9aa@bootlin.com>

Hi Thomas,

...

> @@ -385,7 +385,15 @@ static int cgbc_i2c_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(i2c->dev, ret, "Failed to get I2C bus frequency");
>  
> -	return i2c_add_numbered_adapter(&i2c->adap);
> +	ret = i2c_add_numbered_adapter(&i2c->adap);
> +	if (ret)
> +		return ret;
> +
> +	/* Add known devices to the bus */
> +	for (i = 0; i < pdata->nb_devices; i++)
> +		i2c_new_client_device(&i2c->adap, pdata->devices + i);

Please handle return values here.

Thanks,
Andi

> +
> +	return 0;
