From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Handle i2c DMA failure properly
Date: Wed, 14 Nov 2012 13:13:43 -0200
Message-ID: <CAOMZO5AVDXeu59ZwB35k_0yYx5XwTzdmtj+QXXEoQRMs7Br-KA@mail.gmail.com>
References: <1352903508-18113-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352903508-18113-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tim Michals <tcmichals-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Marek,

On Wed, Nov 14, 2012 at 12:31 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> Properly terminate the DMA transfer in case the DMA PIO transfer
> or setup fails for any reason. While at it, enable support for
> SMBUS_QUICK. This essentially fixes i2c-detect on this IP.

Shouldn't this be split into two patches?

Regards,

Fabio Estevam
