Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21E35C190
	for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166280; cv=none; b=GtoiWzYM2FtlH4rQKUN5UfZ/T2ddMwPsbYQe3DT7wWoyD0s1+/DOVnW/kTmZBzEJeoKn+rzmS74yJpIt7p8tGDCnw02dp3z4QOLnZPiniXxuodohe+lbtvPrVoPtAUZ2kAX4pRyllMxPyKcIeOE9gVHTe3eeFM781DKgT7aD4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166280; c=relaxed/simple;
	bh=2JXv59EVE8tqU5CUvGyTpvWCqE6v5mn/F6kXBG1uDK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+9ZjWu2t+tGRnvsVewNLC2ct1eIxMQjZOvv9VJ7ZMJOQlmM3kR/gXtlf128FZ3MfoPW9fzqiKEEz/N4BJP5j68YEIj7ZkDlkn1dDWe2SqkOBVv2rdruTBT7BOrBd+9rGmCcauDyP2jTWduqhQiHgBJn3Rl9K5XM2j72ZDE3Qx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cOJVqSLX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOJVqSLX"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf0ddaf50fso53107915ad.1
        for <linux-i2c@vger.kernel.org>; Thu, 11 Jun 2026 01:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781166279; x=1781771079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=804yu81ouTxZb9nEIvZ35zhYf9Urr+McqqL3uFPd0xM=;
        b=cOJVqSLXMGPfk+GjAmNBkibqXlMBYZpSSF6QGBhfQ5ngDYQPcWxXc6cprYWU2HwpQy
         j2+KjAv30Bugm/203/Q+wO/pbllPGsMLvhZMqvlsInk0vyKpCQxum8bksXV5hFQ8QHpN
         8O3BhCo1ENk0l/t6SLQca3xCt8Bhh8A4EAiuthSoa82oIBKt7I9SYQGOVswt3wHuB/Si
         QHK3swvhIIFjKybIGAZDMTVH1dYl3Ve71rCC2FjVdkwgI2qsBIgbOvFh9d5Eg9QLAqqx
         iSWQSxRv5Iia6lAwfnhuGZ1XOn4T8xBn45dTx599aPSAmWlVqHlFHtxo4kVNo4In/cta
         ARiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781166279; x=1781771079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=804yu81ouTxZb9nEIvZ35zhYf9Urr+McqqL3uFPd0xM=;
        b=KzuzeokEqbDT38OHmh+pduUuVK26e1PwJMaDPD49cAvjG5GP7NjNQHfEY67bG42NSR
         ydP4XM8ODkG9Zp62hCHZgNngROTGgmc62jT0C2Ic5kj8G3gRmUy2iWiy4yWdiE2tAr45
         dwB1w+jsKMBrMeomH/X+ZB19mPeh/h59NmtxUCWv/a6a9Mip1HkLApIZUfv16btNxHxE
         kGiri0TyCSNweG79e9Y3CzK0CFqReNv82CN7GwNS326IFh4vndVrxfDO0Z5MK52Effnl
         f0p19sDm7fqMYwFitVf+FAQvog5NsTaz5NqGvBILMkwretv9gaYstBOzynOqQ16ROgtl
         mFZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4WbEHFay3+pHs7zGzIwn6s4y2YeMnPlDCFkOtN6eP8xZpmM+25pJ7pJs5nlSAiUFTVfHp7W8JQSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzswMyn5PfOw5d5afx5A7VJYsqq33TSEvsQE65J/qFGRHFVEKKA
	q3Q2m5tO6lfuzHQOTk50NGnE4FVjsxm9QPL2kUS4VqAEnoJ1Ftb7z0adu8XE/TGKPcg=
X-Gm-Gg: Acq92OGhafK0u23NAcsxOKWXzHgLWPRTRbje1Hapr8qJB0u5ejyhF1pVEsI08OZi8rD
	s7susFIF7lj4vI5aQ2JeY2/tXoevZN94hlXkUq1AhTbtKQTStGihZKsT6UJLAEQTZg4/4AQGSjA
	X1MzVgtuqi+C98XgYl4Rwx0Y4aoeK0NtCiztAgF/KmgnIWqIq/1IgCvtQBaPyt9JRNXGzp+wvUW
	D+YKa+/lM3qQomDaI4SvoP2Tpd1+C510aboq+ZwDzo3E9UxqNO54TFgTx3+eFnyZ6vXy/VpD34E
	lxMNe6yZ1cN1SAVDUL3RHjIZVuXLY8dI9rWQMuDS+r1nC2SWUW6vte91VeAZqyee96SfEIdPXj6
	hSmxledlY/TPYSLKmzCxzQ7+vR6BCwmbxjRpXz4to+/un4aEYTE4UoHu62HtnCBbKHINcsaX2Nr
	umtK0w0tZKcmXtMofn0fOquLZkqnUB1yFRDw==
X-Received: by 2002:a17:902:cccf:b0:2c1:d49c:8397 with SMTP id d9443c01a7336-2c2f21a0e1cmr22477145ad.12.1781166278969;
        Thu, 11 Jun 2026 01:24:38 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d211sm276101155ad.3.2026.06.11.01.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:24:37 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:54:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gavin Li <gavin.li@samsara.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-i2c@vger.kernel.org, 
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, andi.shyti@kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v5] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
Message-ID: <yaeiwzxxh42y3oxiro5uxaxbvralwqxweb6cx4vzwx4y7nards@cysus3gbvple>
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

On 10-06-26, 13:34, Gavin Li wrote:
> Another option I am considering:
> 
> - Uninterruptible wait with timeout, timeout based on adap->timeout
> - Upon timeout, reset the device with
>   virtio_i2c_del_vqs() + virtio_i2c_setup_vqs() + virtio_device_ready()
> 
> This behavior more closely mirrors what other I2C bus drivers do.
> The device should be completely quiesced when virtio_i2c_del_vqs()
> returns, avoiding the UAF.

Looks more reasonable with lesser drawbacks.

-- 
viresh
