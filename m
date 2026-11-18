Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032335;
	b=aqyqnhYm0e3OQxM3hrTjMRhRqi8bAuvj1T6kDPmJbCnQH4u9Glc58uIXAa7MzaHQRKou
	 jDI15cW5d17bYHHj2CHU1WOrRkWlZrPgUXsNlEa1OYswVVD3s/HkQoC03uNGDra4aNl3/
	 WNMgTD2fqJjfjkG5ubG5F7O8t1s1SJSslIIdzpU8eqhjKjhZBiVQGo3McXyfAlY+4Ru9Q
	 Xrwf5gS+Skk2ldIETJiM9fEgZEa6hm6iQnUP7ddQhbpfsD+VnDW3R/wAUibK/6nGxBhKH
	 0ss2c0E1x1RcAD77dGgK+NyMUTnKL4fQ29YIQAqxs0Kl84kdJySZ3CEgpk+PE93HEoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vm6X4RXhkwTGS0rODxxBI99H8aOAkurBTqwazIDQj1E=;
	b=JwLKBlMKWZ0PR9qa2T6ro5+6IEgBO32YOpZTcIrxTZBQbdWywbBgof/GFkCTcnDg+f5g
	 Y6ZR700iU3jvx8B8mBgE5yv78UiijbfcO5q8dfkD2uqPnXQQyh5c+/zPWDhGjVZ6hss+Q
	 fZeagBrXYpJ40HWHCQ73VZ4volC2889+VLXpKPE93wR9jjqp0ruPOq5yCSFVTYnRoGV0P
	 rtdBgzV7shP9CMH84IWaslTkOa5TQl8XJdOkmBKnI0EKZ01HszbOSxIpnfy9TfF240h8i
	 DtqhKNakO47yaD9NJpbI1IBy+IQdKmOvvwNdTnA/Awx0N79EEZ2qpSn4wwj3IlHt8GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q1FMbmrY;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2960A2607
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 20:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1F2960A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q1FMbmrY
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36a315ed211so192421eec.0
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 12:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795032334; x=1795637134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vm6X4RXhkwTGS0rODxxBI99H8aOAkurBTqwazIDQj1E=;
        b=Q1FMbmrYQQM0s+ITTtFVk2rDTCxKhZq0tHSCa2oNwKmMIhrmem7HiE4QVyRnT/aIyH
         DXfy3kpwMUJOIhMYIMy+ACBusVXxNb97WjPXy3ICtPgpymxbpK0/ogDILwffmlNlyHZq
         eFMxQxRZ8XFVEd972N+qeDY4Nq9JbbPp24pcGo4fctMzvMj5hnnox2rz/WUOKIrG/GQ8
         UYxRNzI8UIo14siV2QhWPTiAVnItrl2hCUZZrDkDRCyr2ZECEJjSWeooQOiNiQ3w61/C
         ryWjtdjI+8N6tzj8SewjK/TnGSE2EQeqN+0w39ywVYFJPV1JPjAA1lMfVffOxP9LKXSr
         VMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795032334; x=1795637134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vm6X4RXhkwTGS0rODxxBI99H8aOAkurBTqwazIDQj1E=;
        b=zQt28W2wYjW+jT36ZeMRMDezZM8kW8fYeC51rFteELq11fMNWBKc3DhwkRaK+d9OO7
         Pm7jC+1nBsLGM+tUy/JT34No+2huFa1eWGs1uFhXivVDT3BEU1iOV3prpjLiz/PCTaR6
         D0dz/LbRgYGfO+IvMamN16kq3wUbh6Ejvz/xeI+StmAVaNlCQgjsQ3MuTL40o8OqCCfD
         PCJzoLJYib6Bh6YZUbY6p5u2LcGynmW0QPatAujNSkmLKBCIgPbr5WBR4u9mhjFj5wWe
         a3dpL7UGujozTSl5isecJ/5fsyStBMa6VfztH4raYlKM2291eAiBDrZqGmtnxy8pTiF4
         JNgg==
X-Forwarded-Encrypted: i=1; AL+hErF57/+CTbN2fiKyQEfEBRbVACbf2s4pCqmPLcwKKH9ZLjx3CpfrjhwPxamwY0cby4XUw0zUzB/hXIQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7BLGgw7n8uD+J5+6MJ/x0o5xQ4GXpQi1y/oJzj2htoVgVti08
	8gx1tqyoPoSzkIbrcVXsGdQLQtaOdbd45eyI/a+pRFgq/U3VvFOH2GJl
X-Gm-Gg: AZFdTZemFEGWe8tlIsTqQfCjWxI/toQM/WYebz1QIPUyIZd7b6HvUBflWGX6xyTa9nU
	b9TrTxSAoD7yOnV1zu7T5FuYCwg3ltyV47LMneEaXNlcrDfPIVKTdnlQ0q21a017OHnshXyDjYX
	niZssViS9sfxg5PDMDmlU2aTxtTxKNinGxhjh/RsRxNH5t/1jPBa/yy2zxv2UkmhIHQLp39oaNf
	YS/fh8AGlVeu7FBfHgy2nvRhoct583zi1BRmIYbzzwHQ5tPVr/IXCSjpMPYrXSB6LuqqKg4UB/T
	p+O/iGh5ffaGmjlNN1ueJUC1qU2AW9zBXKohuYJoRBEibn5j7CFPO/xpvs/373dBaoftVMm6fHX
	5W6yGGExBDJAIfYkISYYWcvqmRSIERbtxxjRSo5uOhzPsYZCmXmhJYcquGR79t6o7WPDm+9gEZ+
	z73w6HLb1M3Ibso+eULPmGmJea7MVze3JBO3A6yD84vGfIbGgjjR9JMlgWZd441bmn6yGlTqCRp
	L1gjkmZauOiss1KPX7Z3DL+J6I9m2R7uc+Rt3+vyrX1hUC0TtwVUZscy+21q0/Rr7vNWQAAmiKH
	x6SoFLVkUhVjvIoNh9b5fS12mlzQXiG65IHbJ5jXv0LloCrEP9bwUWOowr4aM2VhUfwBb0AAavn
	em88eXjN6LmxkcipWi9pNa5t0AXOW
X-Received: by 2002:a05:7300:ae97:b0:382:2ae3:b1d0 with SMTP id 5a478bee46e88-383ee2228b7mr420599eec.13.1795032333782;
        Wed, 18 Nov 2026 12:05:33 -0800 (PST)
Received: from Mac.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a75d401fsm9683206eec.20.2026.11.18.12.05.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 12:05:33 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: andi.shyti@kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jiri@resnulli.us,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rdunlap@infradead.org,
	richardcochran@gmail.com,
	skhan@linuxfoundation.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v3 2/3] i2c: xiic: add KUnit coverage for register access modes
Date: Wed, 18 Nov 2026 12:05:30 -0800
Message-ID: <20261118-timecard-common-301f823ddd-r2-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179502617695.3136.6995182814188526026@kernel.org>
References: <20261116-wiwi-v3-87afa10a8-2-ahmadexp@gmail.com> <179502617695.3136.6995182814188526026@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Agreed. RAM cannot distinguish a byte read from a truncated word read
returning the same value. I have stated that explicitly in the Kconfig
help and test comment, and retained the direct-x86-64 restriction.

All four KUnit cases pass in x86-64 QEMU. Separately, the source-derived
accessor fixture records which I/O accessor was called, including its
width and address. Removing the forced-word read branch makes that
fixture fail. This is software accessor coverage, not a measurement of
PCIe transaction widths, and I have not added runtime indirection to the
driver just for testing.
