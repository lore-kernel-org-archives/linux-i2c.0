Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795848525;
	b=mcgw1xWG0HS/fKZEHxQ2CSCCeyIB93YNVAwcq1LGFPZocNrdaGjPyCgHIhao4J0Ced5s
	 ZGAeTagk/DLh9X6wUbkyOlsWGK3CjyQVAeAZRUfrUioMlIyGcv8Wn7moQzofax9uoH6dz
	 7ooyTKw5FIWnBBMrrh20SqiCMBf6gqCU/nwNuF6LpCxWRSKbwOHkCbAFpYuiv3XGRWyDb
	 gdTJEGbLElYXaQiX6SlGknWDKs+cnNAk9U/4WAJrvuegpUg7nE8VDA5PAXETINFnVrQj5
	 VzwDfVVv5AgXeL9KvztvNaix4a0MFLSAlrcbQc0sTX82tKSCfCq+4ydwiaqstlb7KGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795848525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GmwGcEcAdjqEyf/n5Ge26j4Y0PMIX8y/qqLJW8+VBy0=;
	b=VA9nB59PjMSczcPAsH3QCr4JgBOunRpj/O+b0bDWvlx0R+4HSAG5vCLyInrdM+/qiv23
	 9E8FgiFLPkn9HugoVsIC4QJRBM+nALpFcS9q+skollhdqtMdGLUKzmenH8Wg/by3VDpt/
	 ZYhcvsreUcx7JSGwUTuhIB34h3GVr9vU/veE4yCTqQmiI5PXMMaGT+rETCljTlvxNJyLb
	 sngxAXhHP0JJVH7NyEOEw894Ovf/qYVSExoQYENeJHW5Ge50X/vuhHgkSFUy751vV4Z1l
	 YdCy560WYiMocfmO2YdC8z5wwI0j7KJyI6HPDkiQzOkmLF6fd454eFXD4hLcv4AX4aA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=apsyTg3O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8558F606A31C
	for <linux-i2c@vger.kernel.org>; Sat, 28 Nov 2026 06:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8558F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=apsyTg3O
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b8786bb305so10501924a12.0
        for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 22:48:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795848524; cv=none;
        d=google.com; s=arc-20260327;
        b=ChdtU5xkNUTPd2lI55m46dKakmvNwBsKti3d/Lf/xFnvaOScGsqOuB8oAdpbfYcBaK
         rOco7b8E6EzN22hbdgPCoyxcTVHy7Og892zqHkr5/TIhnpLVbbt1KuMp0PMBfItcKRdW
         2gyxw4bxCNeQ53X0KClqA4n9lWNmSzDu8xMIB5yCOy+YBiAjykfGl7NaQXOste+aplrm
         6KalMtzxtnu5r3Yc21buh5Q1O3rO73LxRUFc+eDqNYSwFofYSAg9laKJ3yLtnY1nTq6R
         fQP6Eo/F4uVn/M7NE4jXg3eqRS+ExnMhOoUvUsfNCykFp+dhWxwl8IedY/POTGfYxsli
         LzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GmwGcEcAdjqEyf/n5Ge26j4Y0PMIX8y/qqLJW8+VBy0=;
        fh=ml5UIt18Z4qsQB9PZ91dxAuKXjtJ9LA1Gu1a4pm3CV8=;
        b=gn8v5e4PCEhuAYfeNeMuG7E/3tukXcQlEJP26j9+TwgkVAtXO1aIT0me0Hhlx4H/Gm
         s3mJwNQcvcnvN6yty6g8aLE+8w/u7RNlHM/MRWgeKP8ci+b+Re+xMWR4qZfn0seGytHV
         wDYAToix513JsTROm0Wb96KAjzxGBGIbYfYukIig+yPbboN1FibNcJ3YA/yUdXrO8gul
         G16X3qwkcCPT+i/8lD5xpTJ/ez88K0fWfDfrQ3LNxjMouNV/a127Z5pcXQXMnY79t7B2
         Url1MmQPFI4iS24J+R68VWy829NQaV0DG+6nHLC5o/hsuRgZY3EKfPUbz5oPWBfjpYtT
         qJlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795848524; x=1796453324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GmwGcEcAdjqEyf/n5Ge26j4Y0PMIX8y/qqLJW8+VBy0=;
        b=apsyTg3OjURo8DlIeSNP5l5sJmF5cn/L+gJTu/iJCRar+3MOPUqkhRXWpFQnrY+oyk
         qiHbMLkAxSmV8X1NfZzVz68rp2V0rOZezVyEILbz553pNSyjcVpMOe+qTCUQ7xYXdKHk
         nem1MNpWGzGltCSQIJlkaBCaVbG+ofv1C9ZPYedvvqJrU+a4R1FE62girpkNQyj4yeCD
         CoHbbvd8A5vorKjrsTD0ZTutBZKvGzxl5SfOXkYREc0N3tBF6C89m1j2v97VS9A7IAcN
         Fyw8xyyi8V32hEw4gwmT0KKGYZyJlz0gPJv84yBrQ0VSZH8AGPFaVFiSfAWYBWHvbDzV
         WSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795848524; x=1796453324;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GmwGcEcAdjqEyf/n5Ge26j4Y0PMIX8y/qqLJW8+VBy0=;
        b=xz9xCO8YqYuF9KvIGupr9NmGQKPOEd4vTtvTvD6WRxFgXZVBd9tNjjaRP1v/+3mcJr
         bZFBWG4PUVbhMlN3db6tkwcs2S5141lJBVTkzbG+HTXgDVidOuKvDKQlzveFN/cLX3tg
         huUTXT3tv2RJlEalFe5roDmKe/6vyc5nM3LMwEXQDtry4zVMWOs65sp3JRR8+ym899yP
         6Q0DvE++J8XCTrRbD/ImfB9x9DpVe6+2JrfVZJlabryNy+z7E1vVsWd75wzlCdGXjfpC
         c4wAtJR/ID5gYrB0aNMdplOISbGj5BeDQi4OHxCBrRUfmFzW8r0YuBhr3QysKMeirET6
         GF3w==
