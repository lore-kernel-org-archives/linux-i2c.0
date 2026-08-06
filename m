Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6D3AEF45
	for <linux-i2c@vger.kernel.org>; Thu,  6 Aug 2026 01:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785981291; cv=pass; b=BUh14JqjMobdcH167W/a2g9i51HUMTcGwquPYpb2FgrZh4vGCvA8Fa6hhHmlbT17JSC7P30QUhKD+iP1MaKtm0KqpXBC9iu8KBFIjiuxyR1gA/Z5X6hcGHWe0LA74KgZL9m/mgv+ofePOowcma6u6qQnlJfCH6iTRC/M5+6IgbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785981291; c=relaxed/simple;
	bh=AczqHU5YXkv/sGRytG5ILNrvmcbBaCPxNcePJM/KY2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g26fKxJjfdtgd1lVsa1r+EkziSpREFY1oLg2YolQiZMDgUOWDDZwnrvJtWqvHgcb6RDXYd153ROqM7RI7bRP/cmjy3dmfYtBe6eyN/YAFzr3o/ifhX4aaMGBKNBOvTTsUJthwMNenVbMwx6VjwP9tggz8w8XOGE2jdYV58Q0wg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARRbLNkm; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARRbLNkm"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39f20d19895so13221871fa.2
        for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 18:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785981287; cv=none;
        d=google.com; s=arc-20260327;
        b=QH1c9Ab7BA09sUXE83Xl4+0B6oXTjS9DUXyRQ4cirfozGB0uWyGMtoadu3bFnqpzIb
         mg+QO4kVFdcKszY5lgpYmATbbYiutmwwlXLyLQH5s9Geu13M2WpfEgQrPL3J7MMFdgSr
         4o22h9F7othp8p42coP/OU6S2hnvGhVAXloHhfGffySmUVvj5ShdRjJTjRT5Af+YaWG7
         52/pFfUP14NbA30gkvG7o7m0D2GJr+SoG1nvD60w/TQ1l9BBEJhIKOkWP90gW+4alk8M
         ZICcmHkRVqNZ1yQRlkFaoiSfvSxNfxyMn0Bk1DoYBp+Y8ezo2paqRxcEUSPevl0UNod+
         EywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y0v+95FJN2xAeGezXtBHmiTa1Xgl32MRgRsBCWW8cqA=;
        fh=NapM2zA+nM/NG+lfXIqJyeKVUmJgLaulT3ORVgPtnWI=;
        b=KO31sK8rgW0rgc4kd050Zc+nLpf3nLU1BL1sCwJ2DmnTiNDnZoGEg/+I4LsjM4Yzrz
         lW8SViQQrTKXamg/0gsJ51bBX9EbVPpMMAiZqVh0duAAGchjDaA1f7lYQhcuOJvO5Tx3
         00MDv3z5KuEC389OxJXrYJWjX9GQ46lkJYucR0fY2Pn9weVQqHBfZwUlD50jf59i/HaI
         YR79tJJeb8jSD+Gtl+W3eEf0bA3I2W0LZVkTvphhdHkcWkrpxWQtTUNRmNLOfa6Rba15
         W4jQf6be0SQR6JofM43ic3FKfPdDFUd4tKc5FjplmYvhGu3BIO2iWaFWA7fCPwr3UwKv
         Aa/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785981287; x=1786586087; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y0v+95FJN2xAeGezXtBHmiTa1Xgl32MRgRsBCWW8cqA=;
        b=ARRbLNkmhRQIYmTjCNnFVSCjhNvCHVq6agB6tyAWBA5c5P/MtstZLiVGD6gBE2nLGt
         ok/8crs2TTWqbYTqmToA85qJ24bwlYkWyazes+ZBawLvqTm0rfs32JiOlfSOBiZb2RQq
         uRiocUiDNst4ft99f8ZeGKu3IFWj2W+2xxG709G05ONEY38HXfxEw10hppjWDIo2eLkc
         igehXGIayAfTx3uTu34HpLyTPZB0LL9P8z9wbkAZj8O7VnoPJ++S6XrFOvioeHT75YH+
         ISGxynCPuWu4sLr8aN6amv6ik4Ax1/qSr+NpiS5klyUtuglaXr8DN7GcNVGYf/xC9b6q
         2mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785981287; x=1786586087;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y0v+95FJN2xAeGezXtBHmiTa1Xgl32MRgRsBCWW8cqA=;
        b=Ln/NSI0dzQ1PpjNs0qqFDwfNTkwgVyLkpolSF2KkOYNv7TxiZ1hvUAGIZfn3ePArwd
         1cyYGjYxo0eU92Lx8xVv6FDopTIDW3ySZLRusoUMzYYk4+Icwm8w53iLHeoDPPSD8C79
         LE8+Hzp3qyes9FR6ixnlb9+8kAH6GaECE1bQwmw9LgBhDlPJ/mJqbAM0xw+A6fYl18qe
         Uzi84IIFSxdSpYMx6XBSiFbMfHojU1YotLCRGrxl7Lr+nwujrxaR6nRWRaFYxB3BNgRK
         8SHpVXbmnRnaQBeYlG2N5844A5Nw4yGFWS4H3sVyEs1e8uRTYrf4A3saQKv0JyapIAOf
         KaZA==
