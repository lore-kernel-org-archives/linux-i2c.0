Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E452B3DFC77
	for <linux-i2c@vger.kernel.org>; Mon,  4 May 2026 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908370; cv=none; b=W1RzcXEZB0+Zfdvf2DnygXX16GzYA04IZDh756/4OBjl9M1yuVmxUFqSymvD/yxkJL2mhb7FQFKKu9m6fcJr8felipuTLkFfnofoOIGzzNpWO1z92yIHefqa0DHYYUxHTKB68LKU7Fms965mZ+WcrUT/sfVVXayJqDZjgaFigQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908370; c=relaxed/simple;
	bh=uoQKxXtTOGM7U9sEPyd/tKcaeVsijDXdJfQss3oy1ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+0eaUsFKiU+WEilimxD6D/PZEn8GWpKKd7hhD8ejDzIdrZ2RG5rYPA/q5st8oAeDMF0SE9yzyi8dQ3KUXeJVBMtsN9SqU7FSP1QUTncK91XjIonelzVswhnjznjqdhp37P+SQFw60Ey/IXy2cJuyD0rQht/ZP4dbrDfO4WdwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gZeMC5ry; arc=none smtp.client-ip=209.85.222.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gZeMC5ry"
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-95673f7b5baso1017452241.1
        for <linux-i2c@vger.kernel.org>; Mon, 04 May 2026 08:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777908368; x=1778513168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMMO9ig/HXI2INCt+G3ZsbSBReQdyhzNNH1VFFcXtF0=;
        b=iWwnFVHAtpWrxvygMyaZg0V3ErTpqucgacOKfYYp4lvvLZ8pcCG/ju/F7WxfRzNyBe
         GKSjjSaBi4V2XXfYX9KN8The880t4BmukpKLnn9I0YFHycWUHLGvxeuWGikcmdUvyyLB
         hd0jjuguAdntyXWLtBSb/Tc06xXHFayjkXELB+jdTgmMRJLP8UX9SOkw2eX4gEz3kgmy
         UbwMR6Mo/DuB9erSoCmYBbg6fRetmy+ybpUv0N2PTW9daTMnsNx4URgfr9IfYxCdTHzV
         tTwwzXruZIrnGsJ6Ym7xr8t60K91buMYZ0SRlpeQt1lIsYaf1hHG3bTm7AmINlVu291s
         c/SA==
X-Forwarded-Encrypted: i=1; AFNElJ/BtAErdwrC5WdjZ3tpQkkL3OphoL/tKcdTm+xEOEB22m/JyQPaxWBYe+hW1YgqNvthKnlVrTVlTP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhlYa3yCMX7Z9E2QngUk02y3wR7gwCevhnl+U5v5bL2fcdbd+D
	lrAGskwYkcdeUtwi8ZaGN6UPTCPbzPTepn6x5Qbr8+j+M9Wh1CfVQ2jTcOiPgbk4Nd1Foz5JwCy
	0qthTnb0Pn0Ls0+8zAsv0CMjlEHji4E9S7YA2UE45Xyt4ffTM7AGLk3Q51UkKG29pDS+qSEQnI8
	sQ6E4kJYvqV5jz5L5trdjNMg7BZNNEgjfSB7XXIu1cxwvIR0y/M6c8bvDwfXzeTN2+pKUsk8yIF
	90byq3Zs/A=
X-Gm-Gg: AeBDietTaT151cnuo3nOtit7oZI6ivwKIfkWg3nME+slABtO3Dm9XGMyMTJr6rJBuCc
	Mt/3d1ZGFQSPnl7TAeE0/dLvR81YB/5XL6jngXGUgiE55Cb50KtjHvitanyymxkv9Xaqb6eReN3
	DLpzJkYOx2MgbdzHC90rZlFnwcwi2LYY2j6zaQjzB8Vuekpe/CsQ53mhlc+rlwanPZ5688dpO7G
	otH4W/oMbckQFZuGeHgXy0LvmIepsVWXwo+Dl6iinPSkdZb/PQmbclpNbvjuhtRoTYc5CJQ/ilb
	SUwDUJ2UhkvdpGzcVpRaOrfQ9sSkwacWYXHOcmYXqdDcTdjtJRlQSXQOyLcAlb0JaWCClPxTaR/
	oeiQW8M6pLNMeUEJkpFfHoJcGZS8SXKb61FoOcb4Ucs4dWigUnhRn9v4LnTeoCr58QgzPhaq8HM
	QVXRcSnuKzxHWHFBptPNTsSx9g+l1LU30JfUIBvmZf1XV0nGMjqnyRyVlm4hGzi2Y=
