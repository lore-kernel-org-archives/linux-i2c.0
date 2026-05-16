Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033231F4611
	for <linux-i2c@vger.kernel.org>; Sat, 16 May 2026 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778894857; cv=pass; b=fRRVR5RiQ+u95sdS0JnniDA9IhSwkh30tJc76rvIdWpiUfXz9PNCjbaj6f9NtXN7FlHk8IJn1j1KvLdUMpjZlPqMGpHgWAclI1VGjbybtknROL7O0tgqqtaZZX6uDiP6u6hj932R6yP5M0S5R9QQihGjyDzp0qp3pu3rfkZDkEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778894857; c=relaxed/simple;
	bh=bW7QzCTqcRsx/T9yD6fdRoLOs7bmToMIW9FFX1/ogbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7b6exU15DEi+DVuDXK0XexC6HL3K8mzDOiq4Sdb21SiDvJfZc7VJR7dEAsomxU/kLX0Ol2SVHoiXw0Y9+yHAfx+RXG0cJCeyoWkepJ/7f66ii76nevGry/OcPJ6pKym84j6ZqbSn/Hsagl3Ns5zwwMjZumZOgKcTLO7AuRnRe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWcbzqZd; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWcbzqZd"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-651c366f7efso767436d50.1
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 18:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778894855; cv=none;
        d=google.com; s=arc-20240605;
        b=WF0PrMvW3QVFasMIpLk/tlnz68/UFtOJ6BqPz510M2j5KV/KDpwx2rBikG0RTb3q9y
         A+urxKidzxqQSTAe2cul+dukjWiovxvqYuevMmPDkQd9qQD4hCTz/hKpzGTmz9XkxiDf
         ANQ6SfWR94WvhT+dtqUYJguWAC+h0dKYqn/ThgeCG5xz3bY1k5H9rrizd6XYK3sk8Ie5
         Lu4gZno29rX2ki4tgAUhP/sq0zXalmquSEf2m4w7K2UZKHIjLVH9ddF5so280lRUpJv+
         M2C4nOtl7o3QKuLMRSYAuP8JMPOdm5F7RJYmi1zzX8CdsxOzigJnmYBb4DxWYkUtnisC
         JqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L9FZebPfxjmKa8vSCx4bP2RNfwPyM+VKakDWUr1Bhyk=;
        fh=Gv7utp19iUjMHFEYvlFmcYbAdz6qZYG/Sn53CSQwps8=;
        b=akIUFO0Xeoxa9fnhODbSP84bwUMKrbIi9wpnVgZCbodzs5ii7hoIKEsPes3ONEzals
         SBGIQ8uXPc2SymWfEOSkTq0DB5ACqu3HQ6mWRLAMiz+Xf6k22xQ06wdJUrQaHNywtdGk
         TrHZK+nVf0PeRCl8YF0p4EJAjstYm3ahgRVQbkuutsH9XP8bOR9ceRfNFIOiWj/NJluq
         za5qEUaXCTzExxjtdezEPWjU30PY/PrCE+wIuEcVKMajMzZYDDa77mNCt3vr0JYSNXyR
         G1BwxlFh8P1kQXPrzecLNBdEvR32LWisVVX+MqXIkjAPP6HJWYDwp/1PCUOuExJeocjU
         7Jyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778894855; x=1779499655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9FZebPfxjmKa8vSCx4bP2RNfwPyM+VKakDWUr1Bhyk=;
        b=LWcbzqZd/ovl4FjDDMeathj9xRY2PX2MuSg5fhkGp9BjmSiVp6ReTrHPqdsIeuyWNF
         ZZwU+n/icY/by9OZY6l7VnzDEexmXz3IusKOPtyMTPMC4UAQIKDSIowBbT5CLr+5xsrO
         +yN6vYzuLCnMpgnhuR47reycdF9IrfOQ28P6wor5jFZhccyu67Sb1ZR8GpAa0Sm6pXvL
         WAfUQ3mXegfD4mXHhXaiRpxVScLSQPVKaSgsC2wNTPsZM+QmC3nflT7xRWUYmdA1Ixk1
         bfalYICFv/315dhs1sK4yh7oaylMEH46OV6r4Bhro7fDzMWcewJb8nI4AOYhVpuy1o3V
         d63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778894855; x=1779499655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L9FZebPfxjmKa8vSCx4bP2RNfwPyM+VKakDWUr1Bhyk=;
        b=Hk3o1fbDKpUyp7WXAs/nfDluxqc4ZiqA28pOMXPQoVSk/ZYFPpf0OscSle+aegnsAT
         zhw+qzYVRmF0ezRVyMGXhzEV5PSnmE7RFdWHFQIXxHr6OA0ht9rAUOtxAO1yiiE0Ihs4
         X4nV4w27asUGYfdqH2ur9GNXE1knJ9LDnFbzAuPswPWue+tdMu/9vloKejLKmbIqMltU
         n58NhsJx1JGFOrM5lSyLQIwTh3jxlmUst/7hRF3AHQZhWiWwqviX8f3PXNIexlQ2uQXE
         lSLWFeT5k8X7YGsa5eoC7GujklRfW9TqPu92wga6Y5fcHrwEIhUZ6HEXsiUyXdUazY7X
         PUFQ==
