From: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Subject: Re: [PATCH 0/6] i2c-davinci gpio pulsed SCL recovery with ICPFUNC
Date: Tue, 19 Apr 2011 08:20:09 -0400
Message-ID: <BANLkTinTMi76GmgO6HJ0+ifCXsHE3Mjsvg@mail.gmail.com>
References: <BANLkTi=7DbMrbo0nQU+268LC_2258q-_DA@mail.gmail.com>
	<70E876B0EA86DD4BAF101844BC814DFE093FB40998@Cloud.RL.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <70E876B0EA86DD4BAF101844BC814DFE093FB40998-lPJtnb2sqtq44ywRPIzf9A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Povey <Jon.Povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Cc: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bastian Ruppert <Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org>, "Griffis, Brad" <bgriffis-l0cyMroinI0@public.gmane.org>, Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Mon, Apr 18, 2011 at 9:47 PM, Jon Povey <Jon.Povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org> wrote:
> Ben Gardiner wrote:
>
>>>> When creating this series I noticed that there are obvious
>>>> similarities between the existing recovery routine implemented by
>>>> Philby John and John Povey
>
>> I'm not sure how the 20us in the existing method was derived -- I
>> wonder if Philby John or John Povey could comment?
>
> I've been a little bemused about why I am getting credited for I2C
> bus recovery work. I don't remember doing any work on that.

My mistake -- sorry. Also sorry for getting your name wrong repeatedly.

> I did a couple of patches to fix a race when setting up a TX, but
> those are, afaik, unrelated.

In "i2c-davinci: Fix race when setting up for TX" and "i2c-davinci:
Fix TX setup for more SoCs" you mention testing on DM355 -- is there
any you have hardware on which the recovery procedure is executed on
occasion and that you would be available to test modifications to the
current implementation?

> All I know about the bus recovery stuff is looking at it a while back
> and thinking hmm, that seems to wiggle gpio without changing the
> pinmuxing, so it can't possibly work.

:) Probably not then.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
