From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: I2C controller i2c-mv64xxx.c not compliant
Date: Fri, 11 Feb 2011 15:04:32 +0100
Message-ID: <4D5541F0.3020304@gmx.de>
References: <20101115145406.GE3372@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101115145406.GE3372-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Rodolfo,

Rodolfo Giometti said the following:
> I'm using a ltc4266 (PoE chip) with the Marvell i2c controller (CPU
> Feroceon 88FR131).

you already solved your issue, but where did you get register and
functional description of LTC from? Is it under NDA? I couldn't find it
in the web, just a file named 4266fa.pdf not specifying registers. Are
you willing to share your driver?

-- 
KR
Michael
