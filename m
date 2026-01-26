Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42CF3033F7
	for <linux-i2c@vger.kernel.org>; Mon, 26 Jan 2026 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418769; cv=pass; b=FVWJg+uPUHfeRJl0bA8J2CyskxGaTYIlNP3zm/c9YEXbV7PeCWfW6AuLvLHcGFLZisclktirpx+pmQIrWBEnKe0zfy8oeoC5mYbqXY5G3R9PF2lmfFKvCPVIlQg2vRXErZdZ4nn7Fs0uFluNjTsMTK7H8WMsoTgl4hG0qkRB31w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418769; c=relaxed/simple;
	bh=vniLXzKHNspJD1FrLmGqcx0OX77epShC8YHjddOyZr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXWZHJRII0j4P7jbVG77RoJgv0WkgNAdFBUEXX616YeHrx0lJ4WuBhuaQhcf7KlMZ2KaHLwDyjveV8pSYPYMZeEdC0OC5VY8SeWiOIzR2UMNHW9mPS2n9DDoOvTHFURNLFdgULRGcODkdQ0VhqZxfxbSsOlq82KhfpPr+MhMpLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mjlQTbN4; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="mjlQTbN4"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so7172152a12.3
        for <linux-i2c@vger.kernel.org>; Mon, 26 Jan 2026 01:12:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769418766; cv=none;
        d=google.com; s=arc-20240605;
        b=WPJsRjcIKaKerLUwVtRvRkahfu3jr7nxrBuIIXkSQLyVxZQrjNiwLB4oPwZS4pyHvX
         DjNulbHEGYKnJyAfRW5xJDRzWJzjzMsNnQtlJCx1gVYu8ZoNMO2Ewi/LWNGlyoCt7t6C
         pbyaZ9d6wTLMZq2l8Pki55ntwJIGJMJ+OdZzAARN8GszsCcVSSqpVlfUyRqief5CTQ31
         Ro8WTakIVaKrqqdxQ9tED+S50YLZ9z2vrsMR9Iuzl4XMc32VZgAsHu3PfPNJyWmVJU5y
         mQfKAUcP+HjvFSbe+BJCjrI0OSsUDdrYM5tf9TfMWv1Q5etkw3yKManlhnux11oazapX
         ruhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OZ0wRjpBkARHUdg5AXc4jIF+w1YP8Cq41/gPWjBo+gg=;
        fh=DLGnxzP9RWQXJG4GsN36NSErjWOEA+gPAg/P4dTWkeU=;
        b=YJeD5HHfOESFVcV33UizCwl0GeJA4u8VbRduzG7xgF+Ri4F9vIjcMGDl4cq2+Yx232
         wIlXNZjYeVtcp84ftFBXVG/6Zi6quSF73m4VlNpkdynWNK6UdHsw73TRtTh5yFVB9y4l
         TgmcrdCqc3KGF69V36rtTHgWQ6OgE4ZJbHSbRN/CjouCGZj+F6oY74M8JBhMTg6zhVw9
         00T0hBePGsF3ENfh7l+lJ0pVGRt+4TvIFHUseOYxzvb4N0YDIcxezloYmEtQNWXoYWMP
         DpIvlGpLj5hF/8vPbni2fMGHKw7EGitaA6f9KWOOi8Pigh9DDMUIKKQktV8bBB0ROp6p
         s4xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1769418766; x=1770023566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZ0wRjpBkARHUdg5AXc4jIF+w1YP8Cq41/gPWjBo+gg=;
        b=mjlQTbN40meuUe7Qt2JMVdQRsK+Q1McY4Pk1gDmAJ+WYzV97KyhGD+HNG2S5wJ3+ze
         DGoqJtI4sOiZ2Pb/ax1Kyso6sxqoVRhGuBA9vYSEmyNJudhCApzGKVUqzJcJhCiT+U/X
         wG8EluaJZL0gqkUubo9cbQHcK6xBgaqdu717Mr6rd1jzMQ8ifia959ctMieyRAJfNuN/
         9AjElWOD2WzHILJuhX6gB4qnA0lJqUjvC0YwBFkZXepFwpEIgh/x0HrMQhd3BpBqOrbJ
         ZKRacWObla8cWS7Lf3jIBzrIFTOYIZ/Pxf65bzPn+5HGwBSGygFNW6S/2F92j1hfYmdC
         9imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769418766; x=1770023566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZ0wRjpBkARHUdg5AXc4jIF+w1YP8Cq41/gPWjBo+gg=;
        b=SNnSgpZYftZbcgo6UFNj878VQQitEpzBzBQY73PdNZ8dkOvJnldI+KZ8p/lcFEA4u7
         KAnGjzDh44DTUtwJYNEJE1QzhNVbPUukrkGymwT5p5w5YUF7wXKk0PwyppQQyHwOYA0i
         fZTp07qAupoHuPpLbH642b0/+Vpom8kNnFBoqolNMzl9t8jIjYzeRqjMiWls9wwvT6sA
         VUHzajHLw3f9ahBY/mlqUTK56zYK1yBJhnC6FaBMzd3UT5xlpAqmte9n5evrFeUKbcDJ
         +nVGhjcWyfp6fx72RgUp5E2aODW8QI7FGz+TVpxSHzPEeCD4Dvpq3EfANqcerlCPsAeN
         7kGw==
