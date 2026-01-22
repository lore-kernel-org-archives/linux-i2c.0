Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ACC341063;
	Thu, 22 Jan 2026 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099176; cv=none; b=rjx1gjtfumxB7yPONNzZHc2kY3NIG8guCtC4A3NsnZ/2Lx2FgHFBjTd6asuVRbTf4kUIhd41bnO4s7mS0cmV+pNTosSGQjy1G11vZx73nEjCNgMVJtSzu0dvpqlsOtg6pgGyGXt2clui6lQIXcn6eoLJfP+oVFkv1LDNQgLR4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099176; c=relaxed/simple;
	bh=Q7pUzb+BLBPkR6MTyOyPhdlElsSZljZg0UZN5joDqP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myCg9bmgLt2GmDaXXoc8ZMzJIURcP0xXToSz4e78hVi+V0BefMWwazE0v+lfhIP3IPGMRELVq95jCfW8MfckwuYmDbuLeoEjJJ06tj20koBAs7Xq1+VnXAZL549wKl6z+I4YyOngylf6ROjMdVWXJdygGkzzBdMQ01YaSuCTVro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VjAtd5g3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VjAtd5g3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769099168; x=1800635168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Q7pUzb+BLBPkR6MTyOyPhdlElsSZljZg0UZN5joDqP4=;
  b=VjAtd5g3tW523jtPtEdX1yjMMZHSQliaqpPbAP+rjzVand5hkIvjQcRQ
   wXqEwKZF066am2bFlfgVV/GKhR8VI0ahTCEVkF8Lg78v3vVDIn6TFeDtp
   anp5QVQXxoGl9v93TE/2fggO388HXdMf9B9px9b7x9sgVdJD730Z/4kGh
   mFkEM2oCdUT62aX0nG+3FKOsDA626tDwj0S8cAAJHwtFQuC4hr0HjhA2V
   7YKsSYOpUJnkBBWmjCX+sczy9prgkpk2omNBz2SDh67WAhvmxiUGnvwZE
   KZWif7+9KMsND5HBtH49mmjEStElLTyp/of2mHVOsYKBzjnf9uMmE26Yh
   A==;
X-CSE-ConnectionGUID: KDd8SX6EQ4ymJwX8PzP9Xw==
X-CSE-MsgGUID: oV8JhO/KQwGTYcqY+jko3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74199176"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="74199176"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 08:26:03 -0800
X-CSE-ConnectionGUID: DD5CC80dT6uPyzKjt1wxkQ==
X-CSE-MsgGUID: rRQ3r7GqSGSlOqPINgsPtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="206594719"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 22 Jan 2026 08:26:00 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4721595; Thu, 22 Jan 2026 17:25:58 +0100 (CET)
Date: Thu, 22 Jan 2026 17:25:58 +0100
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
Subject: Re: [PATCH v5 4/6] i2c: designware: Implement I2C_M_STOP support
Message-ID: <aXJPljHeRxBXH_Jo@black.igk.intel.com>
References: <20260120-i2c-dw-v5-0-0e34d6d9455c@bootlin.com>
 <20260120-i2c-dw-v5-4-0e34d6d9455c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120-i2c-dw-v5-4-0e34d6d9455c@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 20, 2026 at 10:28:04AM +0100, Benoît Monin wrote:
> Add the support of the I2C_M_STOP flag in i2c_msg by splitting
> i2c_dw_xfer() in two: __i2c_dw_xfer_one_part() for the core transfer logic
> and i2c_dw_xfer() for handling the high-level transaction management.
> 
> In detail __i2c_dw_xfer_one_part() starts a transaction and wait for its
> completion, either with a STOP on the bus or an error. i2c_dw_xfer()
> loops over the messages to search for the I2C_M_STOP flag and calls
> __i2c_dw_xfer_one_part() for each part of the messages up to a STOP or
> the end of the messages array.
> 
> i2c_dw_xfer() takes care of runtime PM and holds the hardware lock on
> the bus while calling __i2c_dw_xfer_one_part(), this allows grouping
> multiple accesses to device that support a STOP in a transaction when
> done via i2c_dev I2C_RDWR ioctl.

