Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90F23D2A1
	for <linux-i2c@vger.kernel.org>; Sun, 14 Jun 2026 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429284; cv=pass; b=FrukqSDdWVKLfBEgkyAlgmppnkfwJAERJcqoJ27J1wdJNJDzu2fFamk5zKPmTwSGT+MFMz003YFdK5P+StwFdtAl5D6AfbXYu1c5F95cSYKd+Y7KywsmTKdDzO6fKWlmdTQGe3wKEDnnGPHY174TMTIm9Cwdj/FFFIHLZKU+P/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429284; c=relaxed/simple;
	bh=6r4U9R99dbPRpiaffjdEr+Fo1qhnTwDcQsAMMtkwyug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ada0KPN4aRwZStwL28cUQ5Gxn4lzx6lTfHZMVmJFhC8gilFyg55rbofcxu99OS2vXwHOhLvTlAMNtIRQKB5GeRkcerKzp4NT2eeqWway23vaYbDP3Ix3Yfl6ctGp/T/i4jJN7yy05yC42z54wBVO+CulWrha321Mq37BiAuNvK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVU7QZfL; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVU7QZfL"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bf84a2b2077so257990966b.2
        for <linux-i2c@vger.kernel.org>; Sun, 14 Jun 2026 02:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781429281; cv=none;
        d=google.com; s=arc-20240605;
        b=iRcqfXPOcaBRfq4VRr1oj6pN1qBLo1JeeHeBFn8ccA4h5XYvLguiCjA2jhXDMv2CH1
         up5ko6Tbze8dXNeJDlJqpviDEEo5AyJW0F100a913WuQDZAnlYJDplrF/MnGBMjSrplK
         iCrh9/fFoN3fv442iK3X3vCGzAFyadk66g2LMp/eqatZkF1ZnwB/XH7uApVnmBeawHB+
         fOSXRCEwYIw1JzeMLgwMLIYepudU+qJDq/pCB4+1vAoquynmroKBIHvXyix0mZz7A7Dh
         KmnW1SG+WIAkTC4JG4aJ9KZllqF/CYpHmNG/4b+r8H9yPB4prSJ8qnNLMVI+2xT4L5N5
         cLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KfLnUSNfvNSyz22YZcSw2u31gAfTNQlrSNtk4+9js6I=;
        fh=oL6cXN+GXvTKj02H9+7TJHuRVdjjZJyZqN//9Nkd/N0=;
        b=CQc9HAAR8jB5b4o3WeNtnmGmFpzMqPdTHJa+kzyDxZsdCZubtM/cmqXMBwv56TE8PJ
         jNFVYlhsaEGAqweY4K/nhGhRpvLGWccWqc1EQfPx2DyhJa5147Jt2qsn9W5oAAf4Gt9l
         3bxhatI91ShpM4Zi4m24TJ/N94ph3fTg5gUf/U25varLuxR12QipzMGihLKb0wwob2vc
         cf6s68wT5h1frDmqWIbUGJvRgfJAmp54nb55AAqswncBcp7obj8jgHAe2rIdyluJxivr
         E9ZezpY52feLZ7NgsKNMtY8nebMQOUFJPDiY63KbRrqxFSVt/+dBhrwg8FnmdUfbqX1U
         UFsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781429281; x=1782034081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfLnUSNfvNSyz22YZcSw2u31gAfTNQlrSNtk4+9js6I=;
        b=IVU7QZfLHwXi3tPIMad7A7El+QjrIRUljmZ+KL2jl8Jlk1naOhSyPthttvqkdOtxiX
         oPFJV1d4wjTSAf7OOTrBtgGMGq8M3u2nuDrRMnfRw5lYMacInHrXtV1ooH/vgHFEumkL
         6awYDRn1IWzlueihFRFfgwtbo01nWcVaDND7YZH/JAfsOeFOeQ8WBSnTIRaferXkgncp
         HS7VO60UXK0de69Cfj0TJvH9ZycjCsFl4jp2tJhcYmFGz45KHABslu1obELavUVuAl8L
         ozztqoGNoXBa7tsOjUAb+5oNDb193pQ1qjUcu5aZ0TvQg98XNB9J5hHGElt4adYaGzTJ
         H1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781429281; x=1782034081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KfLnUSNfvNSyz22YZcSw2u31gAfTNQlrSNtk4+9js6I=;
        b=A61ltj7z4OBrtlfnNZtXPRodFzyZfns9vFyh5vTUGsDeMGK8WHCgWWRTuBbdo3KHAn
         ON9X4kYFLrEwwiZMtFZ5w330K2awpfGrCqNy+IXD//Q/dWy+py/vkziAz/oqhoU4YZri
         iYh2BfP90Lk/5AT69h+k1T7H3o51N/l0BEW3m65No14HLsnxqfvIfis9HaZ9jlfK8it/
         Qkvw+FNa/8xXU0NFkd4gcc5rUH/Ums4ZPDZrHsla6TDPpobS4d16HCBPNBy3/p5wLQOG
         gRP6fgKJVQ9DF4ToOkuvWeSiaHM43b3qtAQWH7i3hwixquauDH0McyX5c/k1k/b032sZ
         /zIw==
