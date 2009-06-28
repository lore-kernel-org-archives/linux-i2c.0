From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: 2.6.31-rc1 build failure: i2c-designware.ko
Date: Sun, 28 Jun 2009 21:01:18 +0200
Message-ID: <20090628210118.15739fbc@hyperion.delvare>
References: <4A47BB88.3090407@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A47BB88.3090407-ZTO5kqT2PaM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tilman Schmidt <tilman-ZTO5kqT2PaM@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 28 Jun 2009 20:50:48 +0200, Tilman Schmidt wrote:
> I encountered this modpost failure building 2.6.31-rc1:
> 
> Kernel: arch/x86/boot/bzImage is ready  (#2)
>   Building modules, stage 2.
>   MODPOST 1218 modules
> ERROR: "clk_enable" [drivers/i2c/busses/i2c-designware.ko] undefined!
> ERROR: "clk_get" [drivers/i2c/busses/i2c-designware.ko] undefined!
> ERROR: "clk_put" [drivers/i2c/busses/i2c-designware.ko] undefined!
> ERROR: "clk_disable" [drivers/i2c/busses/i2c-designware.ko] undefined!
> ERROR: "clk_get_rate" [drivers/i2c/busses/i2c-designware.ko] undefined!
> WARNING: modpost: Found 12 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
> make[1]: *** [__modpost] Fehler 1
> make: *** [modules] Fehler 2
> 
> Config attatched.

Already reported half a dozen times, and already fixed:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=47749b14e55cd167632f9a27a4fc439e591e5268

-- 
Jean Delvare
