From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c devices
Date: Wed, 6 Apr 2011 10:23:13 +0200
Message-ID: <20110406102313.401e2e6c@endymion.delvare>
References: <BANLkTik7i0VQpJb+enUd9c4-XvZQ1S57fQ@mail.gmail.com>
	<20110406052335.GA25578@sirena.org.uk>
	<20110406095240.410b4e7e@endymion.delvare>
	<BANLkTimaRdRNOYM43AhjrU70o=GL0Q-D-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTimaRdRNOYM43AhjrU70o=GL0Q-D-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 6 Apr 2011 01:16:07 -0700, Sonny Rao wrote:
> On Wed, Apr 6, 2011 at 12:52 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > Sonny, on how many systems did you test it? In particular, did you test
> > it on several TV cards (which use I2C a lot and sometimes in complex
> > setups)?
> 
> It has only been tested on my x86 system with the light sensor and
> lightly tested on an ARM system with about 6-7 i2c devices.  I was hoping
> the change would help the ARM systems because they make much
> heavier use of i2c than the x86 system.  I haven't tested on anything
> like multiple TV cards because I don't have such a setup -- the ARM
> boxes with several i2c devices is the most complex user of i2c I have
> at the moment.

I meant several TV card models, individually. I don't expect testing
many at once to reveal any problem that individual testing wouldn't
have.

-- 
Jean Delvare
