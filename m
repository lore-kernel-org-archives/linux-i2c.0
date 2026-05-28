Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B393546FC
	for <linux-i2c@vger.kernel.org>; Thu, 28 May 2026 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005133; cv=none; b=PCHM/Sk5nj7AaJaLAqWinV32Rk2NOVUsR0FizD7vhbkhPm35z4J4xvd8Tfc9t1SvKHVH4crV6CradLPuj2ILCAWUwSWP10waVE+/awxru8JzektFSO28ssMk9qywg15ojXK/wRex8xXisNWu/BmIwKBknsk6qiScl4Q4SaGRgks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005133; c=relaxed/simple;
	bh=rVktahZWejU1jR1k85dCfFo7ewd3VS1Hq2MzKmRkeEU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=OfGrc6fDTjtDpN/XjqB16lc/mznix+av5B2ghbLh1b3Bvf8S2hJAOY8kdiWEdnliJysCUQZ7RFKPSLdtqloHiSlFNbEQnPrC2V+FvyAjMAWzxRkQ8V6ONq2HUQXchETLfsgQCxuXGDyFN15lnvjtNT3CKQt5Gvgo6ONBXO7rXWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=V19OrR7T; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="V19OrR7T"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3045c195251so7128603eec.1
        for <linux-i2c@vger.kernel.org>; Thu, 28 May 2026 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1780005131; x=1780609931; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6+d3eci8Gyt+/+AHbnvkVmgmViYggng28h+t9MnxuY=;
        b=V19OrR7TbL60DBwCk2nLscrIP9Nfrhmi9EAtGTZpmfkKseb1DHRVRSMmOxgvkx5Tfc
         rD86xnS9Sd3lPtn+UuuQNsY+x2RbqDblAWXembLrqmpf6iBeyZWwopwCVFwJdLqwPZRx
         eIHmumQjye4pKMuQJN5RO3EffIRC0UDOWhDy3IZ3rCP8cJmciBlA/Gw3UbAr77wD2KCY
         LT6McIJ0AAFHAYCVy86Un4TzwKuqSfKKlRyP4aSN5Aiyo5Wv4NIeWwu26Kshs8OUZd7H
         Wc4i7S+asXz5mpAhB/dF1TBNa9Xww3s3RtJs2d1DJfNKPwRPkqj9LiisRXS8peSYfSbF
         kMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780005131; x=1780609931;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J6+d3eci8Gyt+/+AHbnvkVmgmViYggng28h+t9MnxuY=;
        b=RnpmbT3hc0snf5yd3v2TXfGmEcs1ul+vhckribu0loJy44vHrfQsWNbpdTI/uuXL1S
         nALgs+JXTlJtbwX6Xhb31TM0P2+s2XuMlu3yrIyUKiIY90mzRYXcWpG0f3N7avEa5HGd
         6HPBzEgOSMUqrvCmqmoxhFfKTRZwjS51PfOJOmr/F+gC98x3FPBe1KNx+PQ6Z/0Q97e0
         rPV7k0olfY9cn8KN257dfWIO1CHBHUQxxhahFtqhZaU6xXhs7qAdlM001PU/SlB8y5qF
         zuLTkR1Ph+NBTOpePXCyjZRdwzjxoRuE7llN/tGb93a65PmnBnGGiC/rEyUuBJxb/B9y
         m98w==
X-Forwarded-Encrypted: i=1; AFNElJ9FGXlUnibAawlfUWg0qY22FYBqmbBCHZaqjg2hIzOvn/mNxNEk0s36U4xEu0U/3Ya7Dz4Z+pf+/bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcn0ZU+IOAifaDaeyQEvAEsahzmGC3sco7khPsF+Ze6bdALKj
	wPML2Cuqt1f2soq7MMLj2cLZaD16g8FbLcAOaUEvYo8V/nsSv+Zy7R4RCYzN5fkfs88=
X-Gm-Gg: Acq92OFfIQyxR8drU8kv9sORCI85/m1dKFoDPB67pbtCmP1jr1RztQ+fguk9hw85KBN
	+7803uNbdTnlPKhFt7abO22bw8qZKAA71M6qxILit0k/5ChuAtDAMSgmxhV8k9Pma7DAh6khSom
	vu+Otfh6KRM2Moq9VC+PVN/7M6Yv7048vBsOvfN1Z8QbNhQ2LpUIyO7uLghQZmCMsI2uhkO0hLY
	SVTbHEkySj5S1sODME+5pdutuUzsYNTDEV0VP+tDbpHAji9gZUQUhmNiR+9Es/xkAyD1VjSzV/S
	/WuGZDNw9h0oEzjU1PjKqNjthXIGMqJ5IK2C77Alot1VnRtCBh6mMIe1sW7TPEwFxESLMULflFx
	cVswdzeWx1jZA3NKqaOq837oBwQjb6ppkblpqi2KssZdw1NEpJ65Qs3dBEf1e5ceu7QfW5U5VN4
	p6fuMn3eQioFfPGRHTM+wzySOvAjMx4RmpQw==
