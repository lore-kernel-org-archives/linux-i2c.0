From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] i2c: designware: Fix bogus sda_hold_time due to uninitialized vars
Date: Mon, 22 May 2017 08:02:29 +0200
Message-ID: <8F61EF18-169A-4FB5-B9C7-9A2ACD4C92B4@linaro.org>
References: <20170519085640.15111-1-ard.biesheuvel@linaro.org> <CAKv+Gu9x_KCdEGBBOw9yaYOcYBcYtxJX-xTX=4kQuWqY=VK0PA@mail.gmail.com> <743ebd23-17ab-03d2-ebd9-66acc9aee417@siemens.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35207 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdEVGCd (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 May 2017 02:02:33 -0400
Received: by mail-wm0-f51.google.com with SMTP id b84so285569294wmh.0
        for <linux-i2c@vger.kernel.org>; Sun, 21 May 2017 23:02:32 -0700 (PDT)
In-Reply-To: <743ebd23-17ab-03d2-ebd9-66acc9aee417@siemens.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



> On 22 May 2017, at 07:46, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>=20
> We need to initializes those variables to 0 for platforms that do not
> provide ACPI parameters. Otherwise, we set sda_hold_time to random
> values, breaking e.g. Galileo and IOT2000 boards.
>=20
> Fixes: 9d6408433019 ("i2c: designware: don't infer timings described by AC=
PI from clock rate")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>=20
> Affects 4.12-rc2.
>=20
> drivers/i2c/busses/i2c-designware-platdrv.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/bus=
ses/i2c-designware-platdrv.c
> index 6283b99d2b17..d1263b82d646 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -94,9 +94,9 @@ static void dw_i2c_acpi_params(struct platform_device *p=
dev, char method[],
> static int dw_i2c_acpi_configure(struct platform_device *pdev)
> {
>    struct dw_i2c_dev *dev =3D platform_get_drvdata(pdev);
> +    u32 ss_ht =3D 0, fp_ht =3D 0, hs_ht =3D 0, fs_ht =3D 0;
>    acpi_handle handle =3D ACPI_HANDLE(&pdev->dev);
>    const struct acpi_device_id *id;
> -    u32 ss_ht, fp_ht, hs_ht, fs_ht;
>    struct acpi_device *adev;
>    const char *uid;
>=20