X-Forwarded-Encrypted: i=1; AHgh+RqJu9u9GWIrI0sSRTHZQ2hXgynGh2HzLSvx8Eh/Gg5QUIsIV1SHpMO8xWJxcANJPMIjw4NbCeq7Rwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjEJ3O/Nc7U5zmNZgIfyrbjjJ1i7sOqLumv+kLip1OFNcFwTkg
	6KZS02pTGKrNVH9mj2v+sz53IJHY/l/gyiGH2JYJAIzwGQHqHr43x0Xpt8ng94KoLSLN9OrmDNn
	ic/kV5OQu8z0p4r47LKUJGb36WDn+4Ow=
X-Gm-Gg: AR+sD13rleZDdtjcICzFOR+3RcZEPenjJxqENpUIlt0tipIYUVd/jdB3KHyJ0HURkQO
	k0pkkwVvgfxBUPcLwzb2MiVGB968p6T5sAO6rqK9pMmcBUmpN3NUo3KhXIpomg5/Aqee/+ryS3w
	WRPYd4lj6hEVloYSSDVDfbwHTEgqDsf0n1eXjZVIPHkOi7u/yoodW+NmuAY+gEvKKc0xjGfNFJi
	1ihqhHQnyfQz838jk3IflZidXre0MHSMVF7f8a5YyxEpCF7DhwC/UfyFhAaleSNMGW6lLnZQe8Z
	hL/3yVUa/Y08MSKCERtemYqs65okbC+rH+2SDKv/XpVNPzg=
X-Received: by 2002:a05:651c:43ce:10b0:39c:6e2c:23c3 with SMTP id
 38308e7fff4ca-39fbb1a77b9mr10575071fa.5.1785981287009; Wed, 05 Aug 2026
 18:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-4-muchamadcoirulanwar@gmail.com> <20260803021304.60316f02@jic23-huawei>
In-Reply-To: <20260803021304.60316f02@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Thu, 6 Aug 2026 08:54:35 +0700
X-Gm-Features: AUfX_mzWK4XXhsRESZ_Kmb2gu7WrUK0XlrPMF2qslyhsMb3pa9c6pviVSb90BcA
Message-ID: <CAO26r3R4TzKmemR4r060Bz8xGaAPZ72j8MCEzOHB29+xtBEsrg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/3] iio: position: add Rust driver for ams AS5600
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, andi.shyti@kernel.org, 
	wsa+renesas@sang-engineering.com, ojeda@kernel.org, dakr@kernel.org, 
	igor.korotin@linux.dev, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 08:13, Jonathan Cameron <jic23@kernel.org> wrote:

