Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511D394798
	for <linux-i2c@vger.kernel.org>; Tue,  2 Jun 2026 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387888; cv=pass; b=JyELibMMPBc1TLIOTJWiT92LWkeZX3QrBxVfa4L9Ya5Lft9bJODyI4M94BZ/zhAaEjZMWErG6RI1oXLtyXA8nTn9EHW1TqxoJ5cJYNIic0VQA9a4VpY2d6EkW1FJ8P+0iqJpUQVzZF89oQM11NgynE4ZOa7PkG1hOnDAtqglFc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387888; c=relaxed/simple;
	bh=pnwmlQxuqdNrQurh7v1e9vKSMxYrp0Jp3doNPYkrr1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuiAK+gjPYawi28uiDuyvs2b8IFQD0lyiZ/uDPxdO+75zf3zrTDqrDJr8QF5Qn19nslnKXmzDo2adKDCibiBIQCUhMIYRGXavfenS3e9n32X/vopPKUz0T+FozKgRnzky14W26HeBFtEMLJwuAf0MCSs3A9aoA/B/jXGQVXqqjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSrTIaqe; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSrTIaqe"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so2248422e87.2
        for <linux-i2c@vger.kernel.org>; Tue, 02 Jun 2026 01:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780387885; cv=none;
        d=google.com; s=arc-20240605;
        b=Sgpn+9TZ9nmk/7MU9mhlRaw4QkIgHR7N/thKuojFqgt82SFCGyQV1QpxeXA893Guo/
         BqC1EXSIOO1WFaxhDKA3peWdzUxlDfNlTX4GRYOp/mvNLKkOyrPoazwkgUp7Km1y1WiQ
         IjsMdt0gU9OnT23tQ3EiOx5KIXMLbHxwcpUkS6cSpNHLkBELZG2cBusmMdv5ZW2wpGKP
         LsxyWJHKSeW8koWELxqah1kEq+O/2oFgvoj/QO7AMzCc/aeYKoY9nCDwxxQLGR5xZLRc
         H9IrFGtwjiuoWP9jNusw4wurgbcIR3yw2Xs2peMqlLiTZlFdmKavk6Kv483dpNZdX1m4
         Eoog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0AqyNY/g3TIszlVcbBsHINX2o3fZo7a95+GAaAZfEE4=;
        fh=9s0cmjgCNqY2CEw9Cz2uzmpf1hFyG50HSeaT5x4LL8o=;
        b=bJ6Lm9icQBf6c1XX0oykaT+MQNcK+s9xEdqaxaS/7EJukCaYTmj/tSfohG0Rr3XOBd
         I197HK+tZOstPtJruMGFG7XCwdiOlbKGT0a1spko2eXG59O6vYazNcn6iRGeG3xlWao7
         9w0pJoiLBaK+hOhW6AscxLIzPiv2B5VkoDQtCjXR1Q8A7A1I09tHhCpZ2EbZeY0nn/gu
         WqT6Wf/teB7ef/97UFY5p/LkLNZfgMxRlDlmB/5S5dHLLqGgtFkOleqd9+7Kt3y3m9ib
         oMuGic5ZVLeYEjtzjc20fOAHGtqH/M04w+7W2fCok+J+2pPLJnYUr3M7ooc1wn5IMsqt
         ZlGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780387885; x=1780992685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0AqyNY/g3TIszlVcbBsHINX2o3fZo7a95+GAaAZfEE4=;
        b=gSrTIaqe8y4APNvrrEF9dpDWnvgf+dXoj40XvtK53tn76AhXRONto3nvO+Z0Q9Bq12
         kWcxtEgncTVBB31sB4OO7Kx19+Kx65xCNBs6k9xIyo3TEjj0XAfWyec+tyaROZ0XQIME
         QOCXojv65TwcDQ99IMOMP8rVpHS54BIvOt7P0c+pTaphRvZM4dsUbprC+IAwmgf3/5oG
         knOUDGVBVFWH00emlyVZuF+uWeZU132AINezOJD4CLMVpPujY6ZGdefK+wWuGbDt6M9v
         pKFRGsHrlt8uzqUwxJ7oklJWnFM/20ib8QC4X22OLsAhyPIAgqvasRZxE/ZqjM7zxMSr
         7pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780387885; x=1780992685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AqyNY/g3TIszlVcbBsHINX2o3fZo7a95+GAaAZfEE4=;
        b=goM+c0bmXKeLYwIgQjdsZiHTL8okJeIsUXeYfUGUdnB5DJNlBLjBJN0HPGF8VGBIFU
         F4uA5lqhDGVxtYk/G+NLd+h6EHC3f5bfwxbeh/4CRZr4X+n8Vtnnaxu2bbfSNV8+E7JF
         it1vjGAtXQYRmSUf8PWEbYiAjnRiOn6FdKQZAb6kOwCUn9cT4bAWA1LnjV9tScNVU7FB
         fKPKgzu9CnjOmsOnK4cU7pL4/Dbkm3lIc+CJmfqlolVT0noeyBPaqnFZl0M4rG0TQCEk
         Pz1S0Uz8r/Ab4V53VIpf6otkTzpAgpquXcJZDQDgO0VNSk/sHd80wuZSGxGqrdoG3b2B
         1kZw==
