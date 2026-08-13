Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D28D44781A;
	Thu, 13 Aug 2026 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619046; cv=none; b=qpuDpbOh/Ik0Q4j6X1M/Io0Gisy8JH42UGE0oIGI3vDza06bURSaWfIWtLUwK8Sp47Ml/CvxcEtjnfBHHsP6nla8Ufwq1cPZ/YyFKZFldcAYTHUqj4TCZ6Vsb2dApth200I0Cz4d0RbHRVUw4ZS+FWzkNP8x+LSBEutP3zLNeg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619046; c=relaxed/simple;
	bh=oCjV56ljoll3z8RFAvgRP5mM5sR8X5ePOiU6Ggqhbuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b18GLIS9uSd+dJ7zYfj1nc7EbeR1pw+iMZoBV6I+lEPlnlbotCAARM+d6lSpy1wOyUrdtmHran0Qfg9n7fNl/AMGO8nPz8waqvT3KFT7oXKExVSpP485N1Zm73sh1l0ea6/qLwrW3ExIx2/hUGt7MWqxiBnjpG4iSB36xJeM0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=GSGj0/tA; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="GSGj0/tA"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hLMjz5x9qz4Ggw;
	Thu, 13 Aug 2026 12:56:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1786618599;
	bh=oCjV56ljoll3z8RFAvgRP5mM5sR8X5ePOiU6Ggqhbuk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GSGj0/tAZSsSH1cAKIcUNRG5VEDFT9FHVPsZS0KgIjmvKdhVFJTPE8036Sw8tU4UC
	 jQcZQbi9MM3mPO8BtWli2fAWuxGjClS0MJkwbmM/I9RiMxh+G6SimiF3NSwdApk+ju
	 03f28h3c6TBcgLZhvKkcwAuy/DhlhzpaLmuzHyHAPwGzcJbYBetCEqAsaZ8lF0VNk2
	 gcKXXwQ4KgIjKLgYp5RmdxusMyzmPOU3KH4onwu2KlFFvSTp06s+M+lMQs0wIGknx7
	 tLMYUhrcLgWDaNQg6p9I9ZUrenMOpfCUdtrXk8w2fZ+Re9t0nOZIOGtx/IkPxQuoiK
	 BhGhwNNPLg6XQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4hLMjz5CWRz7xhr;
	Thu, 13 Aug 2026 12:56:39 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hLMjy5mzxz8sgW;
	Thu, 13 Aug 2026 12:56:38 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id BD96F5F935;
	Thu, 13 Aug 2026 12:56:33 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=linux@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <9095d7c8-92fe-4163-98f8-a53bbcefd6cb@leemhuis.info>
Date: Thu, 13 Aug 2026 12:56:31 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: i2c designware change broke touchpad of a thinkpad
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hardik Prakash <hardikprakash.official@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
 linux-gpio@vger.kernel.org, wsa@kernel.org, brgl@bgdev.pl,
 basavaraj.natikar@amd.com, linusw@kernel.org, nathan@kernel.org,
 chaitanya.kumar.borah@intel.com,
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
 <a23375c9-d188-4737-bfa0-f10e66ae7f08@leemhuis.info>
 <CANTFpSWhqkw4735EFyQ4XoSEiqsgCKt4jTxH4SDO-m3=ybwccw@mail.gmail.com>
 <444caa3c-01ae-4516-b63a-576e095fef94@amd.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <444caa3c-01ae-4516-b63a-576e095fef94@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178661859436.963403.12808473268346004322@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: BD96F5F935
X-NC-CID: RKOwCrsIVpALxgeMzKEcGwzDFGZOUWvUduabVZStSCIRgGf7FW0=

On 8/12/26 14:34, Mario Limonciello wrote:
> On 8/12/26 00:45, Hardik Prakash wrote:
>> On Wed, 12 Aug 2026, Thorsten Leemhuis wrote:
>>> While we wait for Mario a quick question: Should we revert
>>> the culprit for 7.2 and reapply it later once we sorted this out? Of
>>> course I'll continue to help debugging this.
>>>
>>> If it was just me I'd say "don't bother", but these kind of Thinkpads
>>> are what some Linux users frequently buy, so I fear that other people
>>> will run into this if the culprit makes it into 7.2.
>>
>> I agreed, I'd rather have this reverted than ship a known regression.
>>
>> Andi, WSA -- given 7.2 is close, could this go out as a revert now? I'll
>> keep working the AMD bus-timing angle with Thorsten and Mario, and
>> we can resubmit a corrected fix for a later release once it's actually
>> understood.
> 
> Let's please revert for 7.2 final and keep working at this.

