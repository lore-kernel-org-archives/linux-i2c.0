Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F3C43AB0
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116053; cv=none; b=W8JE1GGBIVLJwm3JwMXuneN2Rd9hqdbcVwz40ndQY68QZrg3XKS8xCIhz0TGzaED5mIuA/02iZxP534SuomoYjkdXZb6mqg8WkTxJ9lTf0rGE0mJGiynEBQbp7YI6zpMkFShRZrRDXf1xIFP083mvTJDNGb4d+SarjDVJdZrfQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116053; c=relaxed/simple;
	bh=ky+54WzqhwCQn3Ytm4Zf4MQKrizH9ZoY5ZQZgkQiVj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGazd9aTAn8Am/LFUs/lSakEkcWntiX+ISHpQVm7GyxPk+BRge+bLg2li/AQ2Xvzq5kEk6VeSMXOvrLWYasJxTlLSAt5rcFMLsJ/h2A/BokUZC/QqG0kyMY9sy4u8ehPv2R8Yax0ZbQECRFLpERPfobpDAYaj6/+eu/tlN7NtVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzD6ewqv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wn9hZFrh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzD6ewqv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wn9hZFrh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781116051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRdfQpUlvZVI1ND25INGLzSIbMuZeJsmz2jd0r5twS8=;
	b=gzD6ewqvBi2+kQjweSyWB9hx84TNyVaw696AEtRI+wj0X5w1PMktt9PYWUCcHaY+dbchuN
	1ygcvJI9tLKLtvBIQBwXJgpxyQCOmNt6DPpOsflc7bEcLokaDkz/RvyKHqNlB87fuDh+iY
	LOlRBNzB/FouvWtaZ+kwBhpbQioLZ48=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-_iRIZxWsNmGEJLX3gqqblw-1; Wed, 10 Jun 2026 14:27:29 -0400
X-MC-Unique: _iRIZxWsNmGEJLX3gqqblw-1
X-Mimecast-MFC-AGG-ID: _iRIZxWsNmGEJLX3gqqblw_1781116049
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490ae461f8dso52837085e9.1
        for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781116048; x=1781720848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRdfQpUlvZVI1ND25INGLzSIbMuZeJsmz2jd0r5twS8=;
        b=Wn9hZFrh3wTUnn+VxfkdAboABRl08sR7hAjL23V7RR3EVc6MuMZYHad35a16EK1dlW
         X6GU3+KcNwWZjwADZfwlKEJy5QyaDwO8kOpEpH4rLZrA8HeHt/7pMV+0fz5AH1zOlJMz
         O5HvTXbSCOtdQG0Kj+Fesg6MaFZNtCqUhnsorswdpvz8WvT1QbmYQZ2oEXXEbm9NYnYi
         ygI0oLSyJy9JZtKHqwlaS9LERMzqR13MvMpR/hGzJeXneb88AgXWrWNNWf5WQT5r2Hx4
         e+HSiHSPiOWl9At9cARH7M8xwP6zehJ/7bAscxM7iNcsmkY6/2BC5BBqTUF0KnzkDxH1
         oH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781116048; x=1781720848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRdfQpUlvZVI1ND25INGLzSIbMuZeJsmz2jd0r5twS8=;
        b=nul1PLNbl8zHISlWMs/fXnEXsJz2w7rgo1HwmeeRHuGoLO7bCqZTf4Tym5p8Y5mXB0
         gL7gkvKF5U2+OoFgwFP28bzR3PsNx/NYVw849q+gVUN/JsVB37yWQQZooovKvB3QVO9B
         k6y+zu2qmbsGSlckuMIauRdSZc2oAB9encnSgDbRDmCXyETKx0gbvDqWRYJlrpuBeDhj
         J1pEwmSUBGoHlugXXULyKcbq38Ssw2BRSfXZLd0SbJwP9eVq6acwESI4vPbHr7m+1Qjz
         +l+ldfjaLGoXg1Y/QZgYrWv/8gNgf0A43O5DeKDo3qAkjJx6LHHRPr70dQDPngJuWBEZ
         +ooQ==
X-Gm-Message-State: AOJu0Yx2HL17wEmDDezYELSm1AogeM4bw5VawoQp4OcQlGpzsziLILQz
	5q4/u9dVywVvXRU7fBh7/+G9yqfkBc4uOD15xLqWV4JdsBnrUJMayMAITLZZTzEizTBtgjUu+o/
	BhiheDu50b8/PZFLx8pOJW5V6+qkD8AP66j2yP6lSl8/CXPTqDiKpIPWnLrSTxQ==
X-Gm-Gg: Acq92OEA79KCm9sVHbAvMVY4fQKSNK93fUlkcB9Ty0hvjDKssSRQ5xe3nznBuZrUIYu
	LvIyPwzLsubNxCxhA8nMBRrZBmD222OJ9nXir/PD7SxCqeY4fOEdKIBRSU+r+wKAV/dfTJnjwiv
	Z4CLUXrguq+n4gcTe3fYJqsir5YDXz88Zo1uXLj5zj4jWA4Iw79rieLUnK3eIEmkMJuf+aJYmcK
	PcNqiKxy/5FHFtRvGErV3xha7OW80wEGLxkrDrUdBRkIpTslx6nc39oEg0VTq6i58fDLUL5cl4p
	stQeqHNxUT+1U3NCqqBm5wzxA6LuJ6yOeefkZMn2lOakGHBx4zN2d5sguNDz/xQVI4/Me3FbbaK
	lTFaweZ7DLz0GwHkUl+gVGkzfBh9tS4HkLFoz0FQdu4DNavrx1Iy3Bg==
X-Received: by 2002:a05:600c:6087:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-490c25b0231mr450959545e9.11.1781116048503;
        Wed, 10 Jun 2026 11:27:28 -0700 (PDT)
X-Received: by 2002:a05:600c:6087:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-490c25b0231mr450959235e9.11.1781116048015;
        Wed, 10 Jun 2026 11:27:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm128623628f8f.27.2026.06.10.11.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 11:27:27 -0700 (PDT)
Date: Wed, 10 Jun 2026 14:27:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Li <gavin.li@samsara.com>
Cc: linux-i2c@vger.kernel.org, viresh.kumar@linaro.org,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, andi.shyti@kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v5] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
Message-ID: <20260610142623-mutt-send-email-mst@kernel.org>
References: <20260610155834.79207-1-gavin.li@samsara.com>
 <20260610120606-mutt-send-email-mst@kernel.org>
 <CAKvMnUW-3b=cqHcozydnc6K1vD06FGk1ZO_q7S6SqhA5d8eR2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKvMnUW-3b=cqHcozydnc6K1vD06FGk1ZO_q7S6SqhA5d8eR2g@mail.gmail.com>

On Wed, Jun 10, 2026 at 12:32:42PM -0400, Gavin Li wrote:
> On qemu, queue reset is only supported by virtio-net.

Not hard to fix.

> If a queue reset
> is requested, the vhost backend is never notified, and as a result it's
> still at the device's discretion to write to the potentially freed buffer.
> 
> As for device reset, I really don't want to initiate a device reset just
> because a userspace process was signaled (it seems a little extreme).
> I can implement this if you think it is the best path forward.
> 
> Compared to the original patch of making the wait uninterruptible,
> I feel like this patch has become much larger than I originally wanted.
> The commit a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible
> completion wait") that introduced the UAF mentioned that it was originally
> done because a transfer could hang, but IMO this should really be fixed
> in the vhost backend rather than in the driver, mostly since virtio-i2c
> doesn't provide a way to cancel an in-flight request.

Maybe the 1st step is to revert that then. Up to i2c maintainers.

