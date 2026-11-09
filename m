Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251104;
	b=0I1JP1Ug1TB+4UKAB7q4xg9Vsy1GaU/VglNilX02Yict2LfP1hSiljgmoxN1Ps9Z9H4U
	 Ej6SEzUpbO64Z9QleQ+evpkKW9/sjhrj0UwHeJdGbuyrLmLMzSNGhZw8tGvpk3z37ttxo
	 +EL/u1wQS5Sa2OeXMqGVzfioL/huuBNIjYrg4ASTVHGC6ZIebo/lL6N5KmVVj26ywoROW
	 Lu8/g+x8E5AMbRA7qcscYEZiWmMCJOGbicoGaP4MzqZ+wXiR+kD6ryLJOPNex0kBTO6Ip
	 JWtkg2CKz9ZYQV9J/XWcDuth45QGEkYGSwuwkUTM3HymZvGja99EsE9Rw8Dk/XJ+Ayw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6Ccwykaou03iEXdgsVl2ojrfIyiLm62r6nS34ODXJLk=;
	b=Zy1kdGfevNIjk7Jz4l9bf6S9kLe3MxkRTJJ/qqJHNsqTp55/DJPLV2M13yKH6RngS142
	 9nIsnz1EkCkJaNaz3rJaTmEEKfvR4eWf3914g2QW+A3TCll4wmiC5LIJz++8mFrHkh/zr
	 rsvqKxmFEaAp9y+OxDX/Q/lwONUqL9mxZ6uvdjOWuYLsqxPopa8Mx0l6fwuanqvnTqxc0
	 rDrKpcEdnJCHfPlGy8Ha0bQeNcETOdv1Aps6gfEy76pNTV4WPTU2RCjZHpg4aFddrva3f
	 VXQ7jnHHbjxKx7RdnLTqGJTmmcmlDa2J6DJdcvnd+mKWcZqmwl6QOx5xlQnaBXZ2sXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mgcrea.io header.i=@mgcrea.io header.a=rsa-sha256 header.s=google header.b=jv7CoQJf;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3BD60A381F
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 19:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E3BD60A381F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgcrea.io header.i=@mgcrea.io header.a=rsa-sha256 header.s=google header.b=jv7CoQJf
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso9169505e9.1
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 11:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mgcrea.io; s=google; t=1794251102; x=1794855902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Ccwykaou03iEXdgsVl2ojrfIyiLm62r6nS34ODXJLk=;
        b=jv7CoQJftGCU4PBxF1KDzpDlQUH9a8qKtj4O92bLRSO3djfFWCNS1FPah4as/ZdEgO
         p1HOwXwuJgdCE6rZXINhR7fxok3QUuovGgTfG+CGDPmFFhwd1p5bYlMIGp2TV+d87Omx
         VEqk2lwx+EYiC2G/yYeLVjsyJO6PHsmHkL1H8yYGfpOi3rApQI3lCnQMficcBNzs6jTg
         syLYLv1+W77kS1CnuO0iXi1LSilW3fO8LSsGTLA74K0rBtkCWq2aTpTCeFPk6QAv/Jky
         WCCMP1dmI3MmMIE2klExHJ+omw3u7NxIvq9kmB/BREtssb5sjTqHdJiTXxdok0QifDx/
         l9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794251102; x=1794855902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Ccwykaou03iEXdgsVl2ojrfIyiLm62r6nS34ODXJLk=;
        b=fp9t0Fx/VxWu7AzmyM7WzjTgCie38gBwCEfUJp1Pr4mUkhjUqFTEI5R1F6JHB/17/a
         p8jdu1V2zR2OuXzJ15TYOJYwpuncmQU17xOifonoQW3W3U9sTdTq02oWaiDS7GemmE2Y
         ac135Uwqph5uvvWWHJIRZfRvu7pJhi7t0n8W32UzMuSCbS8ieH83w+1Rm7Yr6V6sJYIz
         3Bz85JRyaDR3W1rj3B7YhrtKa02Nj+G7s+nUHvuYcSRyZsBK02a4fIGMl5nUlhcBnPZu
         o03U4e2lLFE8YaAD8hP6iirymNFfL0u/PH8x/z9ftlgziNnrjd8TYFbVCWN4+igp9p88
         3fcw==