X-Forwarded-Encrypted: i=1; AL+hErFCmkrD/Y6TROgoPxvKMMQCMYNsE0NlauWp1yp8saatw/M6K+URocff1N52McLmfsMrgd3NZM1NLMs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aoSUYyHLvGpjbobXClvkKbBMgjHyq0wzneMO8S+WVrrZV4pLh
	tS4wprTxJhYifdY3cgBKW/06aIC/l0ld0+km7f7NBGJ5Pu/00PGfaM5k5ESS/16DiWm+RoPfXN8
	MFD0tGr0WztU7lMShbGorqKVnsKsAE9MExJE06j0=
X-Gm-Gg: AZFdTZedZTSt5XL6EW9HJOjQHrxT4pmcXo0rw6Z71oNeuqhS1EEa4ctqhINWkiRRx0V
	4Yg4rO+RRtfO1VWTBwpdKcKr9Ko6uWQprMv5RaEUqSb64U2e84Iys5jmOsK/ZItlU9lCbvgmt9y
	H5RGrCDlZX7IJ6pTkcIYCoIkyYAokqB2mIUswxCgIexK2dI5nulPiaPjZaEo2oPUaiAEdQ+Q5+s
	6mJGdxF6/GBCMRCMOjOsfkkZvQBpNGtv5QOd7YH5NlUnI5/rX+n7Tn1xK038p75YeCJ8PhJNPmG
	Ur8pqQfxNH8TyurTtgNKm2mu6lHCFJ2TWRjiV4CIpcrOF5z0qHdR6287gQ3GLF1kRv10q8EvTki
	57e86ZG6mAb26komsquPGWzBxNuvpE9wDdx4BPqbCRo7WOkNMCNimsoXaT3Yi7VwzFvm1
X-Received: by 2002:aa7:d402:0:b0:6b8:6f88:b642 with SMTP id
 4fb4d7f45d1cf-6ba37ee4b37mr14741677a12.44.1795848523591; Fri, 27 Nov 2026
 22:48:43 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <44061940-2AEB-43F0-9838-B3F5411F56C0@gmail.com>
