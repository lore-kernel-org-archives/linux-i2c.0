Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197739DBDB
	for <linux-i2c@vger.kernel.org>; Thu, 10 Sep 2026 03:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789012305; cv=none; b=AyML880as9yeFD+Iejn43p70JVHLsz8HYLVRsTTWrK8xVmegEPny7oCPE53AvTcd9N3JE4wg7XBf6NlO+QQcpzcD+BUUGc+KOSFskbbZuDi6IHcODUqf7jGmXCzYEsSVSzaKxzI+lvmQe3Gyglu9/emKw98CAEWLuYWt9HhKASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789012305; c=relaxed/simple;
	bh=JhvBrHDUqvarV0avpz2ohvq9hMGegsfN5Z9V33aSmfs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=htvQ5M8i8zrtBKgciHnnwgnYGnRWqIhKtM9w2rei7c66BgdqWD2Boe3sgWdRA/Tb7qcA1nEkX9cilASEjx0bRDX3z/ImDitfkQxuR9ECIUbR+KhPkwCajY5z2NSaoos25p6awXzvxWryq9bDfdNdMBFuBJNulx49FJwnntzmQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=MA8iBiA5; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="MA8iBiA5"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1c9879395so4355403a12.1
        for <linux-i2c@vger.kernel.org>; Wed, 09 Sep 2026 20:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1789012295; x=1789617095; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fqlRI6bdXm7vucXWj9GaOa9S6fjYOLaD1e7oy5x25kA=;
        b=MA8iBiA5IfIf9Kru8X5xmXy7MI2eWBUGFwFvjr8P+6W3Q1V8MTo8pLuLnrJb9Rhsp0
         vwrNgt1ktTK8L01pmePy73GufnjcNTNzyw4gUQL21Z09e0XB86z6Uk9nFmnMmmT0JU94
         N5b4ZdrzdA8PQ5ubHoEefJmgh5A67zrPR7fuj2S7w3CzmFxRtKC0WnGl88Z5ffoukD6r
         so23LEqyuQybKU9STDM6y1Hnvd1hvpiNvbuYsEBYaQS3OiD4Q0Pn91H640kl4BqMvFma
         +uWVSUMR42bgCidJcAlG9nbXFGf8MdR4eFaSK0vLYhYaI7qHtgiC5H6U6ggb6NXnzppV
         uvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789012295; x=1789617095;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fqlRI6bdXm7vucXWj9GaOa9S6fjYOLaD1e7oy5x25kA=;
        b=F/ueAFNYx4yhhje4RUcdcWjD11RWOrooGBdUq04ygvgU71EZ65/gM0dz550JbZnxUF
         xzTzL9SDopxHOISe0pt61HLbvc9cZDsTvwTDvg3mHym/Xl9sVaRWI+2/e23/uCvbqUBE
         6a9313qTlFKRW72xEJ0tZQFhdCx8rAyMfPt/e/o+pcEiZOo7jT7KTpylgPVvLAyq/ahg
         UA987qXwVEHlDKM7lrhfTCiekxoeIdHSCCe8qjg++pDN0hN6c0QzlGCY6iPYMry51IuS
         /VWZzHBF73R49eJ5SllhbN+tT7aaXlGmcW+G0nGJMj3LBNcZ/WWW3KorOcDjl1aR1z+n
         ssnw==
X-Forwarded-Encrypted: i=1; AKwUvBxmT68aBLQr08BkPsvJ3R1eGrPnSrob4bS+vg83H5RXBiLKWH/v6xmVwg9PJCoQcqpCwlDKxtVTZl0=@vger.kernel.org
X-Gm-Message-State: AFuF++nMl8BCGKfCMxFxKGyIUP+JWXHeznvX1Io8nEJJ12mO6aItyIDs
	jmf0M3rIKTzHtBREBvaMRCEtOC9r6qt/dXv0bx1ejIHiup8DoAoQwuqsg3v9R5uvNEo=
