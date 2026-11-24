Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524984;
	b=q70FR9B4id6uQWWL6vELE2+Ghkne2/JsK4XYPW1ZV66EptllOWi3/TPusCniuMRzm1BR
	 LgVlCFolH64zI8ClVmfpmfBxQAUzWLREXCDiEx4WxHpsQ4PnP8uBCwbYH51LcutDLIfpF
	 0oSAd+y/+mDxIRh0oEhYO6e9tHI7zX6ZLer9i7EfsMh3exkS1PxM3dIaZPmFSqlLptzpB
	 hcM/+EMkQfrv7ZFsYDOFP1EygLWnptMgvcJOrZznyU2IX2y5vCauP63kmgiN9aJfpnJ4r
	 COvdq+RU2QCSKb+GW5/JvXJp88l2SNHmbfY/DVN6tT8X2e3okhKPfhBRFIxz+Q/DWkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=hN7kRr7ecbZK4AjamlewAkQtVvluvjLq4XDkOaYd8I8=;
	b=y2NoL1pHtLL0CXAqpepXq4Yw/bxqXcwvtLjqslvhXWTlVL9DC4fQ1nSOU4UrOL8+LDex
	 CCQGbLUxZeeWYSK+oc/Y0zW8enyo+f5YJEMjgOsTeELGYbCvriYijZvsFsG+l6jED2qPS
	 j+L0eFPMK8yUi9wAsG2++H5UcdIIEfLo8RZI86G4aZo6F7ZrQ7V3UL6GZr4VnYJJda6jx
	 D/SFtcOEApMNZsvM6zrYnBuXPU1QP+7LEoDxqR0fIDKn9hg69B8tU5pstPIDzjhW3Nk8h
	 2cxZOM8CuWk4obNTseumnuJprkSr24Ti7ArxZIeRtDx9LUS03jzDljc3xWfR4ogZB0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fNBdiCdz;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F3E606A321
	for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 12:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39F3E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fNBdiCdz
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso857901eec.0
        for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 04:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795524982; x=1796129782; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hN7kRr7ecbZK4AjamlewAkQtVvluvjLq4XDkOaYd8I8=;
        b=fNBdiCdz+tgYtr+xzhxnPfPG9qMbfihriW14Aa7k8ZsV3gsUD2GNqwJAGrxqSDkaHv
         aMTJDtBqDRB1C+1nQOvqFLyVimivc8+G/ioVSuDJ+9dQxw84cE+h5aJZtzURCbZwv1gs
         +tBX381GTHJAXs934/XK3/nr/4/uziZxOCP72hByG/CZpYY65p6gQsNqBSL0M7K5yozD
         mRpi8Z68hSoH8YBz4FTVOHfTOQ9+oY2srKvYrtmS8a/Jlmrbr4EFsaZZifx88y2TYF3J
         ekgsZ7TNy/cUP9ICnInBTIgSaiQzViKpqGFK4ZVxBqnedpfLaQvtVF0l+4ZllOquiZpn
         pZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795524982; x=1796129782;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hN7kRr7ecbZK4AjamlewAkQtVvluvjLq4XDkOaYd8I8=;
        b=Jd/fY+Ob5YKZIos0IiTzcK888opdIlpzMVW1zlAOtbKsDlukD8F5IHBnIINOWexPw2
         y7c6+onK5YVrkoiLLlyoxfVrjZv0KtfNTOupq0hqrSyCPn6H6MbxsUDlkQHlVCfqQEGZ
         Jgb2ASEaUSxzfeSkcpgqXL0j29UQz8d/Q5MzsNPKxKTKJFGGt6mElB4Dq7qlfDIrfbUH
         sYXTdZ3Yrb+9USnfc6ZG61S8qzCqg6Gr9Ok/wDYzf8OepSNF27Pj7o9iIAlKH6SY8QOE
         ObypfRrLgiBva3oMElIxooQeabtrq1fh9InfyRPurUt1QkusCQmnKIYmhy0qzxh8zZ9q
         wOvg==
