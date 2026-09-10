Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA563C09F9
	for <linux-i2c@vger.kernel.org>; Thu, 10 Sep 2026 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065872; cv=pass; b=dEP2iIrfjcIwxzJhOE3kQKy03P/2Tb0ls/B5lY1p/1lyRSHbNeD1EG8W6TPQj07YSw5tKrZO7Fs0g8j6lN0SfMeT3zLDYpfs7rQU1kp+gtPEBaWKA61jSLaBVVT/vSL3HQbiwW254lCiq+o43CKTAbFzLGzGXmQv7/ZaF5aqFtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065872; c=relaxed/simple;
	bh=xFtYMESwkraSasJbw3YRh3uL1QWxpB6iuCe15TY2WxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFjXtYVXIKGdAdCAoKiB5JW6ScLyGfxpCOOT/DFZeykmOK5uFYIxG0r1ESJgQFX4KA61AaJKlW29gvFx32vTFv6xxadV/f/bPRR1krgHIE6X6c5jrMQcYtObuVZHryqwhcdcR68xCkZnX8tykUt5P6eHhDGEnV9Pw5QLRKnMtb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/cCd1ME; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/cCd1ME"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2941f7229dso18203566b.1
        for <linux-i2c@vger.kernel.org>; Thu, 10 Sep 2026 11:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789065868; cv=none;
        d=google.com; s=arc-20260327;
        b=QCmsM3jyvchVdbmxjp1HuX8falR4oERr7hIVvOMwnGR20vqJ84bGsOnIis6iG9ucfB
         HEsJZcoGdrXy7h0be3Z/YP9jqJL/WPkh8Q9CWJsNM1hynxJhwEttG2JCrrCO3gtAoNz+
         oIc/ZSQig4P7Asf0INH557osbKSk555Q+obRj5tpsTgFFAEXjW9HfcF+NzORn71Wsjkr
         JRBhDAe35uzdmIUKkzY6m+/xIuedx1UQJh0zDznnFq6BBmsEZqDFH/SqHxzAueAovHIM
         Xfr6KGDUouVyHB3FHUdfQ5kpB/dDzRkvAdR6Tl9dXFm7yYAkc/p+Vbq1zLi3GFCCXZy5
         B6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=K13jkmR1aE3pdZ04hI2AFyUuzFQUQagwS5oXYalfh0c=;
        fh=hZ1zhCv1wG1Ahxe8nOUFGqZ55EAGIQoFhwhCwGRR/N8=;
        b=EfKw8t1cy/Lmb21XSMvQuaR3CuxerbE89FrkNq/LOITRBLKB4FEFNDCvCGKauMFojy
         1b7gRnunV8d2YYVIvAijWi7d7Z1i6FASnf/4/GK7JaI0pYA9+yzTjxmaStHp+9k7ASne
         6/gYbWGm+zYvW2DLazhCfMJzt1h3VUi8EJjdYcU3jYL1CmAx1IkdmC0hmlVCOk8gHa3W
         KiS6WfRzC/gp6NjBn9rwoA1iIYwQSQQFUS/hOcyNVApxcrfO/+AReTeoJ5WJgkcJwxxH
         Lw3etZ8PYP0ntBwWXQf/fPSjdqmPMHkT4uP4i+GGweJGgBqb4PFgDNmvL5T9DFc+X+8W
         Uj/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065868; x=1789670668; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K13jkmR1aE3pdZ04hI2AFyUuzFQUQagwS5oXYalfh0c=;
        b=T/cCd1ME5NRXUGCBKdhX8bwRvsKABSLaTnAvx0z9CFBEhvHNcQy/Y3q2iGev3CNK+t
         qbrEy/accuaxO/ff0ksc3CeoVO/fN/1ai0AbsJ9Y0omNOKEpklmV1IRUONhwbvh+xGgd
         N+Pe7hDn+ewJSVccPtNDSQ2dfUC5Qa4JZXH+W7A9I2l0jPpHYxsgr88txFArfRHcZ6u1
         6ETWIVj31YH6BCAezYFkwEQMetuCRZcdAfx8+6Rmrl/Mf3QstDZJTJM4oV7f8Y9eJI8A
         29MzGUmLQae23xNYFTSkp25x42Tdfgcaeb6nImYmyknzfXshODliXYoMYbqwPtYIIpsN
         /AYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065868; x=1789670668;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K13jkmR1aE3pdZ04hI2AFyUuzFQUQagwS5oXYalfh0c=;
        b=Pb6CNinVz/3FL+bkpAAWjNdTTTKuy7zByqlvnQ9ognOfX62fGSGWhTwP13yFT7i1zq
         sOJDs2Ql+BX0Vw/E4KU6tdTvsBwYiTWiSDu5ggvKWZRNlOEqEf06hW7UCs5QYIl9RCwU
         8UgTh01U4XaQAFHlovmhtZhGmfnEmcah3P8u1BmCQc/M/xn0jm0VoN6N5uqHxPiiX65V
         e6yfMffzx+FD5XpHRyxmFtoVWLYaNxBVchNS2h7+WTKDRo1M2W3ub33Dc9KSGCF7QIqe
         DPqLOSBbCYGd3b4Y23TmtK8AqDCKD5NateTpGWcqCkm+0il5M6qttshuYV9hN0JXvZfM
         BzrQ==