X-Forwarded-Encrypted: i=1; AL+hErFpvCfXMeCm4zVZQ7u1KNxAJg+K6OJXKdjghIBZ6HtpzxFCKgBkEYp983udokUodtuUyiqfKgFd1Kw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8O0D4tsMh+EcT7GWG5jeiE8He0xVqK9jtguFPPPThmbos+1f4N
	rbcb8ZKQc+Ve7rnSRzXIzqSSMRXmLGKcjVUZzpm2VH8dhuJoqtrJmPEGFfpwXmusV1s=
X-Gm-Gg: AYBFou1vUFlKzzNMZ4RZsSpjMcy6p0fySaTRr9zWJ0SIT3P0yWsdmZQRdqXoRiG6Vtw
	6Yk3wj8k+0geh8N+n1n5dvUnalfwWxgDwygNXFLvOEqMEZY8Rhy0sfic+qCXayjkOz5VRcWe0XY
	vX6YkscGIPyJh5c3QSWWREGq5x+9fmC5cHlibNMOYi0Wjgk3fD3BP4KMIpmplm/dTsxcLHTjG8q
	AFNz8U1Bc6KuGFlbl7qjtrmtLI7K9E9T0luvmclDTSYbZquCXORDM+NT/n/U6/wYsWrk1+V0+RW
	olqbBpoNwayS+ReuavK3oKbQnXhAjjHKkfewEsUzEVhDQKToh0AEXCF1dBoxcpVnA9cJ6gvyH3T
	Hp7cURmGkUiC9OMmygnWtzeIkUvJXX6USaQ+oVltzKIyLnjN8bb4wIEEBFal5oeoO3m5seHlLq2
	SaBkhOHt3U7kLYVaHYqLlBMnKPf/zpbfhkV7jyDMaad+2e0VhjgtYZucTl/HDZNTWo99Hl3cKlp
	9vdswMa0Vq5yWdE/HmwzV3IOMbZVF5Mml7nghV+sexbCkjH8+YtHe5XRnQ+QHX9DaHvOGU5hMAg
	t6Kb3PUEZ8praDPWqG5bf77HEZxIEJRFhD9Zk6BObYBTI6oVpb4UL/4sD0WPsdg=
X-Received: by 2002:a05:600c:6291:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-4ba0234ead8mr3131845e9.22.1794251102350;
        Mon, 09 Nov 2026 11:05:02 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:e834:fd4d:2ecb:b787])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm543440f8f.10.2026.11.09.11.05.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 11:05:01 -0800 (PST)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Andi Shyti <andi.shyti@kernel.org>,
	"H . Nikolaus Schaller" <hns@goldelico.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: i2c: ingenic,i2c: Add the X1600
Date: Mon,  9 Nov 2026 20:03:45 +0100
Message-ID: <20261109190345.61480-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <at8jCGfp9dKjieoo@zenone.zhora.eu>
References: <20261024212520.91401-1-olivier@mgcrea.io> <20261024212520.91401-3-olivier@mgcrea.io> <33b5ee36-e293-4356-9906-54e99ba3557e@kernel.org> <at8jCGfp9dKjieoo@zenone.zhora.eu>
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

Hi Nikolaus,

On Mon, Oct 26, 2026 at 10:54:49AM +0100, Andi Shyti wrote:
> I'll wait for Nikolaus ack/r-b for applying the patches.

Could you have a look at v2 when you have a moment? It is the version
after your review of v1: the spike filter programmed on the X1000 and
later, and the X1600 falling back to ingenic,x1000-i2c. It still applies
on i2c-host and on v7.4-rc1.

Thanks,
Olivier
