Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF6648876E
	for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157966; cv=none; b=RaVffu4IsomKCPWi92dCkbb7Lk50pdzukwmS1HzhmUk++w4JzVozHYq3nEa4xhxb6PMVX6GgTnn9j0rOpo9gdgUXGJzsmgnYC61Cz7SegfBLg/xJTwEwyAzsAowmD9uKLLgGCVLVeAVkP0Y8PDog3uIUMAnb0MtfZXgD2hb8sYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157966; c=relaxed/simple;
	bh=PDhxOqT/y5939ng/CB3Fbzc40lOB6wazyR26umXP14I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=l38Vj0Y7jEXc83gvKHR2FUQ6Y1jFftGep8XApJJk5nySSBEehNj0Hu8ESqAAiBtNOaKYlcCeflJOvslDPdbTiMUunirNdtF4YE60ZCKBMG1zJdd0yeey/f3JNIHpqw6GUuxYXJbdQ0YMGHJArqqHg9Af3n1UKTo2bCh/P97UlJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=e603eVw8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="e603eVw8"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1131598a91.3
        for <linux-i2c@vger.kernel.org>; Wed, 19 Aug 2026 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1787157964; x=1787762764; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j2QFmIqsPMjSEaMKX7xQH3oClX6HCcn2Fx3TkiBSFCE=;
        b=e603eVw8XQAXUE4Ewqs5rjmaBCTRQAJFyDHGWTpI7TAsvNcKKNsIozEpPOIBlqzOHH
         MaHao3MTSFPuwoYm48UBbQ2EDIODfsF8lhEncGD8uC/jumfeJUMl9f8a3JmZzMflheF1
         wSdhFpmW2HSTQxEixxOCCR5BMNzqa2TrZbm45Yq8vx7CVC7lqXILmJpcN9HYImAtSK0e
         SdAh1Y+ZYEdaXPlFPUvlOIUEp/knPprHQdnCqpUepTInvHad6ttLZcGo7p+bWH1zRa/T
         pLVZ5ncIeb2LZXJZDT6IoO+nhHZXmi4EChGfF0DOfRUi0VPdPpoEVTZCVnGY8XZYRqs9
         bYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787157964; x=1787762764;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j2QFmIqsPMjSEaMKX7xQH3oClX6HCcn2Fx3TkiBSFCE=;
        b=cf9Z5odFJYATKKBiYIprNUjT4B0nZREchCWaPinmgLSqmWVquX9H9MoOrii0mAQHNt
         IxMrej3Hv4wSMbc3bio06o0JoQpa8PyyZpntbFb8VjbkwmdxaOUCdpr6M+HzKP3DJh2Q
         HQCBU7YM5FKBJB46uGBKDSZyWj9DZ3V+UueiAYhvzhoHrJ84SRnAqYdKFiax1RTc8yvm
         zh6yL5uw3rXJX1ylzAhhzaUBfl/a8q10wN3bB2fTEj0KjPOhQ+hYQ1HRFRZgYbCUwfnc
         brv38EluwSbqrAbNcvuzuK8txoP0IsNhXK0uuZHZn5jH6hbKO4G4G3NNpTC8rjuTOguc
         mJzA==
X-Forwarded-Encrypted: i=1; AHgh+RpX0i8rVnGhRYQOm3tlxZqd0p0bw+Kkt0hnKBCpF/8J/ApM+9MuLtaSLtXYgftd4wgKgeCQMXFkh/w=@vger.kernel.org
X-Gm-Message-State: AFuF++nf9WZCm++ZUWZTiwiOhAX4fT0WdZn2GDn7DprhGPMtefpUS1Mo
	Oyj2OpZ2Dpo0KTp9ZDtSfTjECynudCOjmV3jdxqc9JtpfZnJJzxLm1NCEL6L9sSP6yo=
