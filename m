Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2A3328B7A;
	Tue, 27 Jan 2026 05:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769492664; cv=none; b=RkKbQ+jRxaefa43FpDAQzgiIyb5ZazkhK3iDVg4rt6MDw7rDTkerqJyronwtGb36dLlTct5Dr2InZx6/yBJ+CUkaPc8dSZPaUNt1lMNJNFPO6EUPD/vbEX9jB87TX/VMRym67Go/xdfZBFWVgDqum6t6a6RGHtNzUTMQS6t7lmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769492664; c=relaxed/simple;
	bh=qM4z8UHiQtnvd+pMUHvevqbz/PPwsYAjY6FOpgbAwQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQ2mHiJEwze/2GiR42wuncL3y+mqzS+mbPkMF+xmgLjMCrSvrvE92FEIHFtBsdnLnpuTKUhzc1sCugwctPF/BWIqF+rw7OMK9GTpeup8O92rhY1aG+Wa/YbdpZvancQ3acAlMLegNAuGnOypAANsXvlkqSx6fyc+KAAEHhxH5ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qxdsw65D; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qxdsw65D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1769492655; x=1770097455; i=w_armin@gmx.de;
	bh=M/LefMP6PFSu2VGNeEaSwtbpwHD1ERrAfcYKICiA3l8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qxdsw65Dl4qIySvJQ7ZUymp5D/lRC2g1+pSkPbn+62kVY/JrGX38oM8GNdeq7UpT
	 RBK6r0mETIZoQMEC4T7MpEw/3xEVveHbWA6WGjpBQ1sDsfQTcGZJ5Iel/xv5QspD8
	 8fvNUUTaoy1xJmF/Har1YYmkRwKxCvdx4L5f4neD3TroTfSnJOSjkipfcm6+6kv+A
	 mWIMn2SbNE4vJNC8yp+E1rNts7wmxhRgRR3QrxQKnCjLZj1HcPD0BjuA+k5+4JO+f
	 NUqzOCd69jAag4mGt2IJ3I6PdWVUtNXYtYye2nZUqsEZs6Xwwm9vtmni5Ksd+vrgC
	 1shG4JWk2eTxEPqk4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([93.202.247.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCtZ-1wLsQj3bnj-00cPEk; Tue, 27
 Jan 2026 06:44:14 +0100
Message-ID: <260d3079-b462-4c22-a66d-93f41d099a45@gmx.de>
Date: Tue, 27 Jan 2026 06:44:13 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: i801: Do not instantiate spd5118 under SPD Write
 Disable
To: "Yo-Jung (Leo) Lin" <leo.lin@canonical.com>,
 Jean Delvare <jdelvare@suse.com>, Andi Shyti <andi.shyti@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
 "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250613-for-upstream-not-instantiate-spd5118-v2-1-cf456ed9b587@canonical.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250613-for-upstream-not-instantiate-spd5118-v2-1-cf456ed9b587@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BL8YddUn8z/pSQ9X1ysFnzCp4b/U3xfcm1TS9phxTDGbrYpmYA/
 jQxxx0jaZ1VKW/aDUr6joEDKF4T55CL/bgHAqK5zuE10nRYLMmg8W/O/oyMXki34BBva0aa
 UtF22c3OeRAWUBo0Eovra/wppuy6LehWuK/daMJa8t8ouHlRTnUdjeiFUFGjdDX2fpsWjVv
 6RHNaeM47xgs/HM+g5Ryw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y8gCsiH3fVU=;JaIs9QlHVMTYXwgFDDDlrkZp6XN
 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

Am 13.06.25 um 09:40 schrieb Yo-Jung (Leo) Lin:

> If SPD Write Disable bit in the SMBus is enabled, writing data to
> addresses from 0x50 to 0x57 is forbidden. This may lead to the
> following issues for spd5118 devices:
>
>    1) Writes to the sensor hwmon sysfs attributes will always result
>       in ENXIO.
>
>    2) During system-wide resume, errors may occur during regcache sync,
>       resulting in the following error messages:
>
>       kernel: spd5118 1-0050: failed to write b =3D 0: -6
>       kernel: spd5118 1-0050: pm: dpm_run_callback(): spd5118_resume [sp=
d5118] returns -6
>       kernel: spd5118 1-0050: pm: failed to resume async: error -6
>
>    3) nvmem won't be usable, because writing to the page selector become=
s
>       impossible.
>
> Also, BIOS vendors may choose to set the page to a value !=3D 0 after a =
board
> reset. This will make the sensor not functional unless its MR11 register
> can be changed, which is impossible due to writes being disabled.
>
> To address these issues, don't instantiate it at all if the SPD Write Di=
sable
> bit is set.