X-Forwarded-Encrypted: i=1; AL+hErHDFdqACaXGDl4w3Zgm+A/4TPZh4SNc8qZ9qWLxa7I99buwSK9c7wt1XFkNrBbwUz/NqhuYWKgtr54=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fz8/OYfUhjniVJ9iE2Zv9QOPGhGBd4Rw4h4gU+trOxHIDR4cc
	tSQ+4TeB0pT0pc3JFC2ZVOfFZdsScalLFu7HGnCAnaicTSCnZBcb6TqZ
X-Gm-Gg: AZFdTZexSzJs/5o64b7C/ePc+lHmLByvzW3g78tjSD4Ba49WNXx8qSm84L0sho/a2R7
	RF8/DsWA64atAnfadl9Irjb2zJVEv6ePSlWw6E86PMAv7GkePYAuIA1Ssh+PLl7JWWxx/xcNTh1
	K4SxIIYN/Dfb9U/IdZwJIUnejdf/fNOW9wXkVXQDO3XJ7K88zeRa9sDLcnyhRLPJPC/tEKLZYNa
	uH1y/YEpxQMnjC8Vr9XvawzXJT+f/QFop590gzG1mX66KuLf/8T04iuKCLSVsGRKL7vhw65quCC
	zTo48hpG9wxpA93/eZbYFjaJOvXeBIrNdYYVIVaN/40QuWCzuogzujqT9PnHl7VE/YF7uekSgje
	F9FPZdORY8giGNq4eqlAPh78sW5VD24CpxoBk5BU2QBpI5RNRYSWWbF0c9j/DGrUgDzk3P3tmuP
	2ZfRePliBI2ZrfyVW8MOm26h30zHaDYPb3iZoj78rd7OicHZ2aJhG0a7vvnaNY4uZIPfIs/pAAK
	ougiE8nyVN+aJkv8Ipu+cc7qjm7zX9/Q59H8Qssk2uSU4MXTS7F9h6w7w0np0DF6DjrHilVbE4Z
	ckNgD7T0PREBo+j/4gw/5dY4ISZgeW1SlxNgHA==
X-Received: by 2002:a05:693c:8042:b0:379:8df3:d2c9 with SMTP id 5a478bee46e88-3856f14ca78mr16118427eec.13.1795524982187;
        Tue, 24 Nov 2026 04:56:22 -0800 (PST)
Received: from [192.168.29.85] ([2405:201:8026:213e:1412:77ad:61f2:79f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7fc3sm39991456eec.8.2026.11.24.04.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:56:21 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] i2c: scmi: fix memory leak on invalid block length
From: mdshahid03@gmail.com
To: mdshahid03@gmail.com
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261120054138.194076-1-mdshahid03@gmail.com>
References: <20261120054138.194076-1-mdshahid03@gmail.com>
Date: Tue, 24 Nov 2026 18:26:04 +0530
Message-Id: <179552496489.186639.4680455408849151360.b4-reply@b4>
X-Mailer: b4 0.16.0

Hi,

could you please review and give your feedback ,when time permits.

Thanks
Shahid.

On 2026-11-20 11:11 +0530, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> When the returned block length is invalid,the function returns
> -EPROTO directly without freeing the ACPI response buffer.
> 
> Use goto out instead, so the allocated buffer is freed before
> returning the error.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/i2c/busses/i2c-scmi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
> index 37442c9ee222..b65771d31a28 100644
> --- a/drivers/i2c/busses/i2c-scmi.c
> +++ b/drivers/i2c/busses/i2c-scmi.c
> @@ -248,8 +248,10 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
>  			result = -EIO;
>  			goto out;
>  		}
> -		if (len == 0 || len > I2C_SMBUS_BLOCK_MAX)
> -			return -EPROTO;
> +		if (len == 0 || len > I2C_SMBUS_BLOCK_MAX) {
> +			result = -EPROTO;
> +			goto out;
> +		}
>  		data->block[0] = len;
>  		memcpy(data->block + 1, obj->buffer.pointer, len);
>  		break;
> -- 
> 2.43.0
> 
> 
> 