X-Forwarded-Encrypted: i=1; AJvYcCWYL3XeBRq5ZKmMtCe9xRwKqqiE4y6vbM5jh7vPH1TrUORMvk0/RwZQTdk83q+PwH1zNvekWsBg1qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVyOt3BUxCCaK0GacYTmNOHnX0JN1EIk0qjn0blutOE9ItLaAz
	r2XkyaVf7iz5AhU8SmPxTZTc5+/+1HhiDusFTF6VpbZqZjrJaNj1K1/X76EqJb18f4XmI6vHZLp
	lb89DCT6K2dUotIsM5Uh/WjfYxKGJLSbkmvXDSTkOew==
X-Gm-Gg: AZuq6aIqIns+YKuKXO/VOorNAQH7ra/l81udn1LOO7S8YNxTKbZpgDP/ZYuCi/EQbL7
	Yn6E7Lz6SaTXwyMHIE1Ga/+vKc0bQfKqVpINUb+hiDwcs9VLlje1QPEgDWiyBMHv/HlQMnfLrci
	e4wGokHY099wAvN5q1fS8ZMH55k0yv1z+hW4eJTNv04yaizXYjSZ3dHb7BLogxcLyzNyEDg78Za
	+yHV6l0BQPocHGh/bo4asK79Nac+WGwKLyGirlk7BvJQhPJmxk6zX7ULF2jZEdznhzrvmGQKRm5
	Dn6k7+b6jO0PkBTFM0D95TY1K7Sq073InUOP3izTwx7ZVNdpHoY=
X-Received: by 2002:a05:6402:4508:b0:64c:fc09:c956 with SMTP id
 4fb4d7f45d1cf-658706d59cfmr1542296a12.29.1769418766039; Mon, 26 Jan 2026
 01:12:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827-i2c-pxa-fix-i2c-communication-v3-0-052c9b1966a2@gmail.com>
 <20250827-i2c-pxa-fix-i2c-communication-v3-1-052c9b1966a2@gmail.com>
