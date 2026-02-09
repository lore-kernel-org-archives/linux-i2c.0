Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD22D32693E
	for <linux-i2c@vger.kernel.org>; Mon,  9 Feb 2026 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770628656; cv=none; b=iVOIEjr8tvufWze4EJdnXipB0fDqcjlzhMMbUwFsvHICY1F5toLLodPsX3AwnuoqXwO+0WmYM34+xDW4WwcCxeUhLbxJ8KLgvDU28+mwVruBHs41HW7xp4wxWH88XPAkKNl8kiIdWsuFlo+zUX8pTT2bbX0KLxUjsf5Ps9OvMv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770628656; c=relaxed/simple;
	bh=xky7xwQrL56STM9QQxkbDPU+lCLuKOLy9n6Qf1yRiew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NYjKMIcIftab/satbN09qkOyEQQOX3mnLQmJFOugeiKbi1DvxVwk1E9I4wOFnx9g+vAxbjgp+S7vPNHeWJLRKM6tibvS8f9oPLfqbKw6Hpp6N6cukPH+39nLfy3mM9XK5xC0y2g747z/uFkdotOZqnYOKcATOf0Gpoe4AHYw6GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=m7VLPYnv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="m7VLPYnv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801bc32725so20524415e9.0
        for <linux-i2c@vger.kernel.org>; Mon, 09 Feb 2026 01:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770628654; x=1771233454; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xky7xwQrL56STM9QQxkbDPU+lCLuKOLy9n6Qf1yRiew=;
        b=m7VLPYnvTBJA+guEEGOZ0+csqTXgIJmvUErz0Q5MqFXBazi/L45cElx05IWmYPx4Pa
         dNhxHfRUasUW0XYfbmWXb672TKjgxNlfuUUSCZwaNKbr8xBEUGlSx4LI9UtrDFHJip39
         r6tYKc/HRg8IXfkJ9YyRIJpPrTVR1oJKd4mgGYV6K4/nqlvBNoaPl8bU7TwwT9PRpF1C
         0juCy2JMlJxNKx/6AomNg1EfF6UISaM/ARtsi0TgAI16mwLqvr8OrfmDeotbH6yn3O0B
         zuhssFSQt2EGafYdlMNUh6ZxYHB3Zr7qd5Bugqxj6aT1yIwGB8lY36Mufmt/J/a1MLKF
         6EkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770628654; x=1771233454;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xky7xwQrL56STM9QQxkbDPU+lCLuKOLy9n6Qf1yRiew=;
        b=MlAo7gecp2rjxcWmGDwuTwgtDFcpYDpVaGkV/t3QJXhidY9Bet1JiJlkJCGoRM92A/
         Eg26QBwV3AX0LpjiHAO01xXDdrPMQ6wNAY7ghca6IKM85+907fFb1tvYgdf8uON+ZSMO
         IBfGttFmhFQp16qDlWCmjm2Bz3TGH8+ELz0jBdV1R26pFmm0m+ndq17JZ3mk4dwmOxAz
         Gk+/R1SrIOqOjDcL82AiL/8KjvEut/oQNdy1IDViYcwJnpEbErQSVV+l1F9FG6D0EZsM
         Tnvrx5E1LYkfmQaOGihUb3XfqyjZi4pNzzSQXIHGzDXdnhr8ebgGTtPp8mwtUzZtp8FB
         oN3w==
X-Forwarded-Encrypted: i=1; AJvYcCVUZX+tT3C6ChjPp38aOMJufWctMZ5ymnilRcECwGTa8uCiCf+szJPvtRde3pi0ZEv/vp9Ldg3fSt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUh/MkLeAQJY4zvnXzSzCZkYAbRo4gdKGcAd+HUhEHeL8JRFL
	vf+qDUow8Dz9S3GIJ6mZRVd2HYzZp6ML/eTVB5dzVaaD5QI/XpKNkc3GflDO1c+7ywpPnBQ4EZn
	WhQgUMrw=
