Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E548E347FD7;
	Fri, 23 Jan 2026 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151795; cv=none; b=o5mdpD535IAIongKUMs2Ow5r4juuiAQBzGMgO/2sPPhGnUg628s9og0e9ejwrLZf8BvVyPHl91gI67O/XD3XRfZQW1VK0KAeIlTOmO3asuTzO7e9hdvWFXtLQphDMAzec0WKqH9DMmq3isZrM5+sSg7bb+awcyN1+lxEfjJbSHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151795; c=relaxed/simple;
	bh=k02OseP2N65ITQBV+pMi3tioz8qOOnJftgHC9O14HGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBwxlPjLboMNme1xH7fNIYIt3Q6dJrCg1G7TS7D9jTYsHQxi58UbA7hX6Mu4uTjQIqoBPpU3NSgEIxC/oxmqi6Pq7HGFiVCnmoy7JBJ6AkvAKcjvnmvPS3XF3dmUQK90WjvyAcqx1vTn4hMvXYfZKmdcRowv+ZWKRdDe3BKmpCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIYgycjD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIYgycjD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769151791; x=1800687791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=k02OseP2N65ITQBV+pMi3tioz8qOOnJftgHC9O14HGE=;
  b=nIYgycjDYZrpgZH5r3LgXr4Vj+kuGoJUyOFj9Nmp4fnZPb2ZD1u4vXKg
   jFCusk/jVFXxoSj6StL3F+5WdZio//6GqtWJdt7kSIr+hCOFlt7Jd3lZ2
   gKv7zXQXf9oXO66cM+X67hfyW+Ng1T5F+O3rypv66uqXdsIRPSBW3ooMe
   YPeN9S4S55ycyAjenNywdPeeIbjhbLNFo7ukNJlqTq7mFvXoCkE+Q2aaw
   5Cq0ZmOFYXb/byjBPi+i3F7BkgDvqxG8ePlBzkchvucGL043fswT9kgvG
   2U30Pu/Usg8DueBtlNOHo+QpSeGH2JxcoSMwnLTCDPZ7WBV+U3fkWYeOj
   w==;
X-CSE-ConnectionGUID: XJ62kcPzQH+POhTi/V6Vmw==
X-CSE-MsgGUID: Pb0q26fTRGq4+fXgwNQnjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74034239"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="74034239"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 23:03:08 -0800
X-CSE-ConnectionGUID: bYWh3vtEQ42s8yRCsy9wfg==
X-CSE-MsgGUID: Bjh/MTqqTP2sQrdfWxAK4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211954366"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 22 Jan 2026 23:03:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id E7C2E95; Fri, 23 Jan 2026 08:03:02 +0100 (CET)
Date: Fri, 23 Jan 2026 08:03:02 +0100
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Dmitry Guzman <dmitry.guzman@mobileye.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5 6/6] i2c: designware: Support of controller with
 IC_EMPTYFIFO_HOLD_MASTER disabled
Message-ID: <aXMdJtaQ1eHj3PDJ@black.igk.intel.com>
References: <20260120-i2c-dw-v5-0-0e34d6d9455c@bootlin.com>
 <20260120-i2c-dw-v5-6-0e34d6d9455c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120-i2c-dw-v5-6-0e34d6d9455c@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 20, 2026 at 10:28:06AM +0100, Benoît Monin wrote:
> If IC_EMPTYFIFO_HOLD_MASTER_EN parameter is 0, "Stop" and "Repeated Start"
> bits in command register does not exist, thus it is impossible to send

do not exist

> several consecutive write messages in a single hardware batch. The
> existing implementation worked with such configuration incorrectly:
> all consecutive write messages are joined into a single message without
> any Start/Stop or Repeated Start conditions. For example, the following
> command:
> 
>     i2ctransfer -y 0 w1@0x55 0x00 w1@0x55 0x01
> 
> does the same as
> 
>     i2ctransfer -y 0 w2@0x55 0x00 0x01
> 
> In i2c_dw_msg_is_valid(), we ensure that we do not have such sequence
> of messages requiring a RESTART, aborting the transfer on controller
> that cannot emit them explicitly.
> 
> This behavior is activated by compatible entries because the state of
> the IC_EMPTYFIFO_HOLD_MASTER_EN parameter cannot be detected at runtime.
> The new flag emptyfifo_hold_master reflects the state of the parameter,
> it is set to true for all controllers except those found in Mobileye
> SoCs. For now, the controllers in Mobileye SoCs are the only ones known
> to need the workaround. The behavior of the driver is left unmodified
> for other controllers.
> 
> There is another possible problem with this controller configuration:
> When the CPU is putting commands to the FIFO, this process must not be
> interrupted because if FIFO buffer gets empty, the controller finishes
> the I2C transaction and generates STOP condition on the bus.
> 
> If we continue writing the remainder of the message to the FIFO, the
> controller will start emitting a new transaction with those data. This
> turns a single a single message into multiple I2C transactions. To

a single a single ?

> protect against FIFO underrun, two changes are done:
> 
> First we flag the interrupt with IRQF_NO_THREAD, to prevent it from
> running in a thread on PREEMPT-RT kernel. This ensures that we are not
> interrupted when filling the FIFO as it is very time-senstive. For
> example, being preempted after writing a single byte in the FIFO with
> a 1MHz bus gives us only 18µs before an underrun.
> 
> Second in i2c_dw_process_transfer(), we abort if a STOP is detected
> while a read or a write is in progress. This can occur when processing
> a message larger than the FIFO. In that case the message is processed in
> parts, and rely on the TX EMPTY interrupt to refill the FIFO when it gets
> below a threshold. If servicing this interrupt is delayed for too long,
> it can trigger a FIFO underrun, thus an unwanted STOP.

Can DMA enablement fix this issue?

...

>  static const struct of_device_id dw_i2c_of_match[] = {
>  	{ .compatible = "baikal,bt1-sys-i2c", .data = (void *)MODEL_BAIKAL_BT1 },

You need to rebase on top of the latest tip of i2c-host tree.

> +	{ .compatible = "mobileye,eyeq6lplus-i2c" },

-- 
With Best Regards,
Andy Shevchenko


