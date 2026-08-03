Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5E03AFB19
	for <linux-i2c@vger.kernel.org>; Mon,  3 Aug 2026 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785744886; cv=pass; b=mcGWQNvsWUYLj8rOGlymfz/vJE1wnY8SuYBDdk3tp14WTAmQspdbnC+nDernYbBiBWyAjRtvInorz4cqyhr2ruPPzKnwIpUAJn9w4+XWvgH9WAeWvi2dQ2CXchgbUTFxfNq/Fi24K6hLH2u7a/92rtbMtwJkh0brSKEuI3R/un8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785744886; c=relaxed/simple;
	bh=3cqcNnVb2WyfB9PoSWTB60t1mDaBggOyQJRmUAGfheo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Td3QmvxM9Lxqj7uFm6LL/+15FnD4/amVRw0qE7azV13//WdMU4tjP/8iQRRU5H0m596sFsOOiMdKyvAFBcCOVkqoWS4GojNAhSx74aGAjqKoUgKVDfIuZmGH5OsHBNzABjF7Bbbka63Fuata5Knb9yw50VZseqyMO5INKCeDcXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpe5eZce; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpe5eZce"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b2a8e4c77eso3047343e87.1
        for <linux-i2c@vger.kernel.org>; Mon, 03 Aug 2026 01:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785744882; cv=none;
        d=google.com; s=arc-20260327;
        b=Dwp+LqpdLWYwf5jmQ53qV1wE5BEH0uW4b0j6V8HswyGpzIGT7PJSXUahOrLBsxrjT6
         LsCb/cvzXlIGhXLQ+85DvjUuW4QsapBu0BDRBHBfpNIqEHAip0SPVPOz/CXtlO9kAGru
         AEyN6ryFuu2IeRQsJ6IjZ9XjAv/e/cQ/oh7R+LULtCYVoj8kNFpzc1ZnjtN35UKEHMLo
         DZ/O1n7M0Cf6bQ7ZWYU78lw1cfFHJ/LUvPcj6WgGu5lVTzSSPIBTX4ljIJoykOWgIuqc
         REKotMfXc3UQtFyXrwS9O7WywdAM2HhUvtAH7UmDVi2WpaZB6VWDTKoRdg/K96yRYQCH
         bpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1lH4VF2+CDVyt0vTT1JwRMkG4voqxUDw2iWfdZAsPUs=;
        fh=zb+DldKH0WGsXR6YFJ+E6LObYoDGzmVxrfNHgdCf2Gk=;
        b=FNY0rit1tjByRryyu8qPfoFCnU2DCNhQy6HDClpxwc7slF8GJXPRJ7+kSxbPmsFw5j
         JgpIllIxZyNVSMrb4BmomTpjhCiVksfzsJw+b5Tb7F21ysQRDCchfzUJtYCkhYKQ3wxX
         y5upawZYVUt6X0JtIFxdEHG0NrU+0/Tx5xwp9RtpV+jd0hj55o9jmXY+EYGBqqdNTU3X
         ommg9aTDkclRsTUbQDf+CkWz0DVMoZCft6O2CXoonAF5Sp7dvvpjLE0DreebltSq1fXu
         FvRdIDmXtZmOy11YeTtKcOCMpivk+HH+MKHhhXw7NxO4tnW6TxGL3G5ubw3d5z5umUcV
         8EMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785744882; x=1786349682; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1lH4VF2+CDVyt0vTT1JwRMkG4voqxUDw2iWfdZAsPUs=;
        b=gpe5eZceLVOU41oiyNhrsF5dCxH28DjRPgZvBfCoUEzfSg5pDANkwScQZPRt66WhEm
         PBHvU4T9ebeuqIPBV1VGC2l9zplCaesNOChAWY8n82wbUI4ctsDpDQYTEik65PLGQu3+
         xAs8czo7b9JlZ+ENPYcrNRf7RI48fFV60yLsieDNcnonnfmKxGLqCQ2gXhmHNVcG/NID
         t/uhNXwtcEx3bD51ofGxks9aiPi6Vy3ktPCBGY/KfNEJjChB56/+Gnd4t8QqstsMP7vY
         e5S//msAyWRPmsItCl4PVNwn2910Vv+zVAVNh6BAK5O9O9+mV8j8pXBIYwY0TSdxHqYp
         pzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785744882; x=1786349682;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1lH4VF2+CDVyt0vTT1JwRMkG4voqxUDw2iWfdZAsPUs=;
        b=Nfm7azP455lCTND4F9MrE4IZYZgU3tOU2McUB5YJmVhK/VhGnXaWiNmX6cgxi0NQpw
         nhwFnaT7sYBqxCzYgObag9uglDVrXx/v0aZC2wVuWlQ/PzlwT8+DQnG4du6UupCzwke7
         v0tigLwarI28fpNwr8AATBLhsJVubEuLGJRPoDlJbzH33GMBCyjYlHAdxf1nkMXlIJCp
         XOfpu+YcPwqdbk2OB07fyL+eyls3D8iZCKrS9bekr/H2Hjw5R2sH7aXXxFHailn2NcFg
         vqYPm+hKayh09VSE4GlSX0gnk/9Qg4JLlOyjpoDAUArmNWnxt4HpGd2zSFWj1hj+cxiX
         w46A==
