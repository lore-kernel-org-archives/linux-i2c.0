Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837050;
	b=xCilvMCwKqs7fcRAyIuJmaySimK3EeFMlod8PxvhBcgZxMcHnzpetSTS02BU5ETSBWRh
	 QSYt9fvCNOrcctVGOTHTUo5uvPISPMuKvtr5RUKYeChR6YMUx0VRBcySqZ+GXLbmjKUke
	 DtgKQu3hA+jqphWXepe7DWhWZIZ1DTpEw9M2e3fpOBZm3QyHjvoeycdQmVIrXCzymJY08
	 mLhzPlUjE/OI8CIq+7wboYpZBjo34tDEeR4ca6wHkLG3RwXESTq3OVyG0M60lnPZ3xjZa
	 hQwdgxBRy0Z1qmT2IAthHhuXzvLOaK0FHiasyuQ6rJzIXAGl2RNkexNuG3BXuaccayg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OfHQHM3R+bJudBxYYvhr0hB1WtSESOcSRLIVPlqiZOs=;
	b=koOUfJAX77yQoKCLWOAOp0OEqgtgahtRVXvGj8fWtQtiuLdm+WGYkA5K0KTYB/S36Qbx
	 Ec2SnUhqI/9oFQve6e/UJYRf2OdtnsXniVNqj4r+ufcu0AFichyXzoL4asY4MvLUV/Cqv
	 hGLwWuM5PzvhchS3ActOMqH6O7tNHkN/hnqwA5lWOKVzsG2CCF3vlTGT92XW60gQn1koF
	 E1DmO4nMMRXsv6bwwrPfp1C0sfY4Ahwj77fkCnNuxLPUBev3cIBn5UTQMDjmgYdfHmLL5
	 RzCxwIwV9jN0Zp7tJYqoh6b/7M6LzbeZ4P1jf9bAoKcoN/LTZAiiujYKhgZkhsuKqUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SBF+4URO;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA9260A6F59
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 13:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DA9260A6F59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SBF+4URO
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so17168005e9.1
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 05:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794837049; x=1795441849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OfHQHM3R+bJudBxYYvhr0hB1WtSESOcSRLIVPlqiZOs=;
        b=SBF+4UROMOUEWTue8WdlvuLI4sdVC24pYGuePfawZCeckwbe10Zs25hmSgoLcmjmWV
         fsf1P3RG5a9gydngTRd/PZ1fa5sYiUVR6SIAhHxjVJdlrQCwFMLyg9MPZLuNJLK7iIMD
         DeWTz3Nu/SegJ4Ar66nKt2JFG6+Jbmyackm5qcLK9om7fJXT21X53YYMcIGCjbaGZNKs
         xIpf1GbjjBGeaPDOQFrVQEgLWg/ke85kDJSjMKhR08cQKmLxXSKLAS5O6Fkk/3K2dLS4
         EmnMwWCpW6KloDHc6S8mtURRIBSjxSg8BjH4U7H2kRug9y4y+/5M3ogdTs5ckW0oHZKm
         voeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794837049; x=1795441849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OfHQHM3R+bJudBxYYvhr0hB1WtSESOcSRLIVPlqiZOs=;
        b=stD+xFoXebbSNKvT9xi+7CUc2HBwPiSVm2PkuazWSumufy7LgRDkJf696mjcHisJAv
         HaxDXETYAYJZfV7y6lFgHjLfhBvtU4VOUsrwmPwlXvxH5Y9KiJQjcOoMrb1N32ss4hjl
         jKNbzYToDCXjnCmQgud/aP+D3C+it3wPgj77ClY1+pl6qIvxCzlT5H6z7v0/9e8Eh0vN
         fR7mEn/CSFmo78JmDvv54Ob2qKlPhS777A7vaDORBejxV+RpNDhIyPx8Zq00E1YwHXb9
         btAlttGKRb7dNAd3NmuWwtJvOWYTHVvoHNUXNeRovNr/C9lO84VJ0pO4tqIzfxadKrfa
         Sohg==
X-Forwarded-Encrypted: i=1; AL+hErEp2TOfuTHOlHg+QUSo+LQxu0kcKHkrICtC0Buf3otTfrwWGw+acegfvzqpFs/3ldO/fbR82JRYt1o=@vger.kernel.org
X-Gm-Message-State: APuU4Z82Zk3bSVVKoXo/eB5lXWUrLgQzJfYuKZ22gVo5HheWB3WHAt9/
	c9Ohqh9CrlWdNvQZudR3WvaMUGMJNMUiY8MRs1Gx02KdaUuRkrnY2Ccl
X-Gm-Gg: AYBFou3TgFMfp0hWABEWohG3o6p8hP1a3jCjEK2ifww4gVDEEY9GTGbLsDmpKnvqD78
	76XL/4fVl+nm+eTpKZlVaLlvh6ZYvfOKyOB2CRbunCsiesKQPajvZnfpRInRiflw/dWsnrLOQx0
	we5p+d6n9v3NMaAQuzKq5n52xnsZ4u3Ht68WXo6uW68LVrVfjEzJzJSVPzSTtQhYgsL3RqxRfHD
	shS7d0w7LSgmz3StGB1FUxzx6RJYQPFtdyvAFTLP//hRyKnN1qHKbwHp+mxzdRByl/kae/8WvFA
	+6ZEaW8a3mUKN2AM39EjB599QBcaJVkZxpKy7X0VvCYBMnjNRwdwDllFWnggidSqI1R49Y2T7Tj
	6upTWwlz1R5QHXDilNxBPGXD9lb1arouMMHdi0l8xJG6IyUBHJfBVPsABlG8G6qaxeQR4E2E+Ff
	Ws/kSDV6MmGBZ4gLvRut091pLfqWNk2m9PI/wh6IdZfpygn7dT0UDff6zVjSBD7YWFq561DuMtu
	249iGtaxU4UCh0IZQLRZsgtTP/u+nWKUPPv9zYkRpuTEyZFEjjh3jJSAalYACYRdX7MQb/h103m
	zHxSinlkYz3jiqRRzxMnLCbbVt4Qi509Aq8GOaELcN23Y/7ObYmJheas
X-Received: by 2002:a05:600c:1d0e:b0:4a1:d459:db4b with SMTP id 5b1f17b1804b1-4bb55abaef4mr221596805e9.24.1794837048913;
        Mon, 16 Nov 2026 05:50:48 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb6fb45a32sm69904235e9.1.2026.11.16.05.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:50:48 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	mehmet.fide@screeningeagle.com
Subject: Re: [PATCH] i2c: imx: do not acknowledge the last byte of a block read of one byte
Date: Mon, 16 Nov 2026 14:50:47 +0100
Message-ID: <20261116135047.1379330-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116124430.1358948-1-mehmet.fide@gmail.com>
References: 
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

Sashiko is right: with PEC this NACKs the data byte. v2 will test
i2c_imx->msg->len == 2 instead.

Mehmet
