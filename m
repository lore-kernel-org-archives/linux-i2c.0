Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED111CBA
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116152; cv=none; b=uR6pTsOqiEGIPzWRGhyP6xJadkNnD6vyVMZrHQkmrZUM3kXHveZn0Eng8PGZHUngudgMzaAu3v05ySAbtia+d2T/Q9Rvz3nvwIUjPfKQs+vSzx56jaxjIWp3QkTP/n6d1xjjgtAeaMfTZ/Th+t2UtvnckQmXdeUrYFMgsvAAKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116152; c=relaxed/simple;
	bh=5eJc7bdv9UcuO2/Vxvv3fAGYYH6i/iFPsJ6Zo79uDfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyOoZWGzLXCiMNz9zORyrKvFal4eRGJ9hLc5zQ42lg4Lq1Vtk9t6SDdR7DM+/vv0FVeY6px3a7uO9wb+bjZK6mUHcgIVs6XDcYcygGhZX0L/XRJ0TwqNCjMC1Yg45JknZ0QKzBMo/WWpjnHI1r8dv/43Yzt0fbBpOGVRiKleB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=chmE9fEs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bc3olyn0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chmE9fEs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bc3olyn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781116150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NQAVhVT6gguuYJ2zdf4a7mcws54HuCOez18N0LHRhOc=;
	b=chmE9fEsfAUHUfoIFUe7R/PMsAbUpBmgkCCJyEUGzszsKrDrJY3YCk1MOH2Q09yWmkSGUC
	4v/o8ok1MrvoE+MmsCVxZoc2MBFVLmVNToEWbu6Kh7bDPf1MfC7CLjoEzrLBPUcoYEJJNF
	zIub16Ua8tqkOT1qPjP22B8MAwsC0DA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-Ae9sQ2hLP4i7e1VlkeQSPg-1; Wed, 10 Jun 2026 14:29:08 -0400
X-MC-Unique: Ae9sQ2hLP4i7e1VlkeQSPg-1
X-Mimecast-MFC-AGG-ID: Ae9sQ2hLP4i7e1VlkeQSPg_1781116148
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45eec2ba533so4790218f8f.3
        for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781116148; x=1781720948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NQAVhVT6gguuYJ2zdf4a7mcws54HuCOez18N0LHRhOc=;
        b=bc3olyn0iYvODXE3oY8Z5MxufWA6Ol4+szfj4+3rJzQfAxVrT/U1156c7CGpgzgzxg
         x/KgiOybnFSZOyS8U8GBrVnq4f6wltTztIFEvtg5ccELgkwY5hX3yDgTOvDL/G7LnWXc
         2jV0GO1yBOavvk6XC1p6szTemShcquv7xfnb3MMmJHkAv3gUpDZ1W57+WGhzvMXuLPi5
         AcFYrOpldMRBcZHMjGp2ZJopYbG08RW06+xlo2H/g6RUHUKExRaEyb2qbiMqwWkDwqGu
         hjcfMbTqqd/NPtCYCWR0TiVTLUW6P1d7HP3tzH3oCFIcii+vgFJsOPS8gr525FYLqdO3
         QCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781116148; x=1781720948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQAVhVT6gguuYJ2zdf4a7mcws54HuCOez18N0LHRhOc=;
        b=HW/nSuYwcjyk1YyN5ZZPRoKRymJclCY/yanorihXqHqDEobPkbt8f/mfwBro76FInR
         lGq24cG/S1Xrj8pVA0fxofWJbQXMPfPd78PadeVb1f60ra22cVnVvjua0RypojOZpo7d
         BHtNAkQBZhrRij5D432ZmpgWBOLW5eTVx4bO3V6TgQqPbVCNFc0SWrF0+xteFCDlxLwV
         sV3RklUJL79tveCnuiYs1//Fs1AFZ7+ve3P+dsru40N3u+Qhv1Rml9T/u/JWotGxu7WP
         PlLgmR9E7XRbg5e/SSMm3spQ624FXgcso+z9tedzTxbyORu4Gb6LLg354t0Mr++O0yfV
         EfYA==
X-Gm-Message-State: AOJu0YyjVv5zziAV6uCPIJAkvwrd73gmGTMVqMTnEEARfJOlaRrDLOuP
	0VlmLOpFel4vW/g5Bj5S4FlN+2UXYRKRnlZcfBz+u9UlB+5UXG/MEt8nNss8n7WuA4jYj1xkqgo
	c7eJUDPb8AXfEbl46yBoND+k+I4/vICwYDGH7PVinvDYNGulk4z8S0SoVJfZ5tg==
X-Gm-Gg: Acq92OEnJ6HnDnjQP4MjAC6HzYVlDKXw6l61QxFUIDctzS5UTEPcutnpvRdN7HtDW6e
	ymQ2+/G8kf0wFFQdC6rbh0/jUV+QEUvzlD6sdQn1bb0uxV/mh8ac3pN6UsD7CSVbli+1WqMB0/t
	notmYcb3lTmX12JcrNeIlhbmCrncJ5eqOPdV30AAMm/zpA5ShHc91wjdRIKBBRa/NqauLNKAn+q
	q9eDUG3QC7HVQE9pXl8SFSFxkrmgbzr38JLx9sjmBXXKGolA9fd3BoHEjYezjeQgAbIkMtjv/3R
	W7nvUhgF5phE6p91uyTqbYi/m14IAeUJnvGxZVsUCV+KQFIPCbGX1Hwii8V4B3a7Vmxjxm7ZadX
	6kPcE/reyPUnMylE5ucx1YSdrsClCoqAFunZV9q9EgJJSt0mmzfnUiw==
X-Received: by 2002:a05:600c:6792:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-490c25ee920mr433186655e9.24.1781116147582;
        Wed, 10 Jun 2026 11:29:07 -0700 (PDT)
X-Received: by 2002:a05:600c:6792:b0:48a:f18:ece4 with SMTP id 5b1f17b1804b1-490c25ee920mr433186355e9.24.1781116147125;
        Wed, 10 Jun 2026 11:29:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2ca21f4sm3293785e9.7.2026.06.10.11.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 11:29:06 -0700 (PDT)
Date: Wed, 10 Jun 2026 14:29:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Li <gavin.li@samsara.com>
Cc: linux-i2c@vger.kernel.org, viresh.kumar@linaro.org,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, andi.shyti@kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v5] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
Message-ID: <20260610142758-mutt-send-email-mst@kernel.org>
References: <20260610155834.79207-1-gavin.li@samsara.com>
 <20260610120606-mutt-send-email-mst@kernel.org>
 <CAKvMnUW-3b=cqHcozydnc6K1vD06FGk1ZO_q7S6SqhA5d8eR2g@mail.gmail.com>
 <CAKvMnUXk0GrYNNYOHvME6FYRdKik-7fV5B-NgvRM+i5yYKTmvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKvMnUXk0GrYNNYOHvME6FYRdKik-7fV5B-NgvRM+i5yYKTmvw@mail.gmail.com>

On Wed, Jun 10, 2026 at 01:34:10PM -0400, Gavin Li wrote:
> Another option I am considering:
> 
> - Uninterruptible wait with timeout, timeout based on adap->timeout
> - Upon timeout, reset the device with
>   virtio_i2c_del_vqs() + virtio_i2c_setup_vqs() + virtio_device_ready()
> 
> This behavior more closely mirrors what other I2C bus drivers do.
> The device should be completely quiesced when virtio_i2c_del_vqs()
> returns, avoiding the UAF.

I don't know enough about i2c.

Maybe
1. revert
2. some other hack

-- 
MST

