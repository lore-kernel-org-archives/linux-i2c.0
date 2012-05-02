From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 10/11] ARM: imx6q_sabrelite: clkdev_add cko1
 for sgtl5000
Date: Tue, 1 May 2012 23:47:55 -0300
Message-ID: <CAOMZO5Ab5pYuOY4oLbkOc+SeeT6itKOMJu+zzodFOJaW5h+RuQ@mail.gmail.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
	<1335510185-7906-11-git-send-email-richard.zhao@freescale.com>
	<20120501124706.GF2194@S2101-09.ap.freescale.net>
	<20120501233939.GO2194@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120501233939.GO2194-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, May 1, 2012 at 8:39 PM, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Tue, May 01, 2012 at 08:47:10PM +0800, Shawn Guo wrote:
>> > + =C2=A0 clk_register_clkdev(cko1, NULL, "0-000a");
>>
>> This dev_id looks a little strange to me. =C2=A0I understand that's =
the
>> consequence of having sgtl5000 clock managed in ASoC machine driver
>> imx-sgtl5000.
>>
> Just realised it's not the case. =C2=A0But shouldn't the name look li=
ke
> "sgtl5000.0-000a"?

Since this is common code, we should not hardcode the I2C bus as the
codec can be connected in a I2C bus different of 0.
