Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE7F340A76
	for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776943295; cv=pass; b=SbmttOgJcRGGPaowBEx5uDtHYpcqLKZiEeDKVzCa7yNJRCWGOLu2anmPZYiLAiZruOQazRvUf9FlBhblcRpfV05/V68E0+PyB2w5aP/gUGck5iJfrSc8+eRlyS0MU2GjZlsxxgIUySeLG/3J2Y6dey0w73qG14VqAzW3+C2jMCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776943295; c=relaxed/simple;
	bh=Nmy7kEMfpUsHqvDexW6cpdlVOq+KpdgsNRQIPJC2w6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeFNwEj3Wo8RtujLLRJIYi7h0dfkTUU8iZLAeyVqm97sjhZPtW9OZgQmYxFwG7nrbXC5qSKihMTfdD7U0VwYIg0ZfGye4yhU4M2AT9Yl2smepmsZWM3HIf2T/pMcAk3FiN3ISj/VJHA5IuLrwGaoygYnNtD3tJvIXKzuPBaWqOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s44Pu0cD; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s44Pu0cD"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c7212836bso410915c88.0
        for <linux-i2c@vger.kernel.org>; Thu, 23 Apr 2026 04:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776943293; cv=none;
        d=google.com; s=arc-20240605;
        b=LX9AtPLAXASFK5sLx4whj/vSgpz1r8AWQmi5Vzh90W67Uzwf5rW8leI3Qxf5X+189Q
         gqAOr6UoGQhQb6X3EjiMwrBQbz+khADycY+8NpQf73SzGfQLW0wVMxYEMtNCuTJpc3ec
         HFaJn8t5DyDxoC5V/osac2VqoiIBtSLYec58v7bYhRx9ZSdGL7Y/lbRoNt88AUDEoBtp
         rszSvURiZufLuBzikDGnsr4Oa5vwRNoHCNE1AgMyNUodWTR0Wn+uH21KsB0wVC4JFPmY
         PUPbSdYq7Iyol5vCwA2lJBQ5JqCPFkOUPYx1Vii3JIdRnYOOvzpO9XLmj8YbKQnVXRQF
         Y2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bvsCYSEt+mfAQiUrBXY7U6nuuq2FZaHIZJmYGmC6NsY=;
        fh=AP8E3B4BeNX5Xy5qxVS0p/ne0WoHK/UZInVcgbJNrFw=;
        b=fjMFwcec02lx+EEmgjvv3GwR2t1vx2D5ZNUA3UHhkKWGzZU/xS52Bdk7lXIVj1N5BY
         igQPSM4/Z1HcF3WDzq607vPBzq0Uiviih1t1bxZ6UKDZz9BV1sDeEKK8rRoTNedGe9nZ
         fp2AUQcjkXR7D+g2T56XvJk6VhlDdHcp1dcjjbM3SX6uyOifSj9OEIxFUoI2Ga3kv4Sz
         eMmyC8hysbL+use28EohubmSiPTngKRk6EHpa33kEjmgj7bHkSU8NRtTd9RV906cIxwZ
         Dy05IfugW+Vh8uKjtGgITSmHk6+1wWsIWpd/eoXCjf2Fc0ymTeOXIwC1cFU9SjGIeIiI
         4/uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776943293; x=1777548093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvsCYSEt+mfAQiUrBXY7U6nuuq2FZaHIZJmYGmC6NsY=;
        b=s44Pu0cDuWegTqa7gjBzLt575k/w1atuLdQKyC+mZjoosMXxlAioTxtiqL4K2lktBN
         O0WoHYlZeaXNDxAl0ylBXDb/9tgZ1hyvbbhRIh6M22ecjGSim0+OwMC65K/+dezyfKm/
         bK4ung2lwxb7PygNFoAwy3uv609dLvCB4PjQtg57nBGmdsk7lBRNjw55Nw9XatV7oaFh
         sy/lxawP+vzIUCE3pcrU0X2mhcF4HzRu4DpD+Qk6tQkifOrBYnp3EuJYaOs3SuU1XnsZ
         k4qnI0kmASWNHe6LVjQy0XTPvDFNCdykn7/kT+MV01yUzlMy6X5xbVn3spfxorSPqTUC
         x0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776943293; x=1777548093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bvsCYSEt+mfAQiUrBXY7U6nuuq2FZaHIZJmYGmC6NsY=;
        b=exLDdl+pNM73feD580qUSMiGDRfCE2/sS3EnzsVO+6itJz6KqkenHtjvcTAylbYzpP
         9uw7IYKXUUXIxm3yRDjP4CQkhHMS4J1f7v4zflue4V0gyjwJ/6BNqksYkzcIpx62MYVh
         GujGb0flEeGtWht/ArzFmb3bQWI77e0nAJABsIBBy31+tJenyjzjQ2hw6eI30x+NDChd
         UMe4S1RhJz7mmEIgxTrKyIgD7qzHRWO4utIkOInxVlRcNiRnCwnD/5/izs76w31OarfM
         pWh4zHgdQKI3NFO6j9hH75tgHZ2epUaBUCvW6miz9QwaXcF88sdOPH4vWIGHukMCUKso
         DUAg==
