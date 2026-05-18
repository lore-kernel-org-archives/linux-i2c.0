Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61961395DA9
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779137968; cv=none; b=h0s9vN+RVnaiO3pX1q5Oh0qp4wlP2Z5dFqcxFzKHxZbwzt66dfs7Nzut0Z4XxGO1ymNxtK8jzL6btAAT1TVOaMKRcuCXtiKYi6l5I6DNH2ouRyKByETOnjHf4LW5oPXSEdGlyM4nsdT4bqTqofCpS3vyYw7hFhz/CO0+X8Gwg3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779137968; c=relaxed/simple;
	bh=nr+t1doD2CUBE3bFv8CLDzRSbdfYN9E47Pi8sfYRR1s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=RiGMvXjBPI6CHb0OJYzLOhDssGlpeCEszYGjen/ivladrJDAexJdALQix4qMdVMRcQkrWeEQJqW33rHlTT+iEa1I4AFxkTHfgIInye7WTYpo/eUpzfPx4tJSw3ttZBH+WMkeEClirrgi0I5Nx7d4PfaUmljSJ7dTlDn79hy3IiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=dyg8CyiG; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="dyg8CyiG"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso2522986eec.0
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 13:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779137966; x=1779742766; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC7LwadeZIJzGWSw3EwsmpwE/9tZMQSerDjTwBwBFWo=;
        b=dyg8CyiG/VlbC8sQRcH/JjZXEm5u1XUoiIqxbkpLrehrqPHg0iK1hzgn4NTt7kX4d0
         WPDVmlMYp3hvN3fu7FrGeEE4gaaNPs989pSDCbe1a6VQahMmTdvZphWer5eMvTwiggy8
         HSEhZglqvOVqge5oDlApG6QDaGWGmUNUcziTLdV+9KVjwbL8LYqYET0bbAq+nX4u7P++
         PIkJvWO52iROzOAwXTbFTS4l2EUEPo+Ixenz5VHLE7+3tTZsDwNUqsFMoewFiYiVDAsj
         jFygJp7bmMPsByOq52/0QTK4jj3YXcr2ltcgkCzBOeAu/encTZD/Wsl2rxHz21kf27oM
         Tkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779137966; x=1779742766;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SC7LwadeZIJzGWSw3EwsmpwE/9tZMQSerDjTwBwBFWo=;
        b=fuAKif4SnDN6/KAc473FQX3ArbAJwQrUtehN/tIlzG7hNqHJxrFUpbaSpNwGeo1Dmc
         NWzkFV8AYzunqXp6AAtBum3oMaNIY8jxev/XQR54Ph62AwctOGp1pNJc5e7e4PZWp55Z
         NyKLbAotF5HG+bgm8d3v+JOZXsf8YMxaG3NMGw2xbh7FoQGhYb6BDNeOG6ofrsUdBXMn
         4b8cyhDQF5GZ34EVYUb9IF/rp90WJTArzS1cj+sAbuNxj/+M0zojpM2FiFrlzXmjv0mU
         Fgm1rwqQxzlnlwUV9yFXDR48P4tkMsPCNqTACFI0xGGT2G40ILdBGJn8dqH8F72rOFfu
         BMNA==
X-Gm-Message-State: AOJu0Yw8BY8JiS2IaH07UIe9a7oVdiJZE7z5UNBoCWylBiTOguPDT9Vi
	ImBKOwbwDkzdqKchRWYoU5sxRxZxKWlzuae3ptp0R1pw/6TGH/YTZ7jvUMlykx5qDvM=
X-Gm-Gg: Acq92OHWfbmMeKQSPzW9MR+eq0pnx4N5UwNj8gnsq1SXR1GLk1To/XI6wBtxyRBAAdL
	RsUqwVUnZo80mz/020vKcaMJN5aqeyhEsfBUfGp95hj4tTLs8RsLzRA+niYowcBt4CDmhWvxTCs
	GkUZitHf/ulmo3XO0xlmgUHwT7U5lqCDBvMeZ1O1kpn/FQKcKtowgAUX/Jwjx2dFBhpJL/ZE9Ob
	zFB+Vm8vkg6Sjf8Nkxkfit9v2J0OMjvsq3Vgzx4FwawKLyeU8z9WpDoAzAOp+m5pFWOU5oJBDzv
	E25UThhrVpH84iz4z7AuEh0tPVzjf3QI6xSZVH9vXIEWf1kWS9wENIC5qwzjFRisj9+k8XN9TKz
	GQWR2eLMpuahv7DcdtWtLLvk5ufeSusXBm8qHpFYeeg1GReqk1v58HktPsAy2nCDvHfD4YQi4cv
	eu3IZiNFplGp5PmCJyBnlYa/A=
X-Received: by 2002:a05:7300:dc8e:b0:2f2:5c68:5074 with SMTP id 5a478bee46e88-3039818af8fmr7531363eec.13.1779137966208;
        Mon, 18 May 2026 13:59:26 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6f6sm18597898eec.17.2026.05.18.13.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 13:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 13:59:25 -0700
Message-Id: <DIM3RTVTMA0P.1081TMP4M5RNX@nexthop.ai>
Subject: Re: [PATCH v3] i2c: mux: reg: use device property accessors
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>, "Peter Rosin"
 <peda@lysator.liu.se>
