Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1020D4FF
	for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382434; cv=pass; b=JUv+6OMFJg2DHZYKatQMmJzq5johV1GrDxRk+WU4YB3nKA/grX1F8UqZY6YaV9ibL3TgaiIlvHi2mltsiWvZW7KRTwaenw+rJJAqE53evCSSB0RUJ1xZX0S6hdXPNfMM7/IzouXYua37CmAWnEQke24d6xjpfoukSxxK2J4m/aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382434; c=relaxed/simple;
	bh=H/3/HljBKkNQvfAF2nYLo4pPn7IMLelTewsSEwuiXqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlb+UbXLUilXIi3ZvzqDSI77pC63O1RoeTDOYjH2IKBosO5mJp9G8ybLUBwaSr1skFa3RkEwshUn351g2PK3xK6/WBfSTGCLue4K92uwy7Gmc+5oV0P4+tBl3G0YpThhBixb1dT35TdHy/fZt1uLjP3SuZ2Z4TZj2zFFB6JWc18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7mtgBtR; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7mtgBtR"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66a4c2cbfb6so1586769a12.1
        for <linux-i2c@vger.kernel.org>; Tue, 24 Mar 2026 13:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774382431; cv=none;
        d=google.com; s=arc-20240605;
        b=bDTWNMsVFF3q3J4qUvEs/GYkBEUsTVHMuprUNHDwzeEKYx1Os2qrSIqjFu5Lz9w57E
         GUEKilEre/1mqNzXUFBki7Eu7MB9gqh3zmnih3KtxNlJGa004Xo+jQMpn0I4ZtD1Za9e
         FeoslBDjFopjc/umckbgb+IJbG/bWhrWiIntrMeiL+5rJ9wT/qrNpG4Qu3l66gAwdEWr
         IGYYRnam9NA0UpT8p0DOrh7X1vfXchnNXjGUw9KNP2V4ct4ATbQAMFkL4y3UR22Aa/E0
         ZzgbzKADxek6Uhw839EAdu8LVkpJHWukWgVqbePOfK1UBkQ5W9LpEGokXss+E5jXp14y
         yiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1nuigy5i6MlCzZ5OS0a7Db3vipXMg/2DN1anL0e9s4w=;
        fh=58P/iLzrGlXCc8o4PsYa6pa4W9i/y3rqGUL5UoOKYMY=;
        b=gtL6DC7K3NLQDgRzwCW+KnjK8QuGS1URDbrjL5GpDtW8vsUkAM5xuz9eK02agdOifS
         rBtuO/rDNIgZOAaNWxSLAC3Ykc0KeZro5VzWeQ9yebQj9Rk1SkGJqu/c8PkTBkB22WGq
         arxtIM62abnOAHErJOANy8sDE+13XAIE+XpRXSYTz0amdeH/hQuTsrtHAcvhhO20j44O
         0VDJvgYfedKt/fKPm1ddbNpX5ShpwxMCWIJkuk4ezhigkayE9ib2tgGkOYxqtirHiSoj
         8UTJeFrmm0uhK4nO5VR0oF52Z0c4cGDfro4mIbEfWjP4ja3YM4goxoSmHH0yuad1aUOB
         hBGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774382431; x=1774987231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nuigy5i6MlCzZ5OS0a7Db3vipXMg/2DN1anL0e9s4w=;
        b=F7mtgBtRyRp+eUyW0oozsSHJAmc87CmiVVOlDMGik0btrZGo5RYmJmYgRT96t2z4Z0
         nsrFs9OpzCJIGsa781SDRlkGBbsYJqmGG97BglLgX61JkLrPRiD3SfBwjtB0YVa7iG+9
         6BYQAdAtt5l1GPtIhdFwwhxzq0/HecEKOW02Wqa7Ri8HmEvzRj/ScQAhuUAagwjHmXmc
         /RJYmPkOxHygfmmfKQxW83CzScLwt2/udvyzth7Sh5HsjFF8k0KmUSD9CO2SC+u2BvA9
         B0VEhihjRnX36imrSDFJLI8UV4rEG+PCUgEvq8z/skQhTZi3D2fphLhf/K83K6MJ8/Kz
         Ffcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382431; x=1774987231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1nuigy5i6MlCzZ5OS0a7Db3vipXMg/2DN1anL0e9s4w=;
        b=fZvlmd7Tb4rs2Q9PF2A1CEZcjuq727GZ+KULW/UTgKuP4lC1oiDw2ymP9TB4T5ebyR
         8wy+7yVvRkUIbInNn310g9XpIjOIr8wHc508Xx4mGzmF5MnlSYR9lWjrAmtOa9x3qYaw
         zZrlT9VWlGR2shXTWqQ/EFt9sJ1YWSK26X9/wxENkfHM0KBwBYvDUXPCIIl/vl5Jsj/j
         cGLUOc183D2Dn4hwgvXqMBVTM4RGz9o7kh4JbTvOD9LSgVNzKXYo7wIteob6AiS2WmHT
         qr8tT3g6Jczf37c22AkaXovJYwFUcBukP1kceWLurcH2nqD98OcLK5fcuvA6ePHwwcFO
         igCA==
