From: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drivers: i2c-nforce2: fix coding style issues
Date: Fri, 21 Dec 2012 15:15:08 +0100
Message-ID: <CAH7P7NgXgu0HghZqaDObf++fcsTv3TG7K1mKPnTUGzF9egvraw@mail.gmail.com>
References: <1355951171-3230-1-git-send-email-laurent.navet@gmail.com>
	<20121221110427.6e33bb9d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121221110427.6e33bb9d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> This change causes a reject because __devinit was removed by another
> patch:
> http://git.pengutronix.de/?p=wsa/linux.git;a=commit;h=cda2826abea9a78d21b5e35d71db328657b756e5

i have tested that it applies cleanly on linux-next only, will try on
pengutronix.de/git/wsa/linux.git next time.

> It's an easy one. Please resubmit with the requested changes and then
> Wolfram can apply your patch. Thanks for the good work!
Regards,