In-Reply-To: <44061940-2AEB-43F0-9838-B3F5411F56C0@gmail.com>
From: Felix Huang <akafelixab@gmail.com>
Date: Sat, 28 Nov 2026 01:49:49 -0500
X-Gm-Features: Aa3M54p3nqWBJKGAGlLJmGKj4nCrYhqREY5yWKWqm1Jbif1O1UrWSeGgb0bmJa8
Message-ID: <CAHqDnwtuh9S7rKU3zNLHb9=2f41oduBcX8HhNrNJ1LgkunM4zg@mail.gmail.com>
Subject: Re: [PATCH] i2c: diolan-u2c: use get_unaligned_le32() in diolan_get_serial()
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

Thanks for the review.

You are right: dev->ibuffer is naturally aligned, so the commit message
incorrectly suggests that the current access may be unaligned.

I will send a v2 that keeps the code change but rewords the commit
message to focus on fixing the sparse "cast to restricted __le32"
warning.

Best regards,
Felix Huang

On Sat, Nov 28, 2026 at 1:13=E2=80=AFAM Felix Huang <akafelixab@gmail.com> =
wrote:
>
> =EF=BB=BF Hi Guenter,
>
> Thanks for the review.
>
> You are right: dev->ibuffer is naturally aligned, so the commit message
> incorrectly suggests that the current access may be unaligned.
>
> I will send a v2 that keeps the code change but rewords the commit
> message to focus on fixing the sparse "cast to restricted __le32"
> warning.
>
> Best regards,
>
> Felix Huang (he/him)
> akafelixab@gmail.com
>
> Please note: My working hours and your working hours may be different. Pl=
ease do not feel obligated to reply outside your normal working hours.
>
> On Nov 28, 2026, at 12:20=E2=80=AFAM, Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> =EF=BB=BFOn 11/27/26 18:33, Felix Huang via B4 Relay wrote:
>
> From: Felix Huang <akafelixab@gmail.com>
>
> Fix the following sparse warning by replacing le32_to_cpu(*(u32 *)...)
>
> with get_unaligned_le32():
>
>   drivers/i2c/busses/i2c-diolan-u2c.c:290:26: warning: cast to restricted=
 __le32
>
> This preserves the exact little-endian conversion semantics while also
>
> avoiding potential unaligned memory access on dev->ibuffer.
>
>
> The buffer is allocated with kzalloc_obj and located DIOLAN_OUTBUF_LEN (1=
28)
> bytes into the allocated data structure. It is never unaligned.
>
> It is not my decision to make, but I would not accept this patch as-is
> because it falsely claims that there could be an unaligned buffer.
>
> Guenter
>
> Signed-off-by: Felix Huang <akafelixab@gmail.com>
>
> ---
>
>  drivers/i2c/busses/i2c-diolan-u2c.c | 6 +++---
>
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-diolan-u2c.c b/drivers/i2c/busses/i2c=
-diolan-u2c.c
>
> index d502f6e47..24db6d26c 100644
>
> --- a/drivers/i2c/busses/i2c-diolan-u2c.c
>
> +++ b/drivers/i2c/busses/i2c-diolan-u2c.c
>
> @@ -16,6 +16,7 @@
>
>  #include <linux/slab.h>
>
>  #include <linux/usb.h>
>
>  #include <linux/i2c.h>
>
> +#include <linux/unaligned.h>
>
>    #define DRIVER_NAME        "i2c-diolan-u2c"
>
>  @@ -283,13 +284,12 @@ static void diolan_fw_version(struct i2c_diolan_u2=
c *dev)
>
>  static void diolan_get_serial(struct i2c_diolan_u2c *dev)
>
>  {
>
>      int ret;
>
> -    u32 serial;
>
>        ret =3D diolan_usb_cmd(dev, CMD_GET_SERIAL, true);
>
>      if (ret >=3D 4) {
>
> -        serial =3D le32_to_cpu(*(u32 *)dev->ibuffer);
>
>          dev_info(&dev->interface->dev,
>
> -             "Diolan U2C serial number %u\n", serial);
>
> +             "Diolan U2C serial number %u\n",
>
> +             get_unaligned_le32(dev->ibuffer));
>
>      }
>
>  }
>
>  ---
>
> base-commit: f4585067150b85e33f60876149a6e742928da75e
>
> change-id: 20261127-i2c-diolan-u2c-unaligned-2599ede88a92
>
> Best regards,
>
> --
>
> Felix Huang <akafelixab@gmail.com>
>
>
