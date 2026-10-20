Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525204;
	b=Oj7AGTJ4rr2yljL6HQgYGX0ad4l1yT3NoU6BjCyUBqZiFCIOwgdgbqSoeFrdwz/oFZMl
	 Lf08Q2y2UArFZpaSd9qmzCKYZ+yEl5OSf2GVUKDsgL6yD+D1xp+ag+INZAOuP/lsINRFV
	 j141fFYJMN3jdHojMjadYcp5PFIrZXUXQSaNxkdwXUysed0DG1R+htAvRizyoXsGNEC/3
	 Hq5jthqTsNmV6waTQ1EOO5iBfqECh4ask8pjm5bhOvYOm3Xza+1cyd+e2hrf65yQKMAIp
	 mHz0oEipB8mgS6PbTol/o0lppJ6CF1C3gWO/E5i40htLKsq3DC4fhlkWNSxjFzLo0Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525204;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=0J82ilsu6p4jQx6bNN1P2jhf4sWBs+ejJtb6PInrdyk=;
	b=s8rdoM3WyGroOFEr93ek939jl/J62/ZyyEMlAQeMvuYxRAhUeHJVkxwUnzj0PO5+5qU8
	 0HuBi6oh/KVQhbGxpfmaHAsYNLY6nmHxHH3+5DizYePFT9wphoID5MF3jDU3bbkzBvBGZ
	 tn8MATj7ND5wqq27rHXNJKZxBcTXX2SNeTl3Llgyz/OoGmfqyRJ29jwYNyRse1m28BGou
	 p+Iwt236ojCOKjODYuYwilxjRkDlOoD+kgbuYmvoIjvyxDmMG0EB/7wZPeSFWNqLYX0E7
	 +2l+a14CUuP9xtDcmOVW1QJKZnNO5RTp1yDyfNxAcvvUom05m3wKC7H2rT+FlKKdLZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=YnwXXM1R;
	arc=none smtp.remote-ip=109.224.244.122
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF2606A326
	for <linux-i2c@vger.kernel.org>; Tue, 20 Oct 2026 19:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2CF2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=YnwXXM1R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1792525201; x=1792784401;
	bh=0J82ilsu6p4jQx6bNN1P2jhf4sWBs+ejJtb6PInrdyk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YnwXXM1R1o72AyqcGodC9/QC0VYSkG8kIn1qeetODGW/DoLrRjB4Xf7T6YzUflAwO
	 goxi4CQpcYCsP1me0B0p4ZUSfW4GQQ60GSreB9sJx75CeLHIB6cSLedyu7VSWMwbkq
	 DD+1SG/4/WH/cHUfCqGmiWXM9wf6yVuqb/KTesA5TX4T43gSQoWcUNty/qgfslA6Ht
	 lrG0XbVbhoFkduYfoLcQ7LAPwqCBxOk3AsiPhlDjpNOhkP3BNEJZddYzBjrcEqoWol
	 d+PFWZmOqWzbzcdTkXBDLAkkQoqpEta9TWfJMkTdhFJifdIMhZ57PAMjALTqaisWQg
	 zykkJJQbE33og==
Date: Tue, 20 Oct 2026 19:39:57 +0000
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, Saikiran <bjsaikiran@gmail.com>, Mark Brown <broonie@kernel.org>, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] i2c: qcom-cci: Suspend the controller 50 ms after the last transfer
Message-ID: <20261020193946.51478-3-birk.skyum@pm.me>
In-Reply-To: <20261020193946.51478-1-birk.skyum@pm.me>
References: <20261020193946.51478-1-birk.skyum@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 54af0124be2d0c181593aec4593450dce63b1f11
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

With a 1 s autosuspend delay the controller stays clocked across any
power cycle of a target that is shorter than a second, so the reset on
resume never runs in between and the first transfer after the target
comes back stalls until the 100 ms timeout. Camera sensors are powered
down when they stop streaming and up again when they start, so closing
and reopening a camera quickly hits this.

On the Lenovo Yoga Slim 7x (X1E80100), restarting the OV02C10 with
v4l2-ctl after pauses of 0.05, 0.1, 0.2 and 0.5 s failed in 19 of 20
cycles each, and in 16 of 20 after 1 s pauses. With this change and the
reset on resume, all 100 cycles started, and so did 150 of 150
libcamera starts back to back.

Transfers come in bursts (a sensor mode alone is a few hundred register
writes), so suspending 50 ms after the last one costs one reset per
burst.

Signed-off-by: Birk Skyum <birk.skyum@pm.me>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qco=
m-cci.c
index 51ce174..62b0fcb 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -794,7 +794,7 @@ static int cci_probe(struct platform_device *pdev)
 =09if (ret < 0)
 =09=09goto disable_clocks;
=20
-=09pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
+=09pm_runtime_set_autosuspend_delay(dev, 50);
 =09ret =3D devm_pm_runtime_set_active_enabled(dev);
 =09if (ret)
 =09=09goto disable_clocks;
--=20
2.53.0