X-Gm-Gg: AYBFou3XinKjsOI6W/Bw41Q4dXCuR92FX9s7/2V6JRZ0qKQkVcYMGwPNbnljqpGLZ3B
	+VW3/VDNtg9CTU8kBoutmaPRARP6ZszzCNfUzdHurqM+3CKWtkk8nAnWQWyLMH7dv83g8dgoWyu
	jg/i8mm3qASZj75Wp4QOrrMP72UOzANb7pnCwjP96o3gWFmcOaiqZpjtgJE2X5ExfuBEXNBRa5f
	B0UBfOWcP553hwDXcZwe3hQxodGAyFNpCyQHxj9igCz9UgN3KcLKErcyMSiO5I4/RVXpdTrq0ua
	vaftkINBwFPA2KzPI3PLU90LfgXo1KUR2sWpU+eng+O7wh7yK4rzn8qZdltkOIUJMkDoT7bdV53
	F+Rc8pQw4G3C+lsLd2Uy19/dN6jV1eRmGLuXarUMsera/kOe0sogtxfIouyNaU/Tiq9jzfU6aXi
	FgNOIIxdPdarJxs4sh1SQjwVVyrRzWfs50G03UYrmtdOnjr4qAeOKdf3X4W9A6V9eun7ffA8k=
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id 98e67ed59e1d1-39b26277b88mr58988980a91.24.1789012295153;
        Wed, 09 Sep 2026 20:51:35 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243767e1sm41158832c88.6.2026.09.09.20.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 20:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Sep 2026 20:51:33 -0700
Message-Id: <DLBBXHXIVHZL.BIOFL7T9OAM7@nexthop.ai>
Subject: Re: [PATCH v7] i2c: xiic: restore non-managed runtime PM to fix clk
 WARN flood
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>, "Michal Simek"
 <michal.simek@amd.com>, "Andi Shyti" <andi.shyti@kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@intel.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260821-i2c-xiic-restore-runtime-pm-teardown-v7-1-954e06765144@nexthop.ai>
In-Reply-To: <20260821-i2c-xiic-restore-runtime-pm-teardown-v7-1-954e06765144@nexthop.ai>

