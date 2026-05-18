Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5FD40314F
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114157; cv=pass; b=myq6IJhEj1r3VkhL8ytw5KLQr2YKyekU7/G8r5kQcn9/8sZjzrNhP0iD2MtAChnSAnI6NUPB3cSzHc2nOiRxHNII29AHP4tKWl0vn2QTRqadhixdYgDKNNImkOL4I7gS4KVruc+ow00WiUYsvNXT5VASgmWVaqkLt1DNJB0yecg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114157; c=relaxed/simple;
	bh=6ZDQEOUD14QAFjatdvICgJqIwJxBsV7gED7tBhKefgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BG1RlZK5Ian6IJQMhcyzrwxg7nKKFGSLylLPD11eEckYv7ftA5zvjvLe8HWN2GS38pIfKiOaCj1ESThGROnhUBHdFlpCScuX3nCTXhw2pcjUhNJA+vJPpReC0jL3RnYq3vIQjLCZPlS8YvNJ8NnIvFdqIhPhtwktWlrvXPX9ZE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSgVCrvg; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSgVCrvg"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bf0b47d2f1so16284807b3.3
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 07:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779114152; cv=none;
        d=google.com; s=arc-20240605;
        b=SQ+87aWXJ954Cb4BjN8trE8KnYNlGsQJN+MrTxMrAqVr2yHPytwnav5EkYFAFbwDqO
         TYLsiFIcZ78aQC5+69342A5/nMk+DOAxNgrEtP5kRSL+UwWoJuv0GoJxU7Rw1ylmvila
         RpTLVSNgGn9Dvr+vtzgQxolMTOHD8K77Pj6Fzqqy5Sq+uYw30bo5QZVRXYNg1Gjh3NN7
         ur/JAI2yfjq1eWqI3lQJLqahqkhtlyHpVeT6LP2jnB7/fdWh5P2VH/qjqt50YqiCcIN6
         z5/4EMJSn7rEV6CvX1chIuC4j+UjLfzKUfZLXw3/zojqtCcNWxhVRnx45ubxPrjPojpv
         5iYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ZDQEOUD14QAFjatdvICgJqIwJxBsV7gED7tBhKefgQ=;
        fh=jPPtUpoNiRBImFa0WGLq0C5ZXTQfhySd9btdfiznfaA=;
        b=cLOs5fyj9R+dFgTkcsMcvsySstYCyDWLXntVCRRdQd5ZBtlH3hVzab2pfnhwfUgFkc
         MbG9LU+rDwKrhGm1cpYly+lJOpM09liCh9wq1Bh4dXcH1DgvNq/y6TNT0V2GPeqHS0aw
         So1LMxsMj86WaFWXmwcEJyVpH7XHv+KKVfEj82CsV16b4rY2vL9tkxV0ZA/9ywizimL6
         qza1uZJzRXM+FDE9RxLlq1DOu4CCQJIKRPUCwdAGW9QBn/FGk4p96SOerGnKN+1pbxa/
         QwX7orN+W9Nu0FCGINAvjOZvw8zQ+mkZ+z5d5L+K3VtC7OSxURn2chepjU5QZ51R7CxL
         nC5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114152; x=1779718952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZDQEOUD14QAFjatdvICgJqIwJxBsV7gED7tBhKefgQ=;
        b=gSgVCrvgutC40EhKc9Tc6XyY9CyO11CHN7W/iEzyXY6ihrLbeLa4RaFgqN56Sty5Xt
         s0A08DBqfjVAoZGHuUqgGD2vfOIZdDSrz2wxrmrl3K6awKaDLo9+Pi0SGKjbzxOD1k37
         Cs4+MGame0kXgoYPRdQGtvqKDBNR7OEiJIg13id6jsg/Qt6wAyZcSDqSf7AuuyDI726w
         961lAAiTpf1r8Q7uAk2nDUXGkuTxl+3CuoKOuSR2cSDiLXSJZl/WhE10lWzWqFyhdRwj
         v2x0YwKrMa0g770RqaSgZ4zTsM8nrHb3508FL0R96ku8auDId1fyxKjjuqhSXUwYCiF/
         XwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114152; x=1779718952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ZDQEOUD14QAFjatdvICgJqIwJxBsV7gED7tBhKefgQ=;
        b=PRjwvHztGCmyl1Yl7nqY8Xn+aaLOxFBAOdyQFQfPALtFhp1aEt1Zt6eznUktsGkvEh
         87/Uip0+eDGQ3/MwrPfvjpKZAylBAOhsqHYgpdUuAOy+Bm+x0fykxt38KLXBXqUsPWYz
         2vFoUQ+6c4fC78p9pKKPRCMZP2relM8/7xFznCmpq/0/gQ5OEywLTFiRmR9REdTziZyQ
         sM7KmflvgDGYflx1BhhV4kOe3dz21IuPv6KZiS1v3nv1JpIjr2OIGXpH7XkgpA6trQty
         cGNPRZNemH6h7xk1K9+Acw/rMVK+vtQaUflgIKaTvpWAvjRYpljOVcsi4SOEn9YYrZj9
         ibNw==
