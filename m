From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/1] x86/platform/intel-mid: convert to use i2c_new_client_device()
Date: Fri, 27 Mar 2020 09:37:21 +0200
Message-ID: <CAHp75VdQAReLyr3GxMH8v5hD4EhpdGSunKbdKbaLoXRmnpyYgw@mail.gmail.com>
References: <20200326211015.13654-1-wsa+renesas@sang-engineering.com> <20200326211015.13654-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200326211015.13654-2-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 26, 2020 at 11:10 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Move away from the deprecated API and return the shiny new ERRPTR where
> useful.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  arch/x86/platform/intel-mid/sfi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/platform/intel-mid/sfi.c b/arch/x86/platform/intel-mid/sfi.c
> index b8f7f193f383..30bd5714a3d4 100644
> --- a/arch/x86/platform/intel-mid/sfi.c
> +++ b/arch/x86/platform/intel-mid/sfi.c
> @@ -287,8 +287,8 @@ void intel_scu_devices_create(void)
>
>                 adapter = i2c_get_adapter(i2c_bus[i]);
>                 if (adapter) {
> -                       client = i2c_new_device(adapter, i2c_devs[i]);
> -                       if (!client)
> +                       client = i2c_new_client_device(adapter, i2c_devs[i]);
> +                       if (IS_ERR(client))
>                                 pr_err("can't create i2c device %s\n",
>                                         i2c_devs[i]->type);
>                 } else
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
