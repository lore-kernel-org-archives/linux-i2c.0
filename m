From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] x86: Add basic support for the Congatec CGEB BIOS interface
Date: Mon, 25 Mar 2013 09:31:35 +0100
Message-ID: <CAH9NwWdOCo642KqUXk1y5hbwdtW5RYgQnQfZFUEe4FOJzSiByQ@mail.gmail.com>
References: <1360663374-30951-1-git-send-email-s.hauer@pengutronix.de> <1360663374-30951-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360663374-30951-2-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sascha


> +struct cgeb_pdata {
> +       struct cgeb_board_data          *board;
> +       int unit;
> +};
> +
> +#endif /* __CONGATEC_CGEB_H */
> diff --git a/arch/x86/platform/Makefile b/arch/x86/platform/Makefile
> index 8d87439..9de1789 100644
> --- a/arch/x86/platform/Makefile
> +++ b/arch/x86/platform/Makefile
> @@ -1,5 +1,6 @@
>  # Platform specific code goes here
>  obj-y  += ce4100/
> +obj-y  += congatec/
>  obj-y  += efi/
>  obj-y  += geode/
>  obj-y  += iris/


Fails to build


christian@chgm-pc:~/kernel/linux_mainline$ make
make[1]: Nothing to be done for `all'.
make[1]: Nothing to be done for `relocs'.
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CC      scripts/mod/devicetable-offsets.s
  GEN     scripts/mod/devicetable-offsets.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTLD  scripts/mod/modpost
  CHK     include/generated/compile.h
scripts/Makefile.build:44:
/home/christian/kernel/linux_mainline/arch/x86/platform/congatec/Makefile:
No such file or directory
make[3]: *** No rule to make target
`/home/christian/kernel/linux_mainline/arch/x86/platform/congatec/Makefile'.
 Stop.
make[2]: *** [arch/x86/platform/congatec] Error 2
make[1]: *** [arch/x86/platform] Error 2
make: *** [arch/x86] Error 2


--
Christian Gmeiner, MSc
