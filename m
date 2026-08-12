Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4133288C81;
	Wed, 12 Aug 2026 05:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786512100; cv=none; b=VSNp177sRa57pGlMqdikS6W2b4F7PIALW0876mNnz6GKgRLtUuupIED8csgT55JsTd8ezJdO7eRlGNIyVXnLFGe0cE5e99iBofSczdcwKb5bhKTTAtaXXfkAf/OZgLeW8Mf6TYjwJW3gNS0UZNPQGBocDRaTslyk9RyPO5imBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786512100; c=relaxed/simple;
	bh=fzSgTConT1D0PiurRYdEWDSW+7CJwgtS4Z4IPP0F1pE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/pRvSThXfKoM3dz4xvz8MAJw+cD2448fwh0rxDYp3NUXtHhfDZAfYNPzUtdSU/FNi7SaAx9coy3ceDHDjUe7Wt1x0dLnWuZA80ohTafZfa9rR4BwV9s5IX7EJAQAXBXTthCzxoYiVcXiqC3HMxug2EQip96XdNY0u2UeSBJfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=CthaFbNM; arc=none smtp.client-ip=188.68.63.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="CthaFbNM"
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4hKcKj4BQvz6HQX;
	Wed, 12 Aug 2026 07:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1786512089;
	bh=fzSgTConT1D0PiurRYdEWDSW+7CJwgtS4Z4IPP0F1pE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CthaFbNMGuWd6zVvf2+CDtr9oBU36TtLXSQ9nNOe6kJ8wX7Xl+rhQ54aYgBN1s6Mu
	 AT0pcZjMS1SEpfb2g3RFy7BrHpgye2e5NdfJ4P0b8R8WA2Yie+AqocXDD4xml/Kw26
	 nPTKvcTAXPvZH7/EK84Q7C4SGz3oZe/3VUnID2ff1B44E4+8nwvqn/IWlKONeJbRSw
	 g2SqLrUG0xv+ekyMDbshGje2mCZTLb2iEXoUg0BJD7y/ceh2BVrJ6j0j5rvuNMZk4J
	 MFy3JgnH32NKSopgcm5KuSoLot58xCqXccECOpI55yKtVkrUPpy1uRhLp2NdhshaN9
	 szyd3O3fa4eAA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4hKcKj3RDKz4y8N;
	Wed, 12 Aug 2026 07:21:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hKcKh14Npz8tbg;
	Wed, 12 Aug 2026 07:21:28 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 17BBC5F959;
	Wed, 12 Aug 2026 07:21:23 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <a23375c9-d188-4737-bfa0-f10e66ae7f08@leemhuis.info>
Date: Wed, 12 Aug 2026 07:21:22 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: i2c designware change broke touchpad of a thinkpad
To: Hardik Prakash <hardikprakash.official@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
 linux-gpio@vger.kernel.org, wsa@kernel.org, mario.limonciello@amd.com,
 brgl@bgdev.pl, basavaraj.natikar@amd.com, linusw@kernel.org,
 nathan@kernel.org, chaitanya.kumar.borah@intel.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260718054330.8975-2-hardikprakash.official@gmail.com>
 <amhodWpAI3K6aeBH@zenone.zhora.eu>
 <b4a4eadb-282f-464c-843a-19d415a34d0c@leemhuis.info>
 <CANTFpSW+w1GZMbLXszuqZFCZjeVJfFG2bc1vJad+OMzsy-CPCg@mail.gmail.com>
 <aneQvMN_Zet2b62n@ashevche-desk.local>
 <b5b95476-636f-40b1-8575-47918169b7bb@leemhuis.info>
 <CANTFpSWzV9tzMwc2cURCQBhpZmrv1SsZqnwBEu0jt=ZQWfvWgQ@mail.gmail.com>
 <1a209e14-05c6-4796-a8fc-d0c3a776520d@leemhuis.info>
 <CANTFpSWnTjoTS8hBOvVM_w3pWHyOiBhch_GXe_mG-d56WeF-0w@mail.gmail.com>
 <5a5f7f58-b35b-407f-a5e5-293a88cafcc0@leemhuis.info>
 <CANTFpSWTkwmb3F9UnZmeaLizH-cC6evXD=kd1eNwJWkCfyj8DQ@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CANTFpSWTkwmb3F9UnZmeaLizH-cC6evXD=kd1eNwJWkCfyj8DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178651208363.821984.14913228808045068321@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 17BBC5F959
X-NC-CID: 8/c3jU6DpErcGGu2FJ8rJwEesWIyq3bczfBJjCvJLgNastaClpY=

