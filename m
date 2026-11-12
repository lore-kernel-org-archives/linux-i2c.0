Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449924;
	b=BplQ31FkvO5R3vrOmOgwXATGJMAdd6tAor7H2yQIKBAvuXxBClzfz2vQ9nucFrfWxrB+
	 wFdya/M68qlBFAOcemXYGMBZ9AEWDJBhfA8nYyw0tAaUrRJi4A4lqQCI1T5UeWgNb6AAj
	 e9xzQUGXWTncZbltZXKSvvE0913PZ7EuYZWd9NT9yVrSacte2jJ7Lc/9tMw9l5yisV+py
	 ZTq054omkNv4OULT4MGN/uIKUzBDxlHbMPa/CpPPft6aic303mEvDoFQk7Ev0zu1h5Rkd
	 E1fCYvUPtqeSKQoKCWRy28YFCyFcmSOCd5+iRft6/Hy/SciLMYaWCnrnB7pmA8zQsJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449924;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=VOYcCcAR5BaO17AihNTISMUFMiS2g+MRrRsWRCv0bFQ=;
	b=BKc9PZ/txX0lRmRYqqCFEZQZQoqlfEZZoAOpXpqjxA85rhGImULsKEv1ZcpKlQWfL3p8
	 VO6kOGmPA0f3x1GVdTQFdxS4K8OQWvycU3GLxcOI7VYN/1RtCwGA3sVW9A73/vKUj6tN5
	 yrPqNthLuUyo1uo6kNc0eNO0QDImlNTspz3bcAjbuQTiQsBAwEDGb8/Ys8/2v4B8ju25d
	 pRt8P1QxnCoqGQNiT6yAYDIjnBUm97yrBUybuMDOjqMJFIcLcZW3QAYVd1J03YXy8Xrr6
	 AZuB4vvoHWbV76eJKcIIAtPYzKY2mLIIIYmOwEIyLiTRMbGjsaBALf63E7Bhfig8Kvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=xhkicw7qovbovaejxwtcxvp22q.protonmail2 header.b=YiZ4hAOa;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA69606A331
	for <linux-i2c@vger.kernel.org>; Thu, 12 Nov 2026 02:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAA69606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=xhkicw7qovbovaejxwtcxvp22q.protonmail2 header.b=YiZ4hAOa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xhkicw7qovbovaejxwtcxvp22q.protonmail2; t=1794449919;
	x=1794709119; bh=VOYcCcAR5BaO17AihNTISMUFMiS2g+MRrRsWRCv0bFQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YiZ4hAOavOrw9A3dspvgcbGZZ0xrEzbPu5UwU77kV+cx8xK1k8ke0jA1/5YOzMzT3
	 uNIo60oD/EzUiepWM7kLpqGjWk5JI4D4I2TA8Vz938g7k67iWtsHYL5ezXHwHjBB3f
	 OacH1wTsVjg6KFq4vV14fzC5y/zk52aKtLC0sRi+R9JOU8Dwl+OXldQpKgyZDkCWs1
	 pLEOd/YE6O676tKLzB07UduNM7OTFlGxM5X9IRIVdPoJJ3xufUTbQ5LruG9FBZBUJA
	 n2RWvSv1hSJR7r4/hvLa+ABg4ThLV+DkxjJxNvKwFLFpf8vZwHlVVfv+gZq9gPtr8y
	 F5g83S7FKxo7A==
Date: Thu, 12 Nov 2026 02:18:35 +0000
To: Mika Westerberg <mika.westerberg@linux.intel.com>
From: penhouse24@proton.me
Cc: "westeri@kernel.org" <westeri@kernel.org>, "andi.shyti@kernel.org" <andi.shyti@kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [BUG] i2c: acpi: Dell XPS 17 9720 ELAN 04F3:311C touchpad (VEN_04F3) needs 100 kHz like DLL0945
Message-ID: <iZI_luLf6KPDE7sZSzG-aRF3V1fJFh7moD99YLp6nXVGLKgHTGMY_fnseRx1glU4YXGKNN3zKxSkitJW1MxfxR8WWGb1fegxZnOmq4VArTo=@proton.me>
In-Reply-To: <20261111075931.GG259790@black.igk.intel.com>
References: <CYQ1dYF3ZUj0L_VRzN490SfuHRaulkT_y5NWcIEIl8OtpIgWgXyOlwEyUqZD_uz9bmVBXM2uLOo8bkyzcR-qCxNObstCqFUlK6lUYXK5euE=@proton.me> <20261109104542.GL176724@black.igk.intel.com> <lGd7ChJVtwyvhMVkRinryqLG3Lx32U7xoSjT4_inKH1pBNoAd4dvBKV1A4i9MOIVLKmgx8sVg98gfK-iUwb5Uoy0wX1CM2_c7I1vdTr2tYU=@proton.me> <20261111075931.GG259790@black.igk.intel.com>
Feedback-ID: 217801480:user:proton
X-Pm-Message-ID: fca8eeead4ee04356d57caeb6ca1968a1c244614
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Mika,=20


Tested on top of v7.4-rc2 (067c5c24cef2) on a Dell XPS 17 9720, BIOS 1.41.0=
, without the SSDT override.

The quirk is applied at boot.

