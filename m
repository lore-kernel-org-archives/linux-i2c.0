Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF02D0C89
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787108651; cv=none; b=ZzpypdQQgIRODsivuGQYWZvVBgTq8FCJh/t2DnZ5jdtvP5OjPe03bQP0n6JhNn98/jP+/f7wbHaUHlmbdRR+BnViKIRduQBoC+DoMwPxMRIqvby+ZCR+2F7p7Mq5MbfE25AUWd1IEQpsXDCcbKQj6/xjeZKvNMo+U8A+250jGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787108651; c=relaxed/simple;
	bh=sviH1l6fZpG+pAMydY7Ddw/DfzdQFavnnX4R0hC6FYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOsdpIz7qBh+Z8I9Lp6wivBfsd+V/pzl1/nXfXvX2+gGJQzmRt37TPWrVq5yShiNVl4SztaJxcQZBk1h7cNRpS1blzLKCSofOTwFjaPyE+s9k6gjMdT8SrD8Mle/K2Kuf2Mubr9Jtn5Q6KfnjL2CaCz+d+aeZ8+XmEfyyXAZ+Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6GP20m6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6GP20m6"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84e507b079dso380755b3a.0
        for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 20:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787108649; x=1787713449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xprqNfysYrYnID50ZswWvtk9khSaHU7cD4ltdkSoNFw=;
        b=C6GP20m68aPEL1YjKveOZ3qWOyNLocVcXTD9Xgppj0bHatOQNnczD2+72FfKb7LDRy
         x5Fu9FfbOJ0nuB/tLN01YNYifdRl4thsIenieTrrmpcWpj/J9rvR1AI/e2Pe5a+pdru3
         4USCjRWyayMt0O7/cTe0gH6vtPwE994WLg+vobSCnbKdeiEtnfTLlT5tJTIhQd2OimBK
         mo3NlLzf61oQeIfJFHON2tsF5BQwxhbqOIujNTXrT08G/g1KITlwmEu5H4hp4jTLtHTn
         v1NWv5d3rMPI0MjwFV4DBdGA34GJm1LCojDRYKYzcrOvBl/pZBBajDAekRkBedmrq9+U
         eZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787108649; x=1787713449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xprqNfysYrYnID50ZswWvtk9khSaHU7cD4ltdkSoNFw=;
        b=MA6101k5ZYoeLpjwjMQP1wT9aEm0g9ek6W1oKSvnxAVnpLwAhhsgXKmS+qsR5DOc6u
         gU5xcK+f4rGwapHhNqKjbXumQKJ4WcjXleyxFjdj/m7+K0YlikwQZiZItIaCDYmo1x4n
         6PYQNmnhdFdIA/LZPqTH3z/SpOehv1f5sqGHlDfSgbrOxP7kAhKHoElYwI/U8t9TFLDl
         DiSopPKByZcmaW5dHJbKDLO7wh3rA+CUN3BDaxJ9SC5wnXEcIrB9/DtPB9becrBv7M/i
         4PrEXuVbKGcjLCl5+QjQMGI0+vhGI8HnGGDKbTAdcMqGvr3mXHZvMCwrCENKNuu2XsPc
         kJTA==
X-Gm-Message-State: AOJu0YyajT2oG9rvRetiL829DoTExjA5j01Zbk/FEPZoLbIDVrpv1mqo
	FHZc6yTYCJZPXQRGMlCCURPPE7rP/KKde4EVCrDNi2n/v7HpsEsTKH5vCgYct12Z8GCcZ7BS
X-Gm-Gg: AR+sD10YBgttipkmCwobK6F4WG0dUWuQWY+LBcpoZ5ZNYCMJnhp9eZ3iq6oFjdrtXsm
	sEjeAPz47RjG64wFcDVfuInx0UFjmvRDXGplx71cJ5QuVMNmgJJwU9FWfA9zhRIKJLLMU2GGlX/
	UFKqs4qic/sZ4Ep3dHQ8dygrxcDcUDZKQJbosCOLAFbH69fXq3L2VgTz0/SLx+nh4aA6dvQfe2H
	AF0G65v7Csf8FaA6DaneWlcanOM158TJEEfIdsuSOTC94WMjMhuTHUuUODGegq0mWcNWJpdRXmD
	1tg735Q7a6BoRbsCoWx+A7v0sjPJTa4C+xx8hxpjQTA6qMBpdTRHFmVR+pcsN7VuyD3lK6Zqqc0
	CU9vYOlBwni1dv6vmcrYXunwDBOIr1EDQLnfxaTFO5ZvJu0fJARk8LOLiFpeJnTFDlv6VZAMpVg
	KiFZYcYa3jVzZwDNpZYhAdRgjJ6HZbNeGYK7qinij7O4xDa6C4WT7GL+IcrKcRNp8y3hFItZutQ
	vij40Hk6N2DalFF
X-Received: by 2002:a05:6a00:4205:b0:847:881c:7026 with SMTP id d2e1a72fcca58-851d3850762mr2230803b3a.3.1787108649269;
        Tue, 18 Aug 2026 20:04:09 -0700 (PDT)
Received: from localhost.localdomain ([103.150.184.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3615eb0sm116387b3a.28.2026.08.18.20.04.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 20:04:08 -0700 (PDT)
From: Liu Zhenlong <dragonliu2018@gmail.com>
To: vladimir.zapolskiy@linaro.org
Cc: linux-i2c@vger.kernel.org,
	konrad.dybcio@oss.qualcomm.com
Subject: Re: [PATCH v2] i2c: qcom-cci: fix device_node refcount leak in cci_probe()/cci_remove()
Date: Wed, 19 Aug 2026 11:03:54 +0800
Message-ID: <20260819030354.49170-1-dragonliu2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <db94c578-2bfb-4297-9955-fba690ecfe39@linaro.org>
References: <db94c578-2bfb-4297-9955-fba690ecfe39@linaro.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Vladimir,

Thanks for the review and the Reviewed-by!

On the cast: I considered (void (*)(void *))of_node_put, but kept the
small wrapper.  Casting to an incompatible function pointer type and
calling through it is technically undefined, and tegra_dc_of_node_put()
in drivers/gpu/drm/tegra/rgb.c uses the same one-line wrapper around
of_node_put(), so I followed that existing pattern.  Happy to switch
to the cast if you'd still prefer it.

Regards,
Liu Zhenlong
