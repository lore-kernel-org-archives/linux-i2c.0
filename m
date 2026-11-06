Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969632;
	b=wSxmfD9mKtQgSYebrmXxamCQN/0K7LPPq+DmxwCg/EXJeYAfQWhmptQI6tygwl5PrreY
	 eKVf2bo+kqzfUvLB0iylB0fvHq3XB31FpQPY5qpfCqlg+1zzekaUqCZn0/5SVCCRQWTgV
	 1AFkfZCkVmI4jcnrH4CS1j3ZAjBq3qAy4xI5CX1D/OyP3/ZeSovRPa82gzzQrq/Ufh1SJ
	 v8NfEhtpTaeIoY+LWXWRtAqEW6bD7mZDtE416pzKqVkNDiLNvnxR4KAi43aAxWCWvY74i
	 432qsp5EUZgEEgMOEH7X/kk58xvUT8UQj+NDybUg4ZFgU+H+F8zwHduviFq+bps+wfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oTHjiyDX2guT5VBDXE9scu6NOC96wb99UsVWoSwnSP0=;
	b=46u0V/jEvpTvHpRKIWGT9711yuKbhA1o7y+cT02FoaJpMH5LAFydUKaXMYrcZsHE/UwU
	 NpJKns4uA7nG1B6XczlxHirq71THy9UCkeVGfYyaKc0S1d56j6sSsM/nmS4ihlnkryI2V
	 uKabe3ypmLQO+HsSUp8+IhDjjhmp+q/MgQ/9LTz64W9NVxjiHrlynknL5TqFPVlErIKku
	 2Eq53pZSGDU5CHm5eKwFCpUyXMp7r1ZH/WSEH2AUFgOCvCN/jJXwmxBrJdDC9UPOSWPGG
	 SUI5Ajl/fHS6sURrDyMSL6qWtHkceeBNgPFj+KI/79L9KjX3PmOKWQ9kaX5PN+d459A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RTQOMoxi;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666A3606A337
	for <linux-i2c@vger.kernel.org>; Fri,  6 Nov 2026 12:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 666A3606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RTQOMoxi
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so4081085e9.2
        for <linux-i2c@vger.kernel.org>; Fri, 06 Nov 2026 04:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969631; x=1794574431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTHjiyDX2guT5VBDXE9scu6NOC96wb99UsVWoSwnSP0=;
        b=RTQOMoxix56I3khgiwxSLlG6MqNj4SnKFN0SBhox6cEqvgnl7JGomA1wRtDOmcDzLn
         SMJbxP2clNS4vp9IEQIfNqOTQieTPb/o/DkCapHlrMzsPu6UpPko7DR4mpB3S63dhpsA
         yQIBpXjJ5HgVWdunVyqSVTnmQDD07f5uSMGGmNBys+TeI0//Lgvjg03DukZF8YSSjcXa
         6iBj+12ApuubwP4ZWxCaiBMjqjQQa1joZPEi92XjrxUdybrBwYF7+rkj8D7F62pL697Z
         Dm7VhyarpKwTU6Om6ty0AEYYTNZ8YrIxmj2NZuNBefTI3ypgkCjCScMTGyRuYCr0YEb0
         v0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969631; x=1794574431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oTHjiyDX2guT5VBDXE9scu6NOC96wb99UsVWoSwnSP0=;
        b=Gq+6OL0FxCWR9cdjCbIT+oC1BlrjJoSyjpFyjDvuDP7UMFPmbtou0i3A7+1Nh6YpXf
         0aYWI5nVYUbIImYXbrlTu39hauWsM1n/yeGxQXH1fb6LyW69c/m4j9pbPByQRx+ktab/
         K/+bzVZhdh5L2bIXjt0aVCz3MhUzPjeVe1OLMyAMjPQsrcS5M03JnEoCPDUq1Kccl4/5
         VFSm2IVSBz/uhhMARHSDjz1LGfJBvc3ksvIjq/7ALlfSaJsjrU7rV4ZahpYtx/27LTbS
         3myWAEaLJ6oPDqKmnsvuJOSaV3i9Gc0lr43L9M3Y2BoFTO9/VcK1SP3shaHJQIf0jNVM
         o3RA==
X-Forwarded-Encrypted: i=1; AKwUvBwbnApvavcPqEMtIEZrYqlgTvOfx5auMPqVWwQG0cnw8OioEER73sDQ67o4lJWzZHnJ8Gpts0TLKaQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ykv/OpUCXUsk/m0rW36yw5dAjXrAUWy8Wvh6jX65CRM8wkJVA
	gfu/MF65Fu1NE8nOZX9AncO5wM8MwBPsg1n+bdyuZiySKIrqDB/JfnSD
