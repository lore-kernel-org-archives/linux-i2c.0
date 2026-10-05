Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48D4E66C8
	for <linux-i2c@vger.kernel.org>; Mon,  5 Oct 2026 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791232117; cv=none; b=paFz/vO6Pm1L3plmD3uiRNDdAVEEvcXBN4YQDxP9EqMLnWBvLeqPXjlRPnXBfK2N7JringPI+V2ITH4mq+I4maKbANnIUaTmp0Y81IRY5Zj4u/FmRZHZJhTYY+q8u0sviLB/HrKfz+zYC+w2mp4XDTvmZBgGR4GzxL2mTkdNseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791232117; c=relaxed/simple;
	bh=rF6rQofzYRml/5wBil+Xn0JDP3ogfFhOy5WOAz38e3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqCteq5xXJkFyZZQ0QvowtYW9FtvLwPgGSn0o83zYNsd6Wpqc7yXuzXavUZiL6TxunUGFjtHV39eTS7CwaAIBTlc15DaKJOnvS1hG7e2EsCCRAAaIZFnKfsvVtZTQvext3yAZOS6LjXtgHE1XEUwYUoDLMVvBjyQeOgtoTVqiuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfkpBWi3; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfkpBWi3"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb91ecaccso3446949a12.2
        for <linux-i2c@vger.kernel.org>; Mon, 05 Oct 2026 13:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791232102; x=1791836902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W/C9tWh0XAUTo7k5jKf93sgNA+uT1YvSZ7hoHgaGa7c=;
        b=gfkpBWi3J0c3eoKs0MAu4EHoj1EcHALK9P9EqhjFAEzwgyj46pyqSu72DtmE6QrD3F
         2L88vjqMsGJMq0qP10Kg/ayVuAoMr5yVCWEzpDBeOGcn0JtJ0J7DtRgoPcy8Gek8NTLl
         vjKWu1Nfa5aaUzOOB2EjsFj70H96KGKc3W/AzF57VKC+1llsMOzaTe+ZlD1rULxPN0QQ
         GBp1wVFQ1rw8CZodnUAkxSPXLQa73ef4d+f7TlqE421I9AHgT0bsqa3+g5X+jdBtpfaQ
         vF8N7QeJjTD16o4OUiP9UHdh6SJzHKJSuq7suWWGP/e8ydIK3/L6eR02hQLWRcgHVh8A
         TiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791232102; x=1791836902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W/C9tWh0XAUTo7k5jKf93sgNA+uT1YvSZ7hoHgaGa7c=;
        b=ebPTrLa7JKuqA1XmUQ/PF97uA7qwDExTLMOEReo9lQcstIWwYGqTeE9IVkFoCpc/rn
         trJiS8YtxwXD1ytNlgMHNmB1ZSB5llZUqBymKMq1bQRGkSMF5yg8TpGk7NnGrsWMS/3M
         4bDgXT3ssmS5WsRZK2XpmkBgf5rLifTv1e9SsxHfrVR/DI8s9AqfPhztReUu7H5pqlMw
         6ofQu06SZnfMN2gUta8HboqrDE8WAfd5XkF1zaTNjoLCSbo0wYmJrpDnIyohdx6YgYQ2
         64G+e6WNONrMnLIc7ZC5sBZ94ndGZPTdV+n+xNMiJc7hENhRDGaJuvxlnAJnh5yecqQB
         Oe2A==
X-Forwarded-Encrypted: i=1; AKwUvBzoMXglCcI4Mif2xEhKa51WOKG9kKqudYwfvH7jP7Sbu28tIBlNaKO/FZkkwKeBfTm5LV6zlVDK40I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnSrxZtgrW6ZMn3nSsy52m59tuLLoCT/QPYhuPEqdPVNGwcmRV
	wXa5E+yiQnOAvsLxzJNAX9FnaE14236pkBUkjiQ9483Llr0JMUWmKLLa
X-Gm-Gg: AYBFou2xlztFb49PBLy9qRYAj/BArnH/5/JR8/bvCNAuQwA2o9EymKEiE9t8kHvyAyf
	JCoHuGHeTOcXrXTZsRFgMRIP1CfXnj8N4UIGmhLdOZOmqvGeKX2GwJKcZZZlXtWeViBReSK7fg0
	TEmK+mV4R1cUc5L1KYacTmdj5QI1xLxb2ibh+4GxoRgJS9Tu462d5S50emCw8ctrV1RxDIv2HCx
	x4w9sb1oPdpOgPZ/wGQNS4uSFgWL1uM/TFnnnKsba70+LhxOfoYRDfdEZZs4b4KH861FDgytNFb
	LCkqwqpI7spaynO16M3dSB2nC0IqOHpOjFNrz6AnnzBamUvtthmZ8wRwdvUMESzBNrZ+2fAf0+8
	hOhAldkwkxLmmcprWIVjaBBdBDUmo6DdxNBBClxZqgcvxZXcAAV+lkheGHh2vzTvmbC4ffVKeT8
	Eh/5IwefleSZ79qD53IzyWA63WX6awe5A74N1PNSaWKEV1DAfNifKOEQgGd+cxnmbBsEJmqnjkM
	ZT71X5doYGo38PGxQSNatZLVMgU5pm0
X-Received: by 2002:a05:6402:518f:b0:6ac:afa2:ca25 with SMTP id 4fb4d7f45d1cf-6af9e03a239mr9940306a12.6.1791232102025;
        Mon, 05 Oct 2026 13:28:22 -0700 (PDT)
Received: from debian (ip-78-137-176-146.broadband.digiweb.ie. [78.137.176.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb01e572asm3801024a12.13.2026.10.05.13.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:28:21 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Pablo Mazzini <pmazzini@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/11] dt-bindings: i2c: mv64xxx: add Allwinner B288
Date: Mon,  5 Oct 2026 21:27:27 +0100
Message-ID: <20261005202731.153971-8-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005202731.153971-1-pmazzini@gmail.com>
References: <20261005202731.153971-1-pmazzini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The B288 controller follows the existing Allwinner variant.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
index c4efcef59133..d3b6f7668621 100644
--- a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
@@ -21,6 +21,7 @@ properties:
           - enum:
               - allwinner,suniv-f1c100s-i2c
               - allwinner,sun8i-a23-i2c
+              - allwinner,sun8i-b288-i2c
               - allwinner,sun8i-a83t-i2c
               - allwinner,sun8i-v536-i2c
               - allwinner,sun50i-a64-i2c
-- 
2.52.0