X-Forwarded-Encrypted: i=1; AJvYcCW9+SOAqjDIKb0Vxlh91H9qnoFeB6kMYI+uhmihtQwiix7sTeqsv0+sT8GWnNbPTXU4GbaH1zegu5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK2BCFS8zuV2yRjQxKVNV+IIUooiI4yGUBhHdh18xb62ZnXyA5
	qBGru3y5R5kvnNaNH1FJkfMLscL2cEUm7xV23687/tjLt774G/+hlvHMdE3usUJmC9TsW+oGC0y
	o9ufKhTCj3IPaW3E5nZZgF9Eu0YAMJRA=
X-Gm-Gg: ATEYQzzZH82hjdzWCmgoI1QjYNFvz95Umh3Ynsp9iRGMxRLnlFtKfx2Fcyh5mPP99h/
	3JzfUCpLqBTF7b0iwbMs+n5Z4bmz901kYlkqDUvSVwERgqblFmiCKH3iPl4ttYk8H0TLR42ptHH
	I6VBv92D3kkNORH/EDC4IEvKPSfYNyNMYx8PhcysLIfW5NnndPnGhZr9DY9uek2cTW76j4EqCR0
	j9ic3oQ8w3ueLt6SOJBUpRgo0p1R9HGbWVgoJaGnOE+q/zHLdoBqW7A1AkvlTqR3qT/es7e22HV
	ikK9fZw=
X-Received: by 2002:a17:907:1999:b0:b97:89b5:d7a0 with SMTP id
 a640c23a62f3a-b9a54288647mr44602266b.48.1774382431128; Tue, 24 Mar 2026
 13:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324173527.11321-1-sebasjosue84@gmail.com>
In-Reply-To: <20260324173527.11321-1-sebasjosue84@gmail.com>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Tue, 24 Mar 2026 22:00:20 +0200
X-Gm-Features: AQROBzD7DJFoR-w2ZbaKS2onxXaNipjwmPIQropG4PSX5rpIV2agbqhUt5sEkcM
Message-ID: <CAPnwWgOY6UO2JKMNWw_fZK3Vvg_v9zQWX6Ugz=X+b4esPTn7Rg@mail.gmail.com>
Subject: Re: [PATCH] HID: ft260: validate report size in raw_event handler
To: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-i2c@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

Thanks for the patch. The report size validation gap in ft260_raw_event()
is a valid concern - the raw_event callback is indeed invoked before
hid_report_raw_event() validates the report size, so a truncated report
from a malicious or buggy device could cause OOB reads.

However, I have a couple of comments on the proposed fix:

Please use the existing FT260_REPORT_MAX_LENGTH macro instead of the
hardcoded 64.

More importantly, the size < 64 check alone is insufficient. It prevents
accessing struct fields in a truncated buffer, but does not guard against
a corrupted xfer->length field in an otherwise full-sized report.

Consider: a device sends a valid 64-byte report (passes the size check),
but with xfer->length set to, say, 100. The data payload starts at offset 2=
,
so only 62 bytes are available in the buffer. The existing check at line 10=
77
validates against the destination buffer (dev->read_len - dev->read_idx),
not the source. If read_len is large enough (e.g., 180), the check passes,
and the memcpy reads 100 bytes from a 62-byte region - a 38-byte OOB heap
read from the source side.

A more complete fix would validate xfer->length against the actual report s=
ize:

    struct ft260_i2c_input_report *xfer =3D (void *)data;
    if (size < FT260_REPORT_MAX_LENGTH) {
        hid_warn(hdev, "short report: %d\n", size);
        return 0;
    }
    if (xfer->length > size -
        offsetof(struct ft260_i2c_input_report, data)) {
        hid_warn(hdev, "payload %d exceeds report size %d\n",
             xfer->length, size);
        return 0;
    }
This catches both truncated reports and corrupted length fields.

Would you like to send a v2 addressing the above?

Thanks, Michael

On Tue, Mar 24, 2026 at 7:35=E2=80=AFPM Sebastian Josue Alba Vives
<sebasjosue84@gmail.com> wrote:
>
> ft260_raw_event() casts the raw data buffer to a
> ft260_i2c_input_report struct and accesses its fields without
> validating the size parameter. Since __hid_input_report() invokes
> the driver's raw_event callback before hid_report_raw_event()
> performs its own report-size validation, a device sending a
> truncated HID report can cause out-of-bounds heap reads in the
> kernel.
>
> In the I2C response path, xfer->length (data[1]) is used as the
> length for a memcpy into dev->read_buf. While xfer->length is
> checked against dev->read_len, there is no check that size is large
> enough to actually contain xfer->length bytes of data starting at
> offset 2. A malicious USB device could therefore cause an OOB read
> from the kernel heap, with the result accessible from userspace via
> the I2C read interface.
>
> FT260 devices use 64-byte HID reports. Add a check at the top of
> the handler to reject any report shorter than expected, and log a
> warning to aid debugging.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> ---
>  drivers/hid/hid-ft260.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 333341e80..7ca323992 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -1068,6 +1068,12 @@ static int ft260_raw_event(struct hid_device *hdev=
, struct hid_report *report,
>         struct ft260_device *dev =3D hid_get_drvdata(hdev);
>         struct ft260_i2c_input_report *xfer =3D (void *)data;
>
> +       /* FT260 always sends 64-byte reports */
> +       if (size < 64) {
> +               hid_warn(hdev, "report too short: %d < 64\n", size);
> +               return 0;
> +       }
> +
>         if (xfer->report >=3D FT260_I2C_REPORT_MIN &&
>             xfer->report <=3D FT260_I2C_REPORT_MAX) {
>                 ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
> --
> 2.43.0
>
