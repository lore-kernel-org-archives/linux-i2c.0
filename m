Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD729370AE9;
	Wed, 20 May 2026 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282748; cv=none; b=DoAPn8sq7aTwdKt6kH5uPqtkLfbr+1NlQuwCdL1FFJEJjd3eb4DkzhfkiKJzl4BVwHC0Yb6tafzG47q6D5vDG18JeiZFO6XzSPxMRK9JcRUoIe0Z1SwD7lzShLfIN7PcFR6GIr5N1x/hSLGS2AdQ4RvsANEIoLQoqizicw/EREs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282748; c=relaxed/simple;
	bh=cwtAZCN2UslSG5cFbbPenrGbVM+XRlCTJ4OQhKipdFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSo+LsnYvfv/l9aeqMhweZbiG8nnt839T0SDnOHrcKw0Saz01DKrkaImqgasNL5GaMOCC5n+NEQPqu8/og1NtTcTbL0Yv/cKntWcSkMVkqXW/t+mtgjNJiCneVmj5PZ2nv3fewDRGWL8syuE1ZP9xRQ7457qyOFhXih4IzNetC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag5U2cbJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag5U2cbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71C71F00897;
	Wed, 20 May 2026 13:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779282739;
	bh=LDiqU24FnygipMJZF/E2ohL/T+IcvIu3at5V2stX2lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ag5U2cbJ22AvG78ECvu6dNgipYp3CuxM222XqnkR0d9GwV58g7onMEEtm1WFdr5ca
	 wa2m0xbAA5i3ReRIRovvRmV1i6xzYWBjb3G9RYjDUCRCnrvitHlDKOUrQy1qBnx3e1
	 3roJ9xcW/j11+pt2GcU/cTXA9hAeCUR6gy3H8MJZusaxLsUdf4MUUChFTDjBEfbSY8
	 nAP+WHK3UJ7+bG0YhtkO1An3zzrrVNq64kPcEqONvWaNvPZwdLYzaH0PWo37VV2JcM
	 yOXFlu+qfWCEGkHIwzzLU4mZNKLzk7/YbDn2nnmkp5CBEgAJ2WvoiTI1ExWoRWfiKm
	 jvQT2b1LXRTSg==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: chris.brandt@renesas.com,
	andi.shyti@kernel.org,
	wsa@sang-engineering.com
Cc: claudiu.beznea@kernel.org,
	claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] i2c: riic: Drop empty line
Date: Wed, 20 May 2026 16:12:06 +0300
Message-ID: <20260520131206.932050-5-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520131206.932050-1-claudiu.beznea@kernel.org>
References: <20260520131206.932050-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Drop empty line to follow the coding style.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

 drivers/i2c/busses/i2c-riic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index c15f79868031..33cc96125b73 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -584,7 +584,6 @@ static int riic_i2c_probe(struct platform_device *pdev)
 					     irq_desc->name);
 	}
 
-
 	adap = &riic->adapter;
 	i2c_set_adapdata(adap, riic);
 	strscpy(adap->name, "Renesas RIIC adapter", sizeof(adap->name));
-- 
2.43.0