X-Received: by 2002:a05:6102:8497:10b0:62d:b0b2:88b1 with SMTP id ada2fe7eead31-62db0b28c94mr2562854137.4.1777908367651;
        Mon, 04 May 2026 08:26:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-62bfbc7cc09sm775371137.1.2026.05.04.08.26.07
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 08:26:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-67c2b480857so2023041a12.3
        for <linux-i2c@vger.kernel.org>; Mon, 04 May 2026 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777908366; x=1778513166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hMMO9ig/HXI2INCt+G3ZsbSBReQdyhzNNH1VFFcXtF0=;
        b=gZeMC5ryU2oaXg6ViGkuxmpeflYgybxruHlbvehtFhHZiexQI1QkK+4hM2gzLZ5erp
         dYDHO133SeITG3gPMV5h4HYHiZ+saSZOUbKCNk1+4xTX79iOd8K84KI4BY0FpNsK1G96
         NZmqrO25HtRvQ9VEqXFuCQYmeXYhAb/q1dPrk=
X-Forwarded-Encrypted: i=1; AFNElJ/36gUmHc5daiy+B9myn1zm8nvfQNNYdhFemSgH/khEcZETOnVO64m+eeY2O/h2880cTBX9tU1rvXs=@vger.kernel.org
X-Received: by 2002:aa7:c046:0:b0:66e:abe5:ab22 with SMTP id 4fb4d7f45d1cf-67c17f30f0bmr3243451a12.5.1777908366076;
        Mon, 04 May 2026 08:26:06 -0700 (PDT)
X-Received: by 2002:aa7:c046:0:b0:66e:abe5:ab22 with SMTP id
 4fb4d7f45d1cf-67c17f30f0bmr3243435a12.5.1777908365605; Mon, 04 May 2026
 08:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503165925.1738-1-sozdayvek@gmail.com>
In-Reply-To: <20260503165925.1738-1-sozdayvek@gmail.com>
From: Ray Jui <ray.jui@broadcom.com>
Date: Mon, 4 May 2026 08:25:52 -0700
X-Gm-Features: AVHnY4JWb_dnNm69nyAlo_Bm0xe2N3Q9Ty2tEo2J5f1jtX5xIsn6cbYO7SKSNpE
Message-ID: <CAJ8Y1dQU-ATSFSSRsqgzg8mN9xa1yPFFkNKcyXJDbSV0jkPuNw@mail.gmail.com>
Subject: Re: [PATCH] i2c: bcm-kona: fix spelling mistake in timeout-check comment
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: andi.shyti@kernel.org, florian.fainelli@broadcom.com, rjui@broadcom.com, 
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000009fe2fb0650ff8c43"

--0000000000009fe2fb0650ff8c43
Content-Type: multipart/alternative; boundary="0000000000009361eb0650ff8ca3"

--0000000000009361eb0650ff8ca3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 11:00=E2=80=AFAM Stepan Ionichev <sozdayvek@gmail.co=
m> wrote:

