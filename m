Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87E38DC47
	for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786510806; cv=pass; b=u9dR/9IRJAHLmA2UM3RPahMD3EXU4i93z5EWKZ3mmhI0999hAQY1ljHvW5AtQB1N0k1UdW4gduA7TrKH6lk36zWWZN7haT/xFLq0MGKBKniNuejIQ6d4Z07uT3tafPe3dExg2e313WcNF9kvIYO/dzqYpkiSV9HCNIrGVLBfmUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786510806; c=relaxed/simple;
	bh=GlqYAumRSJZIfX4tvyL7GvVcEEz6BxVJUE0h8Nrgp6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2q8d8nnfavyv+NnDXDyWsBu75fOQ1zd2D7QIR/9YoYb6erQFcaxSSqaM4UScCHq3ib2haaJ9WKR8e/AGxBT0txjaOXEf7ApBGpfbGU+KOSs3AlULviTvd/GuP3CWa5WBQN/Yv1LAJFpG1tEV1lovwWrcCyHevM1Go1D02zy8yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zyvf+ZwK; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyvf+ZwK"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-668432fe416so960874d50.0
        for <linux-i2c@vger.kernel.org>; Tue, 11 Aug 2026 22:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786510803; cv=none;
        d=google.com; s=arc-20260327;
        b=AXEgX6G1yktgrgMOgPxHOcp3KrmY+kQo+YBMKVOe0MiuyeUeS+PHa4d3cz3v5imPZ+
         V0h2fMlNgFqxYZ8mIfb8xNqESdW5xe8r7Vn+GyRalet5XNEj/+AY2vbG6lSR/m/G3OsA
         lHqsOvZj71Q+jtfJoeDmlWfSwogr++uk3FOLUnyhZiK8l3+LUyYAtz4tZKtWVzNXP7C6
         FpCKsLmFdlTYQ0peY/HMr9sGoL6i0Y4RqMTQPFhem1IZixKMQH7qzk1myxlfYiEb5v5B
         sB8/3LJIffTLwECwbfSnHL/l5DXLtVGXQo2vIsDshQBVtxyT8Axr63YV9hW8MVcqeHSE
         YOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m5+ib/Pzb1uORQBVo42Pl8gSnCdf5pSGuLV36Z1X+74=;
        fh=x8NnOAlNA0CLv4r+4xV2ZK0aFjimdvbQ0V8uoLlyvzs=;
        b=PR0umwKlz2HuBQF/imqokgPlVwxLLGxxFIVXXj+4fvwuyBG/ANjRgeIdkuG8qZmzv0
         /5OMoIePxXZZEXPVaIMvHY6wlqcVrLX/yfFuUnVavH8QkuNEt+pnAgiw02VqJGI7jEn5
         ICz5wjIdr7xvI/ongWNRtcqnE5k704MrEhEtqbVyYz6eT8HGhEMv1Wr/QoFHJC7VZpJ7
         x+MjloQWQqo69/xAUSixCV6tPQ538Jp3ctwcIKYfGXYjFOXXX7vqt7NQojVObl1G/1PB
         R8qqcTizDMAuSgHGto1M+XH18GpFx6253c6EgVP0AeUmUZ/DLA/7DEnpC29yyYkesilh
         nBbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786510803; x=1787115603; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m5+ib/Pzb1uORQBVo42Pl8gSnCdf5pSGuLV36Z1X+74=;
        b=Zyvf+ZwKnt1nGS+5EOzckWwJzm9fOIwaL4YvM/i7VrD/dLYempsWhWGA1Bnj/vbqBP
         gdLwLGF+Z1rmzXG7pCr47rncN+ZchnUmdW1zhwFLp+5Wk6G9m+3Nem/ZVqwkRKEQK1pu
         5PN0acDxYS2dKdODTxdKjwRoMB7xkEHYEswGoV0tC4SKY0we8D4YLyJwDPzyg0dA+s8M
         1y56xXkM0QkjcFHolZLFAkpFKqwlVR0xGG0d+easJR7w/4EMIR+YEC6nco4nFA+RCIpM
         DiRfKP749gwyEj/z83sRy+v8N0i5544E+kKMIdJSPNGKjcchF6bRtZIcOekVgZ+eOH+K
         132Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786510803; x=1787115603;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m5+ib/Pzb1uORQBVo42Pl8gSnCdf5pSGuLV36Z1X+74=;
        b=U+0kbu9JwgIlaOaWmRxg+JDy/GSUAWc26vAMDvGGo+IQ1VSf0uQRmyWHwkp5Q3Wa1k
         2YWUB7ukNJDnILX3XWa62UysuLro6yZyj+B/z0lZc1qeJ4V10yDa9wsaII6W51TAraBr
         6I7xoMuqfX4zmKdEk0EDPMkJ/mY5q7e18rlkAm7xlflX5U6tuLfuAgMB2062rGPNHZGI
         3u4T37R5hE0KBJsY1wSvVOiOo2bjvTXI8+UOtQ5Cwl2ItIVQjAg5SUVuy+D8Bu/qQRY4
         ZvhgXt0W9L1V/885UJbzyY/Yb5DMJYy2JH1cz6fMCsOBrMwPgItqM92qbC5zqGu5aDOA
         IhiQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHqiJeDZa9tZ6/sWrGWtcfBaHhQCg/gWGmJrdzn8NinqN4wurkSY9JozJSHidWj/00tI2jxn5En70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6jRwZSTN+DJknR461j1320jzxpzDd+rNehUhm0IbA+sA7MvKE
	XPOuRKTtbWP1Eal7P6UpIu8T00fLwWDscQwtTXcYikgKoAXt2acUSJGIorg5jTv2eDpHMWgF6PR
	c5xap/GZXOUwNHQNV+Y5ITPD0S2U4q/g=