Does i2c-tools support this. I.o.w. can you put an example of user space call
to achieve the above?

> Also, now that we have a lookup of the messages in i2c_dw_xfer() prior
> to each transaction, we use it to make sure the messages are valid for
> the transaction, via a new function i2c_dw_msg_is_valid(). We check
> that the target address does not change before starting the transaction
> instead of aborting the transfer while it is happening, as it was done
> in i2c_dw_xfer_msg(). The target address can only be changed after an
> I2C_M_STOP flag, i.e after a STOP on the i2c bus.
> 
> The I2C_FUNC_PROTOCOL_MANGLING flag is added to the list of
> functionalities supported by the controller, except for the AMD NAVI
> i2c controller which uses its own xfer() function and is left untouched.

...

While the below is not a kernel-doc, I would still use a couple of things to
make it a bit aligned with that.

>  /*
> - * Prepare controller for a transaction and call i2c_dw_xfer_msg.
> + * Prepare controller for a transaction, start the transfer of the msgs

@msgs

> + * and wait for completion, either a STOP or a error.
> + * Return 0 or a negative error code.

Return:

>   */

...

> +/*
> + * Verify that the message at index @idx can be processed as part
> + * of a single transaction. The @msgs array contains the messages
> + * of the transaction. The message is checked against its predecessor
> + * to ensure that it respects the limitation of the controller.

Ha, you even used @ notation here!

Perhaps also add Return: line?

> + */

...

> +	/*
> +	 * The first message of a transaction is valid,
> +	 * no constraint from a previous message.

constraints ?

> +	 */

...

> +static int
> +i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> +{
> +	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
> +	struct i2c_msg *msgs_part;
> +	size_t cnt;
> +	int ret;

> +	dev_dbg(dev->dev, "msgs: %d\n", num);
> +
> +	pm_runtime_get_sync(dev->dev);
> +
> +	ret = i2c_dw_acquire_lock(dev);
> +	if (ret)
> +		goto done_nolock;

A side note: Perhaps make sense to factor the body out to another helper.

> +	/*
> +	 * If the I2C_M_STOP is present in some the messages,
> +	 * we do one transaction for each part up to the STOP.
> +	 */
> +	for (msgs_part = msgs; msgs_part < msgs + num; msgs_part += cnt) {
> +		/*
> +		 * Count the messages in a transaction, up to a STOP
> +		 * or the end of the msgs.
> +		 */
> +		for (cnt = 1; ; cnt++) {

Do we have a guarantee that this doesn't become an infinite loop or more
precisely out-of-boundary access?

I hope to see this be explicitly mentioned in the comment on top of for-loop.

> +			if (!i2c_dw_msg_is_valid(dev, msgs_part, cnt - 1)) {
> +				ret = -EINVAL;
> +				goto done;
> +			}
> +
> +			if ((msgs_part[cnt - 1].flags & I2C_M_STOP) ||
> +			    (msgs_part + cnt == msgs + num))
> +				break;
> +		}
> +
> +		/* transfer one part up to a STOP */
> +		ret = __i2c_dw_xfer_one_part(dev, msgs_part, cnt);
> +		if (ret < 0)
> +			break;
> +	}
>  
>  done:
>  	i2c_dw_release_lock(dev);

>  done_nolock:
>  	pm_runtime_put_autosuspend(dev->dev);
>  
> -	return ret;
> +	if (ret < 0)
> +		return ret;
> +	return num;
>  }

...

> +	if ((dev->flags & MODEL_MASK) != MODEL_AMD_NAVI_GPU)
> +		dev->functionality |= I2C_FUNC_PROTOCOL_MANGLING;

Why do we need this flag? I mean can't we use the fact that the code for that
platform uses custom xfer implementation?

-- 
With Best Regards,
Andy Shevchenko


