Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F13328B42
	for <linux-i2c@vger.kernel.org>; Tue, 27 Jan 2026 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538817; cv=none; b=DhLuCbSBWfvknZ3hcU+9yMVLy5AYZ93iej0sMQrFjYVtX3R15AckLDR4l4AfrrshH3TPhQcDlLCfTZQTRjz3i2BgUrW1FuKNzGzs42wkn9aSiPN2pQJUD0NUvzEooX2Ldwj4Zgi5c95UQH3UMYjQkqpTFV6/wiAo9e3AEI8YkwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538817; c=relaxed/simple;
	bh=awVjRUgdKZ+UdnS5ywDc4NqIYm+2dpdKemBuicN/Wto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHcuC8hXNguuUp2lrEXUYAplRE41Hylmj+byNDlF6FQXkgw5ljs/16bfqAc+5vC+SoN47JsebOE62aL6wIgGd3fJSnM3g33/+ZcqhtW5qDYAXdzssiNBUpSqklkf0LW+f5Dm7Nc2NtZXGGyXkN94aZwncng3WoGLWSyuEPyTW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=drwisvCA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="drwisvCA"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4359a302794so3799474f8f.1
        for <linux-i2c@vger.kernel.org>; Tue, 27 Jan 2026 10:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769538801; x=1770143601; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=awVjRUgdKZ+UdnS5ywDc4NqIYm+2dpdKemBuicN/Wto=;
        b=drwisvCAPx+EZ1vQL02Bmh2OI/OprrlhIKX0IgZQzZJpSxcZs0K8R1iXmu9vq9xSc7
         lCjUqbyx56E/yFG95XcPJTHICgbQd8S8cYBVxLve8TzjRP0kF4eYEmpZaTUylvbXeka1
         lxu0aAtXvGEBYOXO9Vc4xJc5xblLUkor+B5CX+xPpRUbanbb5m/n+kXnXFz8Nzw4ziCF
         nHSTP6r/63iZ7U9/tZQFNVFTPod7bmg8h5RrqfjsVQdfyN2r0mouN6rpUk1Sv/8xh6HK
         NAWSjMgUm6UILhBhREBBYJizqMKGCA1VdFReuUwCyYnTy92mMUMSqSAXro/gflmkF4oN
         PhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769538801; x=1770143601;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awVjRUgdKZ+UdnS5ywDc4NqIYm+2dpdKemBuicN/Wto=;
        b=FgSa2uTeYERcDY/1PbXIHuF/9Za1TCiKHgfLPBUnCjxwcOSsGsiP043soZ+6YiEWWW
         NClKocQRdc9zWUeNWYOdV+0knpgToLT1VfcPYhjq5AgSWfyMa9VJ98tL0GF6un1WHJZt
         XdxPMnE1IAE8ziZg5bHu8rXseM0bDuNoVdDZmzqgiVUKBlv0ib7oaRi8REyob+dhPR78
         zGvvvBSvw01h3kdHNZT9d+bF+EiVZ8ciwL+LH1sCCZ5ELjq5MQh4t6CLD5gJOywL4yzK
         DEJ1QNRLkloevKIA7PKY95PUkAg0RehYiHmuDilR9ufKOyY/i60FGzOqbn8O02vURw1p
         ncZg==
X-Forwarded-Encrypted: i=1; AJvYcCWMDfS8S5FFzYCepHPqHxyC86IDdTpjh4LeJ3XKyNBsqS7Y+mAHxsYgyUBs4Aqw1/cLGKzQutYBgCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLvbLo8z4pwcItm9M3a4lVmpy6TRQ42Pde3AaCS6MCGEKys7u
	/fSGjROvDrs9qRJC0Ifl6ZNqlUq9jK3IdRYD5/xtR4iTEFbCYKViDjPgBe3oSdGtPHFrxSl/l6X
	ZWfQTR4I=
X-Gm-Gg: AZuq6aJVKFliCh3u/pxPsUFkdP7UrDvRJN+InzIU56UL8Se5sx0AUtwALznhKn1Z498
	qxSIuu2KX7TYm7tpkqaeUIclIYGlkcUWfNiWQcHC/8wh7X9sCjT5ad8QQaunqMY+RELKnKnRd4a
	Xt2BR7XQkyex3Pu1oUtx4Mmwen3hm2aOXhLBmt0mESXYdJwzkNCvhRBCmmRWTPfzZCdN+e/Ih80
	uJUpCBz0bzGWGdH/oFPFcVdqZei0hfWPP7G0hExW1CyKHdtFx38XIdhYq7NjwTjq3yonosiH5Du
	R/mr2qknt1gjDzrZuMxeGWhiMNtaV3WSjAb13lrlr4j5fOv2k9BEJpcCnbkLMhIE60fq2XlAK/5
	lN3eHIgWEXRFuj5SEBZ9HA3XdMoEKBNygckKQPyjakjvdPxwT+1QoiC29YKK4AJX8373OOWRCg4
	OMtIZY
