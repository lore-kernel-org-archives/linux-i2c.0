Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50236F8F3
	for <linux-i2c@vger.kernel.org>; Sun,  7 Jun 2026 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780820466; cv=none; b=UpW3SSg3R8EuSlRT01XTSv1b3m+gkA3I3rxdHbrMJrtU7BDNVP2zzUUlT3LfVUOjfSOmJn0Z1YPEkfb7hhJ1LBiX0esyY049ciVtn4PFELZdkMns+/HqC55OR/HdrGAgrHY8apY90Y2uMQZNkNL/3bcM+7qluvYO3xQ7oL5tuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780820466; c=relaxed/simple;
	bh=YQERmjO6hBoH6+GdyySBEbETr2FTBTtGkTU+7Ccv33E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u1W48VWMvvl4YbSwkyqgwRH2kiSbQ9n7W4h41nDl9fj73AH75L2Wr/yTzry+b+weLKnygKpY1xOqRTj74fgXkZIjeascct2MNay1//u2t7McWT/FYL7BgbbYGthz8BXBTbMQFGNVdbBDPSrJuIiHQSxnjwG83i2gswjCIiYvGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=bdwOH6CA; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="bdwOH6CA"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-138129a622dso3732840c88.0
        for <linux-i2c@vger.kernel.org>; Sun, 07 Jun 2026 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1780820464; x=1781425264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXENIPE1x+qpwB7xDgysn50NyxQ6tMkm/oN0K3KXyn0=;
        b=bdwOH6CA3MEm4icejJUJyYT50xPCnyTJczYxHbjgj8rN8tah5IIh+5eQ8YCgJ3CEhg
         uI4CpTox0e5V/hdhDblZhYdum7d3DRyFVxvMZxW1O6ShC0buxyTv9fef1aqOO84stQwm
         9dOF1tRx+zTnwGQjORkBi6TVwrogUiTUtAn2Wvgp2lKnI8vfufQ9YmWJQM8VJr36APGE
         dOUiiHhwTqDAhU7UQcmKVU2qbjdiPetc0SxQ3hicYoB0yhiCHV7LTnIqtHqcVVbKkfqI
         vnhDoHsv7QP+IKKTpGCBSm1UKOoeAKeDVcLODpm7X4Sk1WlpdaUecbs6N9bIj0cglqP+
         NPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780820464; x=1781425264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fXENIPE1x+qpwB7xDgysn50NyxQ6tMkm/oN0K3KXyn0=;
        b=F7QXSKL1wRNcvnqKJvYra2CLm2A48lAwUkXkpKWwunnNsqF0uBWRpPrrACq/U3uw2j
         yCQTqkGE6tvBihiYBDD+T3k115HcAEG6210HI/MjrxWCwaUJF3WgJuPR9EoHmuIaUiTG
         sxWcqM+je1HL5dZDFdYj2Z/x6BZyXKIjjlxAnfjKVNiy5nlLRa7K743VCfiqVQgevZhp
         2K7fBDqUFNYu+BcGxQgbRi0cbjUtM2kdLZsnosdSXXxDA/ICrE0vvdd4WfKJBnyI6H6m
         9PFL9I70tFubKj9ezQyDMf/REbD4GOxY/Sq6iGq78kmNWeayhjSFpKPPZND7D0VE9a7X
         WQ7g==
X-Gm-Message-State: AOJu0YzK4O+uIFWTVVjp9aWIHAopUrVd1E4OsB98Je5kLl7CddLGC18h
	r1mAuLArYHgv8+JFgM53fVeaGu0x6NWGtnW7w1S6gCTldf5xwPZbDHkhJ+UiBVxGMss=
X-Gm-Gg: Acq92OEBpwzYg9osDxMqR7OydpYtRlBL7AXgBYSaYHxoqcLYayWdX0cvd4Fe+qpQ0OW
	EOjyRxvT7PGmsknaRAeDV6koMeT00+dF1F2jjaWu3FMo4OlVv9j5q5pAxtPumriI/I63N8EGi15
	8Ol1DLRElf4BvqRh8qD/eubq5xb8licgINohqSZ6B3c7kOaVaPZC6VSqsQ1S+zXFM+hgBcZkkaF
	pm74VGzwyuyFpFcdJen06aqN32bAXeqGDF1chZMICZQVGAy1klI2YYgdDKmU9iJmCG0Wk3/tXSG
	DX6Fus62I0loVg/qInDI1UEFNFzsGoETh9qclV/H/p96F6CbzI5/L+t8wskmLVII9ywXq+zGYnQ
	RZK3LZwZlQUyf7BBFAWNEzHMs+eQt3VA8RrPp9tWizTRzpVBya05xVsoi7ehdvwAnx6QEvYOv3o
	MwroVkDmD7tAmyvoX/jcypUv7ZwUzd8shVS/F1
