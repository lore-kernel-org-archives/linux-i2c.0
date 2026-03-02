Received: from mail-vs1-f73.google.com (mail-vs1-f73.google.com [209.85.217.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA93B7B7A
	for <linux-i2c@vger.kernel.org>; Mon,  2 Mar 2026 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483999; cv=none; b=bl3RsDKZ1bNwlfKVT5Q/pqsT9AizQgqYEdFzuCgEKvH4v4R1+GQjM6A1Xctb7p87pLZHYqWoDWJmo51TRjG0FFsqza8HLKB9L+FSQoYAaEARGUD9xes+me6sz6GDGSoEzhjPXBcL3k3hPseFhlAEqIK1OUlGL1WfLsr8tDlbXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483999; c=relaxed/simple;
	bh=OHbjNsMFJA4CoiDEb7PeLa9Dac39hTEz/JHm1j+wFEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ewd/mttNnKX7vWFZZgbSYu4K0PQDSzZ3BYVF6lFZ5IRg66kvjb9oPl2ecmsVobiJdUgb3yguxLv7HnDo7jHqE0TDvgPKDG0quzYOdvhJTmXmg+uVnEJHgoawf+PveA2SANKiU6RmGEZKMBZbFijyS+qavXfwLEqVZUkl1cDGb64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--moritzf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vnKJ6ZSS; arc=none smtp.client-ip=209.85.217.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--moritzf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vnKJ6ZSS"
Received: by mail-vs1-f73.google.com with SMTP id ada2fe7eead31-5fdd83e8edaso43861942137.2
        for <linux-i2c@vger.kernel.org>; Mon, 02 Mar 2026 12:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772483997; x=1773088797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3mmlBVt1FgEKATAP0PqgbanOKHO9lhbY7UtQbKGuGg=;
        b=vnKJ6ZSSPGfgfL7azIvFUwCQgJfwZUJw97YzB/Rxclzvau2aK9AGPSH1QP3ZC3JY10
         7iOtlJt5VkqYrr+i9VvGxHzreWC940TAmV9WQEwLyZnklg6yHg9Q5rUhO08MTGzqWAj8
         +LEAZcHIE5nvGR3bBJJszsgg1rY+cbS6zCj5tT/Q82+aCluZAtWa9xwkhH4XTL7qoUGv
         qra455gWrQYQB2PM9kykXUTLyBR4Os8o+eLRCDcJEiV9NLLrNK2kcIMdWrIY8k+0AFxd
         afu9yVWhxjifpl4FaiXRf7x5If6cuZJstFYmRGPPoIJ04f2hdY18iautmDSi/ZYaUw80
         BQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772483997; x=1773088797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3mmlBVt1FgEKATAP0PqgbanOKHO9lhbY7UtQbKGuGg=;
        b=jzva9wVEIYW+VdZ3rw7qOjFPR6DNa4Q/6BDh3TQqmgr2UDmIrwzbz9ad3uGfm25HHN
         jNNt8LgzE8UEwGp3AuGK8Cl+GyajdLT2BTCLyWKDDVC7hDQ1yx/fJzEvte3vhGvD2es1
         Cg1EkbNC3dtMJyv8rpln6YUt7P+NYpERMCU+MGIkOg1zsC1MbYD6ZzdwAsc95URACLC6
         tZYKrj0ug74ll8IaZ2YBYVIatsQ4qn5BTt57LTDkgM/4YBAsvguAzoVEonurDQT6u+Db
         +Ro71cSSmBt/VY8uEdsMdDxEzytD2QWDfXwZxwbbrao63qEgdgwNzwVAZSz3FAXeVYgo
         ttiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrd2JxMcoaRzrdyCUr9K1xv2mOhcPBLMKO38Rids6vYAvBVbYwtYeqZyJBqeK69Oyx3HLrBzOu7pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxgO3azAYob0nrLACffLpSxUqhZkKHrbCSQ/qtiksVPCrpMPME
	24UEsBVLyuCHYGJsCDzxGwheU6p7522ZsvBBMXDj4Gp1/m9yly1r64fj1YK1cl4HPuKcGwBN8dd
	x3tpj5btK5w==
X-Received: from vsbgl14.prod.google.com ([2002:a05:6102:644e:b0:5ff:171a:2949])
 (user=moritzf job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:508f:b0:5f7:2430:cba
 with SMTP id ada2fe7eead31-5ff3235e45fmr7008742137.12.1772483996644; Mon, 02
 Mar 2026 12:39:56 -0800 (PST)
Date: Mon, 2 Mar 2026 20:39:56 +0000
In-Reply-To: <aaVBg3tX8MRR9rZK@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227182308.776922-1-moritzf@google.com> <aaHnrj0onxlxH5D0@ashevche-desk.local>
 <ttbg5vcgzximy77bswykeprkl27hc2civnlpfwmgusm62wvzad@hvnapqphg6af>
 <aaLH0wYeUki0jqGc@ashevche-desk.local> <20260302053738.GO2275908@black.igk.intel.com>
 <aaVBg3tX8MRR9rZK@ashevche-desk.local>
Message-ID: <2n6jkrsxvtkcmbejvbrtc5iq6tidufu72j4rcfphf3bann5os5@u6ha46m4x5ph>
Subject: Re: [PATCH] i2c: designware: Add a new ACPI HID for GOOG5000 I2C controller
From: Moritz Fischer <moritzf@google.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mdf@kernel.org, ovt@google.com, 
	Jan Dabros <jsd@semihalf.com>, andi.shyti@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

On Mon, Mar 02, 2026 at 09:51:31AM +0200, Andy Shevchenko wrote:
> On Mon, Mar 02, 2026 at 06:37:38AM +0100, Mika Westerberg wrote:
> > On Sat, Feb 28, 2026 at 12:47:47PM +0200, Andy Shevchenko wrote:
> > > On Fri, Feb 27, 2026 at 09:52:48PM +0000, Moritz Fischer wrote:
> > > > On Fri, Feb 27, 2026 at 08:51:26PM +0200, Andy Shevchenko wrote:
> > > > > On Fri, Feb 27, 2026 at 06:23:07PM +0000, Moritz Fischer wrote:
> > > > > > Define a new ACPI HID for GOOG5000 as used on Google Axion.
> > > > > >
> > > > > > This has been validated on Silicon.
> > > >
> > > > > > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > > Cc: Jan Dabros <jsd@semihalf.com>
> > > >
> > > > > Please, put Cc list...
> > > >
> > > > > > Signed-off-by: Moritz Fischer <moritzf@google.com>
> > > > > > ---
> > > >
> > > > > ...somewhere here. It will have the same effect on the email. But  
> the
> > > > > positive
> > > > > outcome is the noise reduction in the commit message.
> > > >
> > > > > See also this discussion (patch 18 subthread):
> > > > >  
> https://lore.kernel.org/lkml/20260123113708.416727-19-bigeasy@linutronix.de/
> > > >
> > > > Ok, fair. Do you want me to resend or do you want to patch it when
> > > > applying?
> > >
> > > I'm not a maintainer, so from my p.o.v. the safest option is to send  
> a new
> > > version with all data gathered and put properly (Cc list, ACPI  
> excerpt, et
> > > cetera) in one place.
> >
> > I don't think the excerpt adds any real value.

> It doesn't per se in the commit message. I am asking to have it in the  
> comment
> block for the record (in the mailing list archives).

Will do next time. I think now we have already a record in this thread
that'll get archived.

> > Only thing that really
> > matters is that the ACPI ID is "correct" meaning that it is properly
> > assigned by the owner and that's true here. For the CC list does not  
> matter
> > to me but if you want to resend with that fixed no problem.
> >
> > Either way,
> >
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Ok, will leave it as is then. Thanks

- Moritz
