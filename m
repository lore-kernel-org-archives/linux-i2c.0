Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB113DAAD8
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599057; cv=pass; b=jOD6CzIjQ5zVAzhvUgLA/RR5miJjjtMH6gh8MQNMV/zEAutyiXUKz7FyRTpEj7AdRVnK7qqECQAyDwXA/pmq3LXD+IgEXPUZncq03ew4PudskxN4YxLOLVaPw0fcYkk6/PH25si4zKKZ5+dEmLckq7Zax7MGFzqQigd8XqfkXe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599057; c=relaxed/simple;
	bh=dzJjrTrL7q78P1sOU0UsteKSCr6rLQkmNDTn82utLzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BigrtvCg6NGwJ/M9AaTwg4YuNcpUCq2S1Nc5pQYGbZ7xAwWJJpRJGsLueQeITlBGYexp8mJieYXJ7NLXV6wCQUJF0v0yujZn69S2YHCcXzsX66cBHl4N2iS67m8cLdZo08cyFCCgYj2wyXZPZ+I5c380yVQhszCW62UrDe7imHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0iZBsb3; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0iZBsb3"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66804667af2so1709085d50.0
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 22:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786599046; cv=none;
        d=google.com; s=arc-20260327;
        b=nx3yUAWP8dlqAlFqn0Id+rvoYlOkvui8N/X5JvJZrUM+Xn51FOzyaw/gPULgyYShoN
         rhwPGrNDFMfSjeI/w6d0+tEinJgqCnoD85dz1wauN6oX5Xq8Az6BMf9YBkwVmB1rFwxm
         MdTJKLQz6yTIuRJ3NOUYjJ+l2BVyK5VzXyT6w+JFTVuXfo5OptX9pUd5A4b0NyMuqRsz
         9C8uBNRM8xV+DWC1Fz7Ah1jJ6FDc7kNXUt1Mo5/CfR5/j/tfHIIPZCAyQdslfqG292/h
         yCuVFDHnEi7J1B/yTiLO2D7GRJ5/cQAOg+BtygyFpRGeGiWdB77fKoBVvyQKU/bM8vf5
         Wh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EnCyToIZKjxCTEuJy0awJOyY8tLkpBgGARkr2UgLJmw=;
        fh=MwQNtZ83tLsQlNoU+eA8f+PS0K5K4TcYwPo/XHMLnpw=;
        b=oAKljqLS1T8UYwbyclcvclk0I1bNJMRJ1phbNyvFA7/sRZjB/1c0ILs0ghKIC8h1s2
         yW3F2YUWNUPbWlFc1oa8e+cficbosDe0ZTRGr0TvURBHa9DEcSaffl+qfl+tHLVUv5Q6
         UNybWrdi13I+94cE3rbdQae9WxRjhLLFuKrn61Bb0W+QlVCnz8nKZ9ueHVn3S7rMtcdP
         XG9RADGd+4uPk9l9aoMwLrHWrWCQ6QoUNyX9lij34qT9n1m05wAsS++1QsNlWrYnfggx
         XAnTHvycPvqGaQvPIyKHcxMuYu3D8Gjl64y1ps9mguS4uZXBtNnUzOquFPWuhh7deXwK
         V5WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786599046; x=1787203846; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EnCyToIZKjxCTEuJy0awJOyY8tLkpBgGARkr2UgLJmw=;
        b=m0iZBsb330WRa9TDpGlnxgzjbIDXAND0Fw+hCp9FhiUko0v3IBqEXvOk5RGqfgkFNr
         4sUb+XI5lti1eiguB9ncjCB9zm7CNALWdrb2fDQLsODyWEXu6uJ8lzcW8qm/r5vQZPuz
         d/oshcWtq78wKYYan/XjDnOZuIV7kw8+4y/5H0lqmDMNzV4pfM6qyTcIfZnrLMzIDSnj
         lPlo/Fs1bhTIpiP8DRtRod4z1aQjn1SCkBNMmg663l7OK29OqSff1btLCasFxTJS9p1y
         qLlP2hmeoGDF9OPZCRUr7ZmSQRftG8YkzPYaItlyhfromFq4GT02i5WJxd9exEnRCIyo
         LwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786599046; x=1787203846;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EnCyToIZKjxCTEuJy0awJOyY8tLkpBgGARkr2UgLJmw=;
        b=Hyn13U8LBjhs97lpqeY7xtWgBNvhHOmBw68rx1VuWztAlr9ZVAxPj1xF1XsZ//XaZu
         tTiGbwOla2W37f53uqC4PNv0mJytTegS3M+bzoFRjiGH4xSk75KNk2rM0J5E2uHNXu2m
         1nTMdDw+Gv9bZ4Ib9mXgUNk7Nd/6dZHRxgr/CD6/VNjum+VBBLthQKyu4n7rYZTJf447
         A11HW2qE3WtuDYv3mMFUDTzuNimGwWqMBtVCOYigScKH3VSv8UWQXtJo32hRWAQMUeJ3
         5PHY8EWXPJ9+Ru0wGf+X3KGEsZk/XZYV/XovZiJLfcuy7wPw5GMdXmj+0msyX/s73tHc
         eOUw==
