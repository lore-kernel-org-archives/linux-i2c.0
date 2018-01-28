From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Sun, 28 Jan 2018 16:39:25 +0200
Message-ID: <CAHp75VdWA-0a_FeicHSi_FfWurQ9EvkdW0raqgoRVySTyxDJ0Q@mail.gmail.com>
References: <20180127133209.28995-1-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:40423 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeA1Oj1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 28 Jan 2018 09:39:27 -0500
In-Reply-To: <20180127133209.28995-1-pali.rohar@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>

On Sat, Jan 27, 2018 at 3:32 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> Dell platform team told us that some (DMI whitelisted) Dell Latitude
> machines have ST microelectronics accelerometer at i2c address 0x29.
>
> Presence of that ST microelectronics accelerometer is verified by existen=
ce
> of SMO88xx ACPI device which represent that accelerometer. Unfortunately
> ACPI device does not specify i2c address.
>
> This patch registers lis3lv02d device for selected Dell Latitude machines
> at i2c address 0x29 after detection. And for Dell Vostro V131 machine at
> i2c address 0x1d which was manually detected.
>
> Finally commit a7ae81952cda ("i2c: i801: Allow ACPI SystemIO OpRegion to
> conflict with PCI BAR") allowed to use i2c-i801 driver on Dell machines s=
o
> lis3lv02d correctly initialize accelerometer.
>
> Tested on Dell Latitude E6440.

> +static acpi_status check_acpi_smo88xx_device(acpi_handle obj_handle,
> +                                            u32 nesting_level,
> +                                            void *context,
> +                                            void **return_value)
> +{
> +       struct acpi_device_info *info;
> +       acpi_status status;
> +       char *hid;
> +
> +       status =3D acpi_get_object_info(obj_handle, &info);
> +       if (!ACPI_SUCCESS(status) || !(info->valid & ACPI_VALID_HID))
> +               return AE_OK;
> +
> +       hid =3D info->hardware_id.string;
> +       if (!hid)
> +               return AE_OK;
> +
> +       if (strlen(hid) < 7)
> +               return AE_OK;
> +
> +       if (memcmp(hid, "SMO88", 5) !=3D 0)
> +               return AE_OK;
> +
> +       *((bool *)return_value) =3D true;
> +       return AE_CTRL_TERMINATE;
> +}
> +
> +static bool is_dell_system_with_lis3lv02d(void)
> +{

> +       /*
> +        * Check that ACPI device SMO88xx exists and is enabled. That ACP=
I
> +        * device represent our ST microelectronics lis3lv02d acceleromet=
er but
> +        * unfortunately without any other information (like i2c address)=
.
> +        */

Isn't it simple

return acpi_dev_present("SMO88", NULL, -1);

call?

> +       found =3D false;
> +       status =3D acpi_get_devices(NULL, check_acpi_smo88xx_device, NULL=
,
> +                                 (void **)&found);
> +       if (!ACPI_SUCCESS(status) || !found)
> +               return false;
> +
> +       return true;
> +}


--=20
With Best Regards,
Andy Shevchenko
