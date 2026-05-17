Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1733F5AB
	for <linux-i2c@vger.kernel.org>; Sun, 17 May 2026 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779037751; cv=pass; b=Ovvc1BhMN+oNhM7K3/2zYkzhM83OxIQ7Ao7rWhZhj4fvIJc0TQUo2Gf3su0RjfojPlEIPXQ54tuB4/nSaZnlDr8BF4zps5dOCesul2+TWkjW567e5lbdXol0edh5VZVwHkNdM2V19fm0mMLFvdbn1OU4l2HH9JuMnx2IsYq1Gnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779037751; c=relaxed/simple;
	bh=gR7yXaMbFYnlgjumf6OzkaSf/fm5FQpc728TaerBcYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENcGKhVWSaaXtGjO8WIhdT1YBhNH1Oq0R5Sbc13JBwoA1mJZK9qxQkHmYKJxMzf0HizaOfg87ikVgnnI1LzaxDv7qlwgf1fZ4g9hocpl1YWzhGxHBKx5IlnnYG+0pD/EfdYr4g9cTES9RIsWrLTWRDaPmTNMxPfPpW0qOnTbatI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7ZYzflP; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7ZYzflP"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bf02533706so8427987b3.0
        for <linux-i2c@vger.kernel.org>; Sun, 17 May 2026 10:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779037749; cv=none;
        d=google.com; s=arc-20240605;
        b=lJAAhRi9M7Jo8oyG/m2bQ5Bw9bRZAegJf7S29VXi73gxeK3V6uKWjEMq3+dBKV2lNP
         5MOrBkh8s2CjQImiTrrUVdZCb4n5vH5vY5KMBacVsf7nswO2ylUtYUGsXvqoPPrxKGjJ
         vJGP5WvsxNtz9tKqVhgfbpY9z32DfcBDpIOmigtWET0GFdf90+ITAyxzbMx6EgciU/jq
         5zes0+vrrHwCPsUm6BrBZ2KU7YJc07RAfLgjscaNiAIw+DDnFPNjLCuF+t4hBHeNGzg+
         ByhfXH9PlFRQ0ANmL3kuCXwrMu/eymWpZ/gwQyl6ngD6gu9dzMmsOYXmfCzJ18Y+eyOk
         hqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R2WC/h6pAzuRmbcYX3EI1ehtvQRlSkP72sx7+fUup/0=;
        fh=rQRgqW1Vy4FSJmed0EXb0sZeDGDt0y8JP+9lcx/MRNw=;
        b=Rx2BPfaFlqKpfLDPDgeeCztXdNK5H4WhKs3BzG5KavOwJP0uU67BRED1nxHhCiAOV/
         Ci90bDQmOAefSjbm3Ab3vyuprCFulCMKOJbSHCI+lXFFGwNdccCuYPCYZoGCfQfbiiCC
         jd31q+1l054uI09o6UpE2JlyHdGXlXdHslMQqw8akkex6QsptZs78sv6zKmvc6PZNdI3
         zl6dLBYKMGggShzP3p6H6NFP1saAAQZpvvOV3UNwcHv/2OoBNktTcYjS9N1WzAEQaUod
         DrByk36OgAZchuroupz30y/u/ilnqbZGgh406qjfBUD8BcWArB3BiiPeXx1BBMzObsT7
         2+kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779037749; x=1779642549; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R2WC/h6pAzuRmbcYX3EI1ehtvQRlSkP72sx7+fUup/0=;
        b=F7ZYzflPmc5/sMLk5hNRCa6zuxOmGTYYhlVJ6TtAdFMNyDrZWIUYz57zRL/utm9M5P
         d0HGhfa6GH1Smz0D6/QKq8rCxmL4JbfV68t5t4FZO0dhjr/ZxchyGqn9/XFcRZxyIyK0
         O0Js8o99w1N5eR722lGjdDxDvRjUaY/+w2wEdGAZbKGsw0T3P4fLqaILbTuGBVFg7rJ9
         ATDpGrn+Dstm8sD0xi1wRwuyaGuToTKM8sCrGzSQXv+Vz04dZ6lQI0ZY1fEmqb5rjG59
         Xh9W2sPVQFsRJAOnRSEP82Hy7cA1kTlS+/rh8Ef9nhKcgl4AmaNKBoldxC+W7uvHK3yW
         zJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779037749; x=1779642549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2WC/h6pAzuRmbcYX3EI1ehtvQRlSkP72sx7+fUup/0=;
        b=hiMcOfBOVzpzw4J3O2nDfV1LEWb+F7oHZUtBwLcZOWQ4kba6/2CWmrzfaFnFYlP/pc
         r5X+/7AQAzltouiDNlul8vfTOfa/WgrgrDsM8HvVfybLGuU+fJ3NLaHGwhz16PkU6X4w
         0ZvBjQoGWdpVk0Z33xhDvY3VINZ/vXeTSjjUJBUotwd8mHo5tZbwz5/I7YPjZPgazigx
         USDs68/4VLSN4DNsdgEmDCMvxKXrVN1+vZQcSAsmnRSZTtb5Q13SztRc3bUwMfI2NQCL
         m1QYYDb2HChbI2gO3BNeaMilNoD7ei4i0tA7Xv471gWAxTUIbl1QctBfWC/+gOZOyXjb
         6Gcg==