> Fix a spelling mistake in the timeout-check comment.
>
> No functional change.
>
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  drivers/i2c/busses/i2c-bcm-kona.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm-kona.c
> b/drivers/i2c/busses/i2c-bcm-kona.c
> index 9d8838bbd..d4f287b31 100644
> --- a/drivers/i2c/busses/i2c-bcm-kona.c
> +++ b/drivers/i2c/busses/i2c-bcm-kona.c
> @@ -427,7 +427,7 @@ static int bcm_kona_i2c_write_fifo_single(struct
> bcm_kona_i2c_dev *dev,
>                 return -EREMOTEIO;
>         }
>
> -       /* Check if a timeout occured */
> +       /* Check if a timeout occurred */
>         if (!time_left) {
>                 dev_err(dev->device, "completion timed out\n");
>                 return -EREMOTEIO;
> --
> 2.33.0.windows.2
>
>
Looks good to me. Thanks!

 Acked-by: Ray Jui <ray.jui@broadcom.com>

--0000000000009361eb0650ff8ca3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, May 3, =
2026 at 11:00=E2=80=AFAM Stepan Ionichev &lt;<a href=3D"mailto:sozdayvek@gm=
ail.com">sozdayvek@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Fix a spelling mistake in the timeout-check com=
ment.<br>
<br>
No functional change.<br>
<br>
Signed-off-by: Stepan Ionichev &lt;<a href=3D"mailto:sozdayvek@gmail.com" t=
arget=3D"_blank">sozdayvek@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/i2c/busses/i2c-bcm-kona.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm=
-kona.c<br>
index 9d8838bbd..d4f287b31 100644<br>
--- a/drivers/i2c/busses/i2c-bcm-kona.c<br>
+++ b/drivers/i2c/busses/i2c-bcm-kona.c<br>
@@ -427,7 +427,7 @@ static int bcm_kona_i2c_write_fifo_single(struct bcm_ko=
na_i2c_dev *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EREMOTEIO;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check if a timeout occured */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check if a timeout occurred */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!time_left) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev-&gt;dev=
ice, &quot;completion timed out\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EREMOTEIO;<=
br>
-- <br>
2.33.0.windows.2<br>
<br></blockquote><div><br>Looks good to me. Thanks!<br><br>=C2=A0Acked-by: =
Ray Jui &lt;<a href=3D"mailto:ray.jui@broadcom.com">ray.jui@broadcom.com</a=
>&gt;=C2=A0</div></div></div>

--0000000000009361eb0650ff8ca3--

--0000000000009fe2fb0650ff8c43
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
Kea1UXiDNimY9XcISXAUrVauS3TPqfSofCP4tOVkOfR2zFsciCJ7DPbmanfMXAR2cY6kCgkZCqxY
9Szy6beT2XZUSE9/jFymRSjXZNnLqAe30YCaVeVQUqW9X3NqlPdzO9Ce8AqKdgBlVt4isO6s3zJ5
djaWSUM3zrweXgaVpSRF3iBUxK45Nb0qOkvz0hrBYM2r+iLWR2YbF+Z7W7lw2QMvkbeT1gXn+4pC
K8f1aWKsB9e6Id7uBOkCAwEAAaOCAdgwggHUMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAA
MIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29j
c3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUD
AzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmds
b2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwHwYDVR0RBBgwFoEUcmF5Lmp1aUBi
cm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt
26AjhRiwoJIwHQYDVR0OBBYEFLfOZFpVhKW7s+LOyKdJX5PQH0f8MA0GCSqGSIb3DQEBCwUAA4IC
AQB5Y3tHNG503cqE6g1lZJG3Z1SbuQD8ZXUbYqDNZCnUAd/+zUCraK7TYIOI83X+oof/CscTxVhf
5mazzhESPjHYlC3TLkkxDHQZi06GwKbI00651REpC78vd9dOdZnKnGjpFeDiwJKNxdarSaYiZi/t
6cZD3FIvDaJwYIQ+8HvZOm7FBicC41sMoaxGWZ/tdC6yRoLFckWRvhq0e7wyaBOH2ae8l30V6NXB
RtJd4XemoNk74ybCcGMro0zyBCzQhREo2slK5r/uflroC607XCCIGjLuB6TptSxV97L/9/QSrE2U
4JteFGVwRBJw1s7k8ICf4s22debUZ+OlB0mXjI+8EUDt6vdMeregn5ilQQSsDmBMnz2GzHfV30tb
X92uoE5xui1g4Q3BWkUVwd9wVHaganr3rzc+lQDnQq5cddu1supu3SWp5FqKq36rtf3RX/3zHZ0C
P2pCAlilDHYH2NRF8CYb+gqFySS/PUxwPmFWuD897Hewokex+ux0oZscsuRe0IttCbYfjl/+tSA0
a6Rd+AmkiyASFgEHsLGl6q2OTPYU1PikjUe5RXTp0UC7bdPQXzxaORlh/KWilnz/kV2XblDdybuc
Qz3eVIGvTANnIqPpz94oImrgHX48hMGiH5gGNznLwDBoQl4ZSfvlSi01TcUsYlHJD3LRZWbsh4VG
PDGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1FIENBIDIwMjMCDCsjlIbQJoxUU3h/cTAN
BglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgM5qa5FvPjaXgeYteDKT+5F5/hXfrmDCr
QtkV9dYhNAQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNTA0
MTUyNjA2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEB
BQAEggEAaZ72RSjoHC5Bjy4zsVXkJAJ5X7q8cu6oI8182nf+i0PCTgkSuVUtpEezrXvdLYSry8nv
ogD1iyVlQFWx/jRL3giNUBK6U+wwszeWWK9vLwvh0brtTEz8rTRTGVefJcY2KwGWB9udqvMXrnOU
oI5/o+4suL2omMOpD+F+xc+aQVBYC7AlV/Xr7yrM77eTN2AijOMO9X8tWnxcpbNl2XtmL21honTa
d2VYDtGkO75gDqmHUxXoqfc8U3u5t3QPd8uZ2KkA2sepcb9KZdUNaAW6xKY91Bf+8hPbXBWOLkkM
Qrt1nz/Tl/Cfu5PzTITpqdDcKqJwReCimYpqF3HaJl6KvA==
--0000000000009fe2fb0650ff8c43--
