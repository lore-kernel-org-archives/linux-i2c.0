From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 5/9] i2c: rcar: init new messages in irq
Date: Fri, 23 Oct 2015 16:14:09 +0300
Message-ID: <3725918.YSMPQz70Zm@avalon>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de> <36149610.Eic43bQLgJ@avalon> <20151023121439.GK13380@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:48685 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbbJWNOH (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 23 Oct 2015 09:14:07 -0400
In-Reply-To: <20151023121439.GK13380@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hi Wolfram,

On Friday 23 October 2015 14:14:39 Wolfram Sang wrote:
> > > :/ Let me know if I can send you debug output.
> > 
> > What's the exact issue ?
> 
> Best report ever: I simply don't get a picture :) No warnings, no
> messages. I think we want to make sure my HDMI->DVI converter is proper,
> though.

Does it work with other HDMI sources ?

> > > > .config attached.
> > > 
> > > That one also probes for me... I only disabled DHCP and added my
> > > initramfs. I patched the fbdev build error out and changed Lager dts to
> > > use i2c-rcar (instead of i2c-sh_mobile).
> 
> I made the ADV7180 and AK4642 built-in and this kernel still probes
> rcar-du on my Lager and Magnus' Koelsch...

It's CONFIG_DRM_I2C_ADV7511 that you need for HDMI output.

I have ADV7180 and AK4642 built as modules in my kernel.

> >           <idle>-0     [000] d.h1     1.498063: rcar_i2c_irq: msr 09090909
> >           <idle>-0     [000] d.h1     1.498075: rcar_i2c_irq: msr 08080808
> >           <idle>-0     [000] d.h1     1.498266: rcar_i2c_irq: msr 07070707
> >           <idle>-0     [000] d.h1     1.498348: rcar_i2c_irq: msr 06060606
> >           <idle>-0     [000] d.h1     1.498465: rcar_i2c_irq: msr 49494949
> 
> So, here is the NACK bit set. Which does not happen on my Lager and
> Magnus' Koelsch. I am starting to wonder if you have a board with HW
> issues?

It works fine when reverting this patch :-/

> Could it be another I2C device interfering?

I wouldn't rule anything out, but I don't see why reverting this patch would 
help then.

> Do you happen to know if you have an earlier revision of Koelsch?

RTPORC7791SEB00010S
KOELSCH SN.057

I'm not sure if that tells anything about the board revision.

-- 
Regards,

Laurent Pinchart