X-Received: by 2002:a05:7022:6081:b0:137:f4b6:b39a with SMTP id a92af1059eb24-1380672d9a7mr5614612c88.32.1780820464140;
        Sun, 07 Jun 2026 01:21:04 -0700 (PDT)
Received: from [127.0.0.2] ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5489d17sm9439232c88.1.2026.06.07.01.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:21:03 -0700 (PDT)
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Date: Sun, 07 Jun 2026 01:20:56 -0700
Subject: [PATCH 2/2] i2c: mux: reg: allow fixing the base bus number via
 fwnode
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-i2c-mux-reg-base-bus-num-v1-2-f193b5a8fedc@nexthop.ai>
References: <20260607-i2c-mux-reg-base-bus-num-v1-0-f193b5a8fedc@nexthop.ai>
In-Reply-To: <20260607-i2c-mux-reg-base-bus-num-v1-0-f193b5a8fedc@nexthop.ai>
To: Peter Rosin <peda@lysator.liu.se>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Abdurrahman Hussain <abdurrahman@nexthop.ai>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780820459; l=2252;
 i=abdurrahman@nexthop.ai; s=20260510; h=from:subject:message-id;
 bh=YQERmjO6hBoH6+GdyySBEbETr2FTBTtGkTU+7Ccv33E=;
 b=GA4/wUnezdHhRk5QO3A6zO2xlwtE/AQK4Dg9ix7np0jTjZ2PELt7nH+Osff1G+z1/gLUEHpv6
 0wUC3LwQGXqChAqwQG6JCLVs4v1MsRgJ3iEr7UXdPd4pvM1DDsWuOsl
X-Developer-Key: i=abdurrahman@nexthop.ai; a=ed25519;
 pk=omTm9cCAbO0ZhS32aKfJDKue0W3sQGpG9ub5eYHif8I=

i2c_mux_reg supports per-channel force_nr through mux->data.base_nr
(when set, the channel-N adapter is registered as
i2c_add_numbered_adapter(base_nr + N)), but the only way to populate
base_nr was the legacy i2c_mux_reg_platform_data path. DT/ACPI/swnode
instances have always defaulted to dynamic allocation, which makes
sensors.conf bus stanzas and other static references break across
boots whenever the i2c-core pool shifts.

Read base_nr from the new "base-bus-num" device property in
i2c_mux_reg_probe_fw(). When the property is absent, base_nr stays
zero and the existing dynamic-allocation behaviour is preserved.

Anchor the per-channel bus number to the channel index (values[i]
== the child node's reg) rather than the iteration counter:

  nr = base_nr ? base_nr + values[i] : 0

values[i] is the channel id encoded in the child node's reg property
(0..n-1), which is also what i2c_mux_add_adapter() receives as
chan_id. Using values[i] makes the mapping deterministic across
fwnode-iteration orderings (some OF kernels walk children in reverse
source order) and across DTS gaps (e.g. a mux that wires channels
0, 1, 3 still gets sane, consecutive bus numbers).

Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 13da757100fe..5ea59ecb4ae5 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -141,6 +141,8 @@ static int i2c_mux_reg_probe_fw(struct regmux *mux, struct device *dev)
 	if (!device_property_read_u32(dev, "idle-state", &mux->data.idle))
 		mux->data.idle_in_use = true;
 
+	device_property_read_u32(dev, "base-bus-num", &mux->data.base_nr);
+
 	return 0;
 }
 
@@ -197,7 +199,7 @@ static int i2c_mux_reg_probe(struct platform_device *pdev)
 		muxc->deselect = i2c_mux_reg_deselect;
 
 	for (i = 0; i < mux->data.n_values; i++) {
-		nr = mux->data.base_nr ? (mux->data.base_nr + i) : 0;
+		nr = mux->data.base_nr ? (mux->data.base_nr + mux->data.values[i]) : 0;
 
 		ret = i2c_mux_add_adapter(muxc, nr, mux->data.values[i]);
 		if (ret)

-- 
2.54.0

