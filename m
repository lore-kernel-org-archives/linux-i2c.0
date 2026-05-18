Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227C9381B0A
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135327; cv=none; b=nQKPEICrisRlm+hlbdWvT0H9f0zGgNW156UvQV7pqmGgDDmtm2kS9kURF0V7Tj7l5hZtJeTaB/0NnhJGijgIzLrjC8nNdgqgguarGuT8HbONQXRTJAwicq49UeWEjDy6Ds+PiniKTKwo7epCjihX+yMeJWvrTrH9ACgvRkqphGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135327; c=relaxed/simple;
	bh=ngdPnO1Cyjc/vJTeh8/x1Lz51F/x2nhH32sn1fzppwI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=NmxWacOziYsnL2yHIDaBUKLKn2vJJPsoWY9t+Vrf6BQJTHS6abQDY8u1pMo4ymbWai1BZ9mzaDdKsUoE6yAaKrXmmcMpb9XKnkBGpabH86/PMeVVkvInR0iyJXqW/dGVN5+1ba89OHQqgd0O83nREHT1Y0yjoF+ZOHVgflHpd80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=LfzqjN5z; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="LfzqjN5z"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c156c4a9efso3512885eec.1
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 13:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779135325; x=1779740125; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xiFAZvz3hwO0i2u3Qu3Y6dXTODQg/m869IwtOfJVETM=;
        b=LfzqjN5zUD2TKK93TRSRnN8lEFPt4N3k3Ayz8o3KJkuU2hclLQ4/anChji4QBR7xlA
         JM/hv9pLsxvaKNKYMgA3LSfCKfEeiTGGYQDc+Va3uztBVirokdFRyMhVFybk88VQwwzD
         XSYKTia8VIJiO/mhxxeB01LqCypxkoDuVSRwnhWcFM5EIMElNefK7gb9oGN9ff/SdSnp
         P5T6sBWy9szsMN+PDM5rslFBw1pNR69mWZV1etQaBIC/0N2NVCo01xdUyFshXm29qw+z
         LfKbDMTBmTojzZlT1lzRpKzF5rK7+Y0xXAIw/a0FngcJNmSHwpkVTdOn/qrXOGjR0JIH
         y4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135325; x=1779740125;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xiFAZvz3hwO0i2u3Qu3Y6dXTODQg/m869IwtOfJVETM=;
        b=QLTJuSkI9P/gjiYut7N9gRxLP+wM6AgrFuefGEenR+BsxVWvlEsNZHcQPqPuXAsCy3
         YYsGufYRpR70fDhXSoJRhlGBjVT8z6zQRuzhCUzrfBwyXTrMPmjoTLw5zvBKeFDWADfa
         hiod3L+z/ryG1IOe7Hy7lYpis8XVIzjFzdSBOBuwIQngNPM1kkMB5BqODgu2lYL9/Ct7
         AwJ7QuxlHv10ORhXfrtkQxMtUZkCFkPwESFjTOpKP3KfSFS5lP+RgSlr20H+R0n9tZNJ
         tRk4AvsCuKlaX3vpdY3io4jE92fUW3J7glRqGQehEfspW95RCnjj9Q3Rku/EeCCN4V+1
         8W5A==
X-Gm-Message-State: AOJu0Yxw4T+icWZRAI3jHRu3fygFx8O7wsicUY7nerax/jW5TvdyAVvo
	eHHQu22H2L/BemscSu3FTxuf9jpWgHLNMCv17PSzENqnquHAYEoH4+3baYvWKRSlpuuM9fNaj2U
	xjzRQdPg=
X-Gm-Gg: Acq92OFjNM0l7ibFW8A7Zdvpj09h6vl3AeerMOP2K1RYwGqz1YYMw6/E3XtC+pmkYqF
	yARb9vHnn8gq+3H0zEsd1+e193dgPG1ocnoXFNuvZ81HD6QBeCMt4z4LwFoha0bsdIQU7g5rTVZ
	27tznJttV5QQWtHJB5iLvdE8LLssr6z+EBo3os7BKUPzAGleT6zOevqemX7sWU6pleR97qyt2nf
	evUReYDENILm+ywRRSavYKr5CPBl81pJsqGbQPrF24Sv9SSa99LY8pne6ELBwq9Zd12JEPn3m3e
	fyMUpGwfzg0Og8m/+5Y1jsDsd38pB6bH7OZyxz+QpPHrFNCcrIb9xyEvl/MNtXIhuQC8Lv5GlFd
	DprrOjaYT0icmXcnbnjDeFi60Ns07IaNp7PWJ8wESchG5wUAjuJb/yxG/QHBze421y7tM5mg80b
	ooP+7qor0A+ogf9ojpLveO7uw=
