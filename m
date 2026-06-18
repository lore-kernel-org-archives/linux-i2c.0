Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B5C3783BB
	for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779194; cv=pass; b=IaFF1SELNRgLbV9yPAU/d02KXsdKiiQQe6zPPzg8k92P3BbzK43nIWvsoapNA4ex8YCwy9G8jmL4ASHj/FxrssVbCXlRR4Hy+7Kiv0VclE0lGtqQpq/WIKp3bz2G81DmQRYk3cJrfwKpLNcjryZxSpa/q0V79nSGHaXTdBNX6mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779194; c=relaxed/simple;
	bh=ehufqD82P2Xg2H7xsA1ovgl3kND+Ns1MIr/OvaHbXkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fa6cY0EHQG8QNzzlnFvy0HPF7tHm5d06wdTvFUB513wXFnxsguSAN7GB7RzSBbbMm8ngYRQuKXrPL6D5azhgL0fljqdTCWQNEGtjPrwqQ+1Q99qf5jDCEpH+d2gYh96Zd3l1sTIncOq7Dyjw5akZ8l9j8N7/PcSE6AJPlrvif/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxfEbRQM; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxfEbRQM"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6607e80a846so809034d50.2
        for <linux-i2c@vger.kernel.org>; Thu, 18 Jun 2026 03:39:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781779192; cv=none;
        d=google.com; s=arc-20240605;
        b=DQB0wWnQnHYD6U5MrBdG3eW+y+ybR1EHKMEIKoxjyYY4geFOosvhU7u4cPY0Irc1sG
         EY+xFZLY5xCJraUFc37jz6O9AscTt8yKsuQGDgyJdHrnQblArZITeH07TuUQ9rmWZeLR
         9c2KG9evmbBt/J8R4ntexjyFwZNLX8g3lZYf4E8xgCB+sX0lKhY5ANELbX6+dkNZNkd4
         AdGk5hEgBED1Nh2gbGnM2QhLN5hS/d6BFSncZKPBVYcsCECJcZq/gNsgnp5RszrOQHo2
         vubSkn9pxZS4ENcivCaTZ8TnDUy5cIOk/4ZvuZyiZPtW/Fj3Edsem3sa7b0x6B2QrCtk
         FgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xrAeCKH9AjGdzze7EacqS7shhI047hzpN7Ihbsp4CmY=;
        fh=adlfq5vem7a9qUlFJy/Rg/TDNX2r9ReV6/uhR9RNyAA=;
        b=ZWhR0yoIAdDl5w4Ksm9tOD+emgGld4YG4feWc36sCiZCDOIbNQgIVXV53pORzTXhdV
         //y86a0kE+NYehCEia2cVTZ/srl1EELLT4mQybPv4efTThhrnTrRwbmJ/w4lQ/mGvNl0
         TV6IVELxVP9ECsjagOXXrYS9kGR+gHHwV21i5NVgh8Pgu2r4GLXRVIds4tkGe7dUpgxD
         hJyYfZv/gVUcYS6DTkRmRgRky8BwLqqLFD6zI6q/G5gBDRmaoqKsiT9Fyvnzv+qONBvL
         Sulq4H47jG5xucBxd7dpz9Cb2StxXfdPSHOZR5vXKQhD0XuN6uM7mJ2BZfpOxt0eU4/e
         vUrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781779192; x=1782383992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xrAeCKH9AjGdzze7EacqS7shhI047hzpN7Ihbsp4CmY=;
        b=XxfEbRQM7JJ7GP6Jqv8/+j2XqaNHJvEKRCWb1UNq/OY328xnj7+h2RYFpHsgvBMn1t
         80TNIB/izjtDbvwG3220wgegPanOEPOgfDm641GUwg0w9WxvNBUuld3mUlD78geDw/N1
         H/DCTriWu4Zu0A8bzCt2hymioBjs3GaN698NxR94z7K9+4HsAy95c/pQfjR9MLnqyr1C
         eXwLMK9vCda+AZomKxUY5sFyKYAlvwVCEeHHMYoXLY+rQltmvsDYiQbAvj25/bVaa19X
         GkK0mCrGEaQlaMeH/uDE4jkjmwXvihB9/KEtDGawLJLbIvatY0gMqCdDt/iveqp87qRM
         KIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781779192; x=1782383992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrAeCKH9AjGdzze7EacqS7shhI047hzpN7Ihbsp4CmY=;
        b=WhQO5h0wZCNHUo+7ebM1xAO9lkB23/0DHaz1BxTb79+0AkrlIxGQpy4b5FH76+fa6g
         cagbA2KLSjVV7dxHZsPvaEBGwi97cRHIeN7XcoTYLDxkLX4woexbBMIYszu2tLCeY5zi
         jvhXSCObAYzPaWQbOtg7zV/cno2vVl9LKNwekF/XcYqhsuHKnxAdRMNrYIlooSYG0IFe
         TU7+LZlXKoXoD7OUrKCWtLV086fZcXcLTEFhLUwLujDSwUMxduRNffgdsktCnc8yOUjR
         m7E/k3D7jy5PLI/zqroo3W3QYzUDD90ruxkhRfuZHOg+8mcG4iqO2l1YDnVhb+y1gmP9
         GokA==