X-Gm-Message-State: AOJu0YxLRMQLZrNGvE8fUcEvpLTxwB7z3kAkqQzId8FZ1ia1wSajgB/5
	7j41HFPuXRQkGOfEWh0ZQOUX4SGciOReBkh9cIr+qTd9xYZooDmwoL9U6AhDwdPoluXyWLrUdCX
	Gqqm1e4qJ9zWhn+MfPDH27Z4YUMaYdqM=
X-Gm-Gg: Acq92OE47fwTqvGAXQws0EVbXsKlJb3c6CuUFlYVBLDvkfZ3bldhC+77PcBnVRlZ58c
	NqjrV+tmBeIa+jL6Dm57eIKXcfZfuyGOOYWTFQEtNNw7LOygTAv6P15c4UA+ZmjkOpf+SpxmmKt
	HuHjTmvI0fgPQeMlhz0yt9/mPENKLB5ZCZ8vVY/klDb6fS4dlooFUP/67CMNFAJtaoMtBw99qJ2
	YXk03Ud6OwFm00BTZoqAOUd08NX40qCh2HgZyz+zXMWnk+rVY/LPmvhvXjUqfF2urs/nG01m73/
	dNKP5B5sjrMw+OG8M4GQc2iK6u6287T5LxtMRm1X3mN4MmPz5cR8Sn3aJdh+YGYkh0ZoO+6x4i6
	LbG8H584t73TMHJJaeLH6LV6yoJU9oyHj7rBA5Tcbx0Vm6VJ5f0YoSUaqhp0=
X-Received: by 2002:a53:c05b:0:10b0:65d:5702:3373 with SMTP id
 956f58d0204a3-65e228469f1mr5969955d50.33.1778894854916; Fri, 15 May 2026
 18:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515161516.10474-1-hardikprakash.official@gmail.com> <32e96be9-a987-4847-b02d-d288f3fbeeb2@amd.com>
In-Reply-To: <32e96be9-a987-4847-b02d-d288f3fbeeb2@amd.com>
From: Hardik Prakash <hardikprakash.official@gmail.com>
Date: Sat, 16 May 2026 06:57:23 +0530
X-Gm-Features: AVHnY4KJPM6i6_WJQA-9eYv2Vf-xc3JrjXWgEPVFiQ1CaIVYdKqcVVMtCjHedSs
Message-ID: <CANTFpSV91DjxSFSmc5gCQ5YTy+Oubg11+55V3z-Xg2nM8TKvpA@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] i2c: designware: fix probe ordering for AMD GPIO
 on Lenovo Yoga 7 14AGP11
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, wsa@kernel.org, 
	andriy.shevchenko@intel.com, brgl@bgdev.pl, basavaraj.natikar@amd.com, 
	linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 23:04, Mario Limonciello wrote:
> I have another idea.  Why don't we just move pinctrl-amd to initialize
> earlier?  That should avoid the problem without more quirks I think.

I tested this. Here are the results across four combinations on my
machine (Lenovo Yoga 7 14AGP11 (83TD)):

  subsys_initcall alone:            arbitration errors, WACF2200 does not p=
robe
  subsys_initcall + patch 1:        arbitration errors persist
  patch 1 alone:                    arbitration errors persist
  patch 1 + patch 2 (v3):          clean boot, touchscreen fully functional

