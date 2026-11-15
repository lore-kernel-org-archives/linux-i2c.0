Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.21.23.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794735170;
	b=Riy9dPKzmh4FX2Btgtnw/Ckw+Mn0Xtl/cRIb5Y8Esp2IsQr1oWUorSW3lN9KSel5Q0Q3
	 EyYaD+ZGzghdLOVLQ8aQMTcrlgTIB/7I8bzYWQR9/DJ0pCKc3a5JiZsaXaNfbSXdgloaL
	 wO5XlnnDgXHdupmwLvhjcG4Np7apn3bZ4pIVmU/BHNw6KdPBlsJIBRIJAs5XtV6DDQdPh
	 9muEUwBkmaefIT0eSdG3XUBd0Lf8Vi8GxvKsao/iG8uVkdJIhjXqsiUH+SpIY9U/83TGb
	 QFQcqbuHis7BjxUjUWUaNiEmdyesNE/tqF2ygi9WT6q9NdsC7uYjZtFQf2/hNZMwuCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794735170;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:X-Sender:Content-Type:Content-Transfer-Encoding;
	bh=ausSrf1a5uQksXa58+FoiPtpbF6upiohM3cfazEgWz8=;
	b=48TUte+aef9RKVosrI+0ei+zVsFTgfANHROrJcX1eJXf+O/lqHDNjGQ8HGKNe6FbHKM5
	 8tDLk2PPfJFC5C9x6m7xfSu9yd4oHidGYaPzjSeQPWyzLxkMS6n0E3dxQVwgRe1YiFHoh
	 b7gCThKagjEExOdEUWZ3W8wE/S5XFFW0T4ca00c679/r2bPPbOmKKqREeKUGzjkdcxwuT
	 1NpvtpmC2tVQ+9sH12Oyq8Q3wHyW5v9aft509oVKXUqzjYp3JIMLc2v9hMX36XJuFeM3L
	 FzdYcx8lcBtJbvc14lKrRxmd8Kb3B/V85kMlRj2Cv2JaQ+yNNcDqc2hWRYeWQgDsr+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=disroot.org;
	spf=pass smtp.mailfrom=disroot.org;
	dkim=pass header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=euOMCHKy;
	arc=none smtp.remote-ip=178.21.23.139
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00CF606A31A;
	Sun, 15 Nov 2026 09:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C00CF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=euOMCHKy
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CBA6780622;
	Sun, 15 Nov 2026 10:32:40 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7FupCPq1JdrQ; Sun, 15 Nov 2026 10:32:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1794735159; bh=tOKPWQw84xeK35cbZyEt4w6U/TkmvEGT7MzQBg+zbwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=euOMCHKydbaHzW8GiIziU0x0YHH5fhMTlx61HHvCyiujQG5y0jF8OVYdjVtlIhpD1
	 pA0JlZbccswwnORGSIsGdZUvtdVCdHwx9SN6pnPXi+DNqMgXNq00gJc+ZKMYdZTz1o
	 MakLKiIpqrg1FBaLPVY+l2BJ/AfYfIbmzTsudiB05SqG5ehdQF3nNycY1eJF31Pu9T
	 8wdeuCtjNSry8ozGkNAWqCbdn4VFvXRWw9h+duyud0ZjQlhwabovrEx/T61p9IGOI2
	 ZWCELLnMAz/var//JvhChWcFOjeYDPzwfTgp8RHzPoLT8QYOS/kOtElquHssl5n+b2
	 omgiAEZ+n99Dw==
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 15 Nov 2026 09:32:35 +0000
From: Rustam Adilov <adilov@disroot.org>
To: Michael Zavertkin <misha.zavertkin@mail.ru>
Cc: linux-i2c@vger.kernel.org, Chris Packham
 <chris.packham@alliedtelesis.co.nz>, Andi Shyti <andi.shyti@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] i2c: rtl9300: add realtek,rtl9607c-i2c compatible
In-Reply-To: <3012533a43fd32d1c526e5a90385457f8b46f111.1794728344.git.misha.zavertkin@mail.ru>
References: <cover.1794728344.git.misha.zavertkin@mail.ru>
 <3012533a43fd32d1c526e5a90385457f8b46f111.1794728344.git.misha.zavertkin@mail.ru>
Message-ID: <29914fda0f8aac515458d9f4d7862270@disroot.org>
X-Sender: adilov@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2026-11-15 08:08, Michael Zavertkin wrote:
> RTL9607C was already supported by realtek,rtl9607-i2c, which is
> confusing, because there are another SoCs such as RTL9607F, RTL9607
> (without letter) and a few more. So more correct compatible was added.

Yeah, that makes sense. Yesterday i spent some time documenting the rtl960x
tree [1] and rtl9607 falls into apollomp rather than rtl9607c family.

We should ideally check if RTL9607 and RTL9607C have similar enough i2c
controllers to use same compatible but maybe for another time. Cause if
it turns out they are different then the rtl9607-i2c should not be
deprecated? I don't know what the rules are for this particular case
where due to lack of knowledge at a time we have been using a wrong 
compatible all this time.

[1] https://github.com/Anime4000/RTL960x#rtl960x-families-and-their-subtypes

> New compatible doesn't use IO_MODE_EN register, leaving it to pinctrl
> driver. Old one left for backward compatibility.
> 
> Signed-off-by: Michael Zavertkin <misha.zavertkin@mail.ru>
> ---
>  drivers/i2c/busses/i2c-rtl9300.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
> index a9dd85a286d4..ae20fbdc307a 100644
> --- a/drivers/i2c/busses/i2c-rtl9300.c
> +++ b/drivers/i2c/busses/i2c-rtl9300.c
> @@ -200,10 +200,12 @@ static int rtl9607_i2c_config_chan(struct rtl9300_i2c *i2c, struct rtl9300_i2c_c
>  	if (ret)
>  		return ret;
>  
> -	drv_data = device_get_match_data(i2c->dev);
> -	ret = drv_data->select_scl(i2c, i2c->scl_num);
> -	if (ret)
> -		return ret;
> +	if (device_is_compatible(i2c->dev, "realtek,rtl9607-i2c")) {
> +		drv_data = device_get_match_data(i2c->dev);
> +		ret = drv_data->select_scl(i2c, i2c->scl_num);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	i2c->sda_num = chan->sda_num;
>  	return 0;
> @@ -494,6 +496,10 @@ static int rtl9300_i2c_probe(struct platform_device *pdev)
>  		scl_num = 0;
>  	i2c->scl_num = (u8)scl_num;
>  
> +	if (device_is_compatible(i2c->dev, "realtek,rtl9607-i2c"))
> +		dev_warn(dev, "Compatible 'realtek,rtl9607-i2c' is deprecated. "
> +			      "Use 'realtek,rtl9607c-i2c' instead\n");
> +
>  	platform_set_drvdata(pdev, i2c);
>  
>  	drv_data = device_get_match_data(i2c->dev);
> @@ -652,6 +658,7 @@ static const struct of_device_id i2c_rtl9300_dt_ids[] = {
>  	{ .compatible = "realtek,rtl9312-i2c", .data = (void *) &rtl9310_i2c_drv_data },
>  	{ .compatible = "realtek,rtl9313-i2c", .data = (void *) &rtl9310_i2c_drv_data },
>  	{ .compatible = "realtek,rtl9607-i2c", .data = (void *) &rtl9607_i2c_drv_data },
> +	{ .compatible = "realtek,rtl9607c-i2c", .data = (void *) &rtl9607_i2c_drv_data },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, i2c_rtl9300_dt_ids);
