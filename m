From: "Masayuki Ohtake" <masa-korg-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Subject: Re: [MeeGo-Dev][PATCH] Topcliff: Update PCH_I2C driver to 2.6.35
Date: Mon, 6 Sep 2010 09:44:08 +0900
Message-ID: <000b01cb4d5c$a25a2da0$66f8800a@maildom.okisemi.com>
References: <4C80CBC0.5050908@dsn.okisemi.com> <20100903133613.1c519c49@lxorguk.ukuu.org.uk> <20100903122619.GC4813@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Tomoya MORINAGA <morinaga526-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram Sang,

Thank you for your comments.
We will update and resubmit soon.

Thanks, Ohtake(OKISemi)
----- Original Message ----- 
From: "Wolfram Sang" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: "Alan Cox" <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: "Masayuki Ohtak" <masa-korg-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>; "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>; "Ben Dooks
(embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>; "Crane Cai" <crane.cai-5C7GfCeVMHo@public.gmane.org>; "Samuel Ortiz" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>;
"Linus Walleij" <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>; "Ralf Baechle" <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>; "srinidhi kasagar"
<srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>; <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>;
<yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; <andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; "Tomoya
MORINAGA" <morinaga526-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>; "Arnd Bergmann" <arnd-r2nGTMty4D4@public.gmane.org>
Sent: Friday, September 03, 2010 9:26 PM
Subject: Re: [MeeGo-Dev][PATCH] Topcliff: Update PCH_I2C driver to 2.6.35
