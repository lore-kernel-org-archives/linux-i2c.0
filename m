Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3159F39A066;
	Mon, 10 Aug 2026 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786344523; cv=none; b=B84mkk00U+G0eNmP9QU2BcWa2/fJqpsCUsVqZpyNgvnN+lyGou1hwIuUzobeNGxmcOU0SHBgLXLPv9BUmTlHSB+geTKNIO5ncEEglQm7o1ikDW4vGQ5/+437is+xS8nIXFigqTwhe+QKgpggjrrlD59YQqrIaPpdHV5vbCceyXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786344523; c=relaxed/simple;
	bh=0YgfSDRWRvwm8JaNBzw6AVNCOHoavrNKZe+JEUOzA7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpF0eIslr/4GvjLqq0YjRI8LcS6AVhrHjKZlvvOic1mo5l6oVZ6aPtKuB+H27HZhGuwZMCL6Ezf/8YmjksD8Hn+I2xOwMBv+qA3Tt8Fbw8CrlvwB7YyG2ZdwKzeMHAlC7FFtbeMypW9thn+pHo1aUOrsTdsp3Om3vPTmRb1aL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=F9oE9Wn0; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="F9oE9Wn0"
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4hJQLx69dPz8FcM;
	Mon, 10 Aug 2026 08:48:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1786344505;
	bh=0YgfSDRWRvwm8JaNBzw6AVNCOHoavrNKZe+JEUOzA7c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F9oE9Wn0BxsNeqDMBaNFuMySIxRaWvj6SFD5yvj6JZbTl14pHIE1P12PDCZ7WTdlK
	 nZzn+gWrAqTYCEEXt5JdFGG/B0IepXsDKxximq0NwgtX0Jv3MOo3PXs2FAnBzeCsyg
	 MaP245AsmJHB4kESfN1ij9a84lqf3EJbHfH0cy3q67ePCxUK21Qw9x6IfxEf2QLUX7
	 gfweR41mfqsYcCQeqIH1N4xJvM79fqQ1sj79yvfeLvaimLW12vHe+lKDU+p9vhxVIt
	 qaz33VoK5OrEvWjfxxrZgcooZaJipp56B4AyqCKhWBQt8rRHt+0eqBeosNHUJB2cap
	 T+tyUlEo5NIOQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4hJQLx5S6Cz4xD1;
	Mon, 10 Aug 2026 08:48:25 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hJQLx1sKWz8sZg;
	Mon, 10 Aug 2026 08:48:25 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id E02AE5FB65;
	Mon, 10 Aug 2026 08:48:19 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=linux@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <5a5f7f58-b35b-407f-a5e5-293a88cafcc0@leemhuis.info>
