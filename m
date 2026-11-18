Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026180;
	b=bHknqPA1BQlLxFz/XI/R7xNdCJ0HL/jL62IjUNax7VxGnMHD9ehonsbZPMXIlUkXTvHk
	 WeFsLnehBJpOVdl34r7NTv7FHx90D0Nkr9lSG+1TtEJvq7mpevYYmS6qYWpaVy5I7Rpl7
	 62IXtrpUfxryH+8r8ygDSP8UhSXoO+octKQacPBaAQHxXblBeGOT0z/CkH/T0OKPd0rQK
	 HaJoBvuxcKIGKKc1VD1lrAl7BZQttGTEPbv6MyBNsLrosuupdHTcb5bGZ462ko5zCpDoP
	 cfo7thesscsvsjIiblQnVEjSlOVcYWWUUqWJQkEG+HKDygohjI+jMlaZd+gkvx7srEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026180;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SF2S7Kz97zTXP9nfsFo+IRKUWSLNUxGYr8SOTRSUO5o=;
	b=jEA0fYsK5eaU6cOAK0lqG46pdxHwo2msj/wu1XwQtf54Q1Dlu9fhtm/I6scotN/cF7wR
	 Qpwuu7T5LABfIZLedtnX/T1bWLDiEu2s5HfVjxCfB/qPm3CjZLUEsRM04iuAaDBn1z8uv
	 n0pAga8naOI2s2rMlJvEs/LSGWRkoFgvZAG2mnvKvh/sRr5GHOnMTfBVdAc1iddwvmssG
	 bqOiwqFhoIKg0SdGMybTHbptyGEcTsL4ZskiJbqwUEs/CsPHO7HK/2yCI390nk038Ycok
	 1VI8A50mDVVwDzNcSYeuMU28uXFapf5eolypU0ebx/4m+/JrZF66ANiwYPA+ywwgRkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doylQ1LV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0138E60A3802;
	Wed, 18 Nov 2026 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doylQ1LV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04C41F000D1;
	Wed, 18 Nov 2026 18:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795026179;
	bh=SF2S7Kz97zTXP9nfsFo+IRKUWSLNUxGYr8SOTRSUO5o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=doylQ1LVqI6f0UzWCC5SNSUuo9mhQ3rIiVsx93VzA6zUl3QSkrrXWpk+flquckwZq
	 p97s89PaHQ64NWJEov2bNtJVvDyRrY/xz56MRbcPYfRL8mbrf/yN43rkIC2Gx3JHMx
	 +FgsMqhRd+hH3NapkbrjNqGTsPU1xU7egw6wpGX3zPDezWmKRXiB/m+gk9mJosjp6D
	 qlPilDMgtp/e3gipO1aj4Vqa0R5wZrfQaVUcr2tzSSj0CQFRvYZGjYiqcYOUOhwHmp
	 Oe/mwLTpbocYA+zGZsQHqxwzaUvds3TpsPB/8ANZy2CM3hm7mbnbGalt3+fMivP5t9
	 JTjoIlXBOFuEA==
Subject:
 Re: [PATCH net-next v3 3/3] ptp: ocp: support the WiWi revision 02 Time Card
From: netdev-bot+sashiko@kernel.org
To: ahmadexp@gmail.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, andi.shyti@kernel.org,
 andrew+netdev@lunn.ch, corbet@lwn.net, davem@davemloft.net,
 edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us, kuba@kernel.org,
 linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, rdunlap@infradead.org,
 richardcochran@gmail.com, skhan@linuxfoundation.org
Date: Wed, 18 Nov 2026 18:22:58 +0000
Message-ID: <179502617840.3136.12704245716223038161@kernel.org>
In-Reply-To: <20261116-wiwi-v3-87afa10a8-3-ahmadexp@gmail.com>
References: <20261116-wiwi-v3-87afa10a8-3-ahmadexp@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch fixes the DPLL selector bugs for WiWi only.
- [Medium] The new ptp_ocp_wiwi_sma_out table gives DCF a frequency of
  77000.
- [Medium] On WiWi the patch removes GNSS2 (0x0008) from the SMA output
  table but never clears that selection in the output mux.