X-Forwarded-Encrypted: i=1; AFNElJ/MYXvqs8M6vAf7d9deVIIzw3Nwxp5R1FJr5J4LJTNK3pSkaDUmtMdlvZXPFJ9SnFq1OrrfYMT7hu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiUc7yHMly8dKyACoqUs5ZDyC0K1thzf22D1n9Y6eLe7DW6GWC
	2vAXDOogvHNfgj+RgIPGAmgmN2oCXFjo64cTTZ8uYcwb78wKzYe/iXe2/uirs7a/6sMY8qnLxVu
	h6CP4Kes5MOx1xjrdWYq9yh0s8MMuVs4=
X-Gm-Gg: Acq92OE/LswKCIMkB0FlqXS8qe0JxljjjapwAOP9NK0weMde/JNk9UD1+1+hUkdTJQZ
	NIp7YppfxeHiMWe9kQK8wMvvcNub0itgEQGNTfoYg18vu/u6Y2nLb+Kk29i/aijhZYVf/XBvTqZ
	Lgt0TTgbp+0FKh58fna5KLhbF+3+SBW+oJKIlv6yqBk8BQ+OMceaZYdua2eW4ogE9G8r/wirzaZ
	wszNIxpaVh1rW6tjhvGJYsoHts/azjOTrrCeO9EPnvgJkDGDb3oJmJwRnPFItjKL7xpas0HHBez
	/0BkKlE=
X-Received: by 2002:a17:907:6b07:b0:bf7:a616:cafa with SMTP id
 a640c23a62f3a-bfe2aaf718dmr504436766b.34.1781429280979; Sun, 14 Jun 2026
 02:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610134119.3313484-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
In-Reply-To: <20260610134119.3313484-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Sun, 14 Jun 2026 12:27:50 +0300
X-Gm-Features: AVVi8CcUCzyNGfYKEbKnW1Y5hRq5SFufjr5Nfx6Yd1SLAvRisdRSA2wHtp-44GE
Message-ID: <CAPnwWgNLd2RZVx__T1Z9siKwN_5HrA2hcKwrZ2C6YivQuF6Ubw@mail.gmail.com>
Subject: Re: [PATCH] HID: ft260: fix SMBus block read protocol handling
To: kernel-linux-20260610-80b7ab08@raman.v1.sg
Cc: jikos@kernel.org, bentiss@kernel.org, linux-i2c@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Raman,

Thanks for the patch. Your analysis matches what I see in the driver:
on a block read the count comes from the slave, data->block[0] is not
initialized by the caller, so sizing the read from data->block[0] + 1
is wrong. Reading and validating the count first is the correct fix
for the FT260.

I'm validating on FT260 hardware and will follow up on this thread with
Tested-by/Acked-by when that is complete.

Reviewed-by: Michael Zaidman <michaelz@xsightlabs.com>

