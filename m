From: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH -next] i2c: fix i2c-ismt.c printk format warning
Date: Fri, 15 Feb 2013 14:08:21 -0500
Message-ID: <20130215190821.GA31316@hmsreliant.think-freely.org>
Reply-To: 511E83BC.3050007-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>Fix printk format warning.  dma_addr_t can be 32-bit or 64-bit,
>so cast it to long long for printing.  This also matches the
>printk format specifier that is already used.
>
>drivers/i2c/busses/i2c-ismt.c:532:3: warning: format '%llX' expects argument of type \
>'long long unsigned int', but argument 4 has type 'dma_addr_t' [-Wformat]
>
>Signed-off-by: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
>Cc:	Bill E. Brown <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>Cc:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>Cc:	Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>Cc:	Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
>Cc:	Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>Cc:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Acked-by: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