X-Forwarded-Encrypted: i=1; AHgh+RpOLjHPhiZfBEYkaQFzHistF+WrzomCIJM9FI/QIBklWt1qJqnJk6WeKnRwx5JASjZSipY5qnDXDMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ0V7DZf+vWsLbbwrPA5wM4ee2TmF5s7nEELHxbC5XB5aNDPbl
	TNuGPxJYs5uP2/yFiVMC+ypRcA4uA/J+f5CQUg37GgRTAcoIrcxglSXHqWW2u6iu0hy20sWwLQf
	bsbG1F3Bw5sploYERDDb8lIZvXU1vS27QB3adsdM=
X-Gm-Gg: AR+sD132thgONHCaqvnyLA6T+ufgkwD5gaZBuDD68Zd3Vkisi2QJ0NeZcYDhvXtrl7M
	QAtBD1ENW+y1etM+zMlhZxns9NlT7Wq0LJZhHDf2GfekQAgh10Yx6ibipBnYZgwrzq1Sw3XSiqO
	riJYPNdmOphC/rcu5r130GhaGcibVHyB+YqJDgb4r/riepwS0eASmJOtJd+erqzvERNUl1CTblZ
	8KB5D8zXlMhb8OX+eVvIM3GlKBiv5oKK7BkVlYW0Eg+j33FSJv/ybF5NcGksDqMyADYxc/237Lv
	Ya5KHVlGpfV92/FreSh0PKwaX65p6V2w8rj1piGp0WiDkog1ZfHPH8GO9Q1jrXh1ruOH0c6vde0
	4I/uNqNzvwzlHQP3fxf1+MtZdm8HJ65g7eP6UlpM3y2ztaqFt+kuanerLFbgPbP/r9vhvUuD2Hv
	3tuDTg4/dc3Xa8hc0kqfwz
X-Received: by 2002:a53:ab52:0:b0:667:89c0:71b1 with SMTP id
 956f58d0204a3-66c515731admr1274510d50.31.1786599046144; Wed, 12 Aug 2026
 22:30:46 -0700 (PDT)
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
 <5a5f7f58-b35b-407f-a5e5-293a88cafcc0@leemhuis.info> <CANTFpSWTkwmb3F9UnZmeaLizH-cC6evXD=kd1eNwJWkCfyj8DQ@mail.gmail.com>
 <a23375c9-d188-4737-bfa0-f10e66ae7f08@leemhuis.info> <CANTFpSWhqkw4735EFyQ4XoSEiqsgCKt4jTxH4SDO-m3=ybwccw@mail.gmail.com>
 <444caa3c-01ae-4516-b63a-576e095fef94@amd.com>