X-Received: by 2002:a5d:5f54:0:b0:435:94c4:649c with SMTP id ffacd0b85a97d-435dd0b678dmr3931549f8f.30.1769538800823;
        Tue, 27 Jan 2026 10:33:20 -0800 (PST)
Received: from [10.203.83.73] ([151.37.211.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfccsm662846f8f.17.2026.01.27.10.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:33:20 -0800 (PST)
Message-ID: <d821fb9296bb0084d7e1b7c9a600263084ee6012.camel@baylibre.com>
Subject: Re: [PATCH v2] i2c: Add FTDI FT4222H USB I2C adapter
From: Francesco Lavra <flavra@baylibre.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Date: Tue, 27 Jan 2026 19:33:18 +0100
In-Reply-To: <aXH1fEkQWnekwSui@zenone.zhora.eu>
References: <20260116101816.1200416-1-flavra@baylibre.com>
	 <aXH1fEkQWnekwSui@zenone.zhora.eu>
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

SGkgQW5kaSwKCk9uIFRodSwgMjAyNi0wMS0yMiBhdCAxMTozNyArMDEwMCwgQW5kaSBTaHl0aSB3
cm90ZToKPiBIaSBGcmFuY2VzY28sCj4gCj4gLi4uCj4gCj4gPiArc3RhdGljIGludCBmdDQyMjJf
aTJjX2dldF9zdGF0dXMoc3RydWN0IGZ0NDIyMl9pMmMgKmZ0ZGkpCj4gPiArewo+ID4gK8KgwqDC
oMKgwqDCoMKgLyoKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIE11bHRpcGxlIHJldHJpZXMgYXJlIG5l
ZWRlZCBtb3N0bHkgd2hlbiByZXRyaWV2aW5nIHRoZQo+ID4gY29udHJvbGxlcgo+ID4gK8KgwqDC
oMKgwqDCoMKgICogc3RhdHVzIGFmdGVyIGRvaW5nIGEgd3JpdGUgd2l0aCB0aGUgSTJDIGJ1cyBv
cGVyYXRpbmcgYXQgYQo+ID4gbG93IHNwZWVkLgo+ID4gK8KgwqDCoMKgwqDCoMKgICogRW1waXJp
Y2FsIHRlc3RzIGNvbmR1Y3RlZCBhdCAxMDAga0h6IHNob3dlZCB0aGF0IGFmdGVyIGEKPiA+ICvC
oMKgwqDCoMKgwqDCoCAqIG1heGltdW0tc2l6ZWQgKDUxMi1ieXRlKSB3cml0ZSwgdXAgdG8gMTEg
cmV0cmllcyBhcmUgbmVlZGVkCj4gPiBiZWZvcmUKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIHRoZSBj
aGlwIGNsZWFycyBpdHMgQ1RSTF9CVVNZIGZsYWcuIEJ1dCB1bmRlciBjZXJ0YWluCj4gPiBjb25k
aXRpb25zIG1vcmUKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIHJldHJpZXMgbWF5IGJlIG5lZWRlZDog
Zm9yIGV4YW1wbGUsIHdoZW4gdHJ5aW5nIHRvIGRvIGEKPiA+IHdyaXRlIGFmdGVyCj4gPiArwqDC
oMKgwqDCoMKgwqAgKiBkaXNjb25uZWN0aW5nIHRoZSBTQ0wgbGluZSBmcm9tIHRoZSBJMkMgc2xh
dmUsIHRlc3RzIHNob3dlZAo+ID4gdGhhdCB1cAo+ID4gK8KgwqDCoMKgwqDCoMKgICogdG8gNjQg
cmV0cmllcyBhcmUgbmVlZGVkLgo+ID4gK8KgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDC
oMKgwqBjb25zdCBpbnQgbWF4X3JldHJpZXMgPSA3MDsKPiA+ICvCoMKgwqDCoMKgwqDCoGludCBy
ZXRyeTsKPiA+ICvCoMKgwqDCoMKgwqDCoHU4IHN0YXR1czsKPiA+ICsKPiA+ICvCoMKgwqDCoMKg
wqDCoGZvciAocmV0cnkgPSAwOyByZXRyeSA8IG1heF9yZXRyaWVzOyByZXRyeSsrKSB7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50IHJldCA9IGZ0NDIyMl9jbWRfZ2V0KGZ0
ZGksIEZUNDIyMl9DTURfSTJDX1NUQVRVUywKPiA+ICZzdGF0dXMpOwo+ID4gKwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQgPCAwKQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghKHN0YXR1cyAmIEZUNDIyMl9JMkNfQ1RSTF9CVVNZ
KSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJl
YWs7Cj4gCj4gSG93IGFib3V0IGFkZGluZyBhIHNtYWxsIGRlbGF5IGhlcmUuIERvZXMgaXQgYWxz
byBoZWxwIHRvIHJlZHVjZQo+IHRoZSBtYXhpbXVtIG51bWJlciBvZiByZXRyaWVzPwoKWWVzLCBJ
IHRyaWVkIGFkZGluZyBhIGNhbGwgdG8gbXNsZWVwKDEwKSBoZXJlLCBhbmQgd2l0aCB0aGF0IGRl
bGF5IEkgaGF2ZQpuZXZlciBzZWVuIHRoZSByZXRyeSB2YXJpYWJsZSBoaWdoZXIgdGhhbiA0IGF0
IHRoZSBlbmQgb2YgdGhlIGxvb3AuClNvIEkgd2lsbCBhZGQgbXNsZWVwKDEwKSwgYW5kIGNoYW5n
ZSB0aGUgbWF4X3JldHJpZXMgY29uc3RhbnQgdG8gc29tZXRoaW5nCmxpa2UgNS4KCj4gPiArwqDC
oMKgwqDCoMKgwqB9Cj4gCj4gLi4uCj4gCj4gPiArwqDCoMKgwqDCoMKgwqBkZXZfZGJnKCZhZGFw
dGVyLT5kZXYsICJ0cmFuc2ZlciB3aXRoICVkIG1lc3NhZ2UocykiLCBudW0pOwo+ID4gK8KgwqDC
oMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IG51bTsgKytpKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgY29uc3QgdTggYWRkciA9IG1zZ1tpXS5hZGRyOwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnN0IHUxNiBsZW4gPSBtc2dbaV0ubGVuOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHU4ICpidWYgPSBtc2dbaV0uYnVmOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHU4IGZsYWdzOwo+ID4gKwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZsYWdzID0gKChpID09IDApID8gRlQ0MjIyX0ZMQUdfU1RB
UlQgOgo+ID4gRlQ0MjIyX0ZMQUdfUkVTVEFSVCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaWYgKGkgPT0gbnVtIC0gMSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgZmxhZ3MgfD0gRlQ0MjIyX0ZMQUdfU1RPUDsKPiAKPiBBcmUg
d2Ugc2V0dGluZyBoZXJlIGJvdGggU1RPUCBhbmQgUkVTVEFSVCBhdCB0aGUgc2FtZSB0aW1lLgoK
WWVzLCBmb3IgZWFjaCBJMkMgbWVzc2FnZSB0aGUgZHJpdmVyIG11c3Qgc2V0IHRoZSBjb3JyZWN0
IGZsYWdzIGluIG9yZGVyCmZvciB0aGUgYWRhcHRlciB0byBjcmVhdGUgdGhlIGFwcHJvcHJpYXRl
IEkyQyBidXMgY29uZGl0aW9ucy4KU28gZm9yIGV4YW1wbGUgaW4gYSBzaW5nbGUtbWVzc2FnZSB0
cmFuc2Zlciwgd2Ugc2V0IChGVDQyMjJfRkxBR19TVEFSVCB8CkZUNDIyMl9GTEFHX1NUT1ApOyBp
biBhIDItbWVzc2FnZSB0cmFuc2Zlciwgd2Ugc2V0IChGVDQyMjJfRkxBR19TVEFSVCkgZm9yCnRo
ZSBmaXJzdCBtZXNzYWdlIGFuZCAoRlQ0MjIyX0ZMQUdfUkVTVEFSVCB8IEZUNDIyMl9GTEFHX1NU
T1ApIGZvciB0aGUKc2Vjb25kIG1lc3NhZ2UuCgo+IFRoZSByZXN0IGxvb2tzIGdvb2QgdG8gbWUu
Cg==