X-Gm-Gg: AR+sD11ZCBdGtFi8e/P3zjegyaLTUFKeDL+Hm3GVVKtC4+JakvM7mpkSSorJ68tcUNW
	n81BKyectvsmZT/4enP3GttG8rOM1nnMVMU8PhDHq9+Oj9fph5vlj/sJuLUcelcJrY8XzIET0FM
	9ie9XyzqguUQoVDnKCSweP5yyEKumCYWVIsAORQj+b1rq7m+jUQ+1fCgJp4eAmTUpY4M9UWvXNc
	QiH5IvDYuebp2r65kTYFJ/BLcv9/ECpXypmq3C/7Of439TzPSjPqfVCzlNBJh/WZJ0Pb9UHGa7+
	3zk2Xdwliy0OS4X41RIY/FLpsTGAkY5CNCQrEEy4f6/Q2/MC9q+fHLYZUelmBekL9L8+pX1D+qW
	CigEhEl2LhAwk5aOEQVGkxf4Kc6KJTVGkrgkQ5DRFEMEt6lyrxnRPtu2lNEsJWmyX++xxFUSIte
	t5cFAp1nBn3CPG5UZ4GYJS
X-Received: by 2002:a05:690e:1381:b0:668:894a:f535 with SMTP id
 956f58d0204a3-66b3c3e30a2mr347647d50.26.1786510803119; Tue, 11 Aug 2026
 22:00:03 -0700 (PDT)
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
 <CANTFpSWzV9tzMwc2cURCQBhpZmrv1SsZqnwBEu0jt=ZQWfvWgQ@mail.gmail.com>
 <1a209e14-05c6-4796-a8fc-d0c3a776520d@leemhuis.info> <CANTFpSWnTjoTS8hBOvVM_w3pWHyOiBhch_GXe_mG-d56WeF-0w@mail.gmail.com>
 <5a5f7f58-b35b-407f-a5e5-293a88cafcc0@leemhuis.info>
In-Reply-To: <5a5f7f58-b35b-407f-a5e5-293a88cafcc0@leemhuis.info>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Wed, 12 Aug 2026 10:29:50 +0530
X-Gm-Features: AUfX_mzTrsF23BETOvBnXr0XX5v_mtzYhp5GFBzxvhSw9sXS_Tq8qvIy0_0f-ow
Message-ID: <CANTFpSWTkwmb3F9UnZmeaLizH-cC6evXD=kd1eNwJWkCfyj8DQ@mail.gmail.com>
Subject: Re: i2c designware change broke touchpad of a thinkpad
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	mario.limonciello@amd.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linusw@kernel.org, nathan@kernel.org, chaitanya.kumar.borah@intel.com, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Aug 2026, Thorsten Leemhuis wrote:
> Did a fresh boot and uploaded the dmesg again as well just in case:
> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg2
> https://www.leemhuis.info/files/misc/lsmod
> https://www.leemhuis.info/files/misc/interrupts

Thanks. Second boot reproduces the identical pattern: device_is_bound()
=true at 1.132s, lost arbitration at 2.139s -- same ~1s gap as the first
capture, so this is consistent and reproducible, not a one-off.

interrupts rules out simple IRQ-line sharing: AMDI0010:01 has its own
dedicated line (IRQ 11), separate from AMDI0010:00 (IRQ 10) and every
amd_gpio ACPI:Event line. psp-1 exists (IR-PCI-MSIX-0000:c3:00.2) but
shows zero recorded activity on any CPU.