Cc: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260513-i2c-mux-reg-v3-1-0fa7242605bc@nexthop.ai>
 <f2688bbf-ab8a-484d-98d4-2a502f2ee36a@lysator.liu.se>
 <DIM2U4HC70GE.1B3CO1IS8AJV@nexthop.ai>
In-Reply-To: <DIM2U4HC70GE.1B3CO1IS8AJV@nexthop.ai>

On Mon May 18, 2026 at 1:15 PM PDT, Abdurrahman Hussain wrote:
> On Mon May 18, 2026 at 6:59 AM PDT, Peter Rosin wrote:
>>
>> Hi!
>>
>> After reading v2/v3, I finally got why you removed if (!mux->data.reg).
>> I.e., since you removed the io-remapping from i2c_mux_reg_probe_fw()
>> that part can now be unconditional in i2c_mux_reg_probe(). But,
>> keeping the if just to accomodate potential out-of-tree code that uses
>> the platform data hooking is not needed so v1 feels better than v2/v3.
>> Sorry for being dense. However, see below.
>>
>
> Agreed -- v4 will drop the guard and make
> devm_platform_get_and_ioremap_resource() unconditional.
>
> Follow-up question while we're pruning the platdata path: with the
> guard gone, the .reg and .reg_size fields in
> struct i2c_mux_reg_platform_data are functionally dead (any value a
> platdata user supplied through them is overwritten by
> devm_platform_get_and_ioremap_resource()).  Should I drop those two
> fields from the struct in the same patch, or leave them as silent
> no-ops in the public header?  Happy either way.
>

Scratch that, sorry -- right after sending I noticed
drivers/platform/mellanox/mlx-platform.c is an in-tree platdata
user.  It registers i2c-mux-reg platform_devices via
platform_device_register_resndata(..., res=3DNULL, num_res=3D0, ...)
and supplies a pre-set .reg (a (void __iomem *) cast of an LPC
register address) and .reg_size=3D1 through the platdata struct
(mlxplat_default_mux_data[] and friends around line 474).

Without the if (!mux->data.reg) guard,
devm_platform_get_and_ioremap_resource() would run unconditionally,
fail because the pdev carries no memory resource, and break
mlx-platform's mux probe.  v4 will therefore keep the guard, and
the .reg / .reg_size fields stay in the public platdata struct.

The other two changes stand:

  - i2c_get_adapter_by_fwnode() -> i2c_find_adapter_by_fwnode() +
    put_device() in probe_fw(), matching the OF original.

  - In probe(), move the if (!mux->data.reg) ioremap block --
    together with the reg_size validation that depends on it --
    above the i2c_get_adapter() call.  fwnode users get back the
    master-side ordering of "ioremap before parent-adapter get";
    platdata users see the size check run a bit earlier, but
    mux->data.reg_size is set from platdata by then, so it's
    order-neutral for them.

Cheers,
Abdurrahman

>>> -	adapter =3D of_find_i2c_adapter_by_node(adapter_np);
>>> -	of_node_put(adapter_np);
>>> +
>>> +	adapter =3D i2c_get_adapter_by_fwnode(fwnode);
>>> +	fwnode_handle_put(fwnode);
>>
>> Why did you not change to i2c_find_adapter_by_fwnode()? It would be
>> closer to the original, but maybe that doesn't work for ACPI for some
>> reason?
>>
>
> It works for ACPI -- both _find and _get bottom out in
> i2c_find_adapter_by_fwnode().  My reason for picking the _get
> variant was simply that it does try_module_get(adapter->owner) on
> top.  But i2c_get_adapter() further down in probe() already does
> the same try_module_get() and -EPROBE_DEFERs on failure, so the
> extra acquire-then-immediately-release in probe_fw() isn't earning
> us anything.  v4 will switch to i2c_find_adapter_by_fwnode() +
> put_device(), matching the OF original more closely.
>
>>> -	/* map address from "reg" if exists */
>>> -	if (of_address_to_resource(np, 0, &res) =3D=3D 0) {
>>> -		mux->data.reg_size =3D resource_size(&res);
>>> -		mux->data.reg =3D devm_ioremap_resource(&pdev->dev, &res);
>>> -		if (IS_ERR(mux->data.reg))
>>> -			return PTR_ERR(mux->data.reg);
>>> -	}
>>> -
>>
>> By not doing the io-remapping here, the ordering is now subtly altered.
>> Previously we had io-remapping before the call to i2c_get_adapter().
>> With this change we instead have the call to i2c_get_adapter() before
>> the io-remapping.
>>
>> Since it is apparently difficult the get this patch tested for the
>> existing use cases, we should avoid as many of these innocent looking
>> but subtle changes as possible.
>>
>> Cheers,
>> Peter
>>
>
> Will fix that in v4 by reordering probe() so the
> devm_platform_get_and_ioremap_resource() call comes before
> i2c_get_adapter(), matching the master sequence.  No need to push
> the ioremap back into probe_fw() -- the helper signature stays
> cleaner if probe() owns the call.
>
> Thanks for the careful re-read.
>
> Cheers,
> Abdurrahman