In-Reply-To: <20250827-i2c-pxa-fix-i2c-communication-v3-1-052c9b1966a2@gmail.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 26 Jan 2026 10:12:35 +0100
X-Gm-Features: AZwV_QjHvCNM4XDV7ASy_DsR-MKQkm_PDnKvDdBjq4JrCqpz7uMbU7Pm9e77hpI
Message-ID: <CA+HBbNF6r0eQLS01eTUX0DAZ3mGcQX7N3HTCnTanVPC0num2WQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] i2c: pxa: defer reset on Armada 3700 when recovery
 is used
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Wolfram Sang <wsa@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Hanna Hawa <hhhawa@amazon.com>, Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 7:14=E2=80=AFPM Gabor Juhos <j4g8y7@gmail.com> wrot=
e:
>
> The I2C communication is completely broken on the Armada 3700 platform
> since commit 0b01392c18b9 ("i2c: pxa: move to generic GPIO recovery").
>
> For example, on the Methode uDPU board, probing of the two onboard
> temperature sensors fails ...
>
>   [    7.271713] i2c i2c-0: using pinctrl states for GPIO recovery
>   [    7.277503] i2c i2c-0:  PXA I2C adapter
>   [    7.282199] i2c i2c-1: using pinctrl states for GPIO recovery
>   [    7.288241] i2c i2c-1:  PXA I2C adapter
>   [    7.292947] sfp sfp-eth1: Host maximum power 3.0W
>   [    7.299614] sfp sfp-eth0: Host maximum power 3.0W
>   [    7.308178] lm75 1-0048: supply vs not found, using dummy regulator
>   [   32.489631] lm75 1-0048: probe with driver lm75 failed with error -1=
21
>   [   32.496833] lm75 1-0049: supply vs not found, using dummy regulator
>   [   82.890614] lm75 1-0049: probe with driver lm75 failed with error -1=
21
>
> ... and accessing the plugged-in SFP modules also does not work:
>
>   [  511.298537] sfp sfp-eth1: please wait, module slow to respond
>   [  536.488530] sfp sfp-eth0: please wait, module slow to respond
>   ...
>   [ 1065.688536] sfp sfp-eth1: failed to read EEPROM: -EREMOTEIO
>   [ 1090.888532] sfp sfp-eth0: failed to read EEPROM: -EREMOTEIO
>
> After a discussion [1], there was an attempt to fix the problem by
> reverting the offending change by commit 7b211c767121 ("Revert "i2c:
> pxa: move to generic GPIO recovery""), but that only helped to fix
> the issue in the 6.1.y stable tree. The reason behind the partial succes
> is that there was another change in commit 20cb3fce4d60 ("i2c: Set i2c
> pinctrl recovery info from it's device pinctrl") in the 6.3-rc1 cycle
> which broke things further.
>
> The cause of the problem is the same in case of both offending commits
> mentioned above. Namely, the I2C core code changes the pinctrl state to
> GPIO while running the recovery initialization code. Although the PXA
> specific initialization also does this, but the key difference is that
> it happens before the controller is getting enabled in i2c_pxa_reset(),
> whereas in the case of the generic initialization it happens after that.
>
> Change the code to reset the controller only before the first transfer
> instead of before registering the controller. This ensures that the
> controller is not enabled at the time when the generic recovery code
> performs the pinctrl state changes, thus avoids the problem described
> above.
>
> As the result this change restores the original behaviour, which in
> turn makes the I2C communication to work again as it can be seen from
> the following log:
>
>   [    7.363250] i2c i2c-0: using pinctrl states for GPIO recovery
>   [    7.369041] i2c i2c-0:  PXA I2C adapter
>   [    7.373673] i2c i2c-1: using pinctrl states for GPIO recovery
>   [    7.379742] i2c i2c-1:  PXA I2C adapter
>   [    7.384506] sfp sfp-eth1: Host maximum power 3.0W
>   [    7.393013] sfp sfp-eth0: Host maximum power 3.0W
>   [    7.399266] lm75 1-0048: supply vs not found, using dummy regulator
>   [    7.407257] hwmon hwmon0: temp1_input not attached to any thermal zo=
ne
>   [    7.413863] lm75 1-0048: hwmon0: sensor 'tmp75c'
>   [    7.418746] lm75 1-0049: supply vs not found, using dummy regulator
>   [    7.426371] hwmon hwmon1: temp1_input not attached to any thermal zo=
ne
>   [    7.432972] lm75 1-0049: hwmon1: sensor 'tmp75c'
>   [    7.755092] sfp sfp-eth1: module MENTECHOPTO      POS22-LDCC-KR    r=
ev 1.0  sn MNC208U90009     dc 200828
>   [    7.764997] mvneta d0040000.ethernet eth1: unsupported SFP module: n=
o common interface modes
>   [    7.785362] sfp sfp-eth0: module Mikrotik         S-RJ01           r=
ev 1.0  sn 61B103C55C58     dc 201022
>   [    7.803426] hwmon hwmon2: temp1_input not attached to any thermal zo=
ne
>
> Link: https://lore.kernel.org/r/20230926160255.330417-1-robert.marko@sart=
ura.hr #1
>
> Cc: stable@vger.kernel.org # 6.3+
> Fixes: 20cb3fce4d60 ("i2c: Set i2c pinctrl recovery info from it's device=
 pinctrl")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Tested-by: Robert Marko <robert.marko@sartura.hr>

> Changes in v3:
>   - rebase on tip of i2c/for-current
>   - rework the patch and use a different approach which does not requires
>     modification in the I2C core code and update commit description
>     acccordingly
>   - remove Imre's SoB tag, it should have been a Reviewed-by tag, but due
>     to the rework this is an entirely different patch so that does not
>     apply anyway
>   - use Link tag for the URL of the referenced LKML thread
>   - Link to v2: https://lore.kernel.org/r/20250811-i2c-pxa-fix-i2c-commun=
ication-v2-2-ca42ea818dc9@gmail.com
>
> Changes in v2:
>   - rebase and retest on tip of i2c/for-current
>   - Link to v1: https://lore.kernel.org/r/20250511-i2c-pxa-fix-i2c-commun=
ication-v1-2-e9097d09a015@gmail.com
> ---
>  drivers/i2c/busses/i2c-pxa.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 968a8b8794dac3398a68d827c567aa5bb73ae3d7..70acf33e1d573231f84a1f09c=
ffb376a8277351d 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -268,6 +268,7 @@ struct pxa_i2c {
>         struct pinctrl          *pinctrl;
>         struct pinctrl_state    *pinctrl_default;
>         struct pinctrl_state    *pinctrl_recovery;
> +       bool                    reset_before_xfer;
>  };
>
>  #define _IBMR(i2c)     ((i2c)->reg_ibmr)
> @@ -1144,6 +1145,11 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap,
>  {
>         struct pxa_i2c *i2c =3D adap->algo_data;
>
> +       if (i2c->reset_before_xfer) {
> +               i2c_pxa_reset(i2c);
> +               i2c->reset_before_xfer =3D false;
> +       }
> +
>         return i2c_pxa_internal_xfer(i2c, msgs, num, i2c_pxa_do_xfer);
>  }
>
> @@ -1521,7 +1527,16 @@ static int i2c_pxa_probe(struct platform_device *d=
ev)
>                 }
>         }
>
> -       i2c_pxa_reset(i2c);
> +       /*
> +        * Skip reset on Armada 3700 when recovery is used to avoid
> +        * controller hang due to the pinctrl state changes done by
> +        * the generic recovery initialization code. The reset will
> +        * be performed later, prior to the first transfer.
> +        */
> +       if (i2c_type =3D=3D REGS_A3700 && i2c->adap.bus_recovery_info)
> +               i2c->reset_before_xfer =3D true;
> +       else
> +               i2c_pxa_reset(i2c);
>
>         ret =3D i2c_add_numbered_adapter(&i2c->adap);
>         if (ret < 0)
>
> --
> 2.50.1
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