In-Reply-To: <444caa3c-01ae-4516-b63a-576e095fef94@amd.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Thu, 13 Aug 2026 11:00:34 +0530
X-Gm-Features: AUfX_my538K7HpetEsWzkCNKan89Uhq93sMW4xN3w8ng6VWsxdRZzh0FG90L81w
Message-ID: <CANTFpSWoJGQu43BVnyyyy=QUEF1j3yrH8WBJHj-cJeXdrFbTRQ@mail.gmail.com>
Subject: Re: i2c designware change broke touchpad of a thinkpad
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	brgl@bgdev.pl, basavaraj.natikar@amd.com, linusw@kernel.org, 
	nathan@kernel.org, chaitanya.kumar.borah@intel.com, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Aug 2026, Mario Limonciello wrote:
> This is a fairly similar issue as was seen that led to this commit:
> https://git.kernel.org/torvalds/c/7d62beb102d6f

That fits well -- Thorsten's failure is on i2c_hid_acpi's first Get
Descriptor call specifically, the same transaction that commit ties
to the EC standdown _DSM.

One thing I can't narrow down: my check adds a delay (bound confirmed
at 1.136s), but the actual failure isn't until 2.222s -- over a
second later. A delay landing things later should only cause contention
if crossing some threshold matters, e.g. an EC failsafe that reclaims
the bus if the OS driver hasn't checked in within some window, or
periodic EC polling that our new timing happens to land on top of.
Is either of those a known behavior on this class of hardware? If so
that would explain why earlier (unpatched) timing avoided it and
later (patched) timing doesn't.

If the fix isn't in my dependency check itself, I'm open to hearing
where it should live instead.

Thanks,
Hardik