- [Medium] ptp: ocp: disabled WiWi SMA input reported as 10 MHz in
  ptp_ocp_dpll_frequency_get()
- [Low] On WiWi, ptp_ocp_sma_show() prints "OUT: unavailable\n" when the
  output selector holds a value missing from ptp_ocp_wiwi_sma_out, such…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is a
  remove-vs-ioctl race in ptp_ocp_detach() that can lead to a use-after-…

--

ptp: ocp: support the WiWi revision 02 Time Card

This adds support for the WiWi revision 02 Time Card (2163:1008, subsystem
10ee:0007). It reuses the FB resource table with WiWi-specific MMIO and
MSI-X offsets, adds a WiWi SMA output table without GNSS2, and drives an
MSI enable gate at BAR0 0x1800. On WiWi it also rejects devlink flash,
skips the SPI flash and GNSS2 UART, and blocks timestamper and generator
arming until probe has opened the interrupt gate.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index decc56892059b..df40dac982213 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -1384,6 +1421,23 @@ static const struct ocp_selector ptp_ocp_sma_out[] = {
>  	{ }
>  };
>  
> +/* No validated second receiver on the supported WiWi board. */
> +static const struct ocp_selector ptp_ocp_wiwi_sma_out[] = {
> +	{ .name = "10Mhz", .value = 0x0000, .frequency = 10000000 },
> +	{ .name = "PHC",   .value = 0x0001, .frequency = 1 },
> +	{ .name = "MAC",   .value = 0x0002, .frequency = 1 },
> +	{ .name = "GNSS1", .value = 0x0004, .frequency = 1 },
> +	{ .name = "IRIG",  .value = 0x0010, .frequency = 10000 },
> +	{ .name = "DCF",   .value = 0x0020, .frequency = 77000 },

[Severity: Medium]
Should this be 77500? The SMA DPLL pins advertise DPLL_PIN_FREQUENCY_DCF77
(77.5 kHz) in ptp_ocp_sma_freq[], and ptp_ocp_sma_in already uses 77500
for DCF.

For WiWi, ptp_ocp_dpll_frequency_set() now picks the hardware value with
tbl[i].frequency == frequency. A 77500 Hz request on an output SMA matches
nothing in ptp_ocp_wiwi_sma_out, so it returns -EINVAL.

In the other direction, ptp_ocp_dpll_frequency_get() would report 77000 Hz
for a DCF-routed output, and that frequency is not in the pin's supported
list.

The value was copied from ptp_ocp_sma_out, but this table and its
value-based DPLL path are new in this patch.

[ ... ]

> @@ -2944,6 +3019,14 @@ static const struct ocp_sma_op ocp_fb_sma_op = {
>  	.set_output	= ptp_ocp_sma_fb_set_output,
>  };
>  
> +static const struct ocp_sma_op ocp_wiwi_sma_op = {
> +	.tbl		= { ptp_ocp_sma_in, ptp_ocp_wiwi_sma_out },
> +	.init		= ptp_ocp_sma_fb_init,
> +	.get		= ptp_ocp_sma_fb_get,
> +	.set_inputs	= ptp_ocp_sma_fb_set_inputs,
> +	.set_output	= ptp_ocp_sma_fb_set_output,
> +};

[Severity: Medium]
GNSS2 (0x0008) is dropped from ptp_ocp_wiwi_sma_out, but the output mux is
never reprogrammed. ocp_wiwi_sma_op reuses ptp_ocp_sma_fb_init(), which
only reads sma_map1/sma_map2 to work out the pin direction:

    reg = ioread32(&bp->sma_map1->gpio2);
    bp->sma[2].mode = reg & BIT(15) ? SMA_MODE_OUT : SMA_MODE_IN;

Suppose an output selector already holds GNSS2 at bind time. That could
come from the FPGA default or from a previous kernel. It could also come
from the earlier driver build mentioned in the commit message, which used
the FB table with GNSS2. The CSR is not reset on driver reload. In that
case, will the SMA keep driving the GNSS2 PPS net?

In that state ptp_ocp_sma_show() prints "OUT: unavailable".
ptp_ocp_dpll_frequency_get() finds no match and returns -EINVAL, which
makes the DPLL pin dump fail.

The commit message says:

  "Do not expose an unvalidated second GNSS UART or PPS output source."

Should the WiWi SMA init replace any output selection that is missing
from ptp_ocp_wiwi_sma_out with the pin's default_fcn?

[ ... ]

> @@ -3394,6 +3506,8 @@ ptp_ocp_sma_show(struct ptp_ocp *bp, int sma_nr, char *buf,
>  		return ptp_ocp_show_inputs(tbl[0], val, buf, default_in_val);
>  	}
>  
> +	if (bp->wiwi && !ptp_ocp_select_name_from_val(tbl[1], val))
> +		return sysfs_emit(buf, "OUT: unavailable\n");
>  	return ptp_ocp_show_output(tbl[1], val, buf, default_out_val);
>  }

