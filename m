From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: ARM: shmobile: "i2c<m>" vs. "iic<n>" DT nodes and pinmux
Date: Thu, 21 Aug 2014 23:09:37 +0400
Message-ID: <53F643F1.9060409@cogentembedded.com>
References: <CAMuHMdWqnMZQcRURufCxiGpbkK7ocjH8KnECxdWVPcxN-68J4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWqnMZQcRURufCxiGpbkK7ocjH8KnECxdWVPcxN-68J4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello.

On 08/12/2014 05:11 PM, Geert Uytterhoeven wrote:

> On r8a7790, DT device nodes and C/DT pinmux data for IIC<n> are called
> "iic<n>", with DT aliases from "i2c<m>" to the "iic<n>" DT nodes.
> On r8a7791, DT device nodes and C/DT pinmux data for IIC<n> are called
> "i2c<m>", with DT aliases from "i2c<m>" to the "i2c<m>" DT nodes.

> In light of the proliferation of other members of the R-Car Gen 2 families, is
> there a plan to make this consistent?

    I can probably look at this since the SH-Mobile driver (and/or hardware?) 
is clearly of better quality than R-Car one: I'm constantly getting -ENXIO and 
-EBUSY from the latter trying to read images from ADV7180 I2C video decoder.

WBR, Sergei
