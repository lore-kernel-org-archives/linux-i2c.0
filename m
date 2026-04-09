Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23F3250C06
	for <linux-i2c@vger.kernel.org>; Thu,  9 Apr 2026 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759114; cv=pass; b=bEjXU8KNqPOphvvW3zgGATE/8SkALvh7YH/EHBRuEPKQ/XRoal9XPhKLV7gF7nBTIoXcCj+jfOk/p1Xwcz4XQjTWBFXWIhQTvKYn2z6A+alQCx3yIJR0X4PdiRs0ePYw5mNdjaWxqOJUt9a4CpoqxnU2lQD3AudIZ+6F1kMRjo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759114; c=relaxed/simple;
	bh=uRIpHIXY1Jgv/tUqLrduouxc+mc9S9SHsVuyZmzj/QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbNMKsX14X3BWeYDyBvnYGJ/+v3QrgD9gOhXU04cngbUcgrM08urWeSAZ0XvKH4xs5HcsU7ZWT/Qc3AmtveWinjcKTrmhFP7gCht6ZYsXaxi7OA9Vvy90hfnzL8GyB0YtLDkdg+JO00QxtCn/NWgt+dfFYqLRq8Q2oScC5/RuGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzLxomTq; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzLxomTq"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66c05fb27e4so2199230a12.2
        for <linux-i2c@vger.kernel.org>; Thu, 09 Apr 2026 11:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775759111; cv=none;
        d=google.com; s=arc-20240605;
        b=JxdcKHwwuw2eI34jKybmLS1tgdI5XV2Outn8ivWckHSzbMi7fdpGH5qbCymN4U23BU
         bhcLQZhI5bkzwfuLn8OylpvKSPpnmT9YxUGa/DzY7r+uaK3FvFZEuVN3re5lwW390gGX
         Z3gLweqbrgz1j0mpm069d4ihyLgWHS6gdcHheJU3ijs87dbQps6EfqGEI33mqg85fr8y
         oG3QeJog0TXqI9B9Lcc0uDWeJ31JHB7s7mB6NOLod7la//pVNxQu7ThfO5nksV59P/lo
         H/b7numuWiUE/AtlqTJ+GOoQfTOqh2cR0IVu6UwwliH/9dq+dy56rxgI/Q2RN1IxgggE
         elng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bxi0Dq/1cOaYc6y9Kzzau5RxO3/CNiO8acCYH60FkGo=;
        fh=7GqoOszeECRSqXzepREz3bG+CkpTi/4PxNEdoNn9WU0=;
        b=DDTZatCMWo2ySsAuT5Ghk6PAy2EObc0l779q1+cP3Sj8mwQK2orYCr80RF+aOptP+F
         MKQj0G/Ot9cMVhT81aoxA2GjlWhkF8vINkSeBDRkkOmQEOpdRcQfQq7S9ysV0U/0wQ6R
         LnndhK+IgaBhx0Ts4RQj4bPfRvmOlWD40TSdlZpUVuApRdDr1aApm0hX1q2kjpJCV9Xc
         K1YM+JqKMhZn4HE7KDBtquh+haWxkGQatBQV7gjgVXDQ+WJL9VomVwn8scru+abe/mrP
         CU4OMNfed/vmey6JAgWPVug2ccSiXmzxun108h5IFdJij+k2dclZs91HvB8vGY7sWGSe
         2Qsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775759111; x=1776363911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxi0Dq/1cOaYc6y9Kzzau5RxO3/CNiO8acCYH60FkGo=;
        b=LzLxomTqu3hI303cqh2kQu4o2QnX1b75nZh+6sCJ14WZQWRlau3rNtsEsjvR8ReWl4
         P5xC3YMB1IhHq1kdyBqUhi2nCBOXRxuHWNcvMIXZyADz281HJsOEBMIAhEbVLPuXaj7J
         ndczERAsnqnzXca/SLqO1WOQjw4VQ/7YKEkd22YnM6sYbeRUXQaUnNyqN0w7Lcn2ONgO
         9Opx+SCMutnon9umjt7iexP3KFc5RVv8ATMueCPD8aQA7XrarOswzjrs1YW9Uqa7YAFb
         Pf5B0nrRwGHlRmvI0+M/4f8iueNgVYY+xRf+APnq7COAdYqymyaDyL+0WTbNtiDuuvu8
         JF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775759111; x=1776363911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bxi0Dq/1cOaYc6y9Kzzau5RxO3/CNiO8acCYH60FkGo=;
        b=XomQ0vHj5aFq1AXjRfCE4ZHCTjqO2LEsLYXvV5U3ilGl4IFwKUtvutC0oenWZms6nM
         vr/VLp7z3c8D+GPucrSVhGYQ8I75Ze91E4PNjr9QXVmzThHa4T9qdsNCPlA9Nq2d87D7
         mByG+Fos6Hq6FS3lVX4TRBxyetwHwXDcNOsK2ABL0dP1sH+1Du3Kmm87T0frB+mvZezE
         GNS9aBwB7HWqAuyUlrZCq+YT87AMEarDDoB10y6N21mqNMctu9v5NndGDpMO3i7DXdoM
         iuZl6+t3QBxOJoy+eiagz4PyKh5ISrC2HZnYkcpX9fQ23tcbY7Q9k4qW68jNtNDPaOF8
         xiZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKMOsyxZ0EACAnTHIRGhQp2WxYyfxJygPNqZqyd9dzooO6ft+skWvSOHdiRUehcMdwiIFLz9yLpS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPZsOBkBqmZ9LemUF9/L6oVtFuxVGXNOMTlt1ChbfyC7oGnyD9
	6Cf+fOeODc8Zql10hZsKZ/+9CXEUqxh3GC1KATRNgapF0cMWE/Q825+SmeLDepyqZukJxJY07Y/
	vFzefJpigMPtqHJbhBolJIkkxFOg6sMsAWN8m
