From: Oliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCHv2 1/6] i2c: sunxi: Add Allwinner A1X i2c
 driver
Date: Sun, 26 May 2013 21:05:09 +0200
Message-ID: <51A25CE5.4040901@schinagl.nl>
References: <1369563642-4390-1-git-send-email-maxime.ripard@free-electrons.com> <1369563642-4390-2-git-send-email-maxime.ripard@free-electrons.com> <51A1E9AA.4000008@schinagl.nl> <1781939.MrE9Xthq6W@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1781939.MrE9Xthq6W@flatron>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, kevin-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 05/26/13 16:44, Tomasz Figa wrote:
> Hi Oliver,
>
> I can recommend you a great tool to browse through Linux sources:
> http://lxr.free-electrons.com/source/lib/devres.c?a=arm#L107
>
> It really helps looking up in code things that you aren't sure.
>
> Best regards,
> Tomasz
>
Yeah, I'm allready a heavy user of LXR ;) But sometimes there's just 
information overload and things become hard to follow. Especially when 
there's several ways to do something.

I would have hoped that a 'ldd4' would be available which has OF support 
written in. ldd3 lacks all that.
