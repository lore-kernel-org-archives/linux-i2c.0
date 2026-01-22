Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB747F2EF
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069215; cv=none; b=as3zzEVKr4JSs3r0eTx9Fn04Bi/RdAw6Apcbkj3zbzujRqzSwg+5u2xAy6vrl2ax0XmSqLs13WUH8EIWqY9rVd1QQaGlmFmJXgZHwWRq3AN79fnoPYeL4IKOJiQNTAUaaTavARmd1dQCrwj1ynhlvjAsZC+g4He5KHzpafJoeUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069215; c=relaxed/simple;
	bh=UN81btdLXwLmy+i3FQsqe41ADn+eiw3IDaM94IgibCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o1PvV+HAwj7BBUg1Rzyq2GkUmi2uim3Ra6YOkdZDD0hdPQoIpZ9aOe7TuYDRsTmEzgYq0XEi+WQx3g6K7xwd2yWs3WJ2itM9WkB5fJAsch6U7QZrkviUzsX/vu/kNJULEYNRBY7PG5ErNnzhGto7INKp3hH9ZjhhjrpGze8prTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SkrotNcn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qlgErSsY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkrotNcn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qlgErSsY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769069212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnAUpn2svZoy/oq95lU8MjW2YyOALbOwRLuDG6KCbUY=;
	b=SkrotNcnJ7C/ROyMmdelAZTl8O6wSBcYq4IYukNHUKKtT6KtIqa0QY4HSBZine7RrBXwND
	iO7cCedLtZyrBn0ZatAclfoTXAZ+yUGINUlnRMNFjh0Xod/PhzEMeoHVth60YfqxR+22sp
	xduvvPNiftkLbvjEJa+SIZRzJvN6TYs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-b8K6_epnNOKATXggIrwgzg-1; Thu, 22 Jan 2026 03:06:51 -0500
X-MC-Unique: b8K6_epnNOKATXggIrwgzg-1
X-Mimecast-MFC-AGG-ID: b8K6_epnNOKATXggIrwgzg_1769069210
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4803b4e3b9eso5210865e9.3
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 00:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769069210; x=1769674010; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xnAUpn2svZoy/oq95lU8MjW2YyOALbOwRLuDG6KCbUY=;
        b=qlgErSsYdEo/pm7A674+zhPiVsaHvLXm3TfoweFapfQwrb1sBSLclJkv/Tf90+TNH6
         gwj51mch309JNwNtAUtwV2g2c0qLDOhdk0Immo/wU+z64A4XsUWx+xZ/y23Ei/gyaGNh
         HFJUg/xBJSMIkFQ6nWb1ZzRl8gyb4hahMsZ4FPrH72+/CtsIKUn8kWbEg1vh6s5LD3HF
         xMVohzwE9cftn6yBA1SPGOQ6pRNX/TnQNg9fL+qeUiwhlSOs96eO2jQVfiZtJbBfuIz1
         NCaB1a97mFJSMiEeaXn5g9d/bamdIX4RgzKPYbqzOHpuB0F/XsC4DvCf+mQQ82Wv176C
         z6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769069210; x=1769674010;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xnAUpn2svZoy/oq95lU8MjW2YyOALbOwRLuDG6KCbUY=;
        b=cN6An06YQ5C1og6hYlfwIXjuLLS7YEm3U0uazgE3zrurpPFLy7BHsJI1dJHs4WFHns
         25k94LvHh20Ovj8NkXBEhZy4befobAY53jkHPxLOf2GFa6PughM11ykWHIiKa7UKkzd8
         dRvWtDX4GB9VOLjujJDLPVTSem9xF4ftj+o97haqL/pI9O06qAxdD65fTcNFYsKIyi3+
         uWEh9i2EKK3FYeYP9hm12Mz4obVrdkHcZJplqATkijNwermKvLUEf93Ksl5ZMpHyH5/3
         EvDn21RrAHopTtajuN4iODRHpcfPI8WQ75l/7xxnQMAWxB+e/OlsOQXXzmp8azv3dFXP
         hTrg==
X-Forwarded-Encrypted: i=1; AJvYcCXUu1QuBeGqgIIIjHVQIT0Ux961of4ctY7b8LsfRMHhJ6j4mFcNQ+Dy66ZnHdF0vpnQ/R3005XmzLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ/RmWPZJ72lSqOnon35ywQianN7D7rdiauvlQcqXzhF9dY5vh
	S7kMlc7gqmFoNcA5L+OuZpOB352WCsRj2sYeD6SGJFvc5FYJiDoO1L+NkPIltP3pY3hKjXoz8Ju
	vXt2EXElehfptlTuGvAzY9CshGBXyeJbPajoWLZEq8f+AcZ89P5bw11ycXtI+Dw==
X-Gm-Gg: AZuq6aLJLDtiQB+juKsswgW1TY81LthDH2LrTNNDK1CGnpRTBwlCYe4dnQ9tQJHJSHv
	PrrXwJJlQ1OJ304WBZZqNsQBk14hcJM+eLoPachahPSlqOrNE5ibbuBK1AZh5z1hojQs3/HeADp
	cGAmdJf38vK/LnckvDyzkvWHmvOs0BMizgKNS3YT0Z4q4YySF9D9EacEopzVsNgniggkOZK8mJ4
	QJvu6UBDwXL5MBxCGuh1yh+pd0DnopVAnYLPEEuLhjyPcpwoUOsGd/F5V20RKAIaSRO/c0mSNJB
	wHQplFH8iWVmuS3lW60dtSB3pgO/OqE0vr72+sMgEucUO8JnR906XRldHRAr9vXnlGH4hEJNArd
	jNb2d5K28M63IvSNnMmmCcVzdyXFTYmb0H4Pfi9z0PQdgQhqo7wPSocgyBqWcIL1v8v2x
X-Received: by 2002:a05:600c:46ce:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-4801eb0efe0mr306255065e9.31.1769069209717;
        Thu, 22 Jan 2026 00:06:49 -0800 (PST)
X-Received: by 2002:a05:600c:46ce:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-4801eb0efe0mr306254515e9.31.1769069209274;
        Thu, 22 Jan 2026 00:06:49 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042c38063sm44525215e9.12.2026.01.22.00.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 00:06:48 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Yixun Lan <dlan@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Troy
 Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Yixun Lan <dlan@kernel.org>, Alex Elder <elder@riscstar.com>,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH] i2c: spacemit: drop IRQF_ONESHOT flag from IRQ request
In-Reply-To: <20260122-05-k1-i2c-irq-v1-1-9b8d94bbcd22@kernel.org>
References: <20260122-05-k1-i2c-irq-v1-1-9b8d94bbcd22@kernel.org>
Date: Thu, 22 Jan 2026 09:06:47 +0100
Message-ID: <87tswedqaw.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yixun Lan <dlan@kernel.org> writes:

> In commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT without a
> threaded handler")[1], it will check IRQF_ONESHOT flag in IRQ request,
> and gives a warning if there is no threaded handler. Drop this flag to
> fix this warning.
>
> Link: https://lore.kernel.org/r/20260112134013.eQWyReHR@linutronix.de/ [1]
> Fixes: 5ea558473fa3 ("i2c: spacemit: add support for SpacemiT K1 SoC")
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