On Wed, Jun 10, 2026 at 4:42=E2=80=AFPM Raman Varabets
<kernel-linux-20260610-80b7ab08@raman.v1.sg> wrote:
>
> For I2C_SMBUS_BLOCK_DATA reads, ft260_smbus_xfer() passed
> data->block[0] + 1 as the read length. But on a block read the byte
> count is supplied by the slave as the first byte of the response;
> data->block[0] is not initialized by the caller, so the transfer
> length was taken from stale buffer contents, and the count byte the
> slave did return was stored without any validation.
>
> Implement the SMBus 2.0 block read protocol properly: read the count
> byte first with a repeated START and no STOP, validate it against
> I2C_SMBUS_BLOCK_MAX (resetting the bus and returning -EPROTO on a
> bogus count), then read exactly that many data bytes and finish the
> transaction with STOP. This keeps the whole sequence within a single
> I2C transaction:
>
>   S Addr+Wr A Reg A Sr Addr+Rd A Count A Data... P
>
> To support issuing the two reads as one transaction, teach
> ft260_i2c_read() to honor the caller's flags instead of always
> forcing a START and unconditionally appending STOP to the last
> chunk: START is only emitted if requested, and STOP is appended to
> the final chunk only when the caller asked for it.
>
> Signed-off-by: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg=
>
> ---
>  drivers/hid/hid-ft260.c | 45 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 70e2eedb4..946ed0c6f 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -502,15 +502,23 @@ static int ft260_i2c_read(struct ft260_device *dev,=
 u8 addr, u8 *data,
>         struct ft260_i2c_read_request_report rep;
>         struct hid_device *hdev =3D dev->hdev;
>         u8 bus_busy =3D 0;
> +       /*
> +        * STOP terminates the last chunk; clear means hold the bus so a
> +        * follow-up call continues the same I2C transaction.
> +        */
> +       bool want_stop =3D !!(flag & FT260_FLAG_STOP);
>
>         if ((flag & FT260_FLAG_START_REPEATED) =3D=3D FT260_FLAG_START_RE=
PEATED)
>                 flag =3D FT260_FLAG_START_REPEATED;
> -       else
> +       else if (flag & FT260_FLAG_START)
>                 flag =3D FT260_FLAG_START;
> +       else
> +               flag =3D 0;       /* no fresh START - continue current tr=
ansaction */
>         do {
>                 if (len <=3D rd_data_max) {
>                         rd_len =3D len;
> -                       flag |=3D FT260_FLAG_STOP;
> +                       if (want_stop)
> +                               flag |=3D FT260_FLAG_STOP;
>                 } else {
>                         rd_len =3D rd_data_max;
>                 }
> @@ -708,14 +716,41 @@ static int ft260_smbus_xfer(struct i2c_adapter *ada=
pter, u16 addr, u16 flags,
>                 break;
>         case I2C_SMBUS_BLOCK_DATA:
>                 if (read_write =3D=3D I2C_SMBUS_READ) {
> +                       u8 count =3D 0;
> +
> +                       /*
> +                        * SMBus 2.0 section 6.5.7 block read in one I2C
> +                        * transaction:
> +                        *
> +                        *   S Addr+Wr A Reg A Sr Addr+Rd A Count A Data.=
.. P
> +                        *
> +                        * The count is read separately and validated
> +                        * before sizing the data read so a misbehaving
> +                        * slave cannot drive a write past data->block[].
> +                        */
>                         ret =3D ft260_smbus_write(dev, addr, cmd, NULL, 0=
,
>                                                 FT260_FLAG_START);
>                         if (ret)
>                                 goto smbus_exit;
>
> -                       ret =3D ft260_i2c_read(dev, addr, data->block,
> -                                            data->block[0] + 1,
> -                                            FT260_FLAG_START_STOP_REPEAT=
ED);
> +                       ret =3D ft260_i2c_read(dev, addr, &count, 1,
> +                                            FT260_FLAG_START_REPEATED);
> +                       if (ret)
> +                               goto smbus_exit;
> +
> +                       if (count =3D=3D 0 || count > I2C_SMBUS_BLOCK_MAX=
) {
> +                               hid_warn(hdev,
> +                                        "smbus block read: invalid count=
 %u from slave 0x%02x\n",
> +                                        count, addr);
> +                               ft260_i2c_reset(hdev);
> +                               ret =3D -EPROTO;
> +                               goto smbus_exit;
> +                       }
> +
> +                       data->block[0] =3D count;
> +
> +                       ret =3D ft260_i2c_read(dev, addr, data->block + 1=
,
> +                                            count, FT260_FLAG_STOP);
>                 } else {
>                         ret =3D ft260_smbus_write(dev, addr, cmd, data->b=
lock,
>                                                 data->block[0] + 1,
>
> base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
> --
> 2.54.0
>