X-Forwarded-Encrypted: i=1; AHgh+RpVa/icSzQzBwBuxUJqEtTBPK2N/iBCNySxWlKDwnbfbIzMl/kU48K1V3SAlzWmzgif//EhvSV0chM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJzgfUf2J+Ad2UTDVrerCxv7tVrksZR0ZF6w0jmyeJ3iOOwXw0
	+zzWlNfVWOt6bTjB/ePwaBBRBV7WXXxRDJRobpt10OjQeKpG/jgW7Obl1PtCnjMQCLNi+wNGN2+
	1EAt9kR4FjoF77s0eCcy1kmgjf//Smts=
X-Gm-Gg: AR+sD132IqqXcJSwHGBFvk04dBfSVz0SFpU+IbkvoUHhRyqAf4Tz5ZPDx2VEfkV7M8A
	GG0aeXb5ptdKj/Ni6/C6wPh+sKAz4cFSRo72FI5xJ0odEsNxtclfcxdSWyHidy6LnP+IL325L9n
	IOP+o/V8u+V4kWgDojCwDHcMEe7YZStCwMpOvxjflV65j3ZGDeaVLBM2OtVusLEwgwAPTsJtJ1X
	2aZMtbdC1bC6G8PhTO/A5uuXqU3Fnw3HGcDqntwUsjZbweFUICQDAEeO9xVJefU/uMMvo/FSujB
	5/Cqbe3AOlfuqBtbWKWPbM12H7UJ+u9grIpoPCMrKDvymgkBXxGDQ78ODw==
X-Received: by 2002:ac2:5618:0:b0:5aa:6c98:a090 with SMTP id
 2adb3069b0e04-5b2e4f7337cmr1226857e87.34.1785744881794; Mon, 03 Aug 2026
 01:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-2-muchamadcoirulanwar@gmail.com> <20260803015321.07dc16d1@jic23-huawei>
In-Reply-To: <20260803015321.07dc16d1@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Mon, 3 Aug 2026 15:14:30 +0700
X-Gm-Features: AUfX_mzKoYx4jmKNOBGEKJP7Fj6qvyJ2JbJwMv9MKw9z722A2a-xmz-sO398Fuo
Message-ID: <CAO26r3TrJaa2EVrnv8ZuqR8QR2=Z+Z6e-hHEAwb5MSv8Cc3w3g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, andi.shyti@kernel.org, 
	wsa+renesas@sang-engineering.com, ojeda@kernel.org, dakr@kernel.org, 
	igor.korotin@linux.dev, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 07:53, Jonathan Cameron <jic23@kernel.org> wrote:

> > Implement the Io trait for I2cClient, providing SMBus byte and word
> > read/write operations with automatic offset validation via io_addr().
> >
> > I2cClient implements the generic Io trait rather than exposing
> > standalone SMBus methods, following the direction established in [1]
> > and [2]. The underlying calls are still i2c_smbus_read_byte_data and
> > i2c_smbus_read_word_data.
> >
> > I2cClient now implements IoCapable<u8> and IoCapable<u16> with
> > maxsize=256 (SMBus command byte range 0x00-0xFF, not the 7-bit
> > device address which is handled by the I2C core at adapter level).

> Just to make sure it doesn't get lost across versions - I'll repeat
> briefly what concerns me here.  I'm also interested to hear Wolfram's
> view on this as well as Wolfram has probably seen more weird
> i2c devices than anyone else.
>
> I2C isn't one nice set of here is how you read a byte and here is how
> you read a u16.  Even smbus effectively has 2 options given the large
> number of devices with the bytes flipped.  Those exist because
> they weren't designed against the smbus spec (very few datasheets
> even mention smbus) but rather the less constrained definitions of
> the i2c spec and under that there is no concept of a word so ordering
> is whatever the hardware fancies (wonderfully we even have devices that
> aren't consistent in ordering register pairs but let's ignore those).

Thanks for the feedback, Jonathan.

That's a fair point on naming. The underlying calls are
i2c_smbus_read_word_data and i2c_smbus_write_word_data, so the
interface really is SMBus, not raw I2C.

On smbus_swapped, AS5600 is actually big-endian and currently I handle
swap_bytes() manually in the driver as a workaround. The reason I
didn't add a swapped variant yet is that in v4, the I2C bindings still
followed the MMIO pattern (IoCapable), which is infallible. Adding
smbus_swapped on top of that felt premature when the foundation itself
wasn't right for a bus that can NACK or timeout.

> So maybe introduce this as smbus as long as we can chase it with smbus_swapped
> for the byte swapped version.  Or don't introduce smbus at all
> because if this limited subset of smbus applies, then maybe just jumping
> directly to regmap is the right way to go.
>
> Calling this i2c and provide these interfaces is to me giving the
> wrong impressions of what it is.

In v5 I switched to FallibleIoCapable, which was proposed by Danilo
specifically for fallible transports like I2C. With that
foundation in place, adding a smbus_swapped backend is straightforward
and I can include it in this version if that's the preferred direction.