> Sadly my rust remains very limited :(  So you both end up at the back
> of my review queue and I can't provide much useful review!

Thanks for the review, Jonathan. Every review teaches me something regardless.

> > +config AS5600
> > +     tristate "ams AS5600 magnetic rotary position sensor"
> > +     depends on I2C && IIO && RUST
>
> The IIO dependence should be implicit given it is buried
> deep in a menu gated on that.
>
> > +     help
> > +       Say Y here to build support for the ams AS5600 12-bit
>
> This Say Y language is odd as it sort of disagrees with the M
> section below.  Start off with what it is then finish up with
> any suggestions on Y vs M.
>
> > +       magnetic rotary position sensor with IIO channel support
> > +       (in_angl_raw and in_angl_scale).
> > +
> > +       This is a Rust driver that exposes the 12-bit raw angle
>
> I think the aim is that no one configuring the kernel should even
> know what the language used.
>
> > +       and radian scale via the IIO subsystem.
>
> I'd skip the IIO reference here given to get to this help typically
> someone already navigated down into the IIO menus.


I'll drop "&& IIO" from the depends line and rewrite the help text.
Device description first, Y/M hint at the end, and no mention of the
implementation language.


> > +
> > +static AS5600_CHANNELS: As5600Channels = As5600Channels({
> > +    // SAFETY: `iio_chan_spec` is a repr(C) struct where all-zeroes is valid
> > +    // (integers default to 0, pointers to NULL).
> > +    let mut chan: iio_chan_spec = unsafe { core::mem::zeroed() };
> > +    chan.type_ = iio_chan_type_IIO_ANGL;
> > +    // TODO: Use kernel::bits equivalent once bit_usize exists
> > +    chan.info_mask_separate = (1usize << iio_chan_info_enum_IIO_CHAN_INFO_RAW)
> > +        | (1usize << iio_chan_info_enum_IIO_CHAN_INFO_SCALE);
>
> No nice BIT() equivalent?   Those names end up rather repetitive with
> most of it coming twice.
>
> I don't suppose there is any way to avoid that?


There's no bit_usize in kernel::bits yet. I'm considering adding it
for v5 since the change is small.



> > +impl IioDriver for As5600Priv {
> > +    fn read_raw(&self, _chan: *const iio_chan_spec, mask: isize) -> Result<IioVal> {
> > +        const INFO_RAW: isize = iio_chan_info_enum_IIO_CHAN_INFO_RAW as isize;
> > +        const INFO_SCALE: isize = iio_chan_info_enum_IIO_CHAN_INFO_SCALE as isize;
> > +        match mask {
> > +            // IIO_CHAN_INFO_RAW: read the 12-bit raw angle value.
> > +            INFO_RAW => {
> > +                let hw = self.io_lock.lock();
> > +
> > +                // Read status register to verify magnet presence before
> > +                // reading the angle.
> > +                let status = hw.client.try_read8(AS5600_REG_STATUS as usize)?;
> > +
> > +                // Check magnet presence (MD bit). Without a magnet the angle
> > +                // register contains stale/invalid data.
> > +                if (status & AS5600_STATUS_MD) == 0 {
> > +                    return Err(ENODATA);
> > +                }
> > +
> > +                // Word read at register 0x0C: SMBus read_word_data returns LE,
>
> That seems wrong.  It assumes LE data on the wire, but should return in
> the CPU endianness.  Hence it's a swap in all cases, rather than an be16_to_cpu()
> which would get it backwards on a big endian platform.

You're right that the comment was misleading. That was my mistake. The
swap is unconditional and has nothing to do with CPU endianness. I'll
rewrite the comment to reflect that.

Coirul

>
> > +                // AS5600 stores angle big-endian, so swap_bytes() is needed.
> > +                // Mutex ensures status + angle read is atomic.
> > +                // NOTE: Equivalent to C's i2c_smbus_read_word_swapped().
> > +                // Long-term, regmap-rs with val_format_endian=Big handles
> > +                // this transparently at configuration level.
> > +                let raw = hw.client.try_read16(AS5600_REG_RAW_ANGLE_H as usize)?;
> > +                let angle = raw.swap_bytes() & AS5600_RAW_ANGLE_MASK;
> > +                Ok(IioVal::Int(angle as i32))
> > +            }
> > +            // IIO_CHAN_INFO_SCALE: radians per LSB, 2*pi / 4096 = 0.001533981.
> > +            INFO_SCALE => {
> > +                Ok(IioVal::IntPlusNano(0, 1533981))
> > +            }
> > +            _ => Err(EINVAL),
> > +        }
> > +    }
> > +
> > +    fn channels(&self) -> &[iio_chan_spec] {
> > +        &AS5600_CHANNELS.0
> > +    }
> > +}
>
