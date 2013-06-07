From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] i2c: designware: fix race between subsequent xfers
Date: Fri, 7 Jun 2013 12:19:05 +0300
Message-ID: <CAHp75VfwSTO7UoEGVpd7qdFVSFNYrBG6aXx1Oj8UAkgbmi=1XQ@mail.gmail.com>
References: <1370526216-10060-1-git-send-email-christian.ruppert@abilis.com>
	<1370595083-801-1-git-send-email-christian.ruppert@abilis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1370595083-801-1-git-send-email-christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 7, 2013 at 11:51 AM, Christian Ruppert
<christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org> wrote:
> The designware block is not always properly disabled in the case of
> transfer errors. Interrupts from aborted transfers might be handled
> after the data structures for the following transfer are initialised but
> before the hardware is set up. This can corrupt the data structures to
> the point that the system is stuck in an infinite interrupt loop (where
> FIFOs are never emptied because dev->msg_read_idx == dev->msgs_num).
>
> This patch cleanly disables the designware-i2c hardware at the end of
> every transfer, be it successful or not.
>
> This patch requires https://patchwork.kernel.org/patch/2601241/ to be
> applied first.

What if you just move disabling code from i2c_dw_xfer_init() to the
top of i2c_dw_xfer() ?
Will it help?

--
With Best Regards,
Andy Shevchenko
