From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] i2c: sis630: correct format strings
Date: Mon, 4 Mar 2019 10:16:41 -0800
Message-ID: <CAKwvOdn3_xXm09V8PPdfwkV7CMxGDxgODK3an3HuPiRBBzGM1w@mail.gmail.com>
References: <20190302141836.24638-1-louis@kragniz.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190302141836.24638-1-louis@kragniz.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Louis Taylor <louis@kragniz.eu>
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, clang-built-linux@googlegroups.com, Jon Flatley <jflat@chromium.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, Mar 2, 2019 at 6:19 AM Louis Taylor <louis@kragniz.eu> wrote:
>
> When compiling with -Wformat, clang warns:
>
> drivers/i2c/busses/i2c-sis630.c:482:4: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                         smbus_base + SMB_STS,
>                         ^~~~~~~~~~~~~~~~~~~~
>
> drivers/i2c/busses/i2c-sis630.c:483:4: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                         smbus_base + SMB_STS + SIS630_SMB_IOREGION - 1);
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> drivers/i2c/busses/i2c-sis630.c:531:37: warning: format specifies type
>       'unsigned short' but the argument has type 'int' [-Wformat]
>                  "SMBus SIS630 adapter at %04hx", smbus_base + SMB_STS);
>                                           ~~~~~   ^~~~~~~~~~~~~~~~~~~~
>
> This patch fixes the format strings to use the format type for int.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  drivers/i2c/busses/i2c-sis630.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
> index 1e6805b5cef2..a57aa4fe51a4 100644
> --- a/drivers/i2c/busses/i2c-sis630.c
> +++ b/drivers/i2c/busses/i2c-sis630.c
> @@ -478,7 +478,7 @@ static int sis630_setup(struct pci_dev *sis630_dev)
>         if (!request_region(smbus_base + SMB_STS, SIS630_SMB_IOREGION,
>                             sis630_driver.name)) {
>                 dev_err(&sis630_dev->dev,
> -                       "I/O Region 0x%04hx-0x%04hx for SMBus already in use.\n",
> +                       "I/O Region 0x%04x-0x%04x for SMBus already in use.\n",
>                         smbus_base + SMB_STS,

Even additions with 0x00 imply integer promotions (my least favorite part of C).
Thanks for the cleanup.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