X-Gm-Gg: AYBFou1kPS0RLsVa+Y9pas1gWM38LzyrGmgJly6U5HDBSHk7W+E+ayuEU9A88mDL9Uq
	+Uuvg9h37zTLCXMSQtEmO0x1ly0PMhhaBb7ZP6V25GmHaaaSqvOjxuuCZQpXjdwG+buuoDipZ8q
	VsM3N+3RpZ8VU3Py4HwZuJP+/cGgw9lN3crUWfFH7+7Qyb8VtoQArMubozrPUNek+9+RqjSAqN9
	iVOSgCXb2Q6yW7cc+Su8XgaQgNTuqOc3r4r5lKyfluU6YHUotH+xiOyW54sxft9eDuSaNPFdZPw
	bZSGZy4krNj+sZR7FxfBUrw9vkmruCr582WWf9LD/gGg04/OGElSBWtk2lXZJPF8NG6G8Q09g2L
	8X7PVrSM5MaSskFJyQxFv73EXdo/q2Xtk0VcBc2InkGn3tbBsx/xer89I9QnXb4rCjgfQ99PvD8
	Cf6U+e+4Uq9Y1DlTyC0tFx95r/WzvP+PA/jl4WAVpp1ESWG7RoLJ9m+b3si+bSbK+CLMqJXvOQV
	P4vEcSvCcQHxfgd1X1Wx42gp/XgOtLltQ+/2tejXo9dOPOp0T2uyEbFoJkKxPGMUL7oL7DojD74
	LgeQKWOzuIvJnAFqet4bk96h+el4
X-Received: by 2002:a05:600c:1913:b0:4a2:1398:dd05 with SMTP id 5b1f17b1804b1-4b6de0ce791mr41196125e9.16.1793969630568;
        Fri, 06 Nov 2026 04:53:50 -0800 (PST)
Received: from m2.. ([37.142.148.124])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4b6e1b5d676sm58687815e9.7.2026.11.06.04.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:53:49 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: Re: [PATCH v2 03/15] HID: ft260: add GPIO support
Date: Fri,  6 Nov 2026 14:53:40 +0200
Message-ID: <20261106125340.18483-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7a3kc2tj2mh62aklablkma5teiinm6b6z2rlvrfwk76xcnd2rb@xwsgziioxz6u>
References: <7a3kc2tj2mh62aklablkma5teiinm6b6z2rlvrfwk76xcnd2rb@xwsgziioxz6u>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 03, 2026 at 01:53:26PM +0100, Bartosz Golaszewski wrote:
> There's a lot of sashiko comments to address but a few additional nits
> below.

Thank you for the review. I am working through the Sashiko findings
for v3. Below is what I plan for each of your points.

>> +	mutex_lock(&dev->lock);
>
> Use lock guards from linux/cleanup.h.

[...]

>> +exit:
>> +	mutex_unlock(&dev->lock);
>
> That way you'll avoid this label. Same elsewhere.

I plan to do this as one new patch at the end of v3, which converts
the whole driver to guard(), and to remove these labels there.

The reason is that I also maintain an out-of-tree version of this
driver for kernels older than 6.5, which do not have linux/cleanup.h.
With the conversion as the last patch, the code before it becomes the
base for that version. It builds on older kernels with small changes,
and I can simply leave the last patch out there.

>> +	dev->gc = devm_kzalloc(&hdev->dev, sizeof(*dev->gc), GFP_KERNEL);
>> +	if (!dev->gc)
>> +		return -ENOMEM;
>
> Why is this dynamically allocated? Make it part of ft260_device.

Will do in v3.

>> +	if (!label) {
>> +		ret = -ENOMEM;
>> +		goto exit;
>
> Just return here? Why the label?

Right, it will return directly.

>> +	snprintf(label, label_sz, "%s%s", prefix, dev_name(&hdev->dev));
>
> devm_kasprintf()?

Yes, v3 uses devm_kasprintf().

>> +	hid_info(hdev, "initialize gpio chip on %s\n", label);
>
> Drop logs like this, they add nothing except useless noise. Same
> elsewhere.

Agreed. In v3 I drop both "initialize gpio chip" messages.

The "enabled GPIOs" message moves from info to debug verbosity. It is
off by default. I would like to keep it there, because my hardware
tests read the GPIO mask from it.

Two messages stay at info level. "registering device /dev/ttyFT%d" is
the only one that tells which tty belongs to which device, like
"converter now attached to ttyUSB%d" in the USB serial core.
"chip code" was in the driver before this series, and it is the only
place that prints the chip version.

Thanks,
Michael