On 8/12/26 06:59, Hardik Prakash wrote:
> On Mon, 10 Aug 2026, Thorsten Leemhuis wrote:
>> Did a fresh boot and uploaded the dmesg again as well just in case:
>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg2
>> https://www.leemhuis.info/files/misc/lsmod
>> https://www.leemhuis.info/files/misc/interrupts
> 
> Thanks. Second boot reproduces the identical pattern: device_is_bound()
> =true at 1.132s, lost arbitration at 2.139s -- same ~1s gap as the first
> capture, so this is consistent and reproducible, not a one-off.
> 
> interrupts rules out simple IRQ-line sharing: AMDI0010:01 has its own
> dedicated line (IRQ 11), separate from AMDI0010:00 (IRQ 10) and every
> amd_gpio ACPI:Event line. psp-1 exists (IR-PCI-MSIX-0000:c3:00.2) but
> shows zero recorded activity on any CPU.
> 
> Since lost arbitration means an actual SDA/SCL-level collision (not an
> IRQ conflict), and there's no shared IRQ or visible PSP activity, if
> something else is touching this bus it's happening below what Linux's
> interrupt accounting can see -- which is why I wanted your take, Mario.
> Does this match a known pattern of firmware (PSP/EC) briefly taking
> this bus during boot on AMD platforms?

Thx again. While we wait for Mario a quick question: Should we revert
the culprit for 7.2 and reapply it later once we sorted this out? Of
course I'll continue to help debugging this.

If it was just me I'd say "don't bother", but these kind of Thinkpads
are what some Linux users frequently buy, so I fear that other people
will run into this if the culprit makes it into 7.2.

Ciao, Thorsten

