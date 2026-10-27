Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109286;
	b=aRrHo2lo4ajR+IX4ZRd40vyOGDfkTTBT2R4lfpgqX1cRFiWfID9a7bwLYt77MTr6Zxc1
	 kMWk6TqPGkz2KHjeEKcADFtqwJ6QuwN5ZSoc/9JyXYi7vRGtWWDNh2ozGpgVrE5YjtuPE
	 gxzYfN1s3gbWIZWt+7SpL0AarFkkJAJUCyHO2jlubyBrCv4JvBelzoGOLqZDM0M2TWiah
	 b1GdA2qXmhHBzzJ4X02JDnn8I41RZL40vPYelaZ82oBeO6ztpPo3JY4TqNle5cuTe+XcC
	 BHYWmzR3tB2OKzu2P8ogYi7N8B7nTOjkpWnIANafhpRuUZHDd7FvpLGJDqXDwNUUpnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=J4z9ZlSdwg17sm44uHSAYAhxQN3qoO9h/AHW0OnMDTE=;
	b=FLIy+rmdOIWU2v2jLeIhH8KJ0IQI+0LE148t5I4q7ZWJjs/gAXmC0wgoT2yyo36LrmqF
	 oqw45rFYgo2ukM76INgsUUkxrTjfcPwejQrEorWnZe9WehNgI/SJAmO13x5lvDzFXrNGI
	 Fn3ZQb983x8FNBWV1UG+T+JBTPQVqMKpanWE1UdJo3v8G46vwh0fekIrEPdC6hAkAyatD
	 GIi+Bo4+pKZVbp9TYPULLgGVfty3XUa+HdsJ6iNYbRgV3dI4orhfs18E1OdTiy3doA//W
	 0g1S+MGiJlcPllgy/vYaT0H9Qv9PVJR/r34hOKTD0W09H4AWDhSg8NqcHfFlGjhwKfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="FNj/m/CL";
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B3606A325
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 13:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B3B3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FNj/m/CL
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c40e30c26a4so160037966b.0
        for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793109285; x=1793714085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J4z9ZlSdwg17sm44uHSAYAhxQN3qoO9h/AHW0OnMDTE=;
        b=FNj/m/CLFG41YA1dV1oyDiEs0X78B+xLCpNSLf3GYotGxARVKAsALvTDkBXqn6A5Pd
         vNa3jpthwBdPOAAWSW/RhaJPq/vcBe5P51B7Q4s3MjqQzNuNDqrKprqJVtIyixocWI9p
         YU3CvJAz1J1mi0zOf8ztISM6Pt58bTx+bZrAllQulIHT0mfe0Yk9xsKMixKdR2n7vnXD
         WnD3BgwWNv/62vp8Q10b49Y2ZTmnaw7mXRFRz0EkYPYtF0zmmPgg+E+Y5xadxp5iqIxM
         lutdtXEU1lM41Hjr2UH8gM54465iCWILx2WIKA2VNiTa+NEFRKC7r18ZE6eoVnGg1sre
         X2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109285; x=1793714085;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J4z9ZlSdwg17sm44uHSAYAhxQN3qoO9h/AHW0OnMDTE=;
        b=0Gb6pus5yTHqnm9rQ5ZHxeJGSB7gWeTnnkpkSK4rJzmeGU3Y2byRJADF39TmEMIO/q
         BKEjRKGezp75CRQu9hAdFMuzl1MCxK/ijuC3DrhtBnnrY8gg0eAd7mVKyNgMaUc9v/vc
         CW4V42aWXZD+IrZccJ3oQL2OijyO/Efqx7fTY5v3ZReuF/IGMrFpM2c3h+WXVaFyg5z8
         vWX198TnturzCnP1L7L7MV7JLXYJtqA1iZkrXPwr3db8JNYw7arjLQu57kWNxtifb4Ql
         vHDl0NJ7bmNW6864ciG6WlDed+G4Qo4J8E6WgxaG2OD5jKmTGuQ9ann9dr+VXtAR84/p
         6l1w==
X-Forwarded-Encrypted: i=1; AKwUvBz7XiXb8B/xTeK5Z5nUDdykAgaFkFnOzakHArMOR+mgzBgSmq12GfeeU7jDY2n/yeOtzp3/hS3SoeU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdhNsu61meNoxdGW38+rZiy0xzv+1+Y1h3F7ly4Zf9CpVzuVGU
	38qlYfob3n/Gi+VzQFSKr1MUSDotnB5pv1FEsLJiUuxApXOY5Naw2DUI
