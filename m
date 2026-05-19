Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6223393E;
	Tue, 19 May 2026 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223203; cv=none; b=bFq9gaT94HIAqrz+/zPxzaPUIRb8YmhiXRjXZn0HD7nw62vMduZWLiGaEVVrU02zCbbtut6q38V3ZDZXscrhE6RW4Q+zJ/dELfLRdhacHbBfPoFYYWmPTbHmu6sjkRoh1Gn5TA7LCp1nYXnJUxdczj4+b/0b7ifwRIsxQTjKh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223203; c=relaxed/simple;
	bh=70qXjz446VeLKk6hXJJ2WmzWSV5ePnVXQ0BlNz1ZD1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6MyjIfozDVqIG6+I5dZqrOIjCcAmVAceXNtOJRbRA5vzQ+uN6Jz5XKRfEdDDd7K47jU0ofde5JqlK+lfia55w9k8EACvm/Rg7b811aksGCo+Mz+hA08nPR+lkMvw/QTvf/ky7WKKPTukS3qFzA7KzCXiiGYMMQzIEcfSQPeKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 5BD81238F;
	Tue, 19 May 2026 22:39:53 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 4F80A22EE; Tue, 19 May 2026 22:39:53 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.0
Received: from [192.168.2.172] (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 845F922ED;
	Tue, 19 May 2026 22:39:50 +0200 (CEST)
Message-ID: <69960d6a-2ca2-4633-91cd-9dad27f6de12@lysator.liu.se>
Date: Tue, 19 May 2026 22:39:50 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] i2c: mux: reg: use device property accessors
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260519-i2c-mux-reg-v5-1-7af068f255cd@nexthop.ai>
Content-Language: en-US, sv-SE
From: Peter Rosin <peda@lysator.liu.se>
In-Reply-To: <20260519-i2c-mux-reg-v5-1-7af068f255cd@nexthop.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

On 2026-05-19 20:19, Abdurrahman Hussain wrote:
> Convert the device-tree parsing path to the generic fwnode/device
> property accessors so the driver can be probed on ACPI and swnode
> platforms as well as OF. The helper is renamed from
> i2c_mux_reg_probe_dt() to i2c_mux_reg_probe_fw() to reflect that.
> 
> Accessor translation:
> 
>    of_parse_phandle("i2c-parent") +
>      of_find_i2c_adapter_by_node()    -> fwnode_find_reference() +
>                                           i2c_find_adapter_by_fwnode()
>    of_get_child_count()               -> device_get_child_node_count()
>    of_property_read_bool()            -> device_property_read_bool()
>    for_each_child_of_node()           -> device_for_each_child_node()
>      of_property_read_u32("reg")        on ACPI device nodes:
>                                           acpi_get_local_address()
>                                         everything else (OF, swnode,
>                                         ACPI data nodes):
>                                           fwnode_property_read_u32()
>    of_property_read_u32("idle-state") -> device_property_read_u32()
> 
> The child-node branch uses is_acpi_device_node() rather than
> is_acpi_node(): the latter also matches ACPI data nodes (the
> _DSD hierarchical-property children used by PRP0001-style
> firmware), which have no ACPI handle and would make
> acpi_get_local_address() fall back to evaluating _ADR against the
> root namespace and return -ENODATA.  Routing data nodes through
> fwnode_property_read_u32() instead lets them resolve the "reg"
> property the same way OF and swnode children do.
> 
> Behavioural preservations (deliberate, to avoid regressing existing
> users):
> 
>    - The three-way endian fallback is kept verbatim: an explicit
>      "little-endian" property wins, then "big-endian", and otherwise
>      the host's compile-time byte order. device_is_big_endian() is
>      not used here because it ignores "little-endian" and introduces
>      "native-endian" semantics, which would diverge from the binding.
> 
>    - The "if (!mux->data.reg)" guard around
>      devm_platform_get_and_ioremap_resource() in probe() is kept.
>      drivers/platform/mellanox/mlx-platform.c registers i2c-mux-reg
>      platform_devices with no memory resource and supplies a
>      pre-set .reg / .reg_size through struct
>      i2c_mux_reg_platform_data; without the guard those
>      registrations would fail in probe().
> 
>    - The "if (!mux->data.reg)" ioremap block (and the paired
>      reg_size validation that depends on it) is hoisted above
>      i2c_get_adapter(mux->data.parent), so the fwnode path
>      preserves master's ordering of "ioremap before parent-adapter
>      get".  For platdata users the validation runs from a slightly
>      earlier position, but mux->data.reg_size is already set from
>      platdata by then, so the order is functionally neutral.
> 
> The OF-only of_address_to_resource() translation in the old
> probe_dt() is dropped because the same address is available from
> the platform_device resource table on OF as well as ACPI, and the
> existing fallback in probe() ioremaps it.
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>

Hi!

Thanks for your patience in seeing this through!

Acked-by: Peter Rosin <peda@lysator.liu.se>

Wolfram, can you please pick this one? Perhaps after waiting a bit
for extra tags, see below.

> ---
> - Discriminate ACPI children with is_acpi_device_node() instead of
>    is_acpi_node().  v4 routed every is_acpi_node() child to
>    acpi_get_local_address(), which is wrong for ACPI data nodes
>    (the _DSD hierarchical-property children PRP0001-style firmware
>    uses): data nodes have no ACPI handle, so ACPI_HANDLE_FWNODE()
>    returns NULL, acpi_get_local_address() falls back to evaluating
>    _ADR against the root namespace, and the probe fails with
>    -ENODATA.  is_acpi_device_node() narrows the match to ACPI
>    device nodes (which do carry an _ADR), and the else-branch now
>    resolves "reg" via fwnode_property_read_u32() for OF, swnode,
>    and ACPI data nodes alike.  Flagged by Sashiko on v4.

According to Documentation/process/coding-assistants.rst, you should
perhaps credit the tool with an Assisted-by tag? Given your mail
address I suspect you might have used other AI tools as well? Just
add tags for whatever is appropriate.

Cheers,
Peter