X-Gm-Gg: AR+sD13y/e6QYZHkkgTHXeRG2gi87ybj+qplI8adhZjjvWe1yy3KRga/Fw24maIdUE/
	r64H/E62iKkRE/4BlIEjrISZo+jwGp9/dw9XFQIkO/jAZArTr1cS6P0VF4VSgWMr3VVb7X9pMKN
	gi10UuKXP3gX+3hxbp5kDwdMY3clHGnx4ey72ZRGVvIOc4rxDnkr5bXgDMq5RWokakjYbfX9eMW
	AYVjTTSu/QRemsO8hpiUQ26dWkWDm4bHkhS/eBr6PL9Dpi5r1o/gNEj1NFsVl+O2hheDQ7qMTg5
	KwyKdh4E2QsSLvE2N8Q1igCZUBXVNrh/eHdyRlIME+gCtIJl/251qr7a9BbNlKw+JKozCuBl4AN
	CE7Wn1vcB0Ez9aW9J+HQUdHs5KyLlVvUxViGNy8R8+Oy1DnRsdL03/BOe0ZQ1aVoKqECzBdYr6L
	EkNooglnlDxXbaU/D1g2nemrN5IMgrVDza9um1H2OdXqrBN/40q/dKIcfQ4xvF
X-Received: by 2002:a17:90b:4a4b:b0:38f:240d:b857 with SMTP id 98e67ed59e1d1-39580a4d03cmr10751457a91.2.1787157964497;
        Wed, 19 Aug 2026 09:46:04 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f7c962csm3180844a91.0.2026.08.19.09.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 09:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 09:46:01 -0700
Message-Id: <DKT2MHJFPM96.3Q0I52V3283ER@nexthop.ai>
Cc: "Michal Simek" <michal.simek@amd.com>, "Andi Shyti"
 <andi.shyti@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] i2c: xiic: restore non-managed runtime PM to fix clk
 WARN flood
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.21.0
References: <20260818-i2c-xiic-restore-runtime-pm-teardown-v3-1-5fd315b078e1@nexthop.ai> <aoVRETUfgS4FwMnq@ashevche-desk.local> <aoVRpS7EmL3YYBWH@ashevche-desk.local>
In-Reply-To: <aoVRpS7EmL3YYBWH@ashevche-desk.local>

On Tue Aug 18, 2026 at 11:48 PM PDT, Andy Shevchenko wrote:
> On Wed, Aug 19, 2026 at 09:45:41AM +0300, Andy Shevchenko wrote:
>> On Tue, Aug 18, 2026 at 08:35:10AM -0700, Abdurrahman Hussain wrote:
>
> ...
>
>> >  	pm_runtime_set_autosuspend_delay(dev, XIIC_PM_TIMEOUT);
>> >  	pm_runtime_use_autosuspend(dev);
>> > -	ret =3D devm_pm_runtime_set_active_enabled(dev);
>> > -	if (ret)
>> > -		return ret;
>> > +	/*
>> > +	 * Enable runtime PM by hand: devm_pm_runtime_set_active_enabled()
>> > +	 * tears down in an order that races the devm-enabled clock release =
and
>> > +	 * makes clk_core_disable() WARN (see xiic_i2c_remove()).
>> > +	 */
>> > +	pm_runtime_set_active(dev);
>> > +	pm_runtime_enable(dev);
>> > =20
>> >  	/* SCL frequency configuration */
>> >  	i2c->input_clk =3D clk_get_rate(i2c->clk);
>>=20
>> >  	ret =3D devm_request_threaded_irq(dev, irq, NULL, xiic_process,
>> >  					IRQF_ONESHOT, pdev->name, i2c);
>> >  	if (ret)
>> > -		return ret;
>> > +		goto err_pm_disable;
>>=20
>> This might be problematic now. You need to unwind the IRQ request in non=
-devm
>> manner as well. Scenario is that IRQ comes exactly after PM is disabled
>> in the error path. Is it a problem today? What about tomorrow (assuming =
some
>> new chips / code is added)?
>
> (To be clear: I'm talking about next call(s) that may fail, like xiic_rei=
nit()
>  later in the probe.)
>
>> The rule of thumb is that, no devm_*() call should be followed by a goto=
.

Makes sense. I haven't hit it on our hardware yet, but I understand the
concern: once the probe unwinds runtime PM by hand via goto, the
devm-registered handler stays live across that teardown (and across any
future failing step added after it). I'll switch to
request_threaded_irq()/free_irq() and free it explicitly in the probe
error path and in remove() for v4.

Thanks for careful review!

Best regards,
Abdurrahman