[Severity: Low]
Is "OUT: unavailable" meant to be part of the sysfs ABI?
Documentation/ABI/testing/sysfs-timecard describes the smaN read format
this way:

    The display format of the attribute is a space separated
    list of signals, prefixed by the input/output direction.

It also says output values come from available_sma_outputs, and
"unavailable" is not one of them. Writing the displayed value back fails
with -EINVAL, because sma_parse_inputs()->ptp_ocp_select_val_from_name()
finds no match.

Should the sysfs ABI document be updated along with the devlink rst?

[ ... ]

> @@ -5787,6 +5901,12 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>  	platform_device_unregister(bp->i2c_ctrl);
>  	if (bp->i2c_clk)
>  		clk_hw_unregister_fixed_rate(bp->i2c_clk);
> +	/* Keep child interrupts available until the children are gone. */
> +	if (bp->wiwi_msi) {
> +		iowrite32(0, bp->wiwi_msi);
> +		iowrite32(0, bp->wiwi_msi + 4);
> +		ioread32(bp->wiwi_msi);
> +	}
>  	if (bp->n_irqs)
>  		pci_free_irq_vectors(bp->pdev);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but the
new wiwi_timing_ready flag looks like it could close it.

ptp_ocp_detach() disables the timestampers before it unregisters the
clock:

    if (bp->pps)
        ptp_ocp_ts_enable(bp->pps, ~0, false);
    if (bp->ptp)
        ptp_clock_unregister(bp->ptp);

Until posix_clock_unregister() runs, can userspace still issue
PTP_EXTTS_REQUEST and reach ptp_ocp_enable()->ptp_ocp_ts_enable() with
enable=true, which re-arms the timestamper? On WiWi, ptp_ocp_timing_ready()
still returns true at this point, because wiwi_timing_ready is never
cleared.

ptp_disable_all_events() only disables EXTTS on pins whose func is
PTP_PF_EXTTS. ptp_ocp_set_pins() leaves func at PTP_PF_NONE, so a
re-armed channel stays enabled.

The MSI vector stays requested until ptp_ocp_unregister_ext() runs. The
WiWi gate at 0x1800 also stays open until the children have been freed.

If the fd that armed EXTTS has been closed, put_device() in
ptp_clock_unregister() frees the ptp_clock. An external edge would then
run this on freed memory:

ptp_ocp_ts_irq()
  ptp_clock_event(ext->bp->ptp, &ev)
    spin_lock_irqsave(&ptp->tsevqs_lock, ...)

Would it help to clear wiwi_timing_ready with smp_store_release(..., false)
or to mask OCP_WIWI_TIMING_IRQS before the disable loop?

[ ... ]