X-Gm-Gg: AYBFou0ecgasDTipLtGeBcjfucE7+gWpHqBDmfbSTRUAv/LnhCzCIp0iHdB5Gh/chYl
	bPa5tCR/Arb8zCfHqSuX3ADixEYbo8kmmnjo8sRUbTpRzKmrI6sFOmTwguJsN8CUEwWiagg97z4
	lzEd/7KnG1/wvirtgKqkWPDbuU7sTynXiTxWBTOQ1H77iPK1ARZ1khYooI4UKvWWElyN6YP3pjc
	13cSQukKLWfN+/OQsL93qPYamIGsVaX8G8OtBg7/jJiLGq3icRwWNY38NUIoDRg/422zwWMDtfz
	L7nNbXn9sh37OESj3HnXgEDEwHmr/BJDQjjyHgytHihoeRKw1k1lyOl1gtbuXmYRIJ0ka2sy5m3
	NsiYj7QEqAHb7uAoJcBpMee1M9f3p46SI8lQECyWuewl0OcdVBTHSubRwK11bQ/ybnomjYtdZQq
	jAiKn/YfO52VGKxgnATBL/v629/maz3wmAbEcN0rp4M8apS3jKutV9PCW8Ze2nvupaa6l9nssbv
	YUE12phyq2HQHhqmI6RmsLJ8YKBzxIokWLrK2I+3YfKotLSXk2lALxa9ONuTius+F1Ana17R1DA
	Vo15d7MDa8pX/cT/
X-Received: by 2002:a17:906:c111:b0:c26:1cfd:4244 with SMTP id a640c23a62f3a-c49a735d022mr244123466b.11.1793109284644;
        Tue, 27 Oct 2026 06:54:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b49640f1b9sm59352a12.19.2026.10.27.06.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:54:44 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:54:43 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Stefan Roese <sr@denx.de>, Andi Shyti <andi.shyti@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RESEND] i2c: mt7621: fix copying uninitialized kernel
 stack with reduced page_len
Message-ID: <20261027135443.575faff1@pumpkin>
In-Reply-To: <20261022193853.670625-1-ansuelsmth@gmail.com>
References: <20261022193853.670625-1-ansuelsmth@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 21:38:51 +0200
Christian Marangi <ansuelsmth@gmail.com> wrote:

> When a page_len is less than 5 bytes in mtk_i2c_xfer, uninitialized kernel
> stack data is copied and written to REG_SM0D1_REG. Equally on the read
> part, an unnecessary read is done.
> 
> Guard these extra copy/write and read for the page_len to fix leaking
> uninitialized stack memory.
> 
> Fixes: d04913ec5f89 ("i2c: mt7621: Add MediaTek MT7621/7628/7688 I2C driver")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/i2c/busses/i2c-mt7621.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mt7621.c b/drivers/i2c/busses/i2c-mt7621.c
> index 0a288c998419..9ea5e3f9a763 100644
> --- a/drivers/i2c/busses/i2c-mt7621.c
> +++ b/drivers/i2c/busses/i2c-mt7621.c
> @@ -144,7 +144,6 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	u16 addr;
>  	int i, j, ret, len, page_len;
>  	u32 cmd;
> -	u32 data[2];
>  
>  	i2c = i2c_get_adapdata(adap);
>  
> @@ -186,6 +185,8 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  
>  		/* transfer data */
>  		for (len = pmsg->len, j = 0; len > 0; len -= 8, j += 8) {
> +			u32 data[2] = { };
> +
>  			page_len = (len >= 8) ? 8 : len;
>  
>  			if (pmsg->flags & I2C_M_RD) {
> @@ -194,7 +195,8 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  			} else {
>  				memcpy(data, &pmsg->buf[j], page_len);
>  				iowrite32(data[0], i2c->base + REG_SM0D0_REG);
> -				iowrite32(data[1], i2c->base + REG_SM0D1_REG);
> +				if (page_len > 4)
> +					iowrite32(data[1], i2c->base + REG_SM0D1_REG);

1) Why is this using memcpy() rather then just get_unaligned_u32().
   (Yes, short transfers get tricky...)
2) Have you checked whether the hardware requires both registers be
   read/written for correct operation.

David

>  				cmd = SM0CTL1_WRITE;
>  			}
>  
> @@ -204,7 +206,8 @@ static int mtk_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  
>  			if (pmsg->flags & I2C_M_RD) {
>  				data[0] = ioread32(i2c->base + REG_SM0D0_REG);
> -				data[1] = ioread32(i2c->base + REG_SM0D1_REG);
> +				if (page_len > 4)
> +					data[1] = ioread32(i2c->base + REG_SM0D1_REG);
>  				memcpy(&pmsg->buf[j], data, page_len);
>  			} else {
>  				if (!(pmsg->flags & I2C_M_IGNORE_NAK)) {

