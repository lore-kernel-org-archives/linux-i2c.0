Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714774;
	b=gGqvSYz5NH7/7aKGZQooLLzGhwWV31Y9Wv3yMjeXlwnKrrGJMbB3kH7ZSiaQP30lBncf
	 SCq/a86KZpihUj+l3Qqq68A/ZS2Xn3bi+652PoUfan6n3yad3ArilC73Lewh2iM6sGC3A
	 AQ3fVmORW3q6QeVM3igX2t67qX6mzewMOyJh4RQhudaNM/5xyQF5h/RtIeS8ObNr4oshi
	 Gg+aV3ugV72O0+nMfjYR5VEH0KOwU5RyTXF1vKvtyXiY3Dr55VfuwbmRf7MW6SeyDl63A
	 4m1I5IJ1pBaWr6b/ailhT4brKum7jBcPKFdiYKapAgmAiyU301HBRVwYyT6mbckvUxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714774;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=C9sgm1CgEZ801Q+Y6Ntsh9N4G54PBN4x6AuEdyMRX2g=;
	b=mnBaCg4E4T5nSDqtB7Hzyq+a3pffnsUkgliU7sFg5k6sCqQB8LOQAZUEA39rP2r61POw
	 UmgDBASFEDphm1d/yCJWmKciawkE0Jfei7X4NesGlDiwGhXsR/K9hU1VVlKOgk5mWWagl
	 NIBqrlIbmE1qopTopWTaoIgOCbjdRLYZyMZdx1dHtET7ctU/kWtz08arZRl6aQ7BCODD2
	 bo5C1ywOAOSIJ5I7ZdEiUra3VwSadizhsUiJIsPmEYNOyd+vMQNb06+C57PKVz6o6fvGw
	 cIMxhBSXNnL/lYCbKOLShTmtfckbG8RbVnzue/sWTUwvUU2n6dK0rMyGS89p3yiIxpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mA7WnHT/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C02606A31C;
	Thu, 26 Nov 2026 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mA7WnHT/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F3C1F000D3;
	Thu, 26 Nov 2026 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714773;
	bh=C9sgm1CgEZ801Q+Y6Ntsh9N4G54PBN4x6AuEdyMRX2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mA7WnHT/tBMh2456y7+xCAQH5gGHseMSf/+Uxl8CZl9ouBP4lBrd1UuypbzuW/DwM
	 9uRz+MYwTn+jkQaRtiFCWB2OH37m/gdrSDJ0PzIrpf9n2crdAl8YddOgZlDnXzXB3U
	 X3NgC5DlhY9Sw3xdyYevmYd5DRlIrQMs/MzcDHew+LOr4tZzcKigerai06tE6jXrtU
	 wPbYaqs2hadugasuQNb23uppB3h2Md88+TbeQQDhT/7kyX3KlPagOvaocv4rpJhFbL
	 Goy6VKR0hFayGsF1LeBUIJEf/ii/KSE1a1je3JtApsdx5xSwM4pqTolMwdCfW3mnVj
	 XHxakazLvIDDw==
Date: Thu, 26 Nov 2026 18:39:29 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Werner Gartner <Werner.Gartner@congatec.com>, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v6 07/10] i2c: cgbc: Add support for fixed frequency buses
Message-ID: <awhXXeFy-9vuqseH@zenone.zhora.eu>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
 <20261117-cgbc-i2c-storage-devices-support-v6-7-bb070ad3e9aa@bootlin.com>
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
In-Reply-To: <20261117-cgbc-i2c-storage-devices-support-v6-7-bb070ad3e9aa@bootlin.com>

Hi Thomas,

...

> +static int cgbc_i2c_get_frequency(struct i2c_adapter *adap)
> +{
> +	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
> +	struct cgbc_device_data *cgbc = i2c->cgbc;
> +	u8 cmd[2] = { CGBC_I2C_CMD_SPEED | i2c->bus_id };
> +	unsigned int bus_frequency;
> +	u8 data;

as we are here we can fix a pre-existing small bug, by
initializing data to '0' and...

> +	int ret;
>  
>  	ret = cgbc_command(cgbc, &cmd, sizeof(cmd), &data, 1, NULL);
>  	if (ret)

... returning error (e.g. EIO) when !data. We avoid a potential
division by '0' (a comment would help, as well).

Andi

> -		return dev_err_probe(i2c->dev, ret,
> -				     "Failed to get I2C bus frequency");
> +		return ret;
>  
