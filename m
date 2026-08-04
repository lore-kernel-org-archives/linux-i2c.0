Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004B234B1A5
	for <linux-i2c@vger.kernel.org>; Tue,  4 Aug 2026 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855370; cv=none; b=T0ZWhT0OPW4R2xcMKA+g1Dk9G6Mb5UKiyRN+KWASgZrD1dtHvdsBJKmgQ0Jv7VQYUurao3fBseGLNSb5Hly0YtDFUBdj82n4KV7WKtrAqDpNZeBOghE/Hzvjw2gKtG0Vr2859viqbYlgyF3z5qrVpljHw3lmAwErSEBAVC3kFHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855370; c=relaxed/simple;
	bh=i+H7jY0mSc+KEc7VSzDtqOTfn56oYjDd3KqE1qtHxmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9BL9H62yGDpt6N+TlmoluYQA3qsOpwdRtTretqqw/85dpfEwu852wnZHP5ztL2ESnHRAfheuTqxBeUBY52pMpszIKduLBbF28MXSbHifG3Pjv9FHQLaITDp7aFZGuqt4a/KLa2CnxSgaCuBJvZn9j+OHxMq91XsHBX2z9egr4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNaxwrPT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNaxwrPT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so33849715e9.2
        for <linux-i2c@vger.kernel.org>; Tue, 04 Aug 2026 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785855367; x=1786460167; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dw7iJbqbHaMY2LBdW8tLp5jrEOVyIbWuPmPQ4OlZuQ4=;
        b=jNaxwrPTdiDg27z2uFqzTSPKHFp5tfNnhj7YWC1WHwJam18D6mO7cPGU3keJkB/3Dr
         KOt29CLrRPrMIn02BAd5buyshdGdlspqhbzjq15FK+3YVhqPJDAEtw6wJqJKnlZ/OL19
         hIbvbI5k0shcqJtDXdpD8/+DSN6dVVUqoxT3fj9R5UyzU13Xzyckf2tWOEvEZ4RoRjEs
         sPPy6kM/PsUhNIr8/ziwNN1rOKi5dX1C8q2lj70Mmf9r3hSMwIm4IUNXHSEkk0akp24v
         V05Eswr2bUnyYmdGNFWDMIi9Pwe+KnV6OsFp5fY4P2hPFtLvHAOBl+PItPHu3Evm9e4V
         1hWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785855367; x=1786460167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dw7iJbqbHaMY2LBdW8tLp5jrEOVyIbWuPmPQ4OlZuQ4=;
        b=ZRXsdBU3I0PD3TzBZpR1o7rCa6lWDbx8ofT8W0Q3KzbRUShdqVRfFCYLS/ZEQVSuud
         YfWx8hO4x9zMlmsKxI3RLGrt2n1vlFUxnESX6aAFNkNZDsBXgyfQ8MYbatYjBOwMpyNk
         DYwCq2pEcKAxPDoInpFmOxSn/bxt7Fc/kjBPurCf5dQjZ8adB3i9vgHFQV9QVTMKX9tv
         wXGR97vHVqjFuSyzMDBkY1/cdfeBP2qAmsGRdqQ7pQol8csanSEQBCLlTa6T65DKQhT3
         TMSY4gU+VEOMnZ6uI+ndrl1xxYTLP/3a82VDFwhEuSJ6cDNhv5sniapvV/hudnIqnHh4
         RwLg==
X-Forwarded-Encrypted: i=1; AHgh+Rrq0Mbut2ZB/Y7eK5JaeazRzK6mh5w6y36R6CUOCH6m3cVGKYVI4xlhAWsTCoLdA2KVvM9/xeR04Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztt4r2JrjEyZTBQyhjxp4PshGTzV32+ApgqsTJEMT08qEjAGsu
	Ka0rXEuYBfDDVQfwgyiLx3OF7EphwT2oqWXBfPFXyP+9jBptTs6Njp2A