X-Forwarded-Encrypted: i=1; AFNElJ8e0K01VsKnNeiaky2l+aePMz/1o9LPyrQdsG9qofPJs/GCGW4mDO1uVPPp81bU5g1yVCOgqIfFawE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK+vq3717pWqv6Dgnu4vyuw90xChLwW45Q/r5lhtLKqTGX16ja
	R4OeKBDjxVX0Cw2rvES7mEELdBfIs5aRg/0rmtFkiSFHZT+No1PMYAa4l8IuW3qyib6000ngS9j
	bBZ4QHwZAURSC0eO38B3QvCsc8I1NK+0=
X-Gm-Gg: Acq92OFDcRnLe75twhXCCRsMlx5Ywa5RG9OCWMztmgHtaoajEigdJ1FtTO68TDKuAFx
	bE8iVKqQuspzFy6JzD+ODw08zKzGVHvBavtTMEezHAnDayP+weclqGK5KP82LuJHF+Xl14VVX3l
	rEibK+EoMwP/Flw7njUf8X+61zErcPJrcghR8o/Gx/wchHhjD40mPLybQz/1wUQ+5Y7XBibu2+t
	UD83a+Inv6dVH+oN2MGQyX6SvBH/aRQd9bjv8zH9RmeYm0qlbOeQ6Mq5952zMYZ/mrqhAGyCASa
	RWjQqliLrXj9jzzSInKk
X-Received: by 2002:a05:6512:3b99:b0:5aa:6523:22b5 with SMTP id
 2adb3069b0e04-5aa652323acmr4015131e87.16.1780387885222; Tue, 02 Jun 2026
 01:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
 <20260524132824.54918-2-muchamadcoirulanwar@gmail.com> <20260528162557.2b0b28d9@jic23-huawei>
 <CAO26r3QZyVco2aZRqPSyWr3d-SBAVEknkaeNDM4g5DFCr3-2aw@mail.gmail.com> <20260601100559.274d5b05@jic23-huawei>
In-Reply-To: <20260601100559.274d5b05@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Tue, 2 Jun 2026 15:11:12 +0700
X-Gm-Features: AVHnY4Irm78_Kg_xuJgPzY0YzVzov3ndwWZWvfzeJyil_0GTKGZCNCjHaprgtCs
Message-ID: <CAO26r3QLJ1ZR1Qfjr6wQo+e3H6v=Z=bxkeE8+nseajYgWLbi4g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/4] i2c: rust: implement kernel::io::Io trait for I2cClient
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Igor Korotin <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 10:05:00 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> +CC linux-i2c and Wolfram - make sure to keep them on future versions
> of this patch.

Noted.

> If this was renamed to make it the rust smbus binding then I wouldn't
> be as bothered by this. For something claiming to be I2C this is a
> misleading interface and I am very much against it.

Agreed. I'll rename it to make it clearly SMBus-scoped in v4.

> Understood that there is more to do, but given the regmap already
> encapsulates the smbus support you have here, I'd be much more in
> favour of the focus going on getting that done.
>
> I would almost suggest not merging a non regmap interface for what you
> cover here, except we do get annoying corner cases where the device
> uses a mixture of smbus like commands and non smbus so there probably
> will need to be support at the i2c / smbus level.

Makes sense. Will defer to Wolfram and the i2c folks on whether this
should wait for regmap or land as a clearly-scoped SMBus patch.


> Is this separating a safety argument from a bug check? If so why
> not just use the tighter one?

> +    fn maxsize(&self) -> usize {
> +        256
> +    }

The try_read8 here is a general SMBus wrapper, not AS5600-specific.
The u8 command (register address) applies to any SMBus device, so
8-bit is the protocol max. If we tighten below that, it breaks devices
with registers at 0x80 and above. The 7-bit limit applies to the
device address, not this command byte.

Thanks,
Coirul