X-Gm-Message-State: AFuF++lZyykpbkX1quk38ETLmjlHJILJYFPH4NcgNT34sQQluAXM70A0
	PuH4nAy56ilcrDy7+xcNM8BKe0ytJQtkoL0fru7XHjx0VkLSYctlT1CFPZ9DbcZ0SOnci3Y6WZn
	f6NNC91bt29uB7StUKF0v+DrxGNel9hY=
X-Gm-Gg: AYBFou2TMrOy8A7wveTTIDLCi4HWfX6DdVS8HwVBfabUd3uoWLScX123caxTOSmDhpC
	LMEBVfcxAEmXE/16te98OuUKlpLiMix0fyPIk4pYEcCyKHeQr2NT8aRjJPfm3NGra6TFsY6A5bE
	0u9LyWa1zL7ipXij3Z5oAVUJjs0cyQ/ZBxKm0k9/UAmGYetYoNmw76BFljBtxUyU3z8sluE6m6T
	1cE7CiH77YxfAHNihwhzb/o4uThhIRslfGd/jtSk1FWIUS0UHnoqWGsw03/yAtK9+WtlfytXU/m
	23V+KIN5yzIEpBQKXgPQoRs6ojGqyoW+6Cj6FO7N9JWxESq+7foxYA==
X-Received: by 2002:a17:906:628b:b0:c29:3d59:706b with SMTP id
 a640c23a62f3a-c293d5974b6mr435596166b.44.1789065868035; Thu, 10 Sep 2026
 11:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627153532.547719-1-paritosh.potukuchi@amd.com>
In-Reply-To: <20260627153532.547719-1-paritosh.potukuchi@amd.com>
From: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
Date: Fri, 11 Sep 2026 00:14:16 +0530
X-Gm-Features: AcwNN1Wf20eBeoeYCCCCW1ZvWgiNTZDi866Qnqt9Ke_fVgbm7NEAcsBqFh4rYTM
Message-ID: <CAMfiSebZWbARrZR+CWeTMgo7-LMaCpqxrt_yWfFQVGFLofQ1ig@mail.gmail.com>
Subject: Re: [PATCH] i2c: amd: fix SMBus block header and PEC handling in the
 RX path
To: andi.shyti@kernel.org, shyam-sundar.s-k@amd.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paritosh Potukuchi <paritosh.potukuchi@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andi and Shyam,

Friendly ping on this patch.

Could you please let me know if there are any comments or concerns?

Thanks,
Paritosh


On Sat, 27 Jun 2026 at 21:05, Paritosh Potukuchi
<paritoshpotukuchi@gmail.com> wrote:
>
> Strip SMBus block header bytes from the received buffer before
> forwarding the payload to the upper layers.
>
> Handles the optional PEC Byte at the end of the received
> payload.
>
> Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
> ---
>  drivers/i2c/busses/i2c-amd-asf-plat.c | 34 +++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-amd-asf-plat.c b/drivers/i2c/busses/i2c-amd-asf-plat.c
> index e1699da838c2..daf318ce3bbb 100644
> --- a/drivers/i2c/busses/i2c-amd-asf-plat.c
> +++ b/drivers/i2c/busses/i2c-amd-asf-plat.c
> @@ -46,6 +46,8 @@
>  #define ASF_BLOCK_MAX_BYTES    72
>  #define ASF_ERROR_STATUS       GENMASK(3, 1)
>
> +#define SMBUS_BLOCK_HEADER_SIZE 2
> +
>  struct amd_asf_dev {
>         struct i2c_adapter adap;
>         void __iomem *eoi_base;
> @@ -61,7 +63,7 @@ static void amd_asf_process_target(struct work_struct *work)
>         unsigned short piix4_smba = dev->port_addr->start;
>         u8 data[ASF_BLOCK_MAX_BYTES];
>         u8 bank, reg, cmd;
> -       u8 len = 0, idx, val;
> +       u8 len = 0, idx, val, offset, data_len, payload_len, has_pec;
>
>         /* Read target status register */
>         reg = inb_p(ASFSLVSTA);
> @@ -110,12 +112,40 @@ static void amd_asf_process_target(struct work_struct *work)
>         if (cmd & BIT(0))
>                 return;
>
> +
> +       /*Below is the SMBus block header received on the wire:
> +        *     Command       --  1 Byte
> +        *     Data Length   --  1 Byte (number of data bytes)
> +        *     Data          --  N Bytes
> +        *     PEC           --  optional, 1 Byte
> +        *
> +        *     PEC, if present, is the final byte of the transfer
> +        */
> +
> +       offset = SMBUS_BLOCK_HEADER_SIZE;
> +       if (len < offset)
> +               return;
> +
> +       payload_len = data[1];
> +
> +       if (payload_len > len - offset)
> +               return;
> +
> +       if (len == offset + payload_len + 1)
> +               has_pec = 1;
> +       else if (len == offset + payload_len)
> +               has_pec = 0;
> +       else
> +               return;
> +
> +       data_len = len - has_pec;
> +
>         /*
>          * Although i2c_slave_event() returns an appropriate error code, we
>          * don't check it here because we're operating in the workqueue context.
>          */
>         i2c_slave_event(dev->target, I2C_SLAVE_WRITE_REQUESTED, &val);
> -       for (idx = 0; idx < len; idx++) {
> +       for (idx = offset; idx < data_len; idx++) {
>                 val = data[idx];
>                 i2c_slave_event(dev->target, I2C_SLAVE_WRITE_RECEIVED, &val);
>         }
> --
> 2.43.0
>
