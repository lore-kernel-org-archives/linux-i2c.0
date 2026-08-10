Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481642D7BF
	for <linux-i2c@vger.kernel.org>; Mon, 10 Aug 2026 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339398; cv=pass; b=d0fls5qO8nwrCprt7iNHNwzHdCg0Wahh4SIeYm3fwZ373wdqNYwPsY+oumcvbRsrMjdXW2cM99eFpOsUWWrE7YoVYUKaCCfMSJeYFo1SDrvq4c6mhcadJTxFvwHsQtumbl2t6jD/46krwakae3zbmw0CwrfkUYCkYrugyNbH34k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339398; c=relaxed/simple;
	bh=DyPbHUAtcMi/e7oergn3BUmtEbDPiOqnxDcdQz3Fu8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YH71xovxknvMoZY9qpfg6cQkKwCPSvJyMb5Sn9CbRXgtx7aRYxmEeb6P8DD9tbR6ktHdqmGBq6Pc0/4F6kDm2O9/tm7ygwGhaf3l/Sqw1tS1y7sq4aVpgSKi9p7tmrFkkTFAIlwli3pqofoToAf17Atsh62Dk1GBau2i/sysOrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXT1JuK8; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXT1JuK8"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6689f36ae56so1854360d50.3
        for <linux-i2c@vger.kernel.org>; Sun, 09 Aug 2026 22:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786339395; cv=none;
        d=google.com; s=arc-20260327;
        b=nJJoMphjfw8WijDO51+fUyIKxSLcsof3F7U57Ac7GUCIl5e4vesHTX/tiahqdtqsPB
         jTyFAgDRkGrqQ68bCi9Xz21PyddD5lc6NM1tSzJ1sj418czNClQky3hMuhPxrLWZi4TJ
         q0hfSszXe7G2RXWLX8B4SohGTmzFpoOFTMybWdhzcECn27kXPQS+yLlrdi742YH1NP5L
         eRkNmBFSVyN7rqsbXbUfKloEN3HoDOoREIZeUFrlRuZMXqUju+l/AZbVglcBxx2Lx28B
         8FzsC0Wo23IxF4Kp0GdwnJ348LkXIPYF8FWATfKF+tEw/Pri+msiBBiz8OW1Cs2EhRkl
         i5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V5cg9cUMM483feITK+A0fq23fgcoTcw/hMKjOKcFiHw=;
        fh=1c2X1MRVATxCvT/eLmiNbonuJl7R/16F3ztxkeOROPs=;
        b=kR4MT5XynuAcq45CINFuPhJM9bJ89aejbZP4xbhCQxiMDuXGheGiGYvXPIXvFNhQyX
         W8nRUe9Xadu1z6NBU5ExFumYxYOsLQG49k58FyIT+haF8h9fRko2prs5+5R3ouTK3L7S
         L8B57HEYPvprEPoA+3hBpnk+lZAHPKPtCZtmhbVFZl86s8v3JI7nakHWIefmb0uGhS4H
         T1vZFJmebmQ0mbT3RRxoQsHoUYCTLV8eIIu4VmVdZG21TxqW8TqagWaVpwli3seuZ8nQ
         D4iEkpokJ+yJ3k9mJtXBOBcP7rrrWXy/UVA0uzuipEX0y4xy6MWqBxxsL2UIkC3aNBot
         cv6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786339395; x=1786944195; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V5cg9cUMM483feITK+A0fq23fgcoTcw/hMKjOKcFiHw=;
        b=LXT1JuK8wuLZmiGZ+CBer19SQ7JcLLtQVjWrDN+Ek7K7ys0opvcDUDT/qvMsflVa0i
         U680UU/GEqW4O0iF0wFSI07jnv6QgnfwyJ/Oe7jxiu45QSnnc7DsW3/Iw48rVLWDQ2aA
         ryk6ZzwrSzarSvceyZgCIGd5ALz8iN+Uizqxo1ru45IuM+08KErV0Ly1O5nBRm4jwyyr
         YAjpSXl4oQ0SETp3J0P5JwEbCqGfLN0gmPjF0Gyuq/ddGZAgbkNLKdjK88XcD4Swo2e4
         DDi+a8k01NSGamcpStaPqXJgJl6puRh5OLJSOIN2C4woJqVAM9vnc4MDMdD/wTo1zor9
         TWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786339395; x=1786944195;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V5cg9cUMM483feITK+A0fq23fgcoTcw/hMKjOKcFiHw=;
        b=mDLmERDGfP/dO4nyawgSTYMMP1X48E7O7UkQURTTKFJq+TUzQE/7duiM7qbytD7cjZ
         v/P5ijgMzhMxUZ2Gl4bOyQx6rGpYRA6BLvrrDqUOjj0NAVqyZoCaH8ppoaU09cbxgvSK
         4x99SQ4owwhNZG0GuptKffPeRYV55i0zcUUunSQ+xj6irMtKhUnMHv6xYr8QlDEd/XQF
         5pacAbnohcNVbfBTQH35989NiHu8ICuTcc7J1KBg43pgKB/5UfGZuru2vwk4BYEkBUz/
         flLxExZ5Y9h7bd65n5ksBYGVjdK2oD+TqqaCLhS3qEKrSEzfF9OnjQl7XWjK5mM5Kzzj
         wYNQ==