X-Forwarded-Encrypted: i=1; AFNElJ9ONwVZtFOtQUBZz/M0Tps6ACWCqb3XT4hoABRP0Lnl+YKh1rzVuGsMXCp3IANMIoc/QjtH37C7W3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCArQZ9i4XN86iwmJ9h2Ogk15YKkU8rNGGYDWDn1bbrnDz4P54
	Q4LfKRLnMI/qBlj5lr9yv5ZFyx64VhnbGPQ81bbAdqzBRwviXN6BowKjQZUhLuCWC9cuVsjRhjN
	MhQHtE2XuQHrPx7I7icw9wifHz+yUICc=
X-Gm-Gg: Acq92OEU96vvvpkZhEl/ei7GvF0/PPGthFpbUysNcndavvWD1BgCeJPjWCj4EAUf21X
	cZpNbfEe3xMdXq+NYQj0KOD2NL0AjgqHWWte0DMXwJt528ar4dyormK0mstLPK324/aJxUsCEn3
	6TgqC2atWDdC7DnSV/cqihGbY7ed262llgaPVLxrVzHslVMFt3kYfGLKAI8N86bjsMA740Aw4AD
	bj87kPs9qrwCp6fb6ydoPKD4XpIeotTnVTuZBZwVSyBKgLVWafV8IDBXjiv38m4ZKxD3JiJR5R7
	BIEwiUyWhZvfaUKR+rvsO9intq7Gmre6gErIh8C/MQ3X9rYYJOyP6aLtUpeB+rNAQ4t1zMQuqfh
	yuEoVrfMkt6Q+ZPcUUO0itwrCZGLSCV+hEaVZhXfGSqMY7EYN552aolDw+t4=
X-Received: by 2002:a05:690e:169e:b0:650:36e6:2ace with SMTP id
 956f58d0204a3-65e227cffebmr15679127d50.31.1779114152259; Mon, 18 May 2026
 07:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518071816.26629-1-hardikprakash.official@gmail.com>
 <20260518071816.26629-2-hardikprakash.official@gmail.com> <CAMRc=Me8ieVzXojZ=eNhBPvjjmT5gc6hJXnpC8Bc6WofDbXP4A@mail.gmail.com>
 <CANTFpSU_Ba1c_R9wbjSSqnc1+_vBMAOKDvD=EVtct8hWU+Dxqw@mail.gmail.com> <agsc0NoznnVtclk0@ashevche-desk.local>
In-Reply-To: <agsc0NoznnVtclk0@ashevche-desk.local>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Mon, 18 May 2026 19:52:21 +0530
X-Gm-Features: AVHnY4IGC6Vo6EpyWksUrgKqCXj97Ps2EclQ1nL4YrIUR0jWruOH719GOkgZe4c
Message-ID: <CANTFpSVJ73_j6NqDYXPX8Db4+KN74qJvo8MgdsFAy5HhZ3xScw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, 
	wsa@kernel.org, mario.limonciello@amd.com, basavaraj.natikar@amd.com, 
	linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 19:36, Andy Shevchenko wrote:
> Don't we have already force and ignore lists for _DEP somewhere in the
> drivers/acpi/?

Yes =E2=80=94 I found acpi_honor_dep_ids and acpi_ignore_dep_ids in
drivers/acpi/scan.c, and an arch_acpi_add_auto_dep() weak hook that
RISC-V already uses to synthesize dependencies not present in the DSDT.

However, the DSDT has no _DEP object on AMDI0010:02 at all, so adding
AMDI0030 to acpi_honor_dep_ids would not help =E2=80=94 there is nothing to
honor. The arch_acpi_add_auto_dep() hook could synthesize the
dependency for x86, similar to how RISC-V uses it for IRQ routing, but
it would still require DMI-based hardware identification to avoid
affecting other machines. That is a different location for the quirk,
not the elimination of one.

Unless I am missing something, the driver-level deferral in patch 2
remains the least-invasive approach given the missing _DEP.

Thanks,
Hardik

On Mon, 18 May 2026 at 19:36, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, May 18, 2026 at 05:55:02PM +0530, Hardik Prakash wrote:
> > On Mon, May 18, 2026 at 16:24, Bartosz Golaszewski wrote:
> > > The patch looks fine but I too would prefer this to be handled at a
> > > higher-level. If we know which ACPI devices we're waiting for and wha=
t
> > > the ordering should be - is it possible to somehow setup the devlink
> > > for the platform devices that will be the children of these ACPI
> > > devices?
> > >
> > > If that can't be done, I'm fine with this as a workaround.
> >
> > I checked the DSDT and the kernel's ACPI dependency mechanisms. The
> > DSDT has no _DEP object linking AMDI0010:02 to AMDI0030:00, so there
> > is nothing for fw_devlink to act on. The GpioInt resource is on the
> > touchscreen device (TPNL/WACF2200), not on the I2C controller itself.
> >
> > Setting this up at the ACPI layer would require either a firmware
> > change to add _DEP, or a DMI quirk in the ACPI scan path to synthesize
> > the dependency =E2=80=94 which would be equally quirk-based as the curr=
ent
> > approach, just in a different driver.
>
> Don't we have already force and ignore lists for _DEP somewhere in the
> drivers/acpi/?
>
> > I'll send v5 with your two style fixes applied.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