I've been using my laptop all day and the touchpad lag has not come back so=
 far including on AC power. On the unpatched kernel it returns as before.

Interestingly enough, I did use an off-brand AC charger for my laptop and t=
he touchpad lag returned on the patched and unpatched Linux kernels AND Win=
dows. When I used the Dell AC charger, the lag was gone on the patched kern=
el and Windows, but remained on the unpatched kernel. Perhaps the root caus=
e of this problem, on Linux relative to Windows is that Windows aggressivel=
y filters noise without smoothing? Not sure, just a thought

One question about the DMI match: does it need DMI_BIOS_VERSION? The VEN_04=
F3 ID check already makes the quirk stop applying if a future BIOS switches=
 to a proper ACPI ID. The 400 kHz problem also seems to be in the touchpad =
itself, since the same 04F3:311C part is affected on the Precision 5560. Ma=
tching only on sys_vendor and product_name would also cover users on older =
BIOS versions, and any newer BIOS that still reports VEN_04F3.

Dell also ships the same BIOS image for the Precision 5770, so it likely ex=
poses the same ID, though I can't test that model.

Thanks for the quick patch!



On Wednesday, November 11th, 2026 at 2:59 AM, Mika Westerberg <mika.westerb=
erg@linux.intel.com> wrote:

> Hi,
>=20
> On Mon, Nov 09, 2026 at 08:57:13PM +0000, penhouse24@proton.me wrote:
> > Hi Mika,
> >
> > Thank you for the response (I honestly wasn't expecting anyone to respo=
nd for this niche issue---so a welcome surprise).
> >
> > Yes my BIOS version (v1.41.0) is up to date. Currently, there are no up=
dates available through Windows or from fwupd. I have received BIOS updates=
 many times via Windows since purchasing this computer in 2022 and have had=
 0 change to this problem.
> >
> > For what it=E2=80=99s worth, the DSDT has a valid default ID. TPD0 star=
ts with Name (ITPN, =E2=80=9CDELL0AFF=E2=80=9D), and _INI then overwrites i=
t from the BIOS-provided TPHD variable, which yields =E2=80=9CVEN_04F3=
=E2=80=9D.
> >
> > Please find attached the output of 'sudo dmidecode'.
> >
> > Thank you for helping me fix this.
>=20
> Can you try the below patch?
>=20
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 84841ed13487..bed9260056b3 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -7,6 +7,7 @@
>=20
>  #include <linux/acpi.h>
>  #include <linux/device.h>
> +#include <linux/dmi.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/list.h>
> @@ -356,6 +357,17 @@ static const struct acpi_device_id i2c_acpi_force_40=
0khz_device_ids[] =3D {
>  =09{ }
>  };
>=20
> +static const struct dmi_system_id i2c_acpi_dell_xps_17_9720_dmi_ids[] =
=3D {
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "XPS 17 9720"),
> +=09=09=09DMI_MATCH(DMI_BIOS_VERSION, "1.41.0"),
> +=09=09},
> +=09},
> +=09{ }
> +};
> +
>  static const struct acpi_device_id i2c_acpi_force_100khz_device_ids[] =
=3D {
>  =09/*
>  =09 * When a 400KHz freq is used on this model of ELAN touchpad in Linux=
,
> @@ -377,6 +389,14 @@ static const struct acpi_device_id i2c_acpi_force_10=
0khz_device_ids[] =3D {
>  =09{ .id =3D "ELAN0678" },
>  =09{ .id =3D "ELAN06FA" },
>  =09{ .id =3D "ELAN1300" },
> +=09{
> +=09=09/*
> +=09=09 * Some Dell XPS 17 9720 is not using standard ACPI IDs
> +=09=09 * so we need to match also via DMI strings.
> +=09=09 */
> +=09=09.id =3D "VEN_04F3",
> +=09=09.driver_data =3D (kernel_ulong_t)i2c_acpi_dell_xps_17_9720_dmi_ids=
,
> +=09},
>  =09{ }
>  };
>=20
> @@ -385,6 +405,7 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle =
handle, u32 level,
>  {
>  =09struct i2c_acpi_lookup *lookup =3D data;
>  =09struct acpi_device *adev =3D acpi_fetch_acpi_dev(handle);
> +=09const struct acpi_device_id *id;
>=20
>  =09if (!adev || i2c_acpi_do_lookup(adev, lookup))
>  =09=09return AE_OK;
> @@ -398,7 +419,9 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle =
handle, u32 level,
>  =09if (acpi_match_device_ids(adev, i2c_acpi_force_400khz_device_ids) =3D=
=3D 0)
>  =09=09lookup->force_speed =3D I2C_MAX_FAST_MODE_FREQ;
>=20
> -=09if (acpi_match_device_ids(adev, i2c_acpi_force_100khz_device_ids) =3D=
=3D 0)
> +=09id =3D acpi_match_acpi_device(i2c_acpi_force_100khz_device_ids, adev)=
;
> +=09if (id && (!id->driver_data ||
> +=09=09   dmi_check_system((const struct dmi_system_id *)id->driver_data)=
))
>  =09=09lookup->force_speed =3D I2C_MAX_STANDARD_MODE_FREQ;
>=20
>  =09return AE_OK;
> 