X-Forwarded-Encrypted: i=1; AHgh+RpLpqlBKEDPVF0WCCA4pUsINRNV558POGiJUQ34xfSK2EaaAlX70IzGY/Vf0hBFEEc4C97PDK/2J14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAEX5QR/bKJ9o2hUxJ9Jz/nPLFEww2HPX1PctJWR7uqMLlDIe
	/jf8PbymOmYoBjPR2Nk4gXxDX2QBSPnU9tH+y9MzZoBDbk8RzDyY0JwxZBK0uIIVrWMht3ycJJ0
	yRxUXZTTMuBTUI+lg7XZFxRR2T2Nj20I=
X-Gm-Gg: AR+sD119Xg65K4paMi+XMU5ORje8gFhniO2lD2MMhPwNHP+tAtco5fPk9QcOMOWtAyC
	zxlo1EbNNzzLxWOL/cfq2BPZiuI9w7Dh0S5UJ5BxoLDg+9yPvCZNOIbGY2lCsKrBhH2xrH0NLEt
	WgtDu2mr8L320Aifd3wppGRdeop21V3JocZ/oEC0+6msOOjE77l9ynCrMVqTC2ANFjpZWxT/8Nl
	Daqqis4147D6FSJyb4Z5gXsbrs//ahDhutK2TWmLy6yvc7z/jA3XoNmWIuTbfRwVLXF+JdzJ0CD
	DcmEckVjMISMkp/P6cqHDIhUVxqCeTWab9vuE5OWojYIYReq+fvTZ3odswPZkHrg30i8CERQdkO
	LbsKQnzxwhMyySAPEhJynCPpQl51+NXIoKzH6E7k2XznLt/Pcijh+sfFYhWYTTf8zsTqGLcQ4jr
	AvN6lxh+7+URgbMt3x5WE=
X-Received: by 2002:a53:e031:0:b0:668:2e27:22a7 with SMTP id
 956f58d0204a3-6699ab03662mr18080078d50.33.1786339394857; Sun, 09 Aug 2026
 22:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718054330.8975-2-hardikprakash.official@gmail.com>
 <amhodWpAI3K6aeBH@zenone.zhora.eu> <b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info>
 <CANTFpSW+w1GZMbLXszuqZFCZjeVJfFG2bc1vJad+OMzsy-CPCg@mail.gmail.com>
 <aneQvMN_Zet2b62n@ashevche-desk.local> <b5b95476-636f-40b1-8575-47918169b7bb@leemhuis.info>
In-Reply-To: <b5b95476-636f-40b1-8575-47918169b7bb@leemhuis.info>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Mon, 10 Aug 2026 10:53:03 +0530
X-Gm-Features: AUfX_mzc26r5Gwao6z1n18JIQF8v7sMo9AJLWMgvWgubjztpIoyYpHjrO1eEy8Y
Message-ID: <CANTFpSWzV9tzMwc2cURCQBhpZmrv1SsZqnwBEu0jt=ZQWfvWgQ@mail.gmail.com>
Subject: Re: i2c designware change broke touchpad of a thinkpad
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linusw@kernel.org, nathan@kernel.org, chaitanya.kumar.borah@intel.com, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Aug 2026, Thorsten Leemhuis wrote:
> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>
> [    0.619018] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
> [...]
> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00

Thanks, this trace looks correct on its face (defer at 0.619s, retry
succeeds at 1.122-1.136s), but the link above points to the same file
you sent last round (the master+revert baseline, no debug patch, no
i2c-dw-gpio-dbg lines in it at all) rather than this new capture.

Could you share the full, unfiltered dmesg from this exact boot (the
one with the debug patch applied)? I need to see where
"lost arbitration" falls relative to the trace above.