X-Gm-Message-State: AOJu0Yy7sI+cnBPp1q16CMBoqVCzxaPm7QqRj9xSpwmEUkdNca8ZFKCo
	deQ249SznJi/fPkjemXWUTdyHdyD/lkNDa4SZH/TiqLzl9nsspEi8TPXF3lcIYjnRUnsdtmWQwm
	U/VaLpAPgyNO2ulycG4qFp1pd6rRLbL4=
X-Gm-Gg: AfdE7cnbP2So6dF6jz8Fs+PqF8PmIyuvU79MifsKZu2o2E5F8+HTZGKvQErp63V5thE
	8exUSAujHP993mhRPpgflseBOVz6kZkxMwDB2/4Y25qMRPedXxU9Hm/vr9vhwxhD50N0wO0NUIv
	Yi0tBa/QAMJG0nT5hu5B29Sw0l75fSYkgnqk/YgazlHeV2o7rJZErKk/pEekihAylCrP4EDTmut
	i2jPWsG/zElh8aJsHsYKSaKo6V6IUFs7oOs6MjSsvLe+pxMptONc9uQbmF+syNj8jKaYz8emYQe
	9znHqlgsQUFqa0sXQAPE23Zr8J4OLtKpRDjbqEMHfWpTjYqqMwP3Ee//U52NGU/qdhuLexjd6p3
	Xzr5dKzwtE9k+JL7Jo7vDkzcpNPhmTIn5/JpJnXVA8WJJdBKGyVUZgmigZA==
X-Received: by 2002:a05:690c:690b:b0:7dc:4b2c:58d0 with SMTP id
 00721157ae682-7ffc56432c6mr27548967b3.16.1781779191967; Thu, 18 Jun 2026
 03:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617065922.26004-1-hardikprakash.official@gmail.com>
 <20260617065922.26004-3-hardikprakash.official@gmail.com> <ajJobvY67HKufaTs@ashevche-desk.local>
 <CANTFpSUSKwTj-z0E2w3C_8ue8wANE+dHtDKboZ1+rqwN98C3cA@mail.gmail.com> <ajOWV3apVXOAHcYT@ashevche-desk.local>
In-Reply-To: <ajOWV3apVXOAHcYT@ashevche-desk.local>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Thu, 18 Jun 2026 16:09:40 +0530
X-Gm-Features: AVVi8CcfXuG1o-OqAlZC4gFYJ_kh1KlTBRRpIIDToe2l8F8PIwS0sHJDO8ZbHrU
Message-ID: <CANTFpSX+c0j754dekjax4cWZV5rk-B19=g2mi30WFddfw=212g@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] i2c: designware: defer probe if child GpioInt
 controllers are not bound
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linusw@kernel.org, nathan@kernel.org, chaitanya.kumar.borah@intel.com
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 18, 2026 at 12:25, Andy Shevchenko wrote:
> So the question is, do we expect the resource_source not to be set at
> this point? In other words is there any valid AML that interpreter
> decodes to the empty resource_source? If so, can we ever have the
> following condition to be true?
>
>         string_length != 0 && string_ptr == NULL