> On Mon, 10 Aug 2026 at 12:18, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>
>> On 8/10/26 07:54, Hardik Prakash wrote:
>>> On Sun, 9 Aug 2026, Thorsten Leemhuis wrote:
>>>> Sorry, picked the wrong file while preparing the mail, it's here:
>>>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg
>>>
>>> Thanks, that's the one. Full timeline from that boot:
>>>
>>>   0.619s  AMDI0010:00 and AMDI0010:01 defer (AMDI0030:00 not registered)
>>>   1.136s  Retry succeeds: device_is_bound()=true for AMDI0030:00,
>>>           confirmed for all three children (XXXX0000:00, SYNA8018:00,
>>>           NXP1001:00)
>>>   2.222s  lost arbitration on AMDI0010:01 (x3)
>>>   3.260s  controller timed out, HID descriptor fetch fails
>>>
>>> The dependency check itself is behaving correctly here -- it defers,
>>> then correctly confirms AMDI0030:00 is bound before letting probe
>>> continue. The arbitration failure happens over a second *after* that,
>>> when the touchpad attempts its actual first transaction.
>>>
>>> So this doesn't look like a logic bug in the check itself. My read: by
>>> delaying dw_i2c_plat_probe() by ~500ms (correctly, for GPIO's sake),
>>> something else ends up contending for the AMDI0010:01 bus by the time
>>> the touchpad's first transaction actually happens -- a window that
>>> the original (undeferred, earlier) probe attempt apparently avoided.
>>>
>>> Mario -- does this look like a known AMD I2C/PSP semaphore contention
>>> pattern to you? Wondering if there's a shared bus/firmware consumer
>>> that could explain a ~1s-later collision like this, independent of
>>> the GPIO controller itself being ready.
>>>
>>> Thorsten, if you have it handy: /proc/interrupts and lsmod from this
>>> boot would help narrow down what else might be touching that bus
>>> around the 2.2s mark.
>>
>> Did a fresh boot and uploaded the dmesg again as well just in case:
>>
>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg2
>> https://www.leemhuis.info/files/misc/lsmod
>> https://www.leemhuis.info/files/misc/interrupts
>>
>> Ciao, Thorsten
>>> On Mon, 10 Aug 2026 at 11:06, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>>
>>>> On 8/10/26 07:23, Hardik Prakash wrote:
>>>>> On Sat, 8 Aug 2026, Thorsten Leemhuis wrote:
>>>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>>>>>>
>>>>>> [    0.619018] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
>>>>>> [...]
>>>>>> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
>>>>>
>>>>> Thanks, this trace looks correct on its face (defer at 0.619s, retry
>>>>> succeeds at 1.122-1.136s), but the link above points to the same file
>>>>> you sent last round (the master+revert baseline, no debug patch, no
>>>>> i2c-dw-gpio-dbg lines in it at all) rather than this new capture.
>>>>>> Could you share the full, unfiltered dmesg from this exact boot (the
>>>>> one with the debug patch applied)? I need to see where
>>>>> "lost arbitration" falls relative to the trace above.
>>>>
>>>> Sorry, picked the wrong file while preparing the mail, it's here:
>>>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg
>>>>
>>>> Ciao, Thorsten
>>>>
>>>>> Separately, from your DSDT: NFC1 (NXP1001), which shows up as a child
>>>>> of AMDI0010:01 in your trace, declares its _CRS as a raw resource
>>>>> buffer containing three GPIO resources referencing \_SB.GPIO -- one
>>>>> GpioIo and two separate GpioInt entries. Not sure yet if that's
>>>>> relevant, but it's a pattern I haven't seen on my hardware
>>>>> which I've tested against.
>>>>>
>>>>> Thanks,
>>>>> Hardik
>>>>>
>>>>> On Sun, 9 Aug 2026 at 21:49, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>>>>
>>>>>> On 8/8/26 22:25, Andy Shevchenko wrote:
>>>>>>> On Sat, Aug 08, 2026 at 10:31:28PM +0530, Hardik Prakash wrote:
>>>>>>>> On Fri, 7 Aug 2026, Thorsten Leemhuis wrote:
>>>>>>>>> This became 0a4bb2abc3e56d ("i2c: designware: defer probe if child
>>>>>>>>> GpioInt controllers are not bound") and causes a regression for me: the
>>>>>>>>> Touchpad in my ThinkPad T14s Gen 4 (AMD) stopped working. From the
>>>>>>>>> kernel log:
>>>>>>>>>
>>>>>>>>> i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
>>>>>>>>> i2c_designware AMDI0010:01: controller timed out
>>>>>>>>> i2c_hid_acpi i2c-SYNA8018:00: failed to fetch HID descriptor: -110
>>>>>>>>> i2c_hid_acpi i2c-SYNA8018:00: Failed to fetch the HID Descriptor
>>>>>>>>>
>>>>>>>>> Reverting this change in current mainline/master (f9a2394a23482) fixed
>>>>>>>>> things for me. Full dmesg of current master and master+revert can be
>>>>>>>>> found here:
>>>>>>>>>
>>>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master
>>>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>>>>>>>> [...]
>>>>>>>> Two things that would help narrow this down, whenever you have a moment:
>>>>>>
>>>>>> Thx for looking into this. Here we go:
>>>>>>
>>>>>>>> 1. A DSDT dump
>>>>>>
>>>>>> https://www.leemhuis.info/files/misc/dsdt.dsl
>>>>>>
>>>>>>>> 2. A dmesg with dynamic debug from a kernel built with the attached
>>>>>>>>    patch on top of current mainline/master
>>>>>>
>>>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>>>>>>
>>>>>> [    0.619018] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
>>>>>> [    0.619018] i2c-dw-gpio-dbg: check_child_gpioint(adev=XXXX0000:00)
>>>>>> [    0.619076] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>>>> [    0.619079] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>> device=AMDI0030:00
>>>>>> [    0.619080] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() returned
>>>>>> NULL, deferring
>>>>>> [    0.619082] i2c-dw-gpio-dbg: check_child_gpioint ret=-517 (defer)
>>>>>> [    0.619102] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:01)
>>>>>> [    0.619104] i2c-dw-gpio-dbg: check_child_gpioint(adev=SYNA8018:00)
>>>>>> [    0.619159] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>>>> [    0.619162] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>> device=AMDI0030:00
>>>>>> [    0.619162] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() returned
>>>>>> NULL, deferring
>>>>>> [    0.619164] i2c-dw-gpio-dbg: check_child_gpioint ret=-517 (defer)
>>>>>> [    1.122517] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
>>>>>> [    1.122523] i2c-dw-gpio-dbg: check_child_gpioint(adev=XXXX0000:00)
>>>>>> [    1.122625] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>>>> [    1.122636] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>> device=AMDI0030:00
>>>>>> [    1.122639] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
>>>>>> [    1.122642] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
>>>>>> [    1.135894] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:01)
>>>>>> [    1.135898] i2c-dw-gpio-dbg: check_child_gpioint(adev=SYNA8018:00)
>>>>>> [    1.135976] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>>>> [    1.135980] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>> device=AMDI0030:00
>>>>>> [    1.135983] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
>>>>>> [    1.135985] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
>>>>>> [    1.135987] i2c-dw-gpio-dbg: check_child_gpioint(adev=NXP1001:00)
>>>>>> [    1.136005] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>>>> [    1.136008] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>> device=AMDI0030:00
>>>>>> [    1.136009] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
>>>>>> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
>>>>>>
>>>>>> HTH, Ciao, Thorsten
>>>>>>
>>>>>>>> On Fri, 7 Aug 2026 at 19:37, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>>>>>>> On 7/28/26 10:30, Andi Shyti wrote:
>>>>>>>>>> On Sat, Jul 18, 2026 at 11:13:31AM +0530, Hardik Prakash wrote:
>>>>>>>>>>> I2C controllers may have child devices with GpioInt resources that
>>>>>>>>>>> depend on GPIO controllers being fully initialized. If the I2C
>>>>>>>>>>> controller probes and enumerates children before the referenced GPIO
>>>>>>>>>>> controller has completed probe, GPIO interrupts may not be properly
>>>>>>>>>>> configured, leading to device failures.
>>>>>>>>>>>
>>>>>>>>>>> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
>>>>>>>>>>> AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
>>>>>>>>>>> pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
>>>>>>>>>>> AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
>>>>>>>>>>> fail with lost arbitration errors:
>>>>>>>>>>>
>>>>>>>>>>>   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
>>>>>>>>>>>   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
>>>>>>>>>>>   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
>>>>>>>>>>>   2.348157  lost arbitration
>>>>>>>>>>>
>>>>>>>>>>> Add a dependency check that walks ACPI child devices and defers probe
>>>>>>>>>>> until any referenced GPIO controller is bound.
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>>> #regzbot introduced: 0a4bb2abc3e56d
>>>>>>>>> #regzbot title i2c: designware: ThinkPad touchpad broke
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