What is the status of this patch? We know of yet another user having probl=
ems with
resuming from suspend that could be traced back to the i801 i2c controller=
 having
SPD Write Disable activated.

Are there any problems with this patch that still need to be addressed?

Thanks,
Armin Wolf

> Signed-off-by: Yo-Jung Lin (Leo) <leo.lin@canonical.com>
> ---
> Changes in v2:
> - Fix build failure on some non-x86 archs, by moving __i801_register_spd=
() out of the CONFIG_X86 && defined CONFIG_DMI region
> - Also fix unused function warning by adding __always_inline.
> - Link to v1: https://lore.kernel.org/r/20250528-for-upstream-not-instan=
tiate-spd5118-v1-1-8216e2d38918@canonical.com
> ---
>   drivers/i2c/busses/i2c-i801.c | 28 +++++++++++++++++++++++-----
>   1 file changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801=
.c
> index a7f89946dad41..2a56396d88c29 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -978,6 +978,14 @@ static void i801_disable_host_notify(struct i801_pr=
iv *priv)
>   	iowrite8(priv->original_slvcmd, SMBSLVCMD(priv));
>   }
>  =20
> +static inline __maybe_unused void __i801_register_spd(struct i801_priv =
*priv)
> +{
> +	if (priv->original_hstcfg & SMBHSTCFG_SPD_WD)
> +		i2c_register_spd_write_disable(&priv->adapter);
> +	else
> +		i2c_register_spd_write_enable(&priv->adapter);
> +}
> +
>   static const struct i2c_algorithm smbus_algorithm =3D {
>   	.smbus_xfer	=3D i801_access,
>   	.functionality	=3D i801_func,
> @@ -1157,6 +1165,19 @@ static void dmi_check_onboard_devices(const struc=
t dmi_header *dm, void *adap)
>   	}
>   }
>  =20
> +#ifdef CONFIG_I2C_I801_MUX
> +static void i801_register_spd(struct i801_priv *priv)
> +{
> +	if (!priv->mux_pdev)
> +		__i801_register_spd(priv);
> +}
> +#else
> +static void i801_register_spd(struct i801_priv *priv)
> +{
> +	__i801_register_spd(priv);
> +}
> +#endif
> +
>   /* Register optional targets */
>   static void i801_probe_optional_targets(struct i801_priv *priv)
>   {
> @@ -1177,10 +1198,7 @@ static void i801_probe_optional_targets(struct i8=
01_priv *priv)
>   		dmi_walk(dmi_check_onboard_devices, &priv->adapter);
>  =20
>   	/* Instantiate SPD EEPROMs unless the SMBus is multiplexed */
> -#ifdef CONFIG_I2C_I801_MUX
> -	if (!priv->mux_pdev)
> -#endif
> -		i2c_register_spd_write_enable(&priv->adapter);
> +	i801_register_spd(priv);
>   }
>   #else
>   static void __init input_apanel_init(void) {}
> @@ -1283,7 +1301,7 @@ static int i801_notifier_call(struct notifier_bloc=
k *nb, unsigned long action,
>   		return NOTIFY_DONE;
>  =20
>   	/* Call i2c_register_spd for muxed child segments */
> -	i2c_register_spd_write_enable(to_i2c_adapter(dev));
> +	__i801_register_spd(priv);
>  =20
>   	return NOTIFY_OK;
>   }
>
> ---
> base-commit: 0bb71d301869446810a0b13d3da290bd455d7c78
> change-id: 20250526-for-upstream-not-instantiate-spd5118-463225b346a0
>
> Best regards,
