Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC273DAAA0
	for <linux-i2c@vger.kernel.org>; Fri, 28 Aug 2026 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900007; cv=pass; b=LNTDwYyOcSbt5rUzgWGliqh/udWqEOG/DdrTMyya6ghjLNpePdWOZWaIn8YECT3vN8O9JCLVkdouXN/P5TG4KTLN8Nm034DM5TRXKb15DH/Gm/cVYhChhjojdvkydwvNLfDRZSePKvfdpJTVl7zzBroLkpBd5TDFHw+uTEEaO1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900007; c=relaxed/simple;
	bh=VDp1Ho4MwZv4EbvgCMmKUxapUtWx6PKpAmWR7S3IHPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FesOiA7CKHh2qjN71MWkUEPaliZehpNKl4kOWZgsuQHpvjywgb54/hB6kPTsnKFoTAzaBQkYvNXkshQJvx2xi2M0U8ESW/HhcOJGax1wyhc1kqEUlUBKUntzHxjGV22mGOYNEh54uvtSP+PY6WcDzBQWMGX/iyLI+PdhugoW9VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qfZBbiNs; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfZBbiNs"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b4ab4b4179so784409e87.0
        for <linux-i2c@vger.kernel.org>; Thu, 27 Aug 2026 23:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787900003; cv=none;
        d=google.com; s=arc-20260327;
        b=EwA68GOf2krkmcRi/kEYj2dlFhAlRvpCWv3Dir+1Z3W9iGIl3Y0FJfLmuExO9127yI
         nrcBkD/scynrNBQhgkqAqBA4YntSlbR+G4UAjCxUE8BuiK8mVdnBv8btSO1kLFjdprLH
         nDZGf1Qj0cZ+cKUpbmRWtXofCsREuZj2kdHkKun1W5BKZuA3JTUqSxylwvWz88dKoUJN
         ESV1IflIUCCP1RZ1pGGJtyV5vwucX67qdV9icr0yAki4vEie2K/aw7ROdkDfwTfa4PsB
         qKBNdjxS4bVMimG9KmaoeWe+vchQ3UzDXhVsGlwgxv67+I7U8mnAUTZzZS73PE31SRvL
         tmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8/mQdiOJey4oznV7AyJvIvyzEleWgdqTQVT4AekpJIE=;
        fh=wwdpZrjY5MVT3b03yRx539iXR8s1zOLRO7VAAZu25pk=;
        b=csqGyv+Jv7Qxw3JvPAiHlD3rl2/dgmrFZtOve1aOsxS9UEQ9bKqlT71TakD2BhUbLu
         Y1+vmgd6Ebpu5/ILRjgdCTGFHBubGhN4zoIEY8B/1yat+N1rzm1QWBNLDhGnEmE4Wm4k
         iE+EM3UFQBkXM/cbCDza/pqwBZgDdmhgPlckwyHNcz1OzjKgZG/AH6w9AReE9Dth+AIO
         xk6rr//nTw3QXUB9D3nAK9R8FfNCY3z2zeHjE1aoGGUfxN4rPl5rUChowHU1dD3LOFvm
         IGpwsKcZomED/aGsafLDFeHnKTCDtnW0U8EhD6iUWmgs4YjwY63BPkNQCm5WAJVKZry3
         sE5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787900003; x=1788504803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8/mQdiOJey4oznV7AyJvIvyzEleWgdqTQVT4AekpJIE=;
        b=qfZBbiNsWdbGSjKFpkTy4AtEGvG5q21Ik7XP4RjKVgvCSg8VRTr2R0ncSTvR0Exw6E
         7EXKSQV7TH89d9rzHxQLqI2EMH5Y3d69mOUErV+/XFmTLe8Em6FwGGSIVfvEPRN6IFre
         7x0mfarLD/vuz+mkFbjJrSuuZp8Oszy/ek3sMVQJNRMgBFWNj3b/wQnM7k+N9GEvHRSu
         jQLgk567CzaP6HQGWeDZjW3wWJdlUnRJHLXoMya/RrVsr8z/nReyYLbPbB0ZWOn55FFP
         UKv2/bj+sfKGg0KuDhx/8wTReHLOxbYfi7ckchTR1MlelC4pmXApJba2OgvnMtWLhXG0
         C6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787900003; x=1788504803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8/mQdiOJey4oznV7AyJvIvyzEleWgdqTQVT4AekpJIE=;
        b=mPnb3DshC8jYF7gayjNd4gXwX52y88g4cpDUuhxt6mlnYL3kYNIpAB6FSGn0aOZm2g
         lMxYcJuDup1Etn3CsmAzJY5B8JZF44Rj6fLXH2oA300y/nhLMeFoprmvR9GQ2XvuXjMh
         zc83K1upmZjUFY6cRaJB5s6aAMA1QrRspSbQZFilj/GPIIbcWfT6xWPitbDDD4XyJS1J
         rlWiydbUdqdozR+9EaLzcWcQcRJdP+AOR3U26Vt0R5m2SPN5F2xWwBgHQvmTeRyXf0od
         //dHi5ogS84j6pauPORPUgLUVcg065WxTrtWagBlzGsIwOnYZHBvrmKsGRfduXQUTBkK
         oaoQ==