X-Forwarded-Encrypted: i=1; AFNElJ9u6rcfS6q7a2iHeKHOV1MZIUloqemkmgtc5BupceO3D9LBXFiGAXEudYiHaXor7SQqxkB5WplpAcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxWi/S00S/hghZwb7WnNJmJSYztDg/+UrEsUabKl3qmZoWEXeL
	pOC5HqozQRMo5eqpJf5bmo7JJ0BnbolhWfyBv+jVLytpuBrR48mJKS4kZA9Osu0aI9g1XAhtFsH
	DoDmvwThYJNzfln9WWh6/a9vZAcW7798=
X-Gm-Gg: AeBDiespm2XAaJP1WaxGRp0dHW60hbCj8+iYHVroA1DacBD5oCqswy0KmUwkzkBpNsz
	Wmd1xT9fkRoG2M7TBi7VmBE4kt7dJcLpgklzM8PfM5jbMkdy753nk80l5wdyMt9Uwqhqve8P/Jd
	kFUUKNAgYIjQlER/NdD0PbCXPAGKsLYEtoIC+uNzY/lVwnPUSgLofUlVyeicQJmeqldp/ZjuObK
	DrlTgYZvJR1wU9tEY3OYAB5MSmbw2rBmGRMe9QyfDD6SMTU0ycf3SPBJZQUJHHQ5wF0PlBfOQ5J
	4++yiPFxLNVwoRA4qugJy+g9LPq9eg==
X-Received: by 2002:a05:7022:e09:b0:12c:3d30:37c5 with SMTP id
 a92af1059eb24-12c73f75976mr16263810c88.12.1776943293015; Thu, 23 Apr 2026
 04:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205102942.28745-1-tinsaetadesse2015@gmail.com>
 <CAJ12PfPdkQD6VNROdSGYRWvHGf0FZ61Y-vF2uMB+vsnV1-KNNg@mail.gmail.com> <371b0658-7cbb-400e-b48b-5d7b46cf150d@app.fastmail.com>
In-Reply-To: <371b0658-7cbb-400e-b48b-5d7b46cf150d@app.fastmail.com>
From: TINSAE TADESSE <tinsaetadesse2015@gmail.com>
Date: Thu, 23 Apr 2026 14:21:16 +0300
X-Gm-Features: AQROBzAk0obmB5sPxy2cFAPqPGgmVVzpYnB4tdS-sk4S9aSCrpnVun5c344cRO8
Message-ID: <CAJ12PfONdP2joTduNuA-A5HQRCtE-7jUO_wHOWuQBRb_HtVm2w@mail.gmail.com>
Subject: Re: [PATCH 0/2] i2c: i801: Detect SPD Write Disable and expose as
 adapter quirk
