From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC V2 03/12] i2c: at91: make use of the new infrastructure for
 quirks
Date: Mon, 9 Mar 2015 17:11:57 +0100
Message-ID: <20150309161157.GW9132@odux.rfo.atmel.com>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-4-git-send-email-wsa@the-dreams.de>
 <20150308082845.GB1904@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150308082845.GB1904@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Sun, Mar 08, 2015 at 09:28:45AM +0100, Wolfram Sang wrote:
> On Wed, Feb 25, 2015 at 05:01:54PM +0100, Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
> 
> Hi Ludovic,
> 
> if you have a few minutes, could you please test this series? I'd like to
> include it in 4.1. and because at91 is using the quirk infrastructure in
> a more complex way, it is a really good test candidate.

It was in the pipe. I have reviewed it, this second version seems to be
good. I am just waiting a bit more to give you my ack since I have some
issues to read an i2c eeprom (it works with a temperature sensor).
I am investigating if it doesn't come from a previous regression.

> 
> Thanks,
> 
>    Wolfram
> 

Regards

Ludovic