X-Received: by 2002:a05:7300:a146:b0:2e2:27bb:a48c with SMTP id 5a478bee46e88-3039816db2amr7491742eec.14.1779135324993;
        Mon, 18 May 2026 13:15:24 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302978ad18asm14388520eec.26.2026.05.18.13.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 13:15:24 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 13:15:23 -0700
Message-Id: <DIM2U4HC70GE.1B3CO1IS8AJV@nexthop.ai>
Cc: <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] i2c: mux: reg: use device property accessors
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Peter Rosin" <peda@lysator.liu.se>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20260513-i2c-mux-reg-v3-1-0fa7242605bc@nexthop.ai>
 <f2688bbf-ab8a-484d-98d4-2a502f2ee36a@lysator.liu.se>
In-Reply-To: <f2688bbf-ab8a-484d-98d4-2a502f2ee36a@lysator.liu.se>

On Mon May 18, 2026 at 6:59 AM PDT, Peter Rosin wrote:
>
> Hi!
>
> After reading v2/v3, I finally got why you removed if (!mux->data.reg).
> I.e., since you removed the io-remapping from i2c_mux_reg_probe_fw()
> that part can now be unconditional in i2c_mux_reg_probe(). But,
> keeping the if just to accomodate potential out-of-tree code that uses
> the platform data hooking is not needed so v1 feels better than v2/v3.
> Sorry for being dense. However, see below.
>

Agreed -- v4 will drop the guard and make
devm_platform_get_and_ioremap_resource() unconditional.

Follow-up question while we're pruning the platdata path: with the
guard gone, the .reg and .reg_size fields in
struct i2c_mux_reg_platform_data are functionally dead (any value a
platdata user supplied through them is overwritten by
devm_platform_get_and_ioremap_resource()).  Should I drop those two
fields from the struct in the same patch, or leave them as silent
no-ops in the public header?  Happy either way.

>> -	adapter =3D of_find_i2c_adapter_by_node(adapter_np);
>> -	of_node_put(adapter_np);
>> +
>> +	adapter =3D i2c_get_adapter_by_fwnode(fwnode);
>> +	fwnode_handle_put(fwnode);
>
> Why did you not change to i2c_find_adapter_by_fwnode()? It would be
> closer to the original, but maybe that doesn't work for ACPI for some
> reason?
>

It works for ACPI -- both _find and _get bottom out in
i2c_find_adapter_by_fwnode().  My reason for picking the _get
variant was simply that it does try_module_get(adapter->owner) on
top.  But i2c_get_adapter() further down in probe() already does
the same try_module_get() and -EPROBE_DEFERs on failure, so the
extra acquire-then-immediately-release in probe_fw() isn't earning
us anything.  v4 will switch to i2c_find_adapter_by_fwnode() +
put_device(), matching the OF original more closely.

>> -	/* map address from "reg" if exists */
>> -	if (of_address_to_resource(np, 0, &res) =3D=3D 0) {
>> -		mux->data.reg_size =3D resource_size(&res);
>> -		mux->data.reg =3D devm_ioremap_resource(&pdev->dev, &res);
>> -		if (IS_ERR(mux->data.reg))
>> -			return PTR_ERR(mux->data.reg);
>> -	}
>> -
>
> By not doing the io-remapping here, the ordering is now subtly altered.
> Previously we had io-remapping before the call to i2c_get_adapter().
> With this change we instead have the call to i2c_get_adapter() before
> the io-remapping.
>
> Since it is apparently difficult the get this patch tested for the
> existing use cases, we should avoid as many of these innocent looking
> but subtle changes as possible.
>
> Cheers,
> Peter
>

Will fix that in v4 by reordering probe() so the
devm_platform_get_and_ioremap_resource() call comes before
i2c_get_adapter(), matching the master sequence.  No need to push
the ioremap back into probe_fw() -- the helper signature stays
cleaner if probe() owns the call.

Thanks for the careful re-read.

Cheers,
Abdurrahman
