Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D299E37F00C
	for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785256511; cv=none; b=oM84jADolL7qHXQNZel+KOy4RaR9JgsItgT38EoBopxG6Hoq9XuL1GWSd1GQVookItCo/NeBpX/jTHz0j4nvYUFUCG99OQ4O9fF9ej8HqjP+Qq4MYkeT/fEF8EQH6L04SIozfW1DwmGnL9mF7Feqyu7xfWY5SaOhnJ1F8cNjiJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785256511; c=relaxed/simple;
	bh=m43TZKRlAD0+mkC7QvoFCfpOITlUA2MrHznpqafdOlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBBIsBWsrR1EKFxjlJaMMfnIC7hekKPBQ75c0vG7s8yP7sN/BhlEoyEBbMvcjLT94gltDjyDPuS/3WLXnrGpQeC5UTWC8SR0x1OX2IpEjjy4p/Q9W5q0/Fcftjb3XRtKRiulLUvvlkkNDjmzix3FiYJKAXA1bvX+Ui4mTPiEJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PKVXpA8h; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PKVXpA8h"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-902e4af2d9dso9733436d6.0
        for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 09:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785256509; x=1785861309;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gN8VILB4xTLAErcYugyLT16tsnHHUXbeGohMPbD6t4I=;
        b=GZe3UoLT97rDWKKZwWndf75TAlggMBjhWiQFncpofdaCgdneRQiQQ7NKx28dlVCbK3
         C8lD6xB/UWMMVpbr3shPgvObruJJ5yd2bGUPVTJv4d2bFpYzHyh6RQiejFjY138V2dRH
         9k0Se4bh0O1gaPoM+VjzeKPba1hO1R3vlJSHhmq2P15tYRQA8yFEvBQeqdBQxjwSIojJ
         +svl2ENrZj04ph+Vs32dIgIoC9EIq/FbENdiwqR+HUjv0bkjtKNugNr+VhIjA2R2yYRx
         fRjotaJWXwxS/Dk4DsFGZ18DTL/MbMrtEsG72nHLf/dPY0zxLMPJTyL5qVHNXv9eprVp
         qQhQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/fkos8au4+xG/HO99zmR2EwcsEOtQuO0vIfDVZI7oRtLqRROQcZzM5WoWPQNfKMRrzCRj0qH18YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUYMFCYSuI0y4YfzZED4l+Y/PV5/QeURrvmME4w2WsYFwu9xV
	h+MWE0BEgFUB4KLqbTJiGV7mkz/xp8FYyMtDD/EpawYYb4nywRbvJ3bxErOy0l3Op9Dfmu7EprS
	Iz8uToHfckdV0I7tC+z2KX7DTNwkn9nRn1X3Po2F9oWJVBqsWQOnJFKj9p+9BNNvT4mQp+dV1lk
	UFH+y5+yz5ZjUz7zL7i8qvdxDFNoIKIi7COS3cjoNNKpL8K7YHDzxvHiD0PFLCoCtdMWIYkf0ZZ
	7cOgE8JOjE=
X-Gm-Gg: AR+sD13BTV+rql3K2e2HwRxVvASGvm7zoyj4pbE6HjCLNmeZ8b+KWYKybONMe/sgTwR
	wPMt6OH2PahECGiNx0MQwISJsQuVyL2+iGPBFeMeXrmbkRVYASq014jUXps58guOLUmSslm9m6c
	H+vK9dPSn+DCbiA4gybViM4eta7NcvPstf9oeYwbiWoA3A7yoibkRzEtZT7zGnLRPNIBu5lZGsI
	PUTFDUprljRzvf3L0X2EpLE/WwM4sCXAMdFfBmyKxug+fiPhJdj0W5ZsdoDEuWU7Q0CLy4b1hot
	h3CD8kxYKjr0f6FuuHnyJ8yCpkK3APD6nz83OTyaOifiKlk1MiFxFD7cEWjtvWU/T21set6MbDO
	0L63YYNU6jXYzws+KPTMlroEHJo7aeo4KmYJLBAjSL6SinVwsXI0YyqmTN9ggULtSnEILrKn3QV
	cMBlhKgf28Bt3p0CHOBVG7JVkfmT3+
