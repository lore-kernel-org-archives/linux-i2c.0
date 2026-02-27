Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE02A2D73A7
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772229174; cv=none; b=gmorbRdnUQcZpI5FfLdPRqIlMyCk8HVubrEnqvY7QiBzjbaTiTLVK6PG8IHgO0Y/CPuS74zpk4wJ8UUyC1T6aiXIxeS2v7Y1gyYkwLPhSJJCP6whQjVk96QkViftaPfd/6rqpzLVzRGVwazQvAghWGBJ8aF14if9lpfQsP0lpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772229174; c=relaxed/simple;
	bh=gqF0BJudthA9dStV3V7Dh43+zgLPENI2KlwAIr8CIAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XFsRU8DiUR28+5/OOzK94KOc3WVxhBQUOfd06iFp/0NbzEFOnRNwqvIVg4b//cwM2V3xBS4to7FhMF9GL0QrCTsmZibn/8aknjVLXXYZ6mdLtOi0TW3E7WghOCEIdGTR3JcJ0ceHM+oFz7nFKArLP3zkyUkLrl8SRxKhRZauD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--moritzf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXhSbjc8; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--moritzf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXhSbjc8"
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-5ff0eb3ff4cso3236965137.3
        for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 13:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772229170; x=1772833970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfybHYyzKoIKrdPG6uM2F7ngr5CJPctlBojQTg/sTcU=;
        b=tXhSbjc891bbRUEuYafnf+1mDPcMHn70kgD76C9prGLg4AkzsRaEn905q1VrU2ndK3
         Gzk2qAWERRm4OxZK9Ya5u0658ydywSa9ry1Xs8z+NVG038R8uf0uTYYDKRrkMKehBmmC
         /z4owigOdyGum3CEks0UO4MDqS20FvFu9wPRvJOYpxoZvoaxxX80jzsA1iXDtoy5gbdy
         rT9KuGRF1EIZD4fIRpCxx9zGmlldzNgzqOdTxoKOQT2Z9xfdSoiNo85E5lCY651Ngy31
         34jrXnqEOn2tZAMsLy9T5/oc7Q1UsJNsI59sZq7xFfOKdBoU3vsts2z2ydBW5GY2Qf6E
         MFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772229170; x=1772833970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfybHYyzKoIKrdPG6uM2F7ngr5CJPctlBojQTg/sTcU=;
        b=weBKSAU18O5MoQrD7RCW/3DkixDMq6V6E4+Q1Yd4hYW4/rj1dMHcPz69XuHvsO1jq6
         VJxjxDIA6IMAY+kdAaPI/uqfJOZxwwgsVG+5Srwb4I9TOui9iCvng+tUN4vuV8ZaD1Na
         MsNfhdrwzDJvYYwAkZEB3Sh69lKrLmckk9pKemEYxVhw43QZetwNuUdbL0mjXuXTR6ab
         x5AIRQ6QK101CvBWbKJdW/kMVa0oqwPR3oIn7x5f9UYKCcFmvNsc/OgjJ6V7nwyxiSf0
         OScyv4otLkYE/dXjsXYxuHtGZQ6krnRHZ02emeDJ/RmQPzDytnHWq0lp/dURbVvbcKIj
         zpHg==
X-Gm-Message-State: AOJu0YxQSCu+6IjCbUcuQvKkgeP0lww0BMchDZzj/elBt4h517yP+Eqr
	yvvVNmlgV4aRC/EHX9NgqU7jrfBi0LyIL5bvotwZmrkgQ7dMu8uOGtLiANwFUq2/IYwS3W7ROXL
	v15q6PPHCFQ==
X-Received: from vsbha25.prod.google.com ([2002:a05:6102:6899:b0:5fd:ea94:557])
 (user=moritzf job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:2908:b0:5f1:72a7:f879
 with SMTP id ada2fe7eead31-5ff32511fc5mr2356536137.28.1772229169392; Fri, 27
 Feb 2026 13:52:49 -0800 (PST)
Date: Fri, 27 Feb 2026 21:52:48 +0000
In-Reply-To: <aaHnrj0onxlxH5D0@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227182308.776922-1-moritzf@google.com> <aaHnrj0onxlxH5D0@ashevche-desk.local>
Message-ID: <ttbg5vcgzximy77bswykeprkl27hc2civnlpfwmgusm62wvzad@hvnapqphg6af>
Subject: Re: [PATCH] i2c: designware: Add a new ACPI HID for GOOG5000 I2C controller
From: Moritz Fischer <moritzf@google.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, mdf@kernel.org, 
	ovt@google.com, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Jan Dabros <jsd@semihalf.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Andy,

On Fri, Feb 27, 2026 at 08:51:26PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 27, 2026 at 06:23:07PM +0000, Moritz Fischer wrote:
> > Define a new ACPI HID for GOOG5000 as used on Google Axion.
> >
> > This has been validated on Silicon.

> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Jan Dabros <jsd@semihalf.com>

> Please, put Cc list...

> > Signed-off-by: Moritz Fischer <moritzf@google.com>
> > ---

> ...somewhere here. It will have the same effect on the email. But the  
> positive
> outcome is the noise reduction in the commit message.

> See also this discussion (patch 18 subthread):
> https://lore.kernel.org/lkml/20260123113708.416727-19-bigeasy@linutronix.de/

Ok, fair. Do you want me to resend or do you want to patch it when
applying?

> >  drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
> >  1 file changed, 1 insertion(+)

> ...

> > +	{ "GOOG5000", 0 },

> The ID seems legit, but we need an ACPI excerpt from DSDT to show how it's
> described (just important pieces of the respective Device() object) and  
> better
> reference to the device / platform in question: Is it already on the  
> market?

I pulled this out of the EDK2 code, I hope this satisfies your request.

     Device (I2C0)
     {
       Name (_HID, "GOOG5000")
       Name (_UID, 0x00)
       Method (_STA) {
         Return (0xf)
       }
       Name (_CRS, ResourceTemplate ()
       {
         QWordMemory (
           ResourceProducer,
           PosDecode,
           MinFixed,
           MaxFixed,
           NonCacheable,
           ReadWrite,
           0x0,
           0xA02048000,
           0xA020480FF,
           0x000000000,
           0x000000100
         )
         Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive)
	{
           109
         }
       })
       ...
     }

This is being used by SoCs powering Google's Axion product line.

I can't go into more details on timelines etc, but they *are* real
products.

Thanks,
Moritz

> --
> With Best Regards,
> Andy Shevchenko