Can't see any messages from Andi on lore in the past week and just one
from WSA. Guess well deserved holiday season or something like that.
Happens, no worries, but I guess we thus should try to handle this on
our own.

Hardik, could you submit a revert to the lists? And then I'll provide my
Tested-by and ask Linus to directly pick this up? In a case like this I
guess that is one of the viable options. Or does anyone see a better
path forward here?

Ciao, Thorsten
> I've got a /hunch/ what's going on.
> 
> For both Dell and Lenovo I know a lot of designs have these I2C buses
> that have both the EC and the APU connected to them.  "Both" the EC and
> APU "can" operate as master.
> 
> The reason that this exists is so that when the system is in pre-boot
> the EC acts as master.  This lets you use the touchpad in the BIOS menus
> for example.  When the OS boots up there is some ASL called which sends
> an EC command that tells the EC to stand down.  At this point the APU
> takes over and acts as master.
> 
> So my theory here is that by changing this ordering the _DSM is not
> called at the right timing anymore.
> 
> This is a fairly similar issue as was seen that led to this commit:
> 
> https://git.kernel.org/torvalds/c/7d62beb102d6f
>>
>> Thanks,
>> Hardik
>>
>> On Wed, 12 Aug 2026 at 10:51, Thorsten Leemhuis
>> <regressions@leemhuis.info> wrote:
>>>
>>> On 8/12/26 06:59, Hardik Prakash wrote:
>>>> On Mon, 10 Aug 2026, Thorsten Leemhuis wrote:
>>>>> Did a fresh boot and uploaded the dmesg again as well just in case:
>>>>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg2
>>>>> https://www.leemhuis.info/files/misc/lsmod
>>>>> https://www.leemhuis.info/files/misc/interrupts
>>>>
>>>> Thanks. Second boot reproduces the identical pattern: device_is_bound()
>>>> =true at 1.132s, lost arbitration at 2.139s -- same ~1s gap as the
>>>> first
>>>> capture, so this is consistent and reproducible, not a one-off.
>>>>
>>>> interrupts rules out simple IRQ-line sharing: AMDI0010:01 has its own
>>>> dedicated line (IRQ 11), separate from AMDI0010:00 (IRQ 10) and every
>>>> amd_gpio ACPI:Event line. psp-1 exists (IR-PCI-MSIX-0000:c3:00.2) but
>>>> shows zero recorded activity on any CPU.
>>>>
>>>> Since lost arbitration means an actual SDA/SCL-level collision (not an
>>>> IRQ conflict), and there's no shared IRQ or visible PSP activity, if
>>>> something else is touching this bus it's happening below what Linux's
>>>> interrupt accounting can see -- which is why I wanted your take, Mario.
>>>> Does this match a known pattern of firmware (PSP/EC) briefly taking
>>>> this bus during boot on AMD platforms?
>>>
>>> Thx again. While we wait for Mario a quick question: Should we revert
>>> the culprit for 7.2 and reapply it later once we sorted this out? Of
>>> course I'll continue to help debugging this.
>>>
>>> If it was just me I'd say "don't bother", but these kind of Thinkpads
>>> are what some Linux users frequently buy, so I fear that other people
>>> will run into this if the culprit makes it into 7.2.
>>>
>>> Ciao, Thorsten
>>>
>>>> On Mon, 10 Aug 2026 at 12:18, Thorsten Leemhuis
>>>> <linux@leemhuis.info> wrote:
>>>>>
>>>>> On 8/10/26 07:54, Hardik Prakash wrote:
>>>>>> On Sun, 9 Aug 2026, Thorsten Leemhuis wrote:
>>>>>>> Sorry, picked the wrong file while preparing the mail, it's here:
>>>>>>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg
>>>>>>
>>>>>> Thanks, that's the one. Full timeline from that boot:
>>>>>>
>>>>>>    0.619s  AMDI0010:00 and AMDI0010:01 defer (AMDI0030:00 not
>>>>>> registered)
>>>>>>    1.136s  Retry succeeds: device_is_bound()=true for AMDI0030:00,
>>>>>>            confirmed for all three children (XXXX0000:00,
>>>>>> SYNA8018:00,
>>>>>>            NXP1001:00)
>>>>>>    2.222s  lost arbitration on AMDI0010:01 (x3)
>>>>>>    3.260s  controller timed out, HID descriptor fetch fails
>>>>>>
>>>>>> The dependency check itself is behaving correctly here -- it defers,
>>>>>> then correctly confirms AMDI0030:00 is bound before letting probe
>>>>>> continue. The arbitration failure happens over a second *after* that,
>>>>>> when the touchpad attempts its actual first transaction.
>>>>>>
>>>>>> So this doesn't look like a logic bug in the check itself. My
>>>>>> read: by
>>>>>> delaying dw_i2c_plat_probe() by ~500ms (correctly, for GPIO's sake),
>>>>>> something else ends up contending for the AMDI0010:01 bus by the time
>>>>>> the touchpad's first transaction actually happens -- a window that
>>>>>> the original (undeferred, earlier) probe attempt apparently avoided.
>>>>>>
>>>>>> Mario -- does this look like a known AMD I2C/PSP semaphore contention
>>>>>> pattern to you? Wondering if there's a shared bus/firmware consumer
>>>>>> that could explain a ~1s-later collision like this, independent of
>>>>>> the GPIO controller itself being ready.
>>>>>>
>>>>>> Thorsten, if you have it handy: /proc/interrupts and lsmod from this
>>>>>> boot would help narrow down what else might be touching that bus
>>>>>> around the 2.2s mark.
>>>>>
>>>>> Did a fresh boot and uploaded the dmesg again as well just in case:
>>>>>
>>>>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg2
>>>>> https://www.leemhuis.info/files/misc/lsmod
>>>>> https://www.leemhuis.info/files/misc/interrupts
>>>>>
>>>>> Ciao, Thorsten
>>>>>> On Mon, 10 Aug 2026 at 11:06, Thorsten Leemhuis
>>>>>> <linux@leemhuis.info> wrote:
>>>>>>>
>>>>>>> On 8/10/26 07:23, Hardik Prakash wrote:
>>>>>>>> On Sat, 8 Aug 2026, Thorsten Leemhuis wrote:
>>>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>>>>>>>>>
>>>>>>>>> [    0.619018] i2c-dw-gpio-dbg:
>>>>>>>>> i2c_dw_check_gpio_dependencies(AMDI0010:00)
>>>>>>>>> [...]
>>>>>>>>> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for
>>>>>>>>> AMDI0030:00
>>>>>>>>
>>>>>>>> Thanks, this trace looks correct on its face (defer at 0.619s,
>>>>>>>> retry
>>>>>>>> succeeds at 1.122-1.136s), but the link above points to the same
>>>>>>>> file
>>>>>>>> you sent last round (the master+revert baseline, no debug patch, no
>>>>>>>> i2c-dw-gpio-dbg lines in it at all) rather than this new capture.
>>>>>>>>> Could you share the full, unfiltered dmesg from this exact boot
>>>>>>>>> (the
>>>>>>>> one with the debug patch applied)? I need to see where
>>>>>>>> "lost arbitration" falls relative to the trace above.
>>>>>>>
>>>>>>> Sorry, picked the wrong file while preparing the mail, it's here:
>>>>>>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg
>>>>>>>
>>>>>>> Ciao, Thorsten
>>>>>>>
>>>>>>>> Separately, from your DSDT: NFC1 (NXP1001), which shows up as a
>>>>>>>> child
>>>>>>>> of AMDI0010:01 in your trace, declares its _CRS as a raw resource
>>>>>>>> buffer containing three GPIO resources referencing \_SB.GPIO -- one
>>>>>>>> GpioIo and two separate GpioInt entries. Not sure yet if that's
>>>>>>>> relevant, but it's a pattern I haven't seen on my hardware
>>>>>>>> which I've tested against.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Hardik
>>>>>>>>
>>>>>>>> On Sun, 9 Aug 2026 at 21:49, Thorsten Leemhuis
>>>>>>>> <linux@leemhuis.info> wrote:
>>>>>>>>>
>>>>>>>>> On 8/8/26 22:25, Andy Shevchenko wrote:
>>>>>>>>>> On Sat, Aug 08, 2026 at 10:31:28PM +0530, Hardik Prakash wrote:
>>>>>>>>>>> On Fri, 7 Aug 2026, Thorsten Leemhuis wrote:
>>>>>>>>>>>> This became 0a4bb2abc3e56d ("i2c: designware: defer probe if
>>>>>>>>>>>> child
>>>>>>>>>>>> GpioInt controllers are not bound") and causes a regression
>>>>>>>>>>>> for me: the
>>>>>>>>>>>> Touchpad in my ThinkPad T14s Gen 4 (AMD) stopped working.
>>>>>>>>>>>> From the
>>>>>>>>>>>> kernel log:
>>>>>>>>>>>>
>>>>>>>>>>>> i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost
>>>>>>>>>>>> arbitration
>>>>>>>>>>>> i2c_designware AMDI0010:01: controller timed out
>>>>>>>>>>>> i2c_hid_acpi i2c-SYNA8018:00: failed to fetch HID
>>>>>>>>>>>> descriptor: -110
>>>>>>>>>>>> i2c_hid_acpi i2c-SYNA8018:00: Failed to fetch the HID
>>>>>>>>>>>> Descriptor
>>>>>>>>>>>>
>>>>>>>>>>>> Reverting this change in current mainline/master
>>>>>>>>>>>> (f9a2394a23482) fixed
>>>>>>>>>>>> things for me. Full dmesg of current master and
>>>>>>>>>>>> master+revert can be
>>>>>>>>>>>> found here:
>>>>>>>>>>>>
>>>>>>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master
>>>>>>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>>>>>>>>>>> [...]
>>>>>>>>>>> Two things that would help narrow this down, whenever you
>>>>>>>>>>> have a moment:
>>>>>>>>>
>>>>>>>>> Thx for looking into this. Here we go:
>>>>>>>>>
>>>>>>>>>>> 1. A DSDT dump
>>>>>>>>>
>>>>>>>>> https://www.leemhuis.info/files/misc/dsdt.dsl
>>>>>>>>>
>>>>>>>>>>> 2. A dmesg with dynamic debug from a kernel built with the
>>>>>>>>>>> attached
>>>>>>>>>>>     patch on top of current mainline/master
>>>>>>>>>
>>>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>>>>>>>>>
>>>>>>>>> [    0.619018] i2c-dw-gpio-dbg:
>>>>>>>>> i2c_dw_check_gpio_dependencies(AMDI0010:00)
>>>>>>>>> [    0.619018] i2c-dw-gpio-dbg:
>>>>>>>>> check_child_gpioint(adev=XXXX0000:00)
>>>>>>>>> [    0.619076] i2c-dw-gpio-dbg: GpioInt
>>>>>>>>> resource_source=\_SB.GPIO (len=10)
>>>>>>>>> [    0.619079] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>>>>> device=AMDI0030:00
>>>>>>>>> [    0.619080] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode()
>>>>>>>>> returned
>>>>>>>>> NULL, deferring
>>>>>>>>> [    0.619082] i2c-dw-gpio-dbg: check_child_gpioint ret=-517
>>>>>>>>> (defer)
>>>>>>>>> [    0.619102] i2c-dw-gpio-dbg:
>>>>>>>>> i2c_dw_check_gpio_dependencies(AMDI0010:01)
>>>>>>>>> [    0.619104] i2c-dw-gpio-dbg:
>>>>>>>>> check_child_gpioint(adev=SYNA8018:00)
>>>>>>>>> [    0.619159] i2c-dw-gpio-dbg: GpioInt
>>>>>>>>> resource_source=\_SB.GPIO (len=10)
>>>>>>>>> [    0.619162] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>>>>> device=AMDI0030:00
>>>>>>>>> [    0.619162] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode()
>>>>>>>>> returned
>>>>>>>>> NULL, deferring
>>>>>>>>> [    0.619164] i2c-dw-gpio-dbg: check_child_gpioint ret=-517
>>>>>>>>> (defer)
>>>>>>>>> [    1.122517] i2c-dw-gpio-dbg:
>>>>>>>>> i2c_dw_check_gpio_dependencies(AMDI0010:00)
>>>>>>>>> [    1.122523] i2c-dw-gpio-dbg:
>>>>>>>>> check_child_gpioint(adev=XXXX0000:00)
>>>>>>>>> [    1.122625] i2c-dw-gpio-dbg: GpioInt
>>>>>>>>> resource_source=\_SB.GPIO (len=10)
>>>>>>>>> [    1.122636] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>>>>> device=AMDI0030:00
>>>>>>>>> [    1.122639] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode()
>>>>>>>>> succeeded
>>>>>>>>> [    1.122642] i2c-dw-gpio-dbg: device_is_bound()=true for
>>>>>>>>> AMDI0030:00
>>>>>>>>> [    1.135894] i2c-dw-gpio-dbg:
>>>>>>>>> i2c_dw_check_gpio_dependencies(AMDI0010:01)
>>>>>>>>> [    1.135898] i2c-dw-gpio-dbg:
>>>>>>>>> check_child_gpioint(adev=SYNA8018:00)
>>>>>>>>> [    1.135976] i2c-dw-gpio-dbg: GpioInt
>>>>>>>>> resource_source=\_SB.GPIO (len=10)
>>>>>>>>> [    1.135980] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>>>>> device=AMDI0030:00
>>>>>>>>> [    1.135983] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode()
>>>>>>>>> succeeded
>>>>>>>>> [    1.135985] i2c-dw-gpio-dbg: device_is_bound()=true for
>>>>>>>>> AMDI0030:00
>>>>>>>>> [    1.135987] i2c-dw-gpio-dbg:
>>>>>>>>> check_child_gpioint(adev=NXP1001:00)
>>>>>>>>> [    1.136005] i2c-dw-gpio-dbg: GpioInt
>>>>>>>>> resource_source=\_SB.GPIO (len=10)
>>>>>>>>> [    1.136008] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>>>>>>> device=AMDI0030:00
>>>>>>>>> [    1.136009] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode()
>>>>>>>>> succeeded
>>>>>>>>> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for
>>>>>>>>> AMDI0030:00
>>>>>>>>>
>>>>>>>>> HTH, Ciao, Thorsten
>>>>>>>>>
>>>>>>>>>>> On Fri, 7 Aug 2026 at 19:37, Thorsten Leemhuis
>>>>>>>>>>> <linux@leemhuis.info> wrote:
>>>>>>>>>>>> On 7/28/26 10:30, Andi Shyti wrote:
>>>>>>>>>>>>> On Sat, Jul 18, 2026 at 11:13:31AM +0530, Hardik Prakash
>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>> I2C controllers may have child devices with GpioInt
>>>>>>>>>>>>>> resources that
>>>>>>>>>>>>>> depend on GPIO controllers being fully initialized. If the
>>>>>>>>>>>>>> I2C
>>>>>>>>>>>>>> controller probes and enumerates children before the
>>>>>>>>>>>>>> referenced GPIO
>>>>>>>>>>>>>> controller has completed probe, GPIO interrupts may not be
>>>>>>>>>>>>>> properly
>>>>>>>>>>>>>> configured, leading to device failures.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
>>>>>>>>>>>>>> AMDI0010:02) has a GpioInt resource pointing to GPIO 157
>>>>>>>>>>>>>> on the
>>>>>>>>>>>>>> pinctrl-amd controller (AMDI0030:00). When i2c-designware
>>>>>>>>>>>>>> probes
>>>>>>>>>>>>>> AMDI0010:02 before pinctrl-amd finishes initializing, I2C
>>>>>>>>>>>>>> transactions
>>>>>>>>>>>>>> fail with lost arbitration errors:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>    0.285952  amd_gpio_probe: registering gpiochip  <- GPIO
>>>>>>>>>>>>>> chip visible
>>>>>>>>>>>>>>    0.287121  amd_gpio_probe: requesting parent IRQ <-
>>>>>>>>>>>>>> probe still running
>>>>>>>>>>>>>>    0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <-
>>>>>>>>>>>>>> races here
>>>>>>>>>>>>>>    2.348157  lost arbitration
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Add a dependency check that walks ACPI child devices and
>>>>>>>>>>>>>> defers probe
>>>>>>>>>>>>>> until any referenced GPIO controller is bound.
>>>>>>>>>>
>>>>>>>>>> [...]
>>>>>>>>>>
>>>>>>>>>>>> #regzbot introduced: 0a4bb2abc3e56d
>>>>>>>>>>>> #regzbot title i2c: designware: ThinkPad touchpad broke
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
> 

