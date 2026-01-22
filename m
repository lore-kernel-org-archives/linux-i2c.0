Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F60F34DCEE
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092579; cv=none; b=m10C3v92jKn2UoUCmyEN15+vEtI2vXON5PsyZiwgAEb6IjZUZVbkPmmdVYPkec71ek30GcWZUQ+x5M3M9j+arF5w9Btwy0y05ecrWilIf2Z8TN7RlpVrL3UJ3NL1iHE03osf01psoAGsnJ11ECq5wvQxILL5M4J9z4pQNIHZsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092579; c=relaxed/simple;
	bh=oUSkpNJmY0xJU72nm4mAJJRfKSHFJiXY6nI3DcQbCbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTO0y2UwGsG272GbLwrUbcReqqhw19PLPuqB36QqmfVV7i/Esw5SKwRHCV87M5HCSauI2DvQ1XU6B+eE6PnpwIYWJZbbrAtRg6YUjbLP8PZ4P3aE/CSlx1r1u4pJiciLn1SRN+WTa9pBP5mzjMhBYscyDZfIpJtXCA4yiMXOqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LG0gooH1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qz4xW+pK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LG0gooH1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qz4xW+pK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769092575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HsvOuFjLTr+YqXVe6RGyDhXEKiYKtBULZ5xPe6pwFaU=;
	b=LG0gooH1MtIy2ZzbGWnqifjNb6ro20OHFw1M9G9lxgTw77eznGoDmhPz8Ky9VOuH8DQiHu
	stuAYTiiNRwkSWB0VaVPK7h371XsPBNHBpagv+/iIRipQq3mbbRtqZYB0BO7en70PpJcDu
	rbrwxgSUziMz6mmcl1J4IYRP/9NTL74=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-hbNscIEAMM-r1Ht34-TURQ-1; Thu, 22 Jan 2026 09:36:09 -0500
X-MC-Unique: hbNscIEAMM-r1Ht34-TURQ-1
X-Mimecast-MFC-AGG-ID: hbNscIEAMM-r1Ht34-TURQ_1769092568
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-65813e881afso1134898a12.0
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 06:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769092568; x=1769697368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HsvOuFjLTr+YqXVe6RGyDhXEKiYKtBULZ5xPe6pwFaU=;
        b=qz4xW+pKTncxtM0SOGwG/aMPiDe/HhEW1KFd9rUOAzX0uWbAKTTDP4DEHnZeHJYPVT
         610KfFJjhxEOBgx9rtBZCUvjhonAjgtHIRCB5gasfIPmC3QEauZX4R1ozjTeQq+n371j
         WnRTmr+vfV8zgBZ0XTzKKWpBPkhn7TYiqneNNyxuo4dxZmqrG4tpnUCfG/9onO4Ehfob
         nWmdD+TCgi4AEWYCATRKofbD3lvP0I3UoCY4q/ij6kDXWkjN9i8J1StLu33Qmgxhq4tR
         z07LDbSomZL2694u7Zdfyl1fm9vZvv/dl4NxKpQXby5J2DjIDgzPMwZohbOePtUHEO4C
         pABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769092568; x=1769697368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsvOuFjLTr+YqXVe6RGyDhXEKiYKtBULZ5xPe6pwFaU=;
        b=LkQ69I0Rqit8/NIYm4dpWWBpZNeGMTGaxUTWQawO7MbokrCdoQPnubuC87y3ie7MU5
         arfIvz2CdlevdP7fk1+QWQ65AHrtJ8CS56xnk2sA2XTXPfApY+YeML/UIWtEi19HIuu3
         GpQrEQyJ7uxok195Ge7sIV+RA631DLBYbr4sCtVagvggCDpUVMY34S5U6adGEyCxyN8i
         aSR4SJmUTFFsbnMNwBS8kub1w8ofWkb3mstulfHHKkaqCTgba/lapa7OsMXysSMWfKZT
         SX7SeUYayXC7vnI3D1mSYK9zqC9dWDr27l2h/B3H+gr9r0x5A7DttudAeXznjInjG95f
         oEjw==
X-Forwarded-Encrypted: i=1; AJvYcCW0wlPCYGd94ta+RJu7HVyWVj0d1EAvPT3VVeQ5CzKzveDDfQuyqi4fjZ5PLyOP89EjQe1c8krwJE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjzIgtdqKL577RhIYusfXbua9AiBT+6V86x1seawTjgr1PMvbJ
	k0MhmwnuwFTx3ekNwmCIXvDKsbAIcvbzr69t+KfchqHkqVlU+BD9f+TiKhlhxWPF9+SMeuC7zr7
	TNfWo78EUQ48hbz/1YKLcuzmCjAEv4hMatnfCJnxzBGncTfMZe5mo8HfLgRKtJQ==
X-Gm-Gg: AZuq6aI1hC11CX+Frmy5/iiRNsie1vxn07fta9cmqPEhnLWlhNF+Pdej028wMTmyumL
	PAdl9z+gyO3HNRJvsVw2KPEpNoQx/vueopcYSDAb6nxtSdwtUOPSxxpKWudZ7svBkg4a593u8mt
	6AqmNsDQtvPuu74Pm7t4MRGLJEGV2tQ82LHoUjqI3c+scOX37jzOw9jS6P+NZbnnx8QZr4LQvsk
	h22YmX+Ihsb+Lc4eJt7STgzLsjBHY8jqyuelFSXPNEWE93EQOOVhTKSkShVIsbg8CT2wpSnC1OX
	T17rCNaaVfi7tYPfI7JRFIBYZ6l89bUEsj351yKT06PCzbZBLSYde8jC7zIFUFg6K1thjShijqI
	OqwclZRRhshVP
X-Received: by 2002:a50:cb87:0:b0:658:dbf:d1a0 with SMTP id 4fb4d7f45d1cf-6580dbfd2e4mr4103601a12.30.1769092567812;
        Thu, 22 Jan 2026 06:36:07 -0800 (PST)
X-Received: by 2002:a50:cb87:0:b0:658:dbf:d1a0 with SMTP id 4fb4d7f45d1cf-6580dbfd2e4mr4103583a12.30.1769092567343;
        Thu, 22 Jan 2026 06:36:07 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.175])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452cdb0e4sm15970133a12.13.2026.01.22.06.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 06:36:06 -0800 (PST)
Message-ID: <d681a9d5-ff37-45a0-8398-3e770052177e@redhat.com>
Date: Thu, 22 Jan 2026 15:36:05 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] mctp i2c: Enable SMBus ARP discovery
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
 <20260121092328.2308705-4-heikki.krogerus@linux.intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260121092328.2308705-4-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/26 10:23 AM, Heikki Krogerus wrote:
> Since the SMBus Address Resolution Protocol (ARP) is now
> supported with all I2C host adapters, every ARP-capable MCTP
> device will get automatically enumerated. Those devices just
> need to be bind to this driver.
> 
> The SMBus ARP-capable MCTP devices are identified by
> checking the interface (MCTP SMBus/I2C Transport Binding
> Specification section 6.5). The interface must match the ASF
> protocol, so all devices that use the ASF protocol as their
> interface will be probed by this driver.
> 
> Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0237_1.2.0.pdf
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This patch depends on 1/4 but it looks like it could be a follow-up to
the main series. If so, I think it would be better to re-submit it after
the relevant code landed in net-next to avoid cross sub-tree problems.

Otherwise I think it should go via I2C tree - and we will solve
conflicts as needed later on.

Thanks,

Paolo