X-Gm-Message-State: AOJu0YwRm+7KdpWqaPSMnSMHGcEy46j+DKMypN8cSY4RzZMQnOKbrril
	KT7/GomVR/jkbx1Buh5Gwjr49XBCbq/Mhtc0k/QvcN7E6nlnjL/DCAhc89aHZDCXQOdHcaswIkB
	5D2/+wx0uZKkHGfyIJpEC4ywH4gBIhyA=
X-Gm-Gg: Acq92OE/umygkKtRcA/SNaw3fAQYAZt9EMlsaJLJ05noVl+dZSaCfu78H0gtSZTAjnE
	nwuEM/pTdmDkAJJS4p8timZSBLu5yqJBwAFV3OZASCzvooUEuzsfp5Cbbv6ORODIdWj9/HO9rla
	gVGqvoaO/E11dD+HyM8fM76eRUOWgVP45zB02jALnNKpEOo5EWjfy55VUvKHHL8dxsubJKKFMKt
	jdoZwyrorBFAbpEGGePbkek71UdaX1ukratwFOY5CV9nSw0lh9TbF9zooIQqWEKycX5+ENqVMPG
	y0ooMiNLSw0Rrxh6WEnuBlZh2DVJL0o3Xbrflwl0hiWSq7shmKx68R5cUDR6uIBS2IrWLE5QVUy
	CwrXavaa9q5QCn4ELRjTeKQttpOCTHQgdeRa4LFOKj/x3NViEOn27ULWKhyC5/lUJ4s7w3w==
X-Received: by 2002:a05:690c:60c7:b0:7b8:5f91:65b8 with SMTP id
 00721157ae682-7c9594b35aemr118510287b3.9.1779037749285; Sun, 17 May 2026
 10:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515161516.10474-1-hardikprakash.official@gmail.com> <agmPrF0IClOpDYlR@ashevche-desk.local>
In-Reply-To: <agmPrF0IClOpDYlR@ashevche-desk.local>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Sun, 17 May 2026 22:38:57 +0530
X-Gm-Features: AVHnY4KTSGZpReqSZufyItdUPFDwVE4MyKIswJsHjhtLSg9CO2F4KFhunkJduvo
Message-ID: <CANTFpSWMjz-V_oOsP+7Ww57vhdDVwq0nJ0icQnp3qSq7-=yFRQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Sat, May 17, 2026 at 15:21, Andy Shevchenko wrote:
> On Fri, May 15, 2026 at 09:45:15PM +0530, Hardik Prakash wrote:
> > v3:
> >  - Patch 2 only (patch 1 already in Linus Walleij's tree)
>
> The patch numbering is broken. Where did 2/2 come from?

Both patches are committed in my local tree. git format-patch counted
both commits and numbered this 2/2. I excluded the 0001 file from the
git send-email call since patch 1 is already in Linus Walleij's tree,
but the numbering carried over from the two-commit series.

Apologies for the confusion. If preferred I can resend with 1/1
numbering by dropping patch 1 from my local branch before running
format-patch.

Thanks,
Hardik

On Sun, 17 May 2026 at 15:21, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, May 15, 2026 at 09:45:15PM +0530, Hardik Prakash wrote:
> > The Wacom WACF2200 touchscreen on the Lenovo Yoga 7 14AGP11 (83TD) is
> > non-functional on Linux due to two bugs. Patch 1 (pinctrl-amd GPIO IRQ
> > fix) has already been taken into Linus Walleij's tree. This v3 resend
> > covers patch 2 only, addressing Andy Shevchenko's formatting feedback.
> >
> > Root cause: i2c_designware probes AMDI0010:02 before pinctrl-amd's
> > probe completes, so GPIO 157 (WACF2200 GpioInt per ACPI _CRS) has its
> > interrupt bits cleared when the first I2C transaction is attempted,
> > causing lost arbitration errors. The udev rebind workaround (which
> > works because pinctrl-amd has finished by userspace time) confirms
> > probe ordering as the root cause.
> >
> > Note: the dual-master hypothesis raised by Mario Limonciello was
> > investigated. TPNL's _DSM (UUID 3cdff6f7-4267-4555-ad05-b30a3d8938de)
> > is a pure query method returning a constant HID descriptor address with
> > no side effects, making firmware acting as secondary I2C master unlikely
> > on this hardware. Awaiting Mario and Bart's technical verdict before
> > any further approach changes.
> >
> > v3:
> >  - Patch 2 only (patch 1 already in Linus Walleij's tree)
>
> The patch numbering is broken. Where did 2/2 come from?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
