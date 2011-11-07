From: Hubert Feurstein <h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] drivers/i2c/busses/i2c-at91.c: fix brokeness
Date: Mon, 7 Nov 2011 17:36:39 +0100
Message-ID: <CAFfN3gXdqb7aKF1MiE8XAbu=seTy+9Giqs5SZcMbF2rfoDmX_Q@mail.gmail.com>
References: <alpine.DEB.2.00.1111071019560.21431@gatekeeper.vosshq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1111071019560.21431-vb1CFJ/PVqUnDeILM3HATdG/hX4sBvbD@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

sorry, but your patch still does not apply. You fixed the tab issue,
but it seems that there are still some bad whitespaces left which
corrupt your patch.

Regards
Hubert