To: Mark Pearson <mpearson@squebb.ca>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 8:56=E2=80=AFPM Mark Pearson <mpearson@squebb.ca> w=
rote:
>
> Hi Tinsae,
>
> On Sat, Feb 21, 2026, at 4:57 AM, TINSAE TADESSE wrote:
> > On Thu, Feb 5, 2026 at 1:29=E2=80=AFPM Tinsae Tadesse
> > <tinsaetadesse2015@gmail.com> wrote:
> >>
> >> Hi I2C and HWMON maintainers,
> >>
> >> Intel i801 SMBus controllers feature a "SPD Write Disable" bit
> >> in the SMBHSTCFG register. When set by firmware, the hardware
> >> silently blocks all write transactions to the SPD EEPROM
> >> address range (0x50-0x57) while allowing reads to succeed.
> >>
> >> This creates a significant issue for the spd5118 hwmon driver.
> >> The SPD5118 requires write access for switching between
> >> register pages to read temperature data, and for cache
> >> synchronization during suspend/resume. When SPD Write Disable
> >> is set and the spd5118 driver attempts write transactions, the
> >> bus will generate a storm of SMBus DEV_ERR messages.
> >>
> >> This patch series proposes a generic solution by:
> >> 1. Introducing a new adapter quirk flag in include/linux/i2c.h
> >> to communicate this hardware restriction.
> >> 2. Modifying drivers/i2c/i2c-i801.c to detect the SPD Write
> >> Disable bit and set the quirk flag.
> >> 3. Modifying drivers/hwmon/spd5118.c to check for this quirk
> >> during probe and fail cleanly, as write access is mandatory.
> >>
> >> By using this mechanism, we avoid embedding device-specific
> >> policies in the controller driver and provide client drivers
> >> with the necessary information to make an informed decision.
> >>
> >> Tinsae Tadesse (2):
> >>   i2c: i801: Detect SPD Write Disable and expose as adapter quirk
> >>   hwmon: spd5118: Fail probe if SPD writes are disabled
> >>
> >>  drivers/hwmon/spd5118.c       | 15 +++++++++++++++
> >>  drivers/i2c/busses/i2c-i801.c | 16 +++++++++++++++-
> >>  include/linux/i2c.h           |  3 +++
> >>  3 files changed, 33 insertions(+), 1 deletion(-)
> >>
> >> --
> >> 2.52.0
> >>
> >
>
> I'm hitting a very similar problem on all the Lenovo 2026 Linux certified=
 platforms.
> Your patch is great, and I wanted to add a tested-by tag to say it fixed =
the issue for me, but it doesn't quite unfortunately.
>
> I added this change (hack?) in i2c-smbus.c to take advantage of your chan=
ges and fix the issue that I'm seeing:
>
>  void i2c_register_spd_write_enable(struct i2c_adapter *adap)
>  {
> -       i2c_register_spd(adap, false);
> +       if (adap->quirks && adap->quirks->flags & I2C_AQ_SPD_WRITE_DISABL=
ED)
> +               i2c_register_spd(adap, true);
> +       else
> +               i2c_register_spd(adap, false);
>  }
>
> What do you think? Any side effects or impacts you can foresee based on y=
our testing?
>
> Maintainers - would love your opinion too. I suspect this may become a co=
mmon issue.
>
> Mark

Hi Mark,

Thank you for suggesting this fix, and I apologize for the delayed response=
 :)

> What do you think? Any side effects or impacts you can foresee based on y=
our testing?

I think that fix looks okay; however, it would be helpful to know which ker=
nel
driver was the source of your error. Additionally, having the kernel
debug logs would help pinpoint the exact place of the problem.

> I added this change (hack?) in i2c-smbus.c to take advantage of your chan=
ges and fix the issue that I'm seeing:

The goal of this patch series, as you can see from the RFC, was to
"avoid embedding device-specific policies in the controller driver and
provide client driver with the necessary information to make an informed
decision on whether it can operate or not under SPD Write Disable."
Therefore, I would rather have this check in the client driver's probe func=
tion,
rather than in the SMBus controller driver.


Best,
Tinsae Tadesse