X-Gm-Gg: AeBDiev+6seL571jywqRbnQs9wuDk0Mh0EM1pR+LV8UhYMZAm+cZFQbQlNtuBr3HWZn
	wcsU4xNQI05X+E6Zf99ZgzCkPif52GAjaBbGLUs1ow19ZPWW2oAcrUYXrVBrdCU81MAPhvVzydP
	dPTPUqSSoux6S/2OaXayHaeoBZAFhQEMxOQ/WeKUp4hjt1f5neeSOjsOX77JFTEEpfxCL2ZMexs
	F41ekNBtJFuPiNZGgNNMNxL7u0IH/xf+4xjwUxWRUx6Ht9S4UnslQwPDd5BtyRP/Ew36vp0T/9Q
	6+oEaYY=
X-Received: by 2002:a05:6402:358e:b0:66e:f4c0:c348 with SMTP id
 4fb4d7f45d1cf-66ef4c0c5a1mr8652002a12.7.1775759110757; Thu, 09 Apr 2026
 11:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324173527.11321-1-sebasjosue84@gmail.com>
 <20260324201858.46591-1-sebasjosue84@gmail.com> <2o8np813-n9n6-32sn-922p-6qnrq45s7rs7@xreary.bet>
In-Reply-To: <2o8np813-n9n6-32sn-922p-6qnrq45s7rs7@xreary.bet>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Thu, 9 Apr 2026 21:24:59 +0300
X-Gm-Features: AQROBzD5ryy57P3iGUvqLsmBCdxSK-kLXMP5Y7ZvC8lV482_vL8uUBuQIdBTpOA
Message-ID: <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: ft260: validate report size and payload length in raw_event
To: Jiri Kosina <jikos@kernel.org>
Cc: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 6:50=E2=80=AFPM Jiri Kosina <jikos@kernel.org> wrote=
:
>
> On Tue, 24 Mar 2026, Sebastian Josue Alba Vives wrote:
>
> > ft260_raw_event() casts the raw data buffer to a
> > ft260_i2c_input_report struct and accesses its fields without
> > validating the size parameter. Since __hid_input_report() invokes
> > the driver's raw_event callback before hid_report_raw_event()
> > performs its own report-size validation, a device sending a
> > truncated HID report can cause out-of-bounds heap reads.
> >
> > Additionally, even with a full-sized report, a corrupted
> > xfer->length field can cause memcpy to read beyond the report
> > buffer. The existing check only validates against the destination
> > buffer size, not the source data available in the report.
> >
> > Add two checks: reject reports shorter than FT260_REPORT_MAX_LENGTH,
> > and verify that xfer->length does not exceed the actual data
> > available in the report. Log warnings to aid debugging.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> > ---
> >  drivers/hid/hid-ft260.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> > index 333341e80..68008a423 100644
> > --- a/drivers/hid/hid-ft260.c
> > +++ b/drivers/hid/hid-ft260.c
> > @@ -1068,6 +1068,17 @@ static int ft260_raw_event(struct hid_device *hd=
ev, struct hid_report *report,
> >       struct ft260_device *dev =3D hid_get_drvdata(hdev);
> >       struct ft260_i2c_input_report *xfer =3D (void *)data;
> >
> > +     if (size < FT260_REPORT_MAX_LENGTH) {
> > +             hid_warn(hdev, "short report: %d\n", size);
> > +             return 0;
>
> Michael, can you please confirm whether the device can never legitimately
> send shorter than FT260_REPORT_MAX_LENGTH reports?
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

Hi Jiri,

The FT260 uses different report IDs (0xD0 through 0xDE) for different paylo=
ad
lengths, with each report ID defining a different report size in the HID
descriptor. So yes, the device can legitimately send reports shorter than
FT260_REPORT_MAX_LENGTH, and a blanket size < 64 check would break valid
short transfers.

Looking at __hid_input_report(), the HID core could validate size against
hid_compute_report_size(report) before the raw_event call - essentially
moving the check that hid_report_raw_event() already does to happen earlier=
.
That would handle truncated reports generically for all HID drivers. Howeve=
r,
such a change would affect all HID drivers and require broad testing, so th=
at
is your call.

What the HID core cannot validate is driver-specific payload semantics. In
ft260, the I2C input report has a length field at byte 1 that indicates the
payload size, and the driver uses it as the memcpy length without checking
it against the actual report size or against the expected data capacity for
the specific report ID.

I will submit a per-driver fix with two checks, both essential:
First, a minimum size check before accessing any header fields. Currently,
the HID core does not validate report size before calling raw_event, so a
1-byte report would cause an OOB read just from accessing the length field
at byte 1. This check is necessary regardless of the second check.

Second, a validation of xfer->length against the expected data capacity for
the given report ID. Each I2C input report ID defines a specific data capac=
ity
(report 0xD0 holds up to 4 bytes, 0xDE up to 60 bytes). A corrupted length
field exceeding this capacity would cause an OOB read from the source buffe=
r
during memcpy, even if the report itself is full-sized. Only the driver kno=
ws
these per-report-ID limits.

I have the hardware to test this change. I will credit Sebastian with
Reported-by for identifying the issue.

Thanks,
Michael
