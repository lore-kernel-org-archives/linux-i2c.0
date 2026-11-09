Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208533;
	b=EQwPeaVLY/NaBhBE+gK75eHWY+0/BoK+cTXucXO85AvByoGVxFjkPj9T2KU9cSo7MwZj
	 6Ait8FUvG7r/A6zxuykIQFayThSljzXKSbEJwrP7awz8s0XLokdSpSQ1yXbB0hkdCRIkw
	 K+nazjnXQpw5X88rKfunH7TeLltK01DBGqCL7P1vaLjCM37OfQumvnUhVxRcOpGHXa4bn
	 H5UYOeR1vWi97uMRGJyc6IHrpSScMiEbxQ3Uk3I3Ks09TZT4y3zCIdtr8gXIyx5xPytt7
	 uK38vmcXp5Bsrj2j1UZYPAgV9dpWI+hkiWtH3bPl52Pk9Me3aj8w/65hcgGYruFIakg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208533;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NDe69qNLIYTdhsLYqYQaekRTxEOj0NjeZaREVZUZT1k=;
	b=RAaZtqk8X65BASJ11QdHnCOTEw9QWeR5l7hA+Gt0ASRT6LVo33LMsMqc8mK5wrAKbw0C
	 jdCybdj73yJcYvmyYfcwusVetyLH4zRzXd8jTZ5KXakRNAwrb30SVh8z4X6m0XWNdzUJq
	 TcrYtluT0wXg3oXfzWmlSwMOmIsDeCd/eROjnFMBeqWKYzfM9tX3LP1+RP3W77uPT5zJn
	 C1cbjh/4jpO8ecap9wZ3fbJvokgC/NWXvgifFM2r8vSqhhrbQ+vdSxyqL58ISHzUgZlro
	 yEa7TdUv5N5J/vYx9HF10FM9VTs+r9sFQQQUS6+bZl9AQnpOztnXumrjxuFtfjfWWeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b="i2/ox5zl";
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3513A606A321
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 07:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3513A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=i2/ox5zl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=NDe6
	9qNLIYTdhsLYqYQaekRTxEOj0NjeZaREVZUZT1k=; b=i2/ox5zlx48Yc9tPUkPZ
	myNyvSR8O6TjJ0DwTg3U28GlwBgpxYJQT+kHtERfTPsamq8A8xpaDcWtNVjEB4d9
	hEZFdzWg8JvsKhlQ3WLS4yCqkCcIk76cVNutKyM8R+OuOBYtL3ZHxpMSCrY2t50K
	jYTVnWANWRaTLUxUm7l+kekFNa9WZ3akqOPJEmlFyvZSV+NIddtHWfcS4Qx55x0b
	bqA6Ep/3pWiJvGbQIm08RvQb1+GCjzv2wP97vfcm4jccccuty//1AXN9ZZgyNLNo
	xjUBWivV7vLWE8TH+pzJ3FadM8rhFuzaVQmYLkKyM3Vi4HPRSgCBjtjmu9e2KD9N
	IQ==
Received: (qmail 3136135 invoked from network); 9 Nov 2026 08:15:29 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Nov 2026 08:15:29 +0100
X-UD-Smtp-Session: l3s3148p1@zC8QutJffLMujntg
Date: Mon, 9 Nov 2026 08:15:29 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Linus Walleij <linusw@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
	srinidhi kasagar <srinidhi.kasagar@stericsson.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Andrea Gallo <andrea.gallo@stericsson.com>,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] i2c: nomadik: handle pm_runtime errors
Message-ID: <avFzEaxgam-UuZH0@ninjato>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
 <20261103-i2c-nomadik-fixes-v1-6-655c6af2cb70@mobileye.com>
 <avFwLctRcnJHtINQ@ninjato>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avFwLctRcnJHtINQ@ninjato>

On Mon, Nov 09, 2026 at 08:03:09AM +0100, Wolfram Sang wrote:
> 
> > -	pm_runtime_get_sync(&priv->adev->dev);
> > +	i = pm_runtime_get_sync(&priv->adev->dev);
> > +	if (i)
> > +		return i;
> 
> Testbots revealed a smatch warning:
> 
> drivers/i2c/busses/i2c-nomadik.c:737 nmk_i2c_xfer() warn: pm_runtime_get_sync() also returns 1 on success
> 
> I will fix it here.

Like this:

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 104da275ff91..8cf1d443a25c 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -734,13 +734,13 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	struct nmk_i2c_dev *priv = i2c_get_adapdata(i2c_adap);
 
 	status = pm_runtime_get_sync(&priv->adev->dev);
-	if (status)
+	if (status < 0)
 		return status;
 
 	/* setup the i2c controller */
 	setup_i2c_controller(priv);
 
-	for (i = 0; i < num_msgs; i++) {
+	for (i = 0, status = 0; i < num_msgs; i++) {
 		priv->cli.slave_adr	= msgs[i].addr;
 		priv->cli.buffer		= msgs[i].buf;
 		priv->cli.count		= msgs[i].len;

Note that setting status = 0 is not really required as the I2C core will
ensure num_msgs to be > 0. But if people really hack around it, they
could circumvent that. And code checkers will recognize this path until
we fix the loophole.