> @@ -5881,9 +6001,14 @@ static int ptp_ocp_dpll_frequency_set(const struct dpll_pin *pin,
>  		return -EOPNOTSUPP;
>  
>  	tbl = bp->sma_op->tbl[sma->mode];
> -	for (i = 0; tbl[i].name; i++)
> -		if (tbl[i].frequency == frequency)
> -			return ptp_ocp_sma_store_val(bp, i, sma->mode, sma_nr + 1);
> +	for (i = 0; tbl[i].name; i++) {
> +		if (tbl[i].frequency == frequency) {
> +			int val = bp->wiwi ? tbl[i].value : i;
> +
> +			return ptp_ocp_sma_store_val(bp, val, sma->mode,
> +						     sma_nr + 1);
> +		}
> +	}
>  	return -EINVAL;
>  }
>  
> @@ -5901,6 +6026,8 @@ static int ptp_ocp_dpll_frequency_get(const struct dpll_pin *pin,
>  	int i;
>  
>  	val = bp->sma_op->get(bp, sma_nr + 1);
> +	if (bp->wiwi)
> +		val &= SMA_SELECT_MASK;
>  	tbl = bp->sma_op->tbl[sma->mode];

[Severity: Medium]
When an SMA input is disabled, ptp_ocp_sma_store_val() sets
sma->disabled and writes 0 to the mux field, which also clears
SMA_ENABLE. With the new masking, ptp_ocp_dpll_frequency_get() then
looks up 0x0000 in ptp_ocp_sma_in and matches the 10Mhz entry.
Doesn't that make a disabled WiWi input report 10 MHz over DPLL
netlink?

ptp_ocp_sma_show() avoids this collision by substituting SMA_DISABLE
before the table lookup:

    if (sma->disabled)
        val = SMA_DISABLE;

So sysfs shows "IN: None" for a pin that DPLL reports as 10 MHz.

The wrong readback also gets in the way of re-enabling the pin.
dpll_pin_freq_set() calls frequency_get first. If the requested
frequency matches the current one, it returns 0 without calling
frequency_set. A 10 MHz request on the disabled input is therefore a
silent no-op. ptp_ocp_dpll_frequency_set() never runs and
sma->disabled stays set, yet the request still reports success.

Should ptp_ocp_dpll_frequency_get() check sma->disabled the same way,
so the lookup hits the "None" entry and reports 0 Hz? Or is there a
better way to report a disabled pin here? A disabled pin also reads
back 0 on the other boards that use ptp_ocp_sma_fb_get(), so the
check may belong in the common path rather than only under bp->wiwi.

[Severity: High]
WiWi now uses the hardware selector value here. Non-WiWi boards still pass
the table index i to ptp_ocp_sma_store_val(), so don't they keep the same
bug?

ptp_ocp_sma_store_val() expects a selector bitmask. The sysfs path
ptp_ocp_sma_store() passes it the value from sma_parse_inputs(), and
ptp_ocp_sma_store_val() ORs in SMA_ENABLE before writing the mux.

With ptp_ocp_sma_out (Meta, Celestica, ADVA), a 10 kHz request on an
output SMA matches IRIG at index 5. It writes 0x5 | SMA_ENABLE, which
selects PHC|GNSS1 instead of 0x10.

With ptp_ocp_sma_in, a 10 kHz request writes 0x5 (PPS1|TS1) instead of
IRIG (0x10). A 77500 Hz request writes 0x6 (PPS2|TS1) instead of DCF
(0x20).

On ART, a 1 Hz request writes 0, which ptp_ocp_art_sma_set() rejects.

ptp_ocp_dpll_frequency_get() has the same split. ptp_ocp_sma_fb_get()
returns the raw 16-bit field:

    return (ioread32(gpio) >> shift) & 0xffff;

On FB/ADVA pins whose direction can change, SMA_ENABLE (BIT(15)) is set,
so no table entry matches and the callback returns -EINVAL.
dpll_msg_add_pin_freq() in drivers/dpll/dpll_netlink.c passes that error
on, so the DPLL pin get/dump fails for that pin. By comparison,
ptp_ocp_sma_show() masks with SMA_SELECT_MASK on every board.

The commit message says:

  "Use hardware selector values for WiWi DPLL routing; preserve the
  existing behavior on other boards."

Could tbl[i].value and the SMA_SELECT_MASK masking be applied on every
board instead, as a separate fix with Fixes: 09eeb3aecc6c ("ptp_ocp:
implement DPLL ops"), rather than only for WiWi?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116-wiwi-v3-87afa10a8-0-ahmadexp%40gmail.com