Wolfram is on the CC list. He's no longer listed as I2C subsystem
maintainer in MAINTAINERS (that's now Andi Shyti) but I agree his
experience with I2C devices would be valuable here.

On regmap, I noted in the driver comment that regmap-rs with
val_format_endian=Big would handle the endianness more cleanly. That
would be the better path if the Rust bindings exist or are close. Since
they don't yet, I went with the SMBus approach as a practical stepping
stone. Happy to revisit once regmap-rs is available.

Coirul


> > ---
> >  rust/kernel/i2c.rs | 89 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 89 insertions(+)
> >
> > diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> > index 624b971ca8b0..31c7216d0299 100644
> > --- a/rust/kernel/i2c.rs
> > +++ b/rust/kernel/i2c.rs
> > @@ -14,6 +14,7 @@
> >      devres::Devres,
> >      driver,
> >      error::*,
> > +    io::{Io, IoCapable},
> >      of,
> >      prelude::*,
> >      sync::aref::{
> > @@ -601,3 +602,91 @@ unsafe impl Send for Registration {}
> >  // SAFETY: `Registration` offers no interior mutability (no mutation through &self
> >  // and no mutable access is exposed)
> >  unsafe impl Sync for Registration {}
> > +
> > +impl<Ctx: device::DeviceContext> IoCapable<u8> for I2cClient<Ctx> {
> > +    unsafe fn io_read(&self, address: usize) -> u8 {
> > +        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer
> > +        // (type invariant). `address` was pre-validated by io_addr() before
> > +        // this function is called (trait contract).
> > +        let ret = unsafe { bindings::i2c_smbus_read_byte_data(self.as_raw(), address as u8) };
> > +
> > +        // NOTE: Error is lost here. This is only called via try_read() which
> > +        // first validates bounds via io_addr(). For I2C, the caller should
> > +        // always use try_read8() which provides proper error handling.
> > +        ret as u8
> > +    }
> > +
> > +    unsafe fn io_write(&self, value: u8, address: usize) {
> > +        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer.
> > +        // `address` pre-validated by io_addr().
> > +        unsafe { bindings::i2c_smbus_write_byte_data(self.as_raw(), address as u8, value) };
> > +        // NOTE: Return value is ignored. `IoCapable` trait signature does not
> > +        // support error returns. Use with caution.
> > +    }
> > +}
> > +
> > +impl<Ctx: device::DeviceContext> IoCapable<u16> for I2cClient<Ctx> {
> > +    unsafe fn io_read(&self, address: usize) -> u16 {
> > +        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer.
> > +        // `address` pre-validated by io_addr().
> > +        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), address as u8) };
> > +
> > +        // NOTE: Error is lost here. See u8 implementation note.
> > +        ret as u16
> > +    }
> > +
> > +    unsafe fn io_write(&self, value: u16, address: usize) {
> > +        // SAFETY: `self.as_raw()` returns a valid `struct i2c_client` pointer.
> > +        // `address` pre-validated by io_addr().
> > +        unsafe { bindings::i2c_smbus_write_word_data(self.as_raw(), address as u8, value) };
> > +        // NOTE: Return value is ignored.
> > +    }
> > +}
> > +
> > +impl<Ctx: device::DeviceContext> Io for I2cClient<Ctx> {
> > +    #[inline]
> > +    fn addr(&self) -> usize {
> > +        0
> > +    }
> > +
> > +    /// SMBus command byte range: 0x00-0xFF (256 possible register addresses).
> > +    /// This is NOT the 7-bit device address; that is handled by the I2C core.
> > +    #[inline]
> > +    fn maxsize(&self) -> usize {
> > +        256
> > +    }
> > +
> > +    #[inline]
> > +    fn try_read8(&self, offset: usize) -> Result<u8>
> > +    where
> > +        Self: IoCapable<u8>,
> > +    {
> > +        let reg = self.io_addr::<u8>(offset)? as u8;
> > +        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct i2c_client`
> > +        // as guaranteed by the type invariant of `I2cClient`. `reg` is bounds-checked
> > +        // by `io_addr()` above (offset + 1 <= 256).
> > +        let ret = unsafe { bindings::i2c_smbus_read_byte_data(self.as_raw(), reg) };
> > +        if ret < 0 {
> > +            Err(Error::from_errno(ret))
> > +        } else {
> > +            Ok(ret as u8)
> > +        }
> > +    }
> > +
> > +    #[inline]
> > +    fn try_read16(&self, offset: usize) -> Result<u16>
> > +    where
> > +        Self: IoCapable<u16>,
> > +    {
> > +        let reg = self.io_addr::<u16>(offset)? as u8;
> > +        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct i2c_client`
> > +        // as guaranteed by the type invariant of `I2cClient`. `reg` is bounds-checked
> > +        // by `io_addr()` above (offset + 2 <= 256).
> > +        let ret = unsafe { bindings::i2c_smbus_read_word_data(self.as_raw(), reg) };
> > +        if ret < 0 {
> > +            Err(Error::from_errno(ret))
> > +        } else {
> > +            Ok(ret as u16)
> > +        }
> > +    }
> > +}
>