Separately, from your DSDT: NFC1 (NXP1001), which shows up as a child
of AMDI0010:01 in your trace, declares its _CRS as a raw resource
buffer containing three GPIO resources referencing \_SB.GPIO -- one
GpioIo and two separate GpioInt entries. Not sure yet if that's
relevant, but it's a pattern I haven't seen on my hardware
which I've tested against.

Thanks,
Hardik

On Sun, 9 Aug 2026 at 21:49, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
> On 8/8/26 22:25, Andy Shevchenko wrote:
> > On Sat, Aug 08, 2026 at 10:31:28PM +0530, Hardik Prakash wrote:
> >> On Fri, 7 Aug 2026, Thorsten Leemhuis wrote:
> >>> This became 0a4bb2abc3e56d ("i2c: designware: defer probe if child
> >>> GpioInt controllers are not bound") and causes a regression for me: the
> >>> Touchpad in my ThinkPad T14s Gen 4 (AMD) stopped working. From the
> >>> kernel log:
> >>>
> >>> i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
> >>> i2c_designware AMDI0010:01: controller timed out
> >>> i2c_hid_acpi i2c-SYNA8018:00: failed to fetch HID descriptor: -110
> >>> i2c_hid_acpi i2c-SYNA8018:00: Failed to fetch the HID Descriptor
> >>>
> >>> Reverting this change in current mainline/master (f9a2394a23482) fixed
> >>> things for me. Full dmesg of current master and master+revert can be
> >>> found here:
> >>>
> >>> https://www.leemhuis.info/files/misc/dmesg-master
> >>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
> >> [...]
> >> Two things that would help narrow this down, whenever you have a moment:
>
> Thx for looking into this. Here we go:
>
> >> 1. A DSDT dump
>
> https://www.leemhuis.info/files/misc/dsdt.dsl
>
> >> 2. A dmesg with dynamic debug from a kernel built with the attached
> >>    patch on top of current mainline/master
>
> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>
> [    0.619018] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
> [    0.619018] i2c-dw-gpio-dbg: check_child_gpioint(adev=XXXX0000:00)
> [    0.619076] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> [    0.619079] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> device=AMDI0030:00
> [    0.619080] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() returned
> NULL, deferring
> [    0.619082] i2c-dw-gpio-dbg: check_child_gpioint ret=-517 (defer)
> [    0.619102] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:01)
> [    0.619104] i2c-dw-gpio-dbg: check_child_gpioint(adev=SYNA8018:00)
> [    0.619159] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> [    0.619162] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> device=AMDI0030:00
> [    0.619162] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() returned
> NULL, deferring
> [    0.619164] i2c-dw-gpio-dbg: check_child_gpioint ret=-517 (defer)
> [    1.122517] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
> [    1.122523] i2c-dw-gpio-dbg: check_child_gpioint(adev=XXXX0000:00)
> [    1.122625] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> [    1.122636] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> device=AMDI0030:00
> [    1.122639] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
> [    1.122642] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
> [    1.135894] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:01)
> [    1.135898] i2c-dw-gpio-dbg: check_child_gpioint(adev=SYNA8018:00)
> [    1.135976] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> [    1.135980] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> device=AMDI0030:00
> [    1.135983] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
> [    1.135985] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
> [    1.135987] i2c-dw-gpio-dbg: check_child_gpioint(adev=NXP1001:00)
> [    1.136005] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> [    1.136008] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> device=AMDI0030:00
> [    1.136009] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
>
> HTH, Ciao, Thorsten
>
> >> On Fri, 7 Aug 2026 at 19:37, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >>> On 7/28/26 10:30, Andi Shyti wrote:
> >>>> On Sat, Jul 18, 2026 at 11:13:31AM +0530, Hardik Prakash wrote:
> >>>>> I2C controllers may have child devices with GpioInt resources that
> >>>>> depend on GPIO controllers being fully initialized. If the I2C
> >>>>> controller probes and enumerates children before the referenced GPIO
> >>>>> controller has completed probe, GPIO interrupts may not be properly
> >>>>> configured, leading to device failures.
> >>>>>
> >>>>> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> >>>>> AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> >>>>> pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> >>>>> AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> >>>>> fail with lost arbitration errors:
> >>>>>
> >>>>>   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
> >>>>>   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
> >>>>>   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
> >>>>>   2.348157  lost arbitration
> >>>>>
> >>>>> Add a dependency check that walks ACPI child devices and defers probe
> >>>>> until any referenced GPIO controller is bound.
> >
> > [...]
> >
> >>> #regzbot introduced: 0a4bb2abc3e56d
> >>> #regzbot title i2c: designware: ThinkPad touchpad broke
> >
>