I checked the ACPICA parser in drivers/acpi/acpica/rsutils.c. The
acpi_rs_get_resource_source() helper always assigns string_ptr before
string_length when the resource source is present. When it is absent,
both are cleared together (string_length = 0, string_ptr = NULL). So
string_length != 0 && string_ptr == NULL cannot be produced by normal
AML parsing.

Therefore checking string_length alone is sufficient:

        if (!agpio->resource_source.string_length)
                return 1;

I'll simplify to this in v10.

> You haven't replied to the rest, I assume you agree with all the
> suggestions?

Yes, I agree with all the remaining suggestions and will address them
in v10:
 - acpi_dev_get_resources() on single line, free only on success path
 - Reversed xmas tree ordering for variable declarations
 - Remove useless int ret = 0 assignment
 - acpi_dev_for_each_child() on single line
 - Use guard(device)(gpio_dev) pattern to avoid uninitialized variable
   warning and deduplicate the !gpio_dev check

Thanks,
Hardik

On Thu, 18 Jun 2026 at 12:25, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Jun 18, 2026 at 12:52:46AM +0530, Hardik Prakash wrote:
> > On Wed, Jun 17, 2026 at 14:57, Andy Shevchenko wrote:
>
> > > > +     if (!agpio->resource_source.string_length ||
> > > > +         !agpio->resource_source.string_ptr)
> > > > +             return 1;
> > >
> > > I'm wondering if we simply can move to strncmp() instead of this check
> > >
> > > > +     list_for_each_entry(ref, gpio_controllers, node) {
> > > > +             if (!strcmp(ref->path, agpio->resource_source.string_ptr))
> > >
> > >                 if (!strncmp(ref->path, agpio->resource_source.string_ptr))
> >
> > Could you clarify? strncmp() with n=string_length would protect the
> > dedup check against a NULL or unterminated string_ptr, but we still
> > need string_ptr to be non-NULL before passing it to kstrdup(). Should
> > we keep a NULL/zero-length guard before kstrdup() and only replace the
> > strcmp() in the dedup loop with strncmp()?
>
> Ah, okay, you are talking about the first iteration when the list is empty and
> we have to add it to the list.
>
> So the question is, do we expect the resource_source not to be set at this point?
> In other words is there any valid AML that interpreter decodes to the empty
> resource_source? If so, can we ever have the following condition to be true?
>
>         string_length != 0 && string_ptr == NULL
>
> P.S. Do not top-post! Reply under the piece in question. Also remove
> the context you are not replying to.
>
> > On Wed, 17 Jun 2026 at 14:57, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Wed, Jun 17, 2026 at 12:29:22PM +0530, Hardik Prakash wrote:
>
> ...
>
> > > > +static int check_gpioint_resource(struct acpi_resource *ares, void *data)
> > > > +{
> > > > +     struct list_head *gpio_controllers = data;
> > > > +     struct acpi_resource_gpio *agpio;
> > > > +     struct gpio_controller_ref *ref;
> > > > +
> > > > +     if (!acpi_gpio_get_irq_resource(ares, &agpio))
> > > > +             return 1;
> > >
> > > > +     if (!agpio->resource_source.string_length ||
> > > > +         !agpio->resource_source.string_ptr)
> > > > +             return 1;
> > >
> > > I'm wondering if we simply can move to strncmp() instead of this check
> > >
> > > > +     /* Skip if we've already tracked this GPIO controller */
> > > > +     list_for_each_entry(ref, gpio_controllers, node) {
> > > > +             if (!strcmp(ref->path, agpio->resource_source.string_ptr))
> > >
> > >                 if (!strncmp(ref->path, agpio->resource_source.string_ptr))
> > >
> > >
> > > > +                     return 1;
> > > > +     }
> > > > +
> > > > +     ref = kzalloc(sizeof(*ref), GFP_KERNEL);
> > > > +     if (!ref)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     ref->path = kstrdup(agpio->resource_source.string_ptr, GFP_KERNEL);
> > > > +     if (!ref->path) {
> > > > +             kfree(ref);
> > > > +             return -ENOMEM;
> > > > +     }
> > > > +
> > > > +     list_add_tail(&ref->node, gpio_controllers);
> > > > +     return 1;
> > > > +}
>
> You haven't replied to the rest, I assume you agree with all the suggestions?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