On Wed, 12 Aug 2026 at 18:05, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 8/12/26 00:45, Hardik Prakash wrote:
> > On Wed, 12 Aug 2026, Thorsten Leemhuis wrote:
> >> While we wait for Mario a quick question: Should we revert
> >> the culprit for 7.2 and reapply it later once we sorted this out? Of
> >> course I'll continue to help debugging this.
> >>
> >> If it was just me I'd say "don't bother", but these kind of Thinkpads
> >> are what some Linux users frequently buy, so I fear that other people
> >> will run into this if the culprit makes it into 7.2.
> >
> > I agreed, I'd rather have this reverted than ship a known regression.
> >
> > Andi, WSA -- given 7.2 is close, could this go out as a revert now? I'll
> > keep working the AMD bus-timing angle with Thorsten and Mario, and
> > we can resubmit a corrected fix for a later release once it's actually
> > understood.
>
> Let's please revert for 7.2 final and keep working at this.
>
> I've got a /hunch/ what's going on.
>
> For both Dell and Lenovo I know a lot of designs have these I2C buses
> that have both the EC and the APU connected to them.  "Both" the EC and
> APU "can" operate as master.
>
> The reason that this exists is so that when the system is in pre-boot
> the EC acts as master.  This lets you use the touchpad in the BIOS menus
> for example.  When the OS boots up there is some ASL called which sends
> an EC command that tells the EC to stand down.  At this point the APU
> takes over and acts as master.
>
> So my theory here is that by changing this ordering the _DSM is not
> called at the right timing anymore.
>
> This is a fairly similar issue as was seen that led to this commit:
>
> https://git.kernel.org/torvalds/c/7d62beb102d6f
> >
> > Thanks,
> > Hardik
> >
> > On Wed, 12 Aug 2026 at 10:51, Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> >>
> >> On 8/12/26 06:59, Hardik Prakash wrote:
> >>> On Mon, 10 Aug 2026, Thorsten Leemhuis wrote:
> >>>> Did a fresh boot and uploaded the dmesg again as well just in case:
> >>>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg2
> >>>> https://www.leemhuis.info/files/misc/lsmod
> >>>> https://www.leemhuis.info/files/misc/interrupts
> >>>
> >>> Thanks. Second boot reproduces the identical pattern: device_is_bound()
> >>> =true at 1.132s, lost arbitration at 2.139s -- same ~1s gap as the first
> >>> capture, so this is consistent and reproducible, not a one-off.
> >>>
> >>> interrupts rules out simple IRQ-line sharing: AMDI0010:01 has its own
> >>> dedicated line (IRQ 11), separate from AMDI0010:00 (IRQ 10) and every
> >>> amd_gpio ACPI:Event line. psp-1 exists (IR-PCI-MSIX-0000:c3:00.2) but
> >>> shows zero recorded activity on any CPU.
> >>>
> >>> Since lost arbitration means an actual SDA/SCL-level collision (not an
> >>> IRQ conflict), and there's no shared IRQ or visible PSP activity, if
> >>> something else is touching this bus it's happening below what Linux's
> >>> interrupt accounting can see -- which is why I wanted your take, Mario.
> >>> Does this match a known pattern of firmware (PSP/EC) briefly taking
> >>> this bus during boot on AMD platforms?
> >>
> >> Thx again. While we wait for Mario a quick question: Should we revert
> >> the culprit for 7.2 and reapply it later once we sorted this out? Of
> >> course I'll continue to help debugging this.
> >>
> >> If it was just me I'd say "don't bother", but these kind of Thinkpads
> >> are what some Linux users frequently buy, so I fear that other people
> >> will run into this if the culprit makes it into 7.2.
> >>
> >> Ciao, Thorsten
> >>
> >>> On Mon, 10 Aug 2026 at 12:18, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >>>>
> >>>> On 8/10/26 07:54, Hardik Prakash wrote:
> >>>>> On Sun, 9 Aug 2026, Thorsten Leemhuis wrote:
> >>>>>> Sorry, picked the wrong file while preparing the mail, it's here:
> >>>>>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg
> >>>>>
> >>>>> Thanks, that's the one. Full timeline from that boot:
> >>>>>
> >>>>>    0.619s  AMDI0010:00 and AMDI0010:01 defer (AMDI0030:00 not registered)
> >>>>>    1.136s  Retry succeeds: device_is_bound()=true for AMDI0030:00,
> >>>>>            confirmed for all three children (XXXX0000:00, SYNA8018:00,
> >>>>>            NXP1001:00)
> >>>>>    2.222s  lost arbitration on AMDI0010:01 (x3)
> >>>>>    3.260s  controller timed out, HID descriptor fetch fails
> >>>>>
> >>>>> The dependency check itself is behaving correctly here -- it defers,
> >>>>> then correctly confirms AMDI0030:00 is bound before letting probe
> >>>>> continue. The arbitration failure happens over a second *after* that,
> >>>>> when the touchpad attempts its actual first transaction.
> >>>>>
> >>>>> So this doesn't look like a logic bug in the check itself. My read: by
> >>>>> delaying dw_i2c_plat_probe() by ~500ms (correctly, for GPIO's sake),
> >>>>> something else ends up contending for the AMDI0010:01 bus by the time
> >>>>> the touchpad's first transaction actually happens -- a window that
> >>>>> the original (undeferred, earlier) probe attempt apparently avoided.
> >>>>>
> >>>>> Mario -- does this look like a known AMD I2C/PSP semaphore contention
> >>>>> pattern to you? Wondering if there's a shared bus/firmware consumer
> >>>>> that could explain a ~1s-later collision like this, independent of
> >>>>> the GPIO controller itself being ready.
> >>>>>
> >>>>> Thorsten, if you have it handy: /proc/interrupts and lsmod from this
> >>>>> boot would help narrow down what else might be touching that bus
> >>>>> around the 2.2s mark.
> >>>>
> >>>> Did a fresh boot and uploaded the dmesg again as well just in case:
> >>>>
> >>>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg2
> >>>> https://www.leemhuis.info/files/misc/lsmod
> >>>> https://www.leemhuis.info/files/misc/interrupts
> >>>>
> >>>> Ciao, Thorsten
> >>>>> On Mon, 10 Aug 2026 at 11:06, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >>>>>>
> >>>>>> On 8/10/26 07:23, Hardik Prakash wrote:
> >>>>>>> On Sat, 8 Aug 2026, Thorsten Leemhuis wrote:
> >>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
> >>>>>>>>
> >>>>>>>> [    0.619018] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
> >>>>>>>> [...]
> >>>>>>>> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
> >>>>>>>
> >>>>>>> Thanks, this trace looks correct on its face (defer at 0.619s, retry
> >>>>>>> succeeds at 1.122-1.136s), but the link above points to the same file
> >>>>>>> you sent last round (the master+revert baseline, no debug patch, no
> >>>>>>> i2c-dw-gpio-dbg lines in it at all) rather than this new capture.
> >>>>>>>> Could you share the full, unfiltered dmesg from this exact boot (the
> >>>>>>> one with the debug patch applied)? I need to see where
> >>>>>>> "lost arbitration" falls relative to the trace above.
> >>>>>>
> >>>>>> Sorry, picked the wrong file while preparing the mail, it's here:
> >>>>>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg
> >>>>>>
> >>>>>> Ciao, Thorsten
> >>>>>>
> >>>>>>> Separately, from your DSDT: NFC1 (NXP1001), which shows up as a child
> >>>>>>> of AMDI0010:01 in your trace, declares its _CRS as a raw resource
> >>>>>>> buffer containing three GPIO resources referencing \_SB.GPIO -- one
> >>>>>>> GpioIo and two separate GpioInt entries. Not sure yet if that's
> >>>>>>> relevant, but it's a pattern I haven't seen on my hardware
> >>>>>>> which I've tested against.
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Hardik
> >>>>>>>
> >>>>>>> On Sun, 9 Aug 2026 at 21:49, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >>>>>>>>
> >>>>>>>> On 8/8/26 22:25, Andy Shevchenko wrote:
> >>>>>>>>> On Sat, Aug 08, 2026 at 10:31:28PM +0530, Hardik Prakash wrote:
> >>>>>>>>>> On Fri, 7 Aug 2026, Thorsten Leemhuis wrote:
> >>>>>>>>>>> This became 0a4bb2abc3e56d ("i2c: designware: defer probe if child
> >>>>>>>>>>> GpioInt controllers are not bound") and causes a regression for me: the
> >>>>>>>>>>> Touchpad in my ThinkPad T14s Gen 4 (AMD) stopped working. From the
> >>>>>>>>>>> kernel log:
> >>>>>>>>>>>
> >>>>>>>>>>> i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
> >>>>>>>>>>> i2c_designware AMDI0010:01: controller timed out
> >>>>>>>>>>> i2c_hid_acpi i2c-SYNA8018:00: failed to fetch HID descriptor: -110
> >>>>>>>>>>> i2c_hid_acpi i2c-SYNA8018:00: Failed to fetch the HID Descriptor
> >>>>>>>>>>>
> >>>>>>>>>>> Reverting this change in current mainline/master (f9a2394a23482) fixed
> >>>>>>>>>>> things for me. Full dmesg of current master and master+revert can be
> >>>>>>>>>>> found here:
> >>>>>>>>>>>
> >>>>>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master
> >>>>>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
> >>>>>>>>>> [...]
> >>>>>>>>>> Two things that would help narrow this down, whenever you have a moment:
> >>>>>>>>
> >>>>>>>> Thx for looking into this. Here we go:
> >>>>>>>>
> >>>>>>>>>> 1. A DSDT dump
> >>>>>>>>
> >>>>>>>> https://www.leemhuis.info/files/misc/dsdt.dsl
> >>>>>>>>
> >>>>>>>>>> 2. A dmesg with dynamic debug from a kernel built with the attached
> >>>>>>>>>>     patch on top of current mainline/master
> >>>>>>>>
> >>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
> >>>>>>>>
> >>>>>>>> [    0.619018] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
> >>>>>>>> [    0.619018] i2c-dw-gpio-dbg: check_child_gpioint(adev=XXXX0000:00)
> >>>>>>>> [    0.619076] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >>>>>>>> [    0.619079] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >>>>>>>> device=AMDI0030:00
> >>>>>>>> [    0.619080] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() returned
> >>>>>>>> NULL, deferring
> >>>>>>>> [    0.619082] i2c-dw-gpio-dbg: check_child_gpioint ret=-517 (defer)
> >>>>>>>> [    0.619102] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:01)
> >>>>>>>> [    0.619104] i2c-dw-gpio-dbg: check_child_gpioint(adev=SYNA8018:00)
> >>>>>>>> [    0.619159] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >>>>>>>> [    0.619162] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >>>>>>>> device=AMDI0030:00
> >>>>>>>> [    0.619162] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() returned
> >>>>>>>> NULL, deferring
> >>>>>>>> [    0.619164] i2c-dw-gpio-dbg: check_child_gpioint ret=-517 (defer)
> >>>>>>>> [    1.122517] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
> >>>>>>>> [    1.122523] i2c-dw-gpio-dbg: check_child_gpioint(adev=XXXX0000:00)
> >>>>>>>> [    1.122625] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >>>>>>>> [    1.122636] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >>>>>>>> device=AMDI0030:00
> >>>>>>>> [    1.122639] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
> >>>>>>>> [    1.122642] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
> >>>>>>>> [    1.135894] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:01)
> >>>>>>>> [    1.135898] i2c-dw-gpio-dbg: check_child_gpioint(adev=SYNA8018:00)
> >>>>>>>> [    1.135976] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >>>>>>>> [    1.135980] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >>>>>>>> device=AMDI0030:00
> >>>>>>>> [    1.135983] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
> >>>>>>>> [    1.135985] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
> >>>>>>>> [    1.135987] i2c-dw-gpio-dbg: check_child_gpioint(adev=NXP1001:00)
> >>>>>>>> [    1.136005] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
> >>>>>>>> [    1.136008] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
> >>>>>>>> device=AMDI0030:00
> >>>>>>>> [    1.136009] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
> >>>>>>>> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
> >>>>>>>>
> >>>>>>>> HTH, Ciao, Thorsten
> >>>>>>>>
> >>>>>>>>>> On Fri, 7 Aug 2026 at 19:37, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> >>>>>>>>>>> On 7/28/26 10:30, Andi Shyti wrote:
> >>>>>>>>>>>> On Sat, Jul 18, 2026 at 11:13:31AM +0530, Hardik Prakash wrote:
> >>>>>>>>>>>>> I2C controllers may have child devices with GpioInt resources that
> >>>>>>>>>>>>> depend on GPIO controllers being fully initialized. If the I2C
> >>>>>>>>>>>>> controller probes and enumerates children before the referenced GPIO
> >>>>>>>>>>>>> controller has completed probe, GPIO interrupts may not be properly
> >>>>>>>>>>>>> configured, leading to device failures.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
> >>>>>>>>>>>>> AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
> >>>>>>>>>>>>> pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
> >>>>>>>>>>>>> AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
> >>>>>>>>>>>>> fail with lost arbitration errors:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>    0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
> >>>>>>>>>>>>>    0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
> >>>>>>>>>>>>>    0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
> >>>>>>>>>>>>>    2.348157  lost arbitration
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Add a dependency check that walks ACPI child devices and defers probe
> >>>>>>>>>>>>> until any referenced GPIO controller is bound.
> >>>>>>>>>
> >>>>>>>>> [...]
> >>>>>>>>>
> >>>>>>>>>>> #regzbot introduced: 0a4bb2abc3e56d
> >>>>>>>>>>> #regzbot title i2c: designware: ThinkPad touchpad broke
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>>
> >>
>