X-Received: by 2002:a05:7300:bc0b:b0:2d9:2b54:ea9c with SMTP id 5a478bee46e88-304eb17e882mr152358eec.18.1780005131067;
        Thu, 28 May 2026 14:52:11 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ebd25de3sm50575eec.30.2026.05.28.14.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 14:52:10 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 14:52:09 -0700
Message-Id: <DIUN5NSLIH1U.1U1TFC7N4CJR@nexthop.ai>
Cc: "Peter Rosin" <peda@lysator.liu.se>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] i2c: mux: reg: use device property accessors
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20260519-i2c-mux-reg-v6-1-a27ff50dee67@nexthop.ai>
 <ag1a5TLH7L-BSWWp@shikoro>
In-Reply-To: <ag1a5TLH7L-BSWWp@shikoro>

On Tue May 19, 2026 at 11:55 PM PDT, Wolfram Sang wrote:
> On Tue, May 19, 2026 at 02:18:50PM -0700, Abdurrahman Hussain wrote:
>> Convert the device-tree parsing path to the generic fwnode/device
>> property accessors so the driver can be probed on ACPI and swnode
>> platforms as well as OF. The helper is renamed from
>> i2c_mux_reg_probe_dt() to i2c_mux_reg_probe_fw() to reflect that.
>>=20
>> Accessor translation:
>>=20
>>   of_parse_phandle("i2c-parent") +
>>     of_find_i2c_adapter_by_node()    -> fwnode_find_reference() +
>>                                          i2c_find_adapter_by_fwnode()
>>   of_get_child_count()               -> device_get_child_node_count()
>>   of_property_read_bool()            -> device_property_read_bool()
>>   for_each_child_of_node()           -> device_for_each_child_node()
>>     of_property_read_u32("reg")        on ACPI device nodes:
>>                                          acpi_get_local_address()
>>                                        everything else (OF, swnode,
>>                                        ACPI data nodes):
>>                                          fwnode_property_read_u32()
>>   of_property_read_u32("idle-state") -> device_property_read_u32()
>>=20
>> The child-node branch uses is_acpi_device_node() rather than
>> is_acpi_node(): the latter also matches ACPI data nodes (the
>> _DSD hierarchical-property children used by PRP0001-style
>> firmware), which have no ACPI handle and would make
>> acpi_get_local_address() fall back to evaluating _ADR against the
>> root namespace and return -ENODATA.  Routing data nodes through
>> fwnode_property_read_u32() instead lets them resolve the "reg"
>> property the same way OF and swnode children do.
>>=20
>> Behavioural preservations (deliberate, to avoid regressing existing
>> users):
>>=20
>>   - The three-way endian fallback is kept verbatim: an explicit
>>     "little-endian" property wins, then "big-endian", and otherwise
>>     the host's compile-time byte order. device_is_big_endian() is
>>     not used here because it ignores "little-endian" and introduces
>>     "native-endian" semantics, which would diverge from the binding.
>>=20
>>   - The "if (!mux->data.reg)" guard around
>>     devm_platform_get_and_ioremap_resource() in probe() is kept.
>>     drivers/platform/mellanox/mlx-platform.c registers i2c-mux-reg
>>     platform_devices with no memory resource and supplies a
>>     pre-set .reg / .reg_size through struct
>>     i2c_mux_reg_platform_data; without the guard those
>>     registrations would fail in probe().
>>=20
>>   - The "if (!mux->data.reg)" ioremap block (and the paired
>>     reg_size validation that depends on it) is hoisted above
>>     i2c_get_adapter(mux->data.parent), so the fwnode path
>>     preserves master's ordering of "ioremap before parent-adapter
>>     get".  For platdata users the validation runs from a slightly
>>     earlier position, but mux->data.reg_size is already set from
>>     platdata by then, so the order is functionally neutral.
>>=20
>> The OF-only of_address_to_resource() translation in the old
>> probe_dt() is dropped because the same address is available from
>> the platform_device resource table on OF as well as ACPI, and the
>> existing fallback in probe() ioremaps it.
>>=20
>> Acked-by: Peter Rosin <peda@lysator.liu.se>
>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>> Assisted-by: Claude-Code:claude-opus-4-7
>> Assisted-by: sashiko:gemini-3.1-pro-preview
>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Hi Wolfram,

I noticed this patch didn't make it into 7.1-rc5. Is it still under
review? If not, will it make it during the next merge window?

Best regards,
Abdurrahman