On Fri Aug 21, 2026 at 6:12 PM PDT, Abdurrahman Hussain wrote:
> The devres conversion replaced manual pm_runtime_enable()/disable() with
> devm_pm_runtime_set_active_enabled() and dropped the remove-time runtime
> PM teardown. The managed release tears runtime PM down in the wrong
> order: it calls pm_runtime_dont_use_autosuspend() before
> pm_runtime_disable(), i.e. while runtime PM is still enabled, and devres
> is LIFO so the devm_clk_get_enabled() release runs afterwards.
>
> At remove(), pm_runtime_put_sync() leaves the device active with the
> autosuspend timer armed. Clearing use_autosuspend then makes rpm_idle()
> suspend immediately, and xiic_i2c_runtime_suspend() clk_disable()s the
> clock. The later devm_clk_get_enabled() release clk_disable_unprepare()s
> the already-disabled clock, so clk_core_disable() WARNs ("clkN already
> disabled") on every teardown.
>
> Drop the managed helper and restore the non-managed runtime PM setup and
> teardown, so runtime PM is enabled once in probe and disabled once in
> remove and the clock enable count stays balanced.
>
> Order the remove teardown so runtime PM is disabled before the usage
> count is dropped: pm_runtime_disable() followed by pm_runtime_put_noidle(=
)
> instead of pm_runtime_put_sync(). Dropping the count first with autosuspe=
nd
> still enabled arms the autosuspend timer, and a preemption before
> pm_runtime_disable() lets it expire, suspend the device and clk_disable()
> the clock, which the devm release then disables again - the same WARN.
>
> Restore the non-managed IRQ request as well. The probe error paths now
> unwind runtime PM by hand via goto, and a devm-registered handler is only
> freed later during devres unwind, so it would stay live across the manual
> teardown (and across any future failing step added after it). Request the
> IRQ with request_threaded_irq() and free it explicitly in the probe error
> path and in remove. The probe error path also clears use_autosuspend, to
> match the teardown in remove().
>
> Fixes: 50c63491ff26 ("i2c: xiic: switch to devres managed APIs")
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
> Changes in v7:
> - Add the missing kernel-doc entry for the new @irq member of struct
>   xiic_i2c (the non-managed IRQ request added in v4 introduced the field
>   but not its doc), fixing a "struct member 'irq' not described" W=3D1
>   kernel-doc warning. No functional change.
> - Link to v6: https://patch.msgid.link/20260820-i2c-xiic-restore-runtime-=
pm-teardown-v6-1-5db5c3703ea0@nexthop.ai
>
> Changes in v6:
> - probe: check the pm_runtime_set_active() return value and unwind on
>   failure (undo pm_runtime_use_autosuspend()) instead of ignoring it.
>   On failure runtime PM would stay suspended while the clock is left
>   enabled, and remove()'s pm_runtime_get_sync() would then resume, enable
>   the clock a second time and leak the enable across the manual teardown
>   (Sashiko).
> - Link to v5: https://patch.msgid.link/20260820-i2c-xiic-restore-runtime-=
pm-teardown-v5-1-ca5db9605508@nexthop.ai
>
> Changes in v5:
> - remove(): disable runtime PM before dropping the usage count
>   (pm_runtime_disable() + pm_runtime_put_noidle() instead of
>   pm_runtime_put_sync()), so the armed autosuspend timer can no longer
>   race pm_runtime_disable() and re-trigger the clk double-disable.
> - probe error path: also call pm_runtime_dont_use_autosuspend() so it
>   mirrors the teardown in remove().
> - Link to v4: https://patch.msgid.link/20260819-i2c-xiic-restore-runtime-=
pm-teardown-v4-1-6999eb434d1c@nexthop.ai
>
> Changes in v4:
> - Request the IRQ non-managed (request_threaded_irq/free_irq) and free it
>   in the probe error path and in remove(), instead of a devm handler that
>   would only be released during devres unwind and so stay live across the
>   manual runtime PM teardown in the goto error paths (Andy).
> - Link to v3: https://patch.msgid.link/20260818-i2c-xiic-restore-runtime-=
pm-teardown-v3-1-5fd315b078e1@nexthop.ai
>
> Changes in v3:
> - Drop the managed devm_pm_runtime_set_active_enabled() helper entirely
>   and restore the non-managed runtime PM setup (pm_runtime_set_active +
>   pm_runtime_enable, with probe error unwinding) and teardown
>   (pm_runtime_disable + set_suspended + dont_use_autosuspend), so the
>   disable depth stays balanced rather than being disabled twice (Andi).
> - Link to v2: https://patch.msgid.link/20260814-i2c-xiic-restore-runtime-=
pm-teardown-v2-1-7ae5d0c30ff2@nexthop.ai
>
> Changes in v2:
> - Move the Signed-off-by into the commit message proper (Andy).
> - Link to v1: https://patch.msgid.link/20260813-i2c-xiic-restore-runtime-=
pm-teardown-v1-1-0e7dfb206790@nexthop.ai
>
> To: Michal Simek <michal.simek@amd.com>
> To: Andi Shyti <andi.shyti@kernel.org>
> To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> To: Andy Shevchenko <andriy.shevchenko@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/i2c/busses/i2c-xiic.c | 49 +++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 40 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.=
c
> index 3e7735e1dae0..92cefc7e221b 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -67,6 +67,7 @@ enum i2c_scl_freq {
>   * @rx_pos: Position within current RX message
>   * @endianness: big/little-endian byte order
>   * @clk: Pointer to AXI4-lite input clock
> + * @irq: Interrupt number
>   * @state: See STATE_
>   * @singlemaster: Indicates bus is single master
>   * @dynamic: Mode of controller
> @@ -92,6 +93,7 @@ struct xiic_i2c {
>  	int rx_pos;
>  	enum xiic_endian endianness;
>  	struct clk *clk;
> +	int irq;
>  	enum xilinx_i2c_state state;
>  	bool singlemaster;
>  	bool dynamic;
> @@ -1475,9 +1477,17 @@ static int xiic_i2c_probe(struct platform_device *=
pdev)
> =20
>  	pm_runtime_set_autosuspend_delay(dev, XIIC_PM_TIMEOUT);
>  	pm_runtime_use_autosuspend(dev);
> -	ret =3D devm_pm_runtime_set_active_enabled(dev);
> -	if (ret)
> +	/*
> +	 * Enable runtime PM by hand: devm_pm_runtime_set_active_enabled()
> +	 * tears down in an order that races the devm-enabled clock release and
> +	 * makes clk_core_disable() WARN (see xiic_i2c_remove()).
> +	 */
> +	ret =3D pm_runtime_set_active(dev);
> +	if (ret) {
> +		pm_runtime_dont_use_autosuspend(dev);
>  		return ret;
> +	}
> +	pm_runtime_enable(dev);
> =20
>  	/* SCL frequency configuration */
>  	i2c->input_clk =3D clk_get_rate(i2c->clk);
> @@ -1486,10 +1496,15 @@ static int xiic_i2c_probe(struct platform_device =
*pdev)
>  	if (ret || i2c->i2c_clk > I2C_MAX_FAST_MODE_PLUS_FREQ)
>  		i2c->i2c_clk =3D 0;
> =20
> -	ret =3D devm_request_threaded_irq(dev, irq, NULL, xiic_process,
> -					IRQF_ONESHOT, pdev->name, i2c);
> +	/*
> +	 * Request the IRQ non-managed: later probe steps unwind manually via
> +	 * goto, so a devm handler could still be live after that teardown runs=
.
> +	 */
> +	i2c->irq =3D irq;
> +	ret =3D request_threaded_irq(irq, NULL, xiic_process, IRQF_ONESHOT,
> +				   pdev->name, i2c);
>  	if (ret)
> -		return ret;
> +		goto err_pm_disable;
> =20
>  	i2c->singlemaster =3D device_property_read_bool(dev, "single-master");
> =20
> @@ -1506,14 +1521,16 @@ static int xiic_i2c_probe(struct platform_device =
*pdev)
>  		i2c->endianness =3D BIG;
> =20
>  	ret =3D xiic_reinit(i2c);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Cannot xiic_reinit\n");
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Cannot xiic_reinit\n");
> +		goto err_free_irq;
> +	}
> =20
>  	/* add i2c adapter to i2c tree */
>  	ret =3D i2c_add_numbered_adapter(&i2c->adap);
>  	if (ret) {
>  		xiic_deinit(i2c);
> -		return ret;
> +		goto err_free_irq;
>  	}
> =20
>  	if (pdata) {
> @@ -1526,6 +1543,15 @@ static int xiic_i2c_probe(struct platform_device *=
pdev)
>  		res, irq, i2c->i2c_clk);
> =20
>  	return 0;
> +
> +err_free_irq:
> +	free_irq(irq, i2c);
> +err_pm_disable:
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_dont_use_autosuspend(dev);
> +
> +	return ret;
>  }
> =20
>  static void xiic_i2c_remove(struct platform_device *pdev)
> @@ -1537,6 +1563,8 @@ static void xiic_i2c_remove(struct platform_device =
*pdev)
>  	/* remove adapter & data */
>  	i2c_del_adapter(&i2c->adap);
> =20
> +	free_irq(i2c->irq, i2c);
> +
>  	ret =3D pm_runtime_get_sync(dev);
>  	if (ret < 0)
>  		dev_warn(dev, "Failed to activate device for removal (%pe)\n",
> @@ -1544,7 +1572,10 @@ static void xiic_i2c_remove(struct platform_device=
 *pdev)
>  	else
>  		xiic_deinit(i2c);
> =20
> -	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_dont_use_autosuspend(dev);
>  }
> =20
>  static const struct dev_pm_ops xiic_dev_pm_ops =3D {
>
> ---
> base-commit: d58772d8520c7ef247c4b95c9bd76d3a25da9ff5
> change-id: 20260813-i2c-xiic-restore-runtime-pm-teardown-dd0ab1db2c02
>
> Best regards,
> -- =20
> Abdurrahman Hussain <abdurrahman@nexthop.ai>

Hi Andi, Andy,

Gentle ping on this one. It has been quiet since v7 went out on Aug 21.

Andy, v4 onwards switched to request_threaded_irq()/free_irq() with the
explicit free in the probe error path and in remove(), per your comment on
v3. Does that address your concern, or is there anything else you would
like changed?

Andi, this is a regression fix for 50c63491ff26 (the devres conversion),
and the WARN fires on every unbind/rmmod of the driver, so it would be
good to get it into 7.2 or early 7.3 fixes if the patch looks OK to you.

Happy to respin if anything is still open.

Thanks,
Abdurrahman
