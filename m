Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC6912CDA5;
	Sat,  8 Aug 2026 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786222021; cv=none; b=AX5BAIux+CmItPnpfeU7anMbcGZItYc/Gpr6LzTCAdnM8WSC1P8iXoKWwiIKGHAoo8TTLEL10B4smUMR9k3WQ5EP7G3UuQtsp4Zh7IXKMjU96xcB9N3BBiTZWHBfS96qeIrmQIGEwgKh6QxDjE6JA1tDS7nkuYdPr0egx2prlD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786222021; c=relaxed/simple;
	bh=a7qobFD5p6pxF/niembnFqu5jYJKrEIWj6ctD5Fr98k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd9RW/bdl5uRObOeWnB8f6OtSGNbYJ3/Z6tXUb4kgMuhGoWWTWgO0t/AQwZz5/G6rLgZSUBSofkWtrLYn4WmmFwLuXrIRJ53VsE+S0Cc/fOR+z/BoKDG9nhCtmtFSL1CZUTFwZcoge1RTeVjoqgQEx/sDPLixDLoaM366lgymqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYhQc6Nh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYhQc6Nh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786222019; x=1817758019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a7qobFD5p6pxF/niembnFqu5jYJKrEIWj6ctD5Fr98k=;
  b=WYhQc6NhvuJXApf25a2cUiL7rsvBfYjPUO8zVgg2xEND8BicGQF+luGx
   hyGTJGVubGp8rYl+4ieNWLjA1Xk06JW+hXX9lrU3Eyc2pj6yEqR4fITNo
   n1tH+5uoomby9L+FU3K4sPqxdOLwZokrGv3T+VKYjNEVst5irKsj7QhwV
   +iRokcHRNPosJp1w0VPCPs4GuD639gSbKbzUAxDSCwVSXMnihzVdhD/QS
   BDkUHoUxvlleVtneCSI5kHVXFAk0vYzgPqlYovCZcCjQRMgF/SMljitT3
   f6YvjOODfknH/18AaHdHgnKnN8AT1MmZPYBrd0jIxqbw+REh74FWCu/NX
   Q==;
X-CSE-ConnectionGUID: kuQCZ2m5TeSYG1U5rH8Ggw==
X-CSE-MsgGUID: HlmCAOOuTXShKAoKl5UXOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="97444631"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="97444631"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:46:58 -0700
X-CSE-ConnectionGUID: Qy3n1POiQH643kk4Dn3sQQ==
X-CSE-MsgGUID: ysd/4jkyS62KwMUA33tpjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="263305922"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:46:56 -0700
Date: Sat, 8 Aug 2026 23:46:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baineng Shou <shoubaineng@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] i2c: designware: add atomic transfer support for
 IRQ-off contexts
Message-ID: <aneVvWDgfYr5bEun@ashevche-desk.local>
References: <20260807113333.1635449-1-shoubaineng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807113333.1635449-1-shoubaineng@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: @bigeasy (the question below)

On Fri, Aug 07, 2026 at 07:33:33PM +0800, Baineng Shou wrote:
> The DesignWare I2C controller driver cannot perform transfers when
> IRQs are disabled, e.g. during noirq system resume where an I2C
> client (GPIO expander, PMIC) must be accessed before IRQs are
> re-enabled: the interrupt-driven path calls wait_for_completion_timeout()
> which deadlocks with IRQs off.
> 
> The i2c core already routes to master_xfer_atomic() when
> i2c_in_atomic_xfer_mode() is true, but that gate requires
> system_state > SYSTEM_RUNNING, which does not hold during resume_noirq
> (system_state is already SYSTEM_RUNNING there).  So the framework
> atomic path does not cover resume_noirq either, and designware does
> not implement master_xfer_atomic at all.
> 
> Implement i2c_dw_xfer_atomic() and register it as ->xfer_atomic.
> It reuses the existing i2c_dw_process_transfer() state machine (the
> TX/RX/STOP/ABRT handling is identical to the interrupt path) but:
> 
>   - drives the clock directly via i2c_dw_prepare_clk() instead of
>     pm_runtime (which may sleep),
>   - sets ACCESS_POLLING for the duration of the transfer so register
>     reads use IC_RAW_INTR_STAT and the hardware interrupt is masked,
>   - polls with udelay() + a retry count instead of usleep_range() +
>     jiffies, neither of which is safe with IRQs disabled (the tick is
>     frozen so jiffies does not advance, and usleep_range() may sleep).
> 
> Also fall back to i2c_dw_xfer_atomic() from i2c_dw_xfer() when IRQs
> are disabled, since i2c_in_atomic_xfer_mode() does not cover
> resume_noirq.

The below paragraph should go...

> This is an RFC: the resume_noirq coverage relies on the driver-side
> irqs_disabled() fallback because the framework gate is closed there.
> I'd like feedback on whether that fallback is acceptable or whether
> the gate should be widened in the i2c core instead.
> 
> Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
> ---

...here as a comment / question.

