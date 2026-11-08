Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794133631;
	b=wx1D4irzOKDoLsOEY9bo5tdqWT6D1AbH8y4gRbAMMP29f0DH8AXoKXKYlUUh3eVzCR/m
	 iCK283Wp8Ah7FZql2YIzSmIuAKrdq7pDTnu4/AMGXq4hVtx75Uc1a9jSDUpX8X5+Did9n
	 UOEJv48UR4BfVwLmVC3o5KP1kLbUM6y85TVU8aGADkq8DXt3g8icWjVlytoIsxj/1IbMx
	 CIRh3lr5Q9YINR/ARLpEA8iFWIC3Zqqo16qQjkfW9VBftyLHiqTUzRRBevvHkkPqNf6jd
	 iiCJs+NkBPKh+mkO8Wee4AnfZM+jQVMzmjYEArd5JVE4nG1xmZ2H1bnDFYcc4YkhTFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794133631;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=muKBTpgIwomUfoL+ebA1PuO9dc4a3sXML+kuNL0YxMc=;
	b=qhQvbXMoC931qo5I1eyllpsieLd+IBEC5IVLSwadLHAdXmhM8sI4Ee9TX2SzqW4ODN+R
	 +q9+4TmDtl+qvH8igjtauadbyqkZgz7DMoe4tOw/Mj9OMzZ+Uyatx13GrP5iYTiVEJAUa
	 1BzzkdaQfTJU7W/tKcmGi/7s0cg71U0lDMxR9KJLIDSkqMFbgYiNrPpqVDmefsB2PCWKg
	 Vc6Ak6UvdPYleBv5BGk5HNuGpMNv0u4ogUOKmbEZGaX1lmv3cF59US9xo3dx1s3LEH2tB
	 +25P/l3i4tSYtF2VnmYyYiNBVDFTR5075sQ0hOuoTCvLgAXHT+egZK3Tg5+6VqrDUKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=IwjcfgP9;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4871606A320
	for <linux-i2c@vger.kernel.org>; Sun,  8 Nov 2026 10:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4871606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=IwjcfgP9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:content-transfer-encoding
	:in-reply-to; s=k1; bh=muKBTpgIwomUfoL+ebA1PuO9dc4a3sXML+kuNL0Yx
	Mc=; b=IwjcfgP9iE46P2DVCrb8sqNBMdYcjPCP+KPKR5KgJZIcdkl2QaXc87hQ6
	sp+ynLqDh6YI4nV3O/sH//uny4WjwTFNTxjflcWFA19CAYvu1xzgKBiV5rh7tQeU
	xYPW/YrgHJPaicHFEeSzlWD4Mp8B2M2d643TDPsSCQiIycpcrd3+E2DHKBTFzxgH
	ifisSvEKyK7l80w0ybuhVc9b/b79mY88dWUQPvalg0A6M87JZu0lvJ0rKJgTP3wh
	Ybo3SbY+Q8/7r9y4bzZ3danVSh1+z5qT7GKf7ezMEqvHg9hnpg4rYErjT1RZK/oU
	c1jdXwqloTmzQKHl7AGykEcnWZQGQ==
Received: (qmail 2810692 invoked from network); 8 Nov 2026 11:27:07 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Nov 2026 11:27:07 +0100
X-UD-Smtp-Session: l3s3148p1@tsR9ScFf1Ixe20rG
Date: Sun, 8 Nov 2026 11:27:06 +0100
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
Message-ID: <avBOeuNEVo4xn3o6@shikoro>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
 <20261103-i2c-nomadik-fixes-v1-6-655c6af2cb70@mobileye.com>
 <CAD++jLm+m+YNhTaUnTm=dwO4p8xYe8OjZ7qhQ9_u15dnxURiVQ@mail.gmail.com>
 <auxDe0lmVCDu_iXA@shikoro>
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
In-Reply-To: <auxDe0lmVCDu_iXA@shikoro>

On Thu, Nov 05, 2026 at 10:51:07AM +0200, Wolfram Sang wrote:
> On Thu, Nov 05, 2026 at 09:42:02AM +0100, Linus Walleij wrote:
> > On Tue, Nov 3, 2026 at 9:30 AM Dmitry Guzman <Dmitry.Guzman@mobileye.com> wrote:
> > 
> > > In nmk_i2c_xfer(), pm_runtime_get_sync() is called on start and then
> > > the controller registers are accessed without checking the return value.
> > > If pm_runtime_get_sync() fails, access to the register of the device that
> > > was not correctly powered on may cause a bus fault or other unpredictable
> > > system behavior.
> > >
> > > Check the return value of pm_runtime_get_sync() and it if is not 0,
> > > return the error immediately.
> > >
> > > Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
> > (...)
> > > -       pm_runtime_get_sync(&priv->adev->dev);
> > > +       i = pm_runtime_get_sync(&priv->adev->dev);
> > > +       if (i)
> > > +               return i;
> > 
> > It's a bit odd to reuse the i (= iterator...) variable for this.
> > I would just add an int ret or int err for this.
> 
> Yes, please.

I changed this to:

@@ -730,11 +730,12 @@ static int nmk_i2c_xfer_one(struct nmk_i2c_dev *priv, u16 flags)
 static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 		struct i2c_msg msgs[], int num_msgs)
 {
-	int status = 0;
-	int i;
+	int status, i;
 	struct nmk_i2c_dev *priv = i2c_get_adapdata(i2c_adap);
 
-	pm_runtime_get_sync(&priv->adev->dev);
+	status = pm_runtime_get_sync(&priv->adev->dev);
+	if (status)
+		return status;
 
 	/* setup the i2c controller */
 	setup_i2c_controller(priv);

while applying.