Since lost arbitration means an actual SDA/SCL-level collision (not an
IRQ conflict), and there's no shared IRQ or visible PSP activity, if
something else is touching this bus it's happening below what Linux's
interrupt accounting can see -- which is why I wanted your take, Mario.
Does this match a known pattern of firmware (PSP/EC) briefly taking
this bus during boot on AMD platforms?

Thanks,
Hardik

On Mon, 10 Aug 2026 at 12:18, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
> On 8/10/26 07:54, Hardik Prakash wrote:
> > On Sun, 9 Aug 2026, Thorsten Leemhuis wrote:
> >> Sorry, picked the wrong file while preparing the mail, it's here:
> >> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg
> >
> > Thanks, that's the one. Full timeline from that boot:
> >
> >   0.619s  AMDI0010:00 and AMDI0010:01 defer (AMDI0030:00 not registered)
> >   1.136s  Retry succeeds: device_is_bound()=true for AMDI0030:00,
> >           confirmed for all three children (XXXX0000:00, SYNA8018:00,
> >           NXP1001:00)
> >   2.222s  lost arbitration on AMDI0010:01 (x3)
> >   3.260s  controller timed out, HID descriptor fetch fails
> >
> > The dependency check itself is behaving correctly here -- it defers,
> > then correctly confirms AMDI0030:00 is bound before letting probe
> > continue. The arbitration failure happens over a second *after* that,
> > when the touchpad attempts its actual first transaction.
> >
> > So this doesn't look like a logic bug in the check itself. My read: by
> > delaying dw_i2c_plat_probe() by ~500ms (correctly, for GPIO's sake),
> > something else ends up contending for the AMDI0010:01 bus by the time
> > the touchpad's first transaction actually happens -- a window that
> > the original (undeferred, earlier) probe attempt apparently avoided.
> >
> > Mario -- does this look like a known AMD I2C/PSP semaphore contention
> > pattern to you? Wondering if there's a shared bus/firmware consumer
> > that could explain a ~1s-later collision like this, independent of
> > the GPIO controller itself being ready.
> >
> > Thorsten, if you have it handy: /proc/interrupts and lsmod from this
> > boot would help narrow down what else might be touching that bus
> > around the 2.2s mark.
>
> Did a fresh boot and uploaded the dmesg again as well just in case:
>
> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg2
> https://www.leemhuis.info/files/misc/lsmod
> https://www.leemhuis.info/files/misc/interrupts
>
> Ciao, Thorsten
> > On Mon, 10 Aug 2026 at 11:06, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >>
> >> On 8/10/26 07:23, Hardik Prakash wrote:
> >>> On Sat, 8 Aug 2026, Thorsten Leemhuis wrote:
> >>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
> >>>>
> >>>> [    0.619018] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
> >>>> [...]
> >>>> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
> >>>
> >>> Thanks, this trace looks correct on its face (defer at 0.619s, retry
> >>> succeeds at 1.122-1.136s), but the link above points to the same file
> >>> you sent last round (the master+revert baseline, no debug patch, no
> >>> i2c-dw-gpio-dbg lines in it at all) rather than this new capture.
> >>>> Could you share the full, unfiltered dmesg from this exact boot (the
> >>> one with the debug patch applied)? I need to see where
> >>> "lost arbitration" falls relative to the trace above.
> >>
> >> Sorry, picked the wrong file while preparing the mail, it's here:
> >> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg
> >>
> >> Ciao, Thorsten
> >>
> >>> Separately, from your DSDT: NFC1 (NXP1001), which shows up as a child
> >>> of AMDI0010:01 in your trace, declares its _CRS as a raw resource
> >>> buffer containing three GPIO resources referencing \_SB.GPIO -- one
> >>> GpioIo and two separate GpioInt entries. Not sure yet if that's
> >>> relevant, but it's a pattern I haven't seen on my hardware
> >>> which I've tested against.
> >>>
> >>> Thanks,
> >>> Hardik
> >>>
> >>> On Sun, 9 Aug 2026 at 21:49, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >>>>
> >>>> On 8/8/26 22:25, Andy Shevchenko wrote:
> >>>>> On Sat, Aug 08, 2026 at 10:31:28PM +0530, Hardik Prakash wrote:
> >>>>>> On Fri, 7 Aug 2026, Thorsten Leemhuis wrote:
> >>>>>>> This became 0a4bb2abc3e56d ("i2c: designware: defer probe if child
> >>>>>>> GpioInt controllers are not bound") and causes a regression for me: the
> >>>>>>> Touchpad in my ThinkPad T14s Gen 4 (AMD) stopped working. From the
> >>>>>>> kernel log:
> >>>>>>>
> >>>>>>> i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
> >>>>>>> i2c_designware AMDI0010:01: controller timed out
> >>>>>>> i2c_hid_acpi i2c-SYNA8018:00: failed to fetch HID descriptor: -110
> >>>>>>> i2c_hid_acpi i2c-SYNA8018:00: Failed to fetch the HID Descriptor
> >>>>>>>
> >>>>>>> Reverting this change in current mainline/master (f9a2394a23482) fixed
> >>>>>>> things for me. Full dmesg of current master and master+revert can be
> >>>>>>> found here:
> >>>>>>>
> >>>>>>> https://www.leemhuis.info/files/misc/dmesg-master
> >>>>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
> >>>>>> [...]
> >>>>>> Two things that would help narrow this down, whenever you have a moment:
> >>>>
> >>>> Thx for looking into this. Here we go:
> >>>>
> >>>>>> 1. A DSDT dump
> >>>>
> >>>> https://www.leemhuis.info/files/misc/dsdt.dsl
> >>>>
> >>>>>> 2. A dmesg with dynamic debug from a kernel built with the attached
> >>>>>>    patch on top of current mainline/master
> >>>>
> >>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
> >>>>
> >>>> [    0.619018] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
> >>>> [    0.619018] i2c-dw-gpio-dbg: check_child_gpioint(adev=XXXX0000:00)
> >>>> [    0.619076] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >>>> [    0.619079] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >>>> device=AMDI0030:00
> >>>> [    0.619080] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() returned
> >>>> NULL, deferring
> >>>> [    0.619082] i2c-dw-gpio-dbg: check_child_gpioint ret=-517 (defer)
> >>>> [    0.619102] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:01)
> >>>> [    0.619104] i2c-dw-gpio-dbg: check_child_gpioint(adev=SYNA8018:00)
> >>>> [    0.619159] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >>>> [    0.619162] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >>>> device=AMDI0030:00
> >>>> [    0.619162] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() returned
> >>>> NULL, deferring
> >>>> [    0.619164] i2c-dw-gpio-dbg: check_child_gpioint ret=-517 (defer)
> >>>> [    1.122517] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
> >>>> [    1.122523] i2c-dw-gpio-dbg: check_child_gpioint(adev=XXXX0000:00)
> >>>> [    1.122625] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >>>> [    1.122636] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >>>> device=AMDI0030:00
> >>>> [    1.122639] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
> >>>> [    1.122642] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
> >>>> [    1.135894] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:01)
> >>>> [    1.135898] i2c-dw-gpio-dbg: check_child_gpioint(adev=SYNA8018:00)
> >>>> [    1.135976] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >>>> [    1.135980] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >>>> device=AMDI0030:00
> >>>> [    1.135983] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
> >>>> [    1.135985] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
> >>>> [    1.135987] i2c-dw-gpio-dbg: check_child_gpioint(adev=NXP1001:00)
> >>>> [    1.136005] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >>>> [    1.136008] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >>>> device=AMDI0030:00
> >>>> [    1.136009] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
> >>>> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
> >>>>
> >>>> HTH, Ciao, Thorsten
> >>>>
> >>>>>> On Fri, 7 Aug 2026 at 19:37, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >>>>>>> On 7/28/26 10:30, Andi Shyti wrote:
> >>>>>>>> On Sat, Jul 18, 2026 at 11:13:31AM +0530, Hardik Prakash wrote:
> >>>>>>>>> I2C controllers may have child devices with GpioInt resources that
> >>>>>>>>> depend on GPIO controllers being fully initialized. If the I2C
> >>>>>>>>> controller probes and enumerates children before the referenced GPIO
> >>>>>>>>> controller has completed probe, GPIO interrupts may not be properly
> >>>>>>>>> configured, leading to device failures.
> >>>>>>>>>
> >>>>>>>>> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> >>>>>>>>> AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> >>>>>>>>> pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> >>>>>>>>> AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> >>>>>>>>> fail with lost arbitration errors:
> >>>>>>>>>
> >>>>>>>>>   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
> >>>>>>>>>   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
> >>>>>>>>>   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
> >>>>>>>>>   2.348157  lost arbitration
> >>>>>>>>>
> >>>>>>>>> Add a dependency check that walks ACPI child devices and defers probe
> >>>>>>>>> until any referenced GPIO controller is bound.
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>>> #regzbot introduced: 0a4bb2abc3e56d
> >>>>>>> #regzbot title i2c: designware: ThinkPad touchpad broke
> >>>>>
> >>>>
> >>>
> >>
> >
>