X-Forwarded-Encrypted: i=1; AHgh+RpoewIZwTttGI0zDGDC4Y71aAJqakUIO2w6c8e4F094Ew1/lC9s1iSJiGZFJROF/xWq1908qKjwzzQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l+nS41OKTOeKzvZTVEbpijCVVxvQyN+oQAJGeBp6NTMAH527T6
	CaRgF9gTStA43UmlSa2+RlAi0BbPg1nylqw71gPAmERAyck6DMNRCRcrDiRLU7TVIUev3LQq6CZ
	G/5EbgpvBJXnG7KKdyVyuCrwWXipQyNA=
X-Gm-Gg: AR+sD12NJbfJV+kqF322zIVYN5I1v4TlGipM6UYaP+ftveXgWWB17TKJGqoRd8LWGx+
	PIvz47HRah0HaQkVoT3L/YeEaDCMQfRpJDdZPd9uzPu8GeVSjBdZ1Mwd7kbzNM0JCbqUGMXAYrq
	H3gNPtDBsNZbeansAg5ZpythmuPUjvYdrKCPb5Ou5eM8YzlDn3exAliJ4xflbhRkalPPT7Vk/XO
	UvJ2cUthv/QKbc8KaN3caFUcuhmu8uc+KsUmHj0IimDKCUGez9mvsxzmNwD9Kt0Dg7COYRv6uit
	57F6xA3Y8ATGJVZyBp0OgJp1hzh0SSM8Ls79IhzPEI06rX4=
X-Received: by 2002:a05:651c:31c8:b0:3a1:9562:73b with SMTP id
 38308e7fff4ca-3a301b16d7amr7296801fa.11.1787900003015; Thu, 27 Aug 2026
 23:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
 <20260822062725.60519-3-muchamadcoirulanwar@gmail.com> <20260824010726.2849f3d8@jic23-huawei>
In-Reply-To: <20260824010726.2849f3d8@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Fri, 28 Aug 2026 13:53:11 +0700
X-Gm-Features: AcwNN1WSQYP0-fvQo2t11ibIgmSEw8WyeXQCvmMnxHqFizPZCb4cCawVOvt7eDQ
Message-ID: <CAO26r3RLnX4HXrKDF6akmG722Q2CvDU-uJ40Yfuu_wwJdGgA9g@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/3] rust: add minimal IIO subsystem abstractions
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com, 
	brucer42@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Mon, 24 Aug 2026 at 07:07, Jonathan Cameron <jic23@kernel.org> wrote:
> This looks fine to me subject to a few little things - see inline.
>
> However I didn't take the time to decode every line of rust today so ther=
e were bits
> I simply didn't understand yet.  So for this to be able to move forward I=
'm going
> to need reviews from rust experts!

Thanks for the review. I'll add an explicit review request to Danilo
and Igor in the v6 cover
letter.

Brandon Saint-John has been CC'd since v2 and reviewed the series at
v3. If he has time to look at it again, a Reviewed-by from him on the
Rust abstractions would be welcome.