X-Received: by 2002:a05:6214:29e8:b0:8d0:3950:aa0f with SMTP id 6a1803df08f44-9081731dfbemr35657366d6.22.1785256508667;
        Tue, 28 Jul 2026 09:35:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-9081dc28933sm215666d6.4.2026.07.28.09.35.08
        for <linux-i2c@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2026 09:35:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ee593a5a2fso238656d6.1
        for <linux-i2c@vger.kernel.org>; Tue, 28 Jul 2026 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785256508; x=1785861308; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gN8VILB4xTLAErcYugyLT16tsnHHUXbeGohMPbD6t4I=;
        b=PKVXpA8hmMBVaOSe7UElXHVpbi7mgLTKeXmW4GWerGpi+AuPkvNIAiD4Z7MPSCiGYO
         hYrT/y9e19aVdOsbVYvdI8E1okd7yj816iCDiBErIt0sFiWqM6ebrQqtn4NXcl6y50M3
         imhSa6eyC5D/vhEKo8q6iLjxtWHKdVOsBqlxI=
X-Forwarded-Encrypted: i=1; AHgh+RpjLfgBSNWFI1ASPdHggeTYuCXPYf7B6d89VCEJDwL/2gntfJ1lAm1/s0i/7Zj4pbTP201MfHE2qdc=@vger.kernel.org
X-Received: by 2002:a05:6214:1c85:b0:907:86e6:f5a1 with SMTP id 6a1803df08f44-908170892afmr29297966d6.12.1785256507836;
        Tue, 28 Jul 2026 09:35:07 -0700 (PDT)
X-Received: by 2002:a05:6214:1c85:b0:907:86e6:f5a1 with SMTP id
 6a1803df08f44-908170892afmr29297436d6.12.1785256507344; Tue, 28 Jul 2026
 09:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717085507.34209-1-jonas.gorski@bisdn.de> <amjDbiXiq6Rse0Ir@zenone.zhora.eu>
In-Reply-To: <amjDbiXiq6Rse0Ir@zenone.zhora.eu>
From: Ray Jui <ray.jui@broadcom.com>
Date: Tue, 28 Jul 2026 09:34:55 -0700
X-Gm-Features: AUfX_mwWp_nD7dLFFvb7nP4h_zgWe_5sD0K9AQeuFv5JgZHf0zNVM9s_sB9-m54
Message-ID: <CAJ8Y1dQgWzg+updo+QB1c3MdMzje2PKDFhaL4F3LqWadR8x0zQ@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: iproc: reset bus after timeout if START_BUSY is stuck
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Jonas Gorski <jonas.gorski@bisdn.de>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Kevin Cernekee <cernekee@chromium.org>, 
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000034a540657ae6ca8"

--000000000000034a540657ae6ca8
Content-Type: multipart/alternative; boundary="000000000000f42d0d0657ae6b28"

--000000000000f42d0d0657ae6b28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andi / Jonas,

On Tue, Jul 28, 2026 at 8:04=E2=80=AFAM Andi Shyti <andi.shyti@kernel.org> =
wrote:

> Hi Jonas,
>
> ...
>
> > diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c
> b/drivers/i2c/busses/i2c-bcm-iproc.c
> > index b5629cffe99b..86ca4c2221c4 100644
> > --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> > +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> > @@ -803,6 +803,17 @@ static int bcm_iproc_i2c_xfer_wait(struct
> bcm_iproc_i2c_dev *iproc_i2c,
> >       }
> >
> >       if (!time_left && !iproc_i2c->xfer_is_done) {
> > +             /*
> > +              * The controller may fail to clear START_BUSY after a
> timeout,
> > +              * reset the controller to recover in that case.
> > +              */
> > +             if (!!(iproc_i2c_rd_reg(iproc_i2c, M_CMD_OFFSET) &
> > +                    BIT(M_CMD_START_BUSY_SHIFT))) {
> > +                     bcm_iproc_i2c_enable_disable(iproc_i2c, false);
> > +                     bcm_iproc_i2c_init(iproc_i2c);
> > +                     bcm_iproc_i2c_enable_disable(iproc_i2c, true);
> > +             }
> > +
> >               /* flush both TX/RX FIFOs */
> >               val =3D BIT(M_FIFO_RX_FLUSH_SHIFT) |
> BIT(M_FIFO_TX_FLUSH_SHIFT);
> >               iproc_i2c_wr_reg(iproc_i2c, M_FIFO_CTRL_OFFSET, val);
>
> the patch makes sense to me, but can I have an ack from the
> Broadcom folks? Ray? Scott?
>

Sorry for the late reply. But yea, this reset after timeout when start busy
is still set looks good to me. Thanks.

Acked-by: Ray Jui <ray.jui@broadcom.com>


>
> Thanks,
> Andi
>

--000000000000f42d0d0657ae6b28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Andi / Jonas,</div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 28,=
 2026 at 8:04=E2=80=AFAM Andi Shyti &lt;<a href=3D"mailto:andi.shyti@kernel=
.org">andi.shyti@kernel.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Hi Jonas,<br>
<br>
...<br>
<br>
&gt; diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i=
2c-bcm-iproc.c<br>
&gt; index b5629cffe99b..86ca4c2221c4 100644<br>
&gt; --- a/drivers/i2c/busses/i2c-bcm-iproc.c<br>
&gt; +++ b/drivers/i2c/busses/i2c-bcm-iproc.c<br>
&gt; @@ -803,6 +803,17 @@ static int bcm_iproc_i2c_xfer_wait(struct bcm_ipr=
oc_i2c_dev *iproc_i2c,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!time_left &amp;&amp; !iproc_i2c-&gt;xfe=
r_is_done) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The controller may=
 fail to clear START_BUSY after a timeout,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * reset the controll=
er to recover in that case.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!!(iproc_i2c_rd_r=
eg(iproc_i2c, M_CMD_OFFSET) &amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 BIT(M_CMD_START_BUSY_SHIFT))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bcm_iproc_i2c_enable_disable(iproc_i2c, false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bcm_iproc_i2c_init(iproc_i2c);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bcm_iproc_i2c_enable_disable(iproc_i2c, true);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* flush both TX=
/RX FIFOs */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D BIT(M_FI=
FO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iproc_i2c_wr_reg=
(iproc_i2c, M_FIFO_CTRL_OFFSET, val);<br>
<br>
the patch makes sense to me, but can I have an ack from the<br>
Broadcom folks? Ray? Scott?<br></blockquote><div><br></div><div>Sorry for t=
he late reply. But yea, this reset after timeout when start busy is still s=
et looks good to me. Thanks.<br><br>Acked-by: Ray Jui &lt;<a href=3D"mailto=
:ray.jui@broadcom.com">ray.jui@broadcom.com</a>&gt;</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Andi<br>
</blockquote></div></div>

--000000000000f42d0d0657ae6b28--

--000000000000034a540657ae6ca8
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
BglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgLkKUJkhGoPmpjZ4icoCrbLVen6iRUM+e
UnqtLr4YFjMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYwNzI4
MTYzNTA4WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZI
AWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEB
BQAEggEAFB4jaBh5JCp36sMEIzQLu59z3yrOwVFS8/6cbThLBB57WjeYCqyweMjnfnsyURd2ojKM
JdupEQyTW2bT0Gd38NSD1vipPtLxObk2rcioECsQMp2boK79Zmcd6Kznac8UxX4DfwHfBTbaCqov
eQ5wgtQWEedjQSCjfg9Z1rkZ87K0OCGrjhJOybNP50pduSxfrQq7/gZlg8X6J6qG2kQk30dFAqBg
SZeCm0X2zlCz+ZEdtM06JJ7YLUakwoythqaZd8AxeQNmQ8+SynracNLiwd9KjrjPL9fZMfxRGU5J
Js00ZO94dI4Kva3e6bCt8mhnnt3cbEfuLLcquAM/Kgof+A==
--000000000000034a540657ae6ca8--
