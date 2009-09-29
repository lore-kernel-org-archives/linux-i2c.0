From: Richard Zhao <linuxzsc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: check busy bit when START/STOP
Date: Tue, 29 Sep 2009 23:14:42 +0800
Message-ID: <4e090d470909290814v292487f4l2ff3323bec145def@mail.gmail.com>
References: <4e090d470909290441i7016c4f4g9a929d78838f9b7@mail.gmail.com>
	 <20090929132505.GM27039@pengutronix.de>
	 <4e090d470909290654r6fb36cb4h505662c7cb84b1f8@mail.gmail.com>
	 <20090929142440.GF32420@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090929142440.GF32420-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 29, 2009 at 10:24 PM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Tue, Sep 29, 2009 at 09:54:05PM +0800, Richard Zhao wrote:
>> On Tue, Sep 29, 2009 at 9:25 PM, Sascha Hauer <s.hauer@pengutronix.d=
e> wrote:
>
>> > I think it's generally a good idea to start/stop the clocks when n=
eeded
>> > as you do here. It should be an extra patch though.
>
>> You think I should split the patch to three: IBB, reg_dump, clk dis/=
en ?
>> The idea is good, more easy to revert. but sometimes, I think it mak=
e
>> small things too complex.
>
> Keeping small things simple is half the reason for doing this - it's =
not
> just bisection, it's also the fact that it's much easier to read and
> understand a small patch that does one thing than it is to do the sam=
e
> with a large patch which makes several unrelated changes. =A0When sev=
eral
> changes are lumped in together it's harder to see the complete versio=
n
> of any one change in isolation and more effort is required to work ou=
t
> which goals are being accomplished with any given chunk of the patch.
>

Thank you all!
If you don't have other comments, I will split the patch and send out
again tomorrow.

Thanks
Richard