>
> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index a56ba6309594..5dc917d92151 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -86,6 +86,7 @@ macro_rules! declare_err {
> >      declare_err!(EIOCBQUEUED, "iocb queued, will get completion event.=
");
> >      declare_err!(ERECALLCONFLICT, "Conflict with recalled state.");
> >      declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
> > +    declare_err!(ENODATA, "No data available.");
>
> Do we have something says there must be a user in the same patch?
> A really generic thing like this in C would definitely be a patch on its
> own so that folk who care about maintaining a given file can easily see
> it without reviewing the rest of the series.
>
> So unless you can't do otherwise, break this out as a precursor patch.

I'll break it out as its own patch. The patch will note that the first
user is the AS5600 driver, which returns ENODATA when the magnet is
absent.


> >  }
> >
> >  /// Generic integer kernel error.
> > diff --git a/rust/kernel/iio.rs b/rust/kernel/iio.rs
> > new file mode 100644
> > index 000000000000..f1638160fed1
> > --- /dev/null
> > +++ b/rust/kernel/iio.rs
> ...
>
> > +
> > +build_iio_enum! {
> > +    /// Raw unprocessed value from the channel (`IIO_CHAN_INFO_RAW`).
> > +    ///
> > +    /// For sensors, this is typically the ADC reading or register val=
ue
> > +    /// before any scaling or offset correction.
> > +    Raw =3D iio_chan_info_enum_IIO_CHAN_INFO_RAW,
>
> I guess there may be a rust convention for this but from a human trying t=
o
> read the code point of view this need a blank line here and in similar pl=
aces
> where you have docs / thing documented repeated back to back.

Fair point. I'll add blank lines between the variant doc blocks and
audit the rest of iio.rs for the same pattern.


> > +    /// Scale factor to convert raw values to SI units (`IIO_CHAN_INFO=
_SCALE`).
> > +    ///
> > +    /// The processed value is `raw * scale`. The unit depends on the =
channel
> > +    /// type (e.g. V for voltage, m/s=C2=B2 for acceleration, rad for =
angle).
> > +    Scale =3D iio_chan_info_enum_IIO_CHAN_INFO_SCALE,
> > +}
>
>
> > +
> > +/// C-compatible trampoline for the `iio_info.read_raw` callback.
> > +///
> > +/// # Safety
> > +///
> > +/// This function is only called by the IIO core via the `read_raw` fu=
nction
> > +/// pointer in `iio_info`. The IIO core guarantees:
> > +/// - `indio_dev` is a valid `iio_dev` allocated by `iio_device_alloc`=
.
> > +/// - `chan` points to a valid channel spec from the device's channel =
array.
> > +/// - `val` is a valid non-null pointer to a writable `int`.
> > +/// - `val2` is a valid non-null pointer to a writable `int`. The IIO =
core
> > +///   always passes stack-allocated storage for both, regardless of wh=
ether
> > +///   the driver uses `val2` (e.g. `IIO_VAL_INT` only writes `val`; `v=
al2`
>
> That val2 is always a valid pointer smells a bit like the c interface lea=
king
> into the rust.  I'm not necessarily against that being a constraint we ta=
ke
> on but I'm not sure how we document that. Probably add something to the C=
 docs.
> Any C driver relying on this today is probably buggy for other reasons.

As you suggested, I'll add a note to the C-side iio_info.read_raw
documentation in include/linux/iio/iio.h. The IIO core always passes
stack-allocated storage for both val and val2 regardless of which
IIO_VAL_* type the driver returns, so the assumption holds, it just
isn't written down anywhere. I'll also note it in the SAFETY block of
read_raw_callback.


> > +        Ok(IioVal::Fractional(v, v2)) =3D> {
> > +            // SAFETY: both `val` and `val2` are valid per the Safety =
contract.
> > +            unsafe {
> > +                *val =3D v;
> > +                *val2 =3D v2.get();
>
> Why get in some places and not others?  May well be a gap in my really li=
mited
> rust knowledge.

This came up in v3 and I answered it then but forgot to add the comment
as I said I would. IioVal::Fractional holds a NonZeroI32 denominator to
prevent division-by-zero in iio_format_value(). NonZeroI32 is a newtype
wrapper over i32, so .get() is needed to extract the inner i32. The
other variants hold plain i32 and don't need it. I'll add an inline
comment in v6.