Date: Mon, 10 Aug 2026 08:48:18 +0200
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
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 xsFNBFJ4AQ0BEADCz16x4kl/YGBegAsYXJMjFRi3QOr2YMmcNuu1fdsi3XnM+xMRaukWby47
 JcsZYLDKRHTQ/Lalw9L1HI3NRwK+9ayjg31wFdekgsuPbu4x5RGDIfyNpd378Upa8SUmvHik
 apCnzsxPTEE4Z2KUxBIwTvg+snEjgZ03EIQEi5cKmnlaUynNqv3xaGstx5jMCEnR2X54rH8j
 QPvo2l5/79Po58f6DhxV2RrOrOjQIQcPZ6kUqwLi6EQOi92NS9Uy6jbZcrMqPIRqJZ/tTKIR
 OLWsEjNrc3PMcve+NmORiEgLFclN8kHbPl1tLo4M5jN9xmsa0OZv3M0katqW8kC1hzR7mhz+
 Rv4MgnbkPDDO086HjQBlS6Zzo49fQB2JErs5nZ0mwkqlETu6emhxneAMcc67+ZtTeUj54K2y
 Iu8kk6ghaUAfgMqkdIzeSfhO8eURMhvwzSpsqhUs7pIj4u0TPN8OFAvxE/3adoUwMaB+/plk
 sNe9RsHHPV+7LGADZ6OzOWWftk34QLTVTcz02bGyxLNIkhY+vIJpZWX9UrfGdHSiyYThHCIy
 /dLz95b9EG+1tbCIyNynr9TjIOmtLOk7ssB3kL3XQGgmdQ+rJ3zckJUQapLKP2YfBi+8P1iP
 rKkYtbWk0u/FmCbxcBA31KqXQZoR4cd1PJ1PDCe7/DxeoYMVuwARAQABzSdUaG9yc3RlbiBM
 ZWVtaHVpcyA8bGludXhAbGVlbWh1aXMuaW5mbz7CwZQEEwEKAD4CGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AWIQSoq8a+lZZX4oPULXVytubvTFg9LQUCaOO74gUJHfEI0wAKCRBytubv
 TFg9Lc4iD/4omf2z88yGmior2f1BCQTAWxI2Em3S4EJY2+Drs8ZrJ1vNvdWgBrqbOtxN6xHF
 uvrpM6nbYIoNyZpsZrqS1mCA4L7FwceFBaT9CTlQsZLVV/vQvh2/3vbj6pQbCSi7iemXklF7
 y6qMfA7rirvojSJZ2mi6tKIQnD2ndVhSsxmo/mAAJc4tiEL+wkdaX1p7bh2Ainp6sfxTqL6h
 z1kYyjnijpnHaPgQ6GQeGG1y+TSQFKkb/FylDLj3b3efzyNkRjSohcauTuYIq7bniw7sI8qY
 KUuUkrw8Ogi4e6GfBDgsgHDngDn6jUR2wDAiT6iR7qsoxA+SrJDoeiWS/SK5KRgiKMt66rx1
 Jq6JowukzNxT3wtXKuChKP3EDzH9aD+U539szyKjfn5LyfHBmSfR42Iz0sofE4O89yvp0bYz
 GDmlgDpYWZN40IFERfCSxqhtHG1X6mQgxS0MknwoGkNRV43L3TTvuiNrsy6Mto7rrQh0epSn
 +hxwwS0bOTgJQgOO4fkTvto2sEBYXahWvmsEFdLMOcAj2t7gJ+XQLMsBypbo94yFYfCqCemJ
 +zU5X8yDUeYDNXdR2veePdS3Baz23/YEBCOtw+A9CP0U4ImXzp82U+SiwYEEQIGWx+aVjf4n
 RZ/LLSospzO944PPK+Na+30BERaEjx04MEB9ByDFdfkSbM7BTQRSeAENARAAzu/3satWzly6
 +Lqi5dTFS9+hKvFMtdRb/vW4o9CQsMqL2BJGoE4uXvy3cancvcyodzTXCUxbesNP779JqeHy
 s7WkF2mtLVX2lnyXSUBm/ONwasuK7KLz8qusseUssvjJPDdw8mRLAWvjcsYsZ0qgIU6kBbvY
 ckUWkbJj/0kuQCmmulRMcaQRrRYrk7ZdUOjaYmjKR+UJHljxLgeregyiXulRJxCphP5migoy
 ioa1eset8iF9fhb+YWY16X1I3TnucVCiXixzxwn3uwiVGg28n+vdfZ5lackCOj6iK4+lfzld
 z4NfIXK+8/R1wD9yOj1rr3OsjDqOaugoMxgEFOiwhQDiJlRKVaDbfmC1G5N1YfQIn90znEYc
 M7+Sp8Rc5RUgN5yfuwyicifIJQCtiWgjF8ttcIEuKg0TmGb6HQHAtGaBXKyXGQulD1CmBHIW
 zg7bGge5R66hdbq1BiMX5Qdk/o3Sr2OLCrxWhqMdreJFLzboEc0S13BCxVglnPqdv5sd7veb
 0az5LGS6zyVTdTbuPUu4C1ZbstPbuCBwSwe3ERpvpmdIzHtIK4G9iGIR3Seo0oWOzQvkFn8m
 2k6H2/Delz9IcHEefSe5u0GjIA18bZEt7R2k8CMZ84vpyWOchgwXK2DNXAOzq4zwV8W4TiYi
 FiIVXfSj185vCpuE7j0ugp0AEQEAAcLBfAQYAQoAJgIbDBYhBKirxr6Vllfig9QtdXK25u9M
 WD0tBQJo47viBQkd8QjTAAoJEHK25u9MWD0tCH8P/1b+AZ8K3D4TCBzXNS0muN6pLnISzFa0
 cWcylwxX2TrZeGpJkg14v2R0cDjLRre9toM44izLaz4SKyfgcBSj9XET0103cVXUKt6SgT1o
 tevoEqFMKKp3vjDpKEnrcOSOCnfH9W0mXx/jDWbjlKbBlN7UBVoZD/FMM5Ul0KSVFJ9Uij0Z
 S2WAg50NQi71NBDPcga21BMajHKLFzb4wlBWSmWyryXI6ouabvsbsLjkW3IYl2JupTbK3viH
 pMRIZVb/serLqhJgpaakqgV7/jDplNEr/fxkmhjBU7AlUYXe2BRkUCL5B8KeuGGvG0AEIQR0
 dP6QlNNBV7VmJnbU8V2X50ZNozdcvIB4J4ncK4OznKMpfbmSKm3t9Ui/cdEK+N096ch6dCAh
 AeZ9dnTC7ncr7vFHaGqvRC5xwpbJLg3xM/BvLUV6nNAejZeAXcTJtOM9XobCz/GeeT9prYhw
 8zG721N4hWyyLALtGUKIVWZvBVKQIGQRPtNC7s9NVeLIMqoH7qeDfkf10XL9tvSSDY6KVl1n
 K0gzPCKcBaJ2pA1xd4pQTjf4jAHHM4diztaXqnh4OFsu3HOTAJh1ZtLvYVj5y9GFCq2azqTD
 pPI3FGMkRipwxdKGAO7tJVzM7u+/+83RyUjgAbkkkD1doWIl+iGZ4s/Jxejw1yRH0R5/uTaB MEK4