> +/* Poll up to ~1s in 10us steps; bounded fallback for the IRQ-off path. */
> +#define I2C_DESIGNWARE_ATOMIC_POLL_RETRIES	100000

Just add a constant for the step time, this will give some clarification to the
above comment.

#define I2C_DESIGNWARE_ATOMIC_POLL_STEP_US	10

> +/*
> + * Atomic-context variant of i2c_dw_wait_transfer().  The normal polling
> + * path (ACCESS_POLLING branch in i2c_dw_wait_transfer()) uses usleep_range()
> + * and a jiffies deadline, neither of which is safe when IRQs are disabled
> + * (noirq system resume, shutdown): the tick is frozen so jiffies does not
> + * advance, and usleep_range() may sleep.  Poll IC_RAW_INTR_STAT with
> + * udelay() and a retry count instead, while reusing the shared
> + * i2c_dw_process_transfer() state machine so TX/RX/STOP/ABRT handling is
> + * identical to the interrupt path.  Caller must have set ACCESS_POLLING.
> + */
> +static int i2c_dw_wait_transfer_atomic(struct dw_i2c_dev *dev)
> +{
> +	unsigned int stat;
> +	int retries = I2C_DESIGNWARE_ATOMIC_POLL_RETRIES;
> +
> +	do {
> +		if (try_wait_for_completion(&dev->cmd_complete))
> +			return 0;
> +
> +		stat = i2c_dw_read_clear_intrbits(dev);
> +		if (stat)
> +			i2c_dw_process_transfer(dev, stat);
> +		else
> +			udelay(10);
> +	} while (--retries > 0);

' > 0' is redundant and gives actually off-by-one (the amount of retries).

> +	return -ETIMEDOUT;
> +}
> +
> +/*
> + * i2c_dw_xfer_atomic - transfer messages in atomic context.
> + *
> + * Used when IRQs are disabled, e.g. during noirq system resume where an
> + * I2C client (GPIO expander, PMIC) must be accessed before IRQs are
> + * re-enabled.  pm_runtime and mutexes may sleep, so drive the clock
> + * directly via i2c_dw_prepare_clk(); ACCESS_POLLING makes register reads
> + * use IC_RAW_INTR_STAT and routes the wait through
> + * i2c_dw_wait_transfer_atomic().
> + */

> +int
> +i2c_dw_xfer_atomic(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)

Make it a single line.

> +{
> +	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
> +	unsigned int flags = dev->flags;
> +	int ret;
> +
> +	dev->flags |= ACCESS_POLLING;
> +
> +	ret = i2c_dw_prepare_clk(dev, true);
> +	if (ret)
> +		goto out_flags;
> +
> +	ret = i2c_dw_acquire_lock(dev);
> +	if (ret)
> +		goto out_clk;
> +
> +	reinit_completion(&dev->cmd_complete);
> +	dev->msgs = msgs;
> +	dev->msgs_num = num;
> +	dev->cmd_err = 0;
> +	dev->msg_write_idx = 0;
> +	dev->msg_read_idx = 0;
> +	dev->msg_err = 0;
> +	dev->status = 0;
> +	dev->abort_source = 0;
> +	dev->rx_outstanding = 0;
> +
> +	i2c_dw_xfer_init(dev);
> +
> +	ret = i2c_dw_wait_transfer_atomic(dev);
> +
> +	if (i2c_dw_is_controller_active(dev)) {
> +		i2c_recover_bus(&dev->adapter);
> +		i2c_dw_init(dev);
> +	} else {
> +		__i2c_dw_disable_nowait(dev);
> +	}

> +	if (!ret) {

Use traditional pattern, id est

	if (ret)
		goto out_release_lock;

> +		if (likely(!dev->cmd_err && !dev->status))
> +			ret = 0;

		goto out_release_lock;

> +		else if (dev->cmd_err == DW_IC_ERR_TX_ABRT)
> +			ret = i2c_dw_handle_tx_abort(dev);
> +		else
> +			ret = -EIO;
> +	}
> +
> +	i2c_dw_release_lock(dev);
> +out_clk:
> +	i2c_dw_prepare_clk(dev, false);
> +out_flags:
> +	dev->flags = flags;
> +	return ret < 0 ? ret : num;
> +}

...

> +	/*
> +	 * Fall back to the atomic path when IRQs are disabled, e.g. during
> +	 * noirq system resume where an I2C client (GPIO expander, PMIC)
> +	 * must be accessed before IRQs are re-enabled.  The i2c core's
> +	 * i2c_in_atomic_xfer_mode() gate does not cover resume_noirq
> +	 * (system_state is already SYSTEM_RUNNING there), so the driver has
> +	 * to route the transfer itself.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) ? !preemptible() : irqs_disabled())

I don't like this. Do we have something better for this?
Perhaps @bigeasy knows?

> +		return i2c_dw_xfer_atomic(adap, msgs, num);

-- 
With Best Regards,
Andy Shevchenko


