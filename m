Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868671;
	b=ZhqmFcI5gsPBTZgsBtz2IdxM6jnFX1db5GCtqTS40cYH3SIUHhzCfxtU4lrl24OvErJG
	 oLx7eRe1kHjvD6Sc5lx6nKVzOyN0MfCSSo5xj6yT8680z5oJ7yYu+12B6nF5N2sBoT3Ua
	 E5hfgROZ8Uu+8OM8c6VgCMRt4AiiUvBf6IBsxAXCgXltemdujcKHOReuxseKB9gtCGYbd
	 Yf+1+9+nYzjbcGBES1ihSyceWo6d+SYEyOZE3Xa1B0NE+/EPlDKwrTumOhzOipb0uoqMv
	 dCWc3U/Z9YnF+ckxK/CZF/EyPbflHLJXxLZZlVekVLyzFx1vWtnwW6CxdQaxaE5tRDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868671;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=2Kob7YlwVM+xHHu2Uvpi+NLog2cKg/RBxEB5tTCs0Yk=;
	b=3DYfgv4qL8luegskzm3wqvU5lsod+qd+60RNgLgkA8QaaXAbfH3Z23YtNAuRDxTMYSeI
	 AlEna7cFpo5IWalLh05zI28N2dKstAPW4joBZnQUGZIp1dpHytoK/tWNMF+MSMLv6nCL8
	 s+wmimOEV65M94yj5X8vqaK40NCobraZvGso1YBW2VJC1tzShFxXE3n8vF9xbxpBBj8mO
	 CimplTS3FQrtKEh/EqQcmz+pOP/u12ynqTg74Fqp0ih+YYUNFo5rZe6S8zeG//cv2aKX7
	 iSrYZ5ugHpAaoMD2xVyAls1/ywyTSqacMj24EeGokqHDEHrfclfiafqwrgeDNOeV2fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=JKYwwhzG;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8F606A338
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 08:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BD8F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=JKYwwhzG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:content-transfer-encoding
	:in-reply-to; s=k1; bh=2Kob7YlwVM+xHHu2Uvpi+NLog2cKg/RBxEB5tTCs0
	Yk=; b=JKYwwhzGpO7p0wD7j5WBusl+5uPKnIQr5LW27p1RaPjWrYpSh8yCRZb6U
	+TmIjyOpHIfW9RrkNOELPIWVswKCRT5peC2xvMKYxwo7Ng5WVknGYbitD41LzJMi
	3hQVAk4Cj9+lUC0vy0uDXkrVoNRuqCefqCT+K4YKSV5DGQGau+Ol4C2c78vMRz2P
	4Ps+kCSSiHIryaR1trBC2kNtQA1NZuMqxJenGosSjaGB0o8sTiFFUo5lqVseKLR1
	7GouPftCld2vLt1XOjEDx9/vbQBG78k62eQNNlgpQJRfSUkxQ7aPfmBO0GjFlLUR
	p214tVN9oyOr/mp7dTaacE9WY10GQ==
Received: (qmail 1074718 invoked from network); 5 Nov 2026 09:51:07 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Nov 2026 09:51:07 +0100
X-UD-Smtp-Session: l3s3148p1@BjyumINf3sTAwtcC
Date: Thu, 5 Nov 2026 10:51:07 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Dmitry Guzman <Dmitry.Guzman@mobileye.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	srinidhi kasagar <srinidhi.kasagar@stericsson.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Andrea Gallo <andrea.gallo@stericsson.com>,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] i2c: nomadik: handle pm_runtime errors
Message-ID: <auxDe0lmVCDu_iXA@shikoro>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
 <20261103-i2c-nomadik-fixes-v1-6-655c6af2cb70@mobileye.com>
 <CAD++jLm+m+YNhTaUnTm=dwO4p8xYe8OjZ7qhQ9_u15dnxURiVQ@mail.gmail.com>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLm+m+YNhTaUnTm=dwO4p8xYe8OjZ7qhQ9_u15dnxURiVQ@mail.gmail.com>

On Thu, Nov 05, 2026 at 09:42:02AM +0100, Linus Walleij wrote:
> On Tue, Nov 3, 2026 at 9:30 AM Dmitry Guzman <Dmitry.Guzman@mobileye.com> wrote:
> 
> > In nmk_i2c_xfer(), pm_runtime_get_sync() is called on start and then
> > the controller registers are accessed without checking the return value.
> > If pm_runtime_get_sync() fails, access to the register of the device that
> > was not correctly powered on may cause a bus fault or other unpredictable
> > system behavior.
> >
> > Check the return value of pm_runtime_get_sync() and it if is not 0,
> > return the error immediately.
> >
> > Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
> (...)
> > -       pm_runtime_get_sync(&priv->adev->dev);
> > +       i = pm_runtime_get_sync(&priv->adev->dev);
> > +       if (i)
> > +               return i;
> 
> It's a bit odd to reuse the i (= iterator...) variable for this.
> I would just add an int ret or int err for this.

Yes, please.