In-Reply-To: 
 <CANTFpSWnTjoTS8hBOvVM_w3pWHyOiBhch_GXe_mG-d56WeF-0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178634450053.1965100.10858780517657452661@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: E02AE5FB65
X-NC-CID: zMw+Bz0y/mBSyderzXH+Gc6zvvv0N4CG0N9BE6v7AaRWLj8EMio=

On 8/10/26 07:54, Hardik Prakash wrote:
> On Sun, 9 Aug 2026, Thorsten Leemhuis wrote:
>> Sorry, picked the wrong file while preparing the mail, it's here:
>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg
> 
> Thanks, that's the one. Full timeline from that boot:
> 
>   0.619s  AMDI0010:00 and AMDI0010:01 defer (AMDI0030:00 not registered)
>   1.136s  Retry succeeds: device_is_bound()=true for AMDI0030:00,
>           confirmed for all three children (XXXX0000:00, SYNA8018:00,
>           NXP1001:00)
>   2.222s  lost arbitration on AMDI0010:01 (x3)
>   3.260s  controller timed out, HID descriptor fetch fails
> 
> The dependency check itself is behaving correctly here -- it defers,
> then correctly confirms AMDI0030:00 is bound before letting probe
> continue. The arbitration failure happens over a second *after* that,
> when the touchpad attempts its actual first transaction.
> 
> So this doesn't look like a logic bug in the check itself. My read: by
> delaying dw_i2c_plat_probe() by ~500ms (correctly, for GPIO's sake),
> something else ends up contending for the AMDI0010:01 bus by the time
> the touchpad's first transaction actually happens -- a window that
> the original (undeferred, earlier) probe attempt apparently avoided.
> 
> Mario -- does this look like a known AMD I2C/PSP semaphore contention
> pattern to you? Wondering if there's a shared bus/firmware consumer
> that could explain a ~1s-later collision like this, independent of
> the GPIO controller itself being ready.
> 
> Thorsten, if you have it handy: /proc/interrupts and lsmod from this
> boot would help narrow down what else might be touching that bus
> around the 2.2s mark.

Did a fresh boot and uploaded the dmesg again as well just in case:

https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg2
https://www.leemhuis.info/files/misc/lsmod
https://www.leemhuis.info/files/misc/interrupts

Ciao, Thorsten
> On Mon, 10 Aug 2026 at 11:06, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>
>> On 8/10/26 07:23, Hardik Prakash wrote:
>>> On Sat, 8 Aug 2026, Thorsten Leemhuis wrote:
>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>>>>
>>>> [    0.619018] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
>>>> [...]
>>>> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
>>>
>>> Thanks, this trace looks correct on its face (defer at 0.619s, retry
>>> succeeds at 1.122-1.136s), but the link above points to the same file
>>> you sent last round (the master+revert baseline, no debug patch, no
>>> i2c-dw-gpio-dbg lines in it at all) rather than this new capture.
>>>> Could you share the full, unfiltered dmesg from this exact boot (the
>>> one with the debug patch applied)? I need to see where
>>> "lost arbitration" falls relative to the trace above.
>>
>> Sorry, picked the wrong file while preparing the mail, it's here:
>> https://www.leemhuis.info/files/misc/dmesg_patch_dyndbg
>>
>> Ciao, Thorsten
>>
>>> Separately, from your DSDT: NFC1 (NXP1001), which shows up as a child
>>> of AMDI0010:01 in your trace, declares its _CRS as a raw resource
>>> buffer containing three GPIO resources referencing \_SB.GPIO -- one
>>> GpioIo and two separate GpioInt entries. Not sure yet if that's
>>> relevant, but it's a pattern I haven't seen on my hardware
>>> which I've tested against.
>>>
>>> Thanks,
>>> Hardik
>>>
>>> On Sun, 9 Aug 2026 at 21:49, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>>
>>>> On 8/8/26 22:25, Andy Shevchenko wrote:
>>>>> On Sat, Aug 08, 2026 at 10:31:28PM +0530, Hardik Prakash wrote:
>>>>>> On Fri, 7 Aug 2026, Thorsten Leemhuis wrote:
>>>>>>> This became 0a4bb2abc3e56d ("i2c: designware: defer probe if child
>>>>>>> GpioInt controllers are not bound") and causes a regression for me: the
>>>>>>> Touchpad in my ThinkPad T14s Gen 4 (AMD) stopped working. From the
>>>>>>> kernel log:
>>>>>>>
>>>>>>> i2c_designware AMDI0010:01: i2c_dw_handle_tx_abort: lost arbitration
>>>>>>> i2c_designware AMDI0010:01: controller timed out
>>>>>>> i2c_hid_acpi i2c-SYNA8018:00: failed to fetch HID descriptor: -110
>>>>>>> i2c_hid_acpi i2c-SYNA8018:00: Failed to fetch the HID Descriptor
>>>>>>>
>>>>>>> Reverting this change in current mainline/master (f9a2394a23482) fixed
>>>>>>> things for me. Full dmesg of current master and master+revert can be
>>>>>>> found here:
>>>>>>>
>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master
>>>>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>>>>>> [...]
>>>>>> Two things that would help narrow this down, whenever you have a moment:
>>>>
>>>> Thx for looking into this. Here we go:
>>>>
>>>>>> 1. A DSDT dump
>>>>
>>>> https://www.leemhuis.info/files/misc/dsdt.dsl
>>>>
>>>>>> 2. A dmesg with dynamic debug from a kernel built with the attached
>>>>>>    patch on top of current mainline/master
>>>>
>>>> https://www.leemhuis.info/files/misc/dmesg-master-plus_revert
>>>>
>>>> [    0.619018] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
>>>> [    0.619018] i2c-dw-gpio-dbg: check_child_gpioint(adev=XXXX0000:00)
>>>> [    0.619076] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>> [    0.619079] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>> device=AMDI0030:00
>>>> [    0.619080] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() returned
>>>> NULL, deferring
>>>> [    0.619082] i2c-dw-gpio-dbg: check_child_gpioint ret=-517 (defer)
>>>> [    0.619102] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:01)
>>>> [    0.619104] i2c-dw-gpio-dbg: check_child_gpioint(adev=SYNA8018:00)
>>>> [    0.619159] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>> [    0.619162] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>> device=AMDI0030:00
>>>> [    0.619162] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() returned
>>>> NULL, deferring
>>>> [    0.619164] i2c-dw-gpio-dbg: check_child_gpioint ret=-517 (defer)
>>>> [    1.122517] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:00)
>>>> [    1.122523] i2c-dw-gpio-dbg: check_child_gpioint(adev=XXXX0000:00)
>>>> [    1.122625] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>> [    1.122636] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>> device=AMDI0030:00
>>>> [    1.122639] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
>>>> [    1.122642] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
>>>> [    1.135894] i2c-dw-gpio-dbg: i2c_dw_check_gpio_dependencies(AMDI0010:01)
>>>> [    1.135898] i2c-dw-gpio-dbg: check_child_gpioint(adev=SYNA8018:00)
>>>> [    1.135976] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>> [    1.135980] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>> device=AMDI0030:00
>>>> [    1.135983] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
>>>> [    1.135985] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
>>>> [    1.135987] i2c-dw-gpio-dbg: check_child_gpioint(adev=NXP1001:00)
>>>> [    1.136005] i2c-dw-gpio-dbg: GpioInt resource_source=\_SB.GPIO (len=10)
>>>> [    1.136008] i2c-dw-gpio-dbg: acpi_fetch_acpi_dev() succeeded,
>>>> device=AMDI0030:00
>>>> [    1.136009] i2c-dw-gpio-dbg: gpio_device_find_by_fwnode() succeeded
>>>> [    1.136010] i2c-dw-gpio-dbg: device_is_bound()=true for AMDI0030:00
>>>>
>>>> HTH, Ciao, Thorsten
>>>>
>>>>>> On Fri, 7 Aug 2026 at 19:37, Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>>>>> On 7/28/26 10:30, Andi Shyti wrote:
>>>>>>>> On Sat, Jul 18, 2026 at 11:13:31AM +0530, Hardik Prakash wrote:
>>>>>>>>> I2C controllers may have child devices with GpioInt resources that
>>>>>>>>> depend on GPIO controllers being fully initialized. If the I2C
>>>>>>>>> controller probes and enumerates children before the referenced GPIO
>>>>>>>>> controller has completed probe, GPIO interrupts may not be properly
>>>>>>>>> configured, leading to device failures.
>>>>>>>>>
>>>>>>>>> On Lenovo Yoga 7 14AGP11, the WACF2200 touchscreen (child of
>>>>>>>>> AMDI0010:02) has a GpioInt resource pointing to GPIO 157 on the
>>>>>>>>> pinctrl-amd controller (AMDI0030:00). When i2c-designware probes
>>>>>>>>> AMDI0010:02 before pinctrl-amd finishes initializing, I2C transactions
>>>>>>>>> fail with lost arbitration errors:
>>>>>>>>>
>>>>>>>>>   0.285952  amd_gpio_probe: registering gpiochip  <- GPIO chip visible
>>>>>>>>>   0.287121  amd_gpio_probe: requesting parent IRQ <- probe still running
>>>>>>>>>   0.301454  AMDI0010:02 dw_i2c_plat_probe: start  <- races here
>>>>>>>>>   2.348157  lost arbitration
>>>>>>>>>
>>>>>>>>> Add a dependency check that walks ACPI child devices and defers probe
>>>>>>>>> until any referenced GPIO controller is bound.
>>>>>
>>>>> [...]
>>>>>
>>>>>>> #regzbot introduced: 0a4bb2abc3e56d
>>>>>>> #regzbot title i2c: designware: ThinkPad touchpad broke
>>>>>
>>>>
>>>
>>
> 