X-Gm-Gg: AZuq6aJ32x8oArGwz127djSsEIEJjd8o6ojGPmvV6WQxx5SUBm7aBs1WeGAoLes/NtZ
	nPdxjnmU2hcfaC6RKFcwhafXhWbOfWt5rLqBi0BRWT1NqcRR/yQkN2KGSDFlEyQEcrPeBjwLgAM
	gIv4C5ACEpFe3lJbXxU+vgYP6Itg/P6s4rxaXouBm/5Sbgem89tI4+hcPht73ajcnhyzF/29c+b
	06hH69xf8I3+lyPcPDWUa7y7wlgTYA/jSFqBBtZqa01YRDn9pnkJR572RZhw4uS2HdXmNch4nZM
	b3L45FWw6NJMYs2xWxpciQ+ASGOJ20TzFh+iWVHj9i1E8Bf3h1aFh3aGlg1TzUKZFupCVMxDvgd
	f3ApfjJpxXjcrmB9aagCpg04hKCFFovNsX1rSwlDOvNdC05LpreJnw56K+4+sC8Ede4eNGWGIlK
	c6yiAl4DVOKEPl
X-Received: by 2002:a05:600c:528b:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-483201e25b5mr140575465e9.10.1770628654251;
        Mon, 09 Feb 2026 01:17:34 -0800 (PST)
Received: from [10.203.83.32] ([151.57.91.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d33f5fsm315880595e9.5.2026.02.09.01.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:17:34 -0800 (PST)
Message-ID: <115bc80b5d4098cd350569a12c41a072c4ffd6d3.camel@baylibre.com>
Subject: Re: [PATCH v3] i2c: Add FTDI FT4222H USB I2C adapter
From: Francesco Lavra <flavra@baylibre.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Date: Mon, 09 Feb 2026 10:17:32 +0100
In-Reply-To: <aYPBXTrREaaXZIdM@zenone.zhora.eu>
References: <20260129155230.3054708-1-flavra@baylibre.com>
	 <aYPBXTrREaaXZIdM@zenone.zhora.eu>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI2LTAyLTA0IGF0IDIzOjA2ICswMTAwLCBBbmRpIFNoeXRpIHdyb3RlOgouLi4K
PiA+ICvCoMKgwqDCoMKgwqDCoGJ1ZlswXSA9IHNsYXZlX2FkZHIgPDwgMTsKPiA+ICvCoMKgwqDC
oMKgwqDCoGJ1ZlsyXSA9IGJ1ZlszXSA9IDA7Cj4gPiArwqDCoMKgwqDCoMKgwqBkbyB7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50IHBrdF9sZW4gPSBtaW4oRlQ0MjIyX1RY
X0hEUkxFTiArIGxlbiAtIHdyaXR0ZW4sCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBGVDQyMjJfQlVMS19NQVhMRU4p
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJvb2wgZmlyc3RfcGt0ID0gKHdy
aXR0ZW4gPT0gMCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm9vbCBsYXN0
X3BrdCA9ICh3cml0dGVuICsgcGt0X2xlbiA9PSBGVDQyMjJfVFhfSERSTEVOCj4gPiArIGxlbik7
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50IHJldCwgYWN0dWFsX2xlbjsK
PiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBidWZbMV0gPSAwOwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChmaXJzdF9wa3QpCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ1ZlsxXSB8PSBmbGFncyAm
IEZUNDIyMl9GTEFHX1JFU1RBUlQ7Cj4gCj4gQXJlbid0IHdlIGxvc2luZyB0aGUgX1NUQVJUIGNh
c2UgaGVyZT8KClRoZSBfUkVTVEFSVCBmbGFnIGlzIDB4MywgYW5kIHRoZSBfU1RBUlQgZmxhZyBp
cyAweDAyLCBzbyBieSBhcHBseWluZyB0aGUKX1JFU1RBUlQgbWFzayB3ZSBhcmUgaW5jbHVkaW5n
IHRoZSBfU1RBUlQgY2FzZSB0b28uIEJ1dCB0aGUgY29kZSBzaG91bGRuJ3QKZGVwZW5kIG9uIHRo
aXMgZGV0YWlsLCBJIHdpbGwgY2hhbmdlIGl0IHRvIGBmbGFncyAmIChGVDQyMjJfRkxBR19TVEFS
VCB8CkZUNDIyMl9GTEFHX1JFU1RBUlQpYC4K