X-Gm-Gg: AR+sD13ic0VHurW5DHe0j6OvrTpQrcVj41x08uqD3pNO11q8VtM9lW8FVHZQ1e6T4Ce
	M0h2ehsLQbjPlw6KjX6fsf1IanDTH6s705M7/W7isxKnhduxfHYiJuedwl0553nxcIivRvgJknc
	4JlvIvqDNgbSNyzy9BVhk0cS472+NhC+Whqpa1U9ScD6/+YU+SlMoK2B4ExGdw8Ksm5NCQUtDcj
	U+DSLKuSkC2tY4B4PmrDkCAUTyZVJW9+ovOQkM6R7/xqRIr/nDeEcLgMnG3ccf+1VRxWMGXc2n1
	Cf/ZWnYxpNufSOpJvTc2Y31H1H8q265kEFezl9T3qyvl06PNRNCnG2lEWQnT4FH1TEl0uhmCy3F
	lMZL6TRXr23caUKHgxhe4UvxYNZG+dwNbLX1LacxFxTL9JRNEtsvmU5JP76CL/XxJIY1GGi0jxu
	eE32YmmD4pGRtQn73LCr82kh3qduBuVxoJqzGQwhU8mftprR3CiQ+u
X-Received: by 2002:a05:600c:8b16:b0:492:6447:7a7f with SMTP id 5b1f17b1804b1-4980c66c84emr273645135e9.6.1785855366892;
        Tue, 04 Aug 2026 07:56:06 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e041b4bsm3730495e9.12.2026.08.04.07.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 07:56:06 -0700 (PDT)
Date: Tue, 4 Aug 2026 15:57:17 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, andi.shyti@kernel.org, 
	wsa+renesas@sang-engineering.com, ojeda@kernel.org, dakr@kernel.org, igor.korotin@linux.dev, 
	branstj@gmail.com
Subject: Re: [RFC PATCH v4 3/3] iio: position: add Rust driver for ams AS5600
Message-ID: <anH7kbxvS6z5GlPI@nsa>
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-4-muchamadcoirulanwar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707151542.91997-4-muchamadcoirulanwar@gmail.com>

Hi Coirul,

Same as Jonathan on my rust capabilities (maybe now I'll have proper
motivation to learn it :)).

Just one question below...

On Tue, Jul 07, 2026 at 10:15:42PM +0700, Muchamad Coirul Anwar wrote:
> Add a Rust driver for the ams AS5600 12-bit magnetic rotary position
> sensor. The driver exposes in_angl_raw and in_angl_scale via the IIO
> sysfs interface.
> 
> Features:
> - ARef<I2cClient> for safe refcounted I2C client access
> - Mutex-serialized status + angle read sequence
> - Static channel spec (module-level const)
> - No magnet validation at probe (deferred to read_raw per IIO convention)
> - Error propagation via ? operator (no recovery state machine)
> 
> The byte order for the AS5600's big-endian registers is handled via
> swap_bytes() in-driver. This is equivalent to C's
> i2c_smbus_read_word_swapped(). The long-term solution is regmap-rs
> where endianness is configured once at the transport level.
> 
> Tested on BeagleBone Black (AM335x) with AS5600 on i2c-2 (0x36).
> 
> Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
> ---

...

> +impl IioDriver for As5600Priv {
> +    fn read_raw(&self, _chan: *const iio_chan_spec, mask: isize) -> Result<IioVal> {
> +        const INFO_RAW: isize = iio_chan_info_enum_IIO_CHAN_INFO_RAW as isize;
> +        const INFO_SCALE: isize = iio_chan_info_enum_IIO_CHAN_INFO_SCALE as isize;

Likely stupid question but do we always need the above? Some drivers might have
several INFO_* bits sets and we often need to nest the match if multiple channels have the
same bits. For those cases having to define all of them like this and
then doing the match seems not great to me. I guess we can directly have 
` iio_chan_info_enum_IIO_CHAN_INFO_RAW as isize` in match but not sure
if it's also that neat...

So bottom line, it would be nice if we could have something nicely
readable that we could directly pass to match.

On another topic, I believe mask is present in several drivers for
historic reasons but note that this parameter is not really a mask. So
other name like 'info' is more appropriate.

- Nuno Sá