The subsys_initcall promotion does not seem to resolve the race on
this hardware,
i2c_designware is still probing AMDI0010:02 before pinctrl-amd finishes
regardless of the earlier initcall level. The explicit device_is_bound()
deferral in patch 2 appears to be necessary to enforce the ordering.

I can provide the full dmesg for any combination, if it is useful.

Thanks,
Hardik

On Fri, 15 May 2026 at 23:04, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 5/15/26 11:15, Hardik Prakash wrote:
> > The Wacom WACF2200 touchscreen on the Lenovo Yoga 7 14AGP11 (83TD) is
> > non-functional on Linux due to two bugs. Patch 1 (pinctrl-amd GPIO IRQ
> > fix) has already been taken into Linus Walleij's tree. This v3 resend
> > covers patch 2 only, addressing Andy Shevchenko's formatting feedback.
> >
> > Root cause: i2c_designware probes AMDI0010:02 before pinctrl-amd's
> > probe completes, so GPIO 157 (WACF2200 GpioInt per ACPI _CRS) has its
> > interrupt bits cleared when the first I2C transaction is attempted,
> > causing lost arbitration errors. The udev rebind workaround (which
> > works because pinctrl-amd has finished by userspace time) confirms
> > probe ordering as the root cause.
> >
> > Note: the dual-master hypothesis raised by Mario Limonciello was
> > investigated. TPNL's _DSM (UUID 3cdff6f7-4267-4555-ad05-b30a3d8938de)
> > is a pure query method returning a constant HID descriptor address with
> > no side effects, making firmware acting as secondary I2C master unlikel=
y
> > on this hardware. Awaiting Mario and Bart's technical verdict before
> > any further approach changes.
> >
> > v3:
> >   - Patch 2 only (patch 1 already in Linus Walleij's tree)
> >   - Fix variable declaration style in dw_i2c_needs_amd_gpio_dep (Andy S=
hevchenko)
> >   - Add BugLink tag (Andy Shevchenko)
> >   - Add -v3 subject versioning (Andy Shevchenko)
> >   - CC AMD engineers (Andy Shevchenko)
> >
> > v2:
> >   - Replace custom HID/UID lookup with acpi_dev_get_first_match_dev() (=
Andy Shevchenko)
> >   - Use acpi_get_first_physical_node() for platform device lookup
> >   - Use device_is_bound() under device_lock() with explanatory comments
> >   - Fix dev_warn to use dev_name() instead of hardcoded suffix
> >   - Fix commit message (removed incorrect "existing" reference)
> >   - Add Assisted-by tags per coding-assistants.rst
> >
> > Kernel bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D221494
> > Related: https://bugzilla.kernel.org/show_bug.cgi?id=3D221454
> >
> > Hardik Prakash (1):
> >    i2c: designware: fix probe ordering for AMD GPIO on Lenovo Yoga 7
> >      14AGP11
> >
> >   drivers/i2c/busses/i2c-designware-platdrv.c | 77 ++++++++++++++++++++=
+
> >   1 file changed, 77 insertions(+)
>
> I have another idea.  Why don't we just move pinctrl-amd to initialize
> earlier?  That should avoid the problem without more quirks I think.
>
> Something like this:
>
> =E2=95=B0=E2=94=80=E2=9D=AF git diff
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.=
c
> index e3128b0045d22..56a189082351b 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -1292,7 +1292,18 @@ static struct platform_driver amd_gpio_driver =3D =
{
>          .remove         =3D amd_gpio_remove,
>   };
>
> -module_platform_driver(amd_gpio_driver);
> +static int __init amd_gpio_init(void)
> +{
> +       return platform_driver_register(&amd_gpio_driver);
> +}
> +subsys_initcall(amd_gpio_init);
> +
> +static void __exit amd_gpio_exit(void)
> +{
> +       platform_driver_unregister(&amd_gpio_driver);
> +}
> +module_exit(amd_gpio_exit);
>
>   MODULE_AUTHOR("Ken Xue <Ken.Xue@amd.com>, Jeff Wu <Jeff.Wu@amd.com>");
>   MODULE_DESCRIPTION("AMD GPIO pinctrl driver");
> +MODULE_LICENSE("GPL");
>
