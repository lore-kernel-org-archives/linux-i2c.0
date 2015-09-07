From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: i2ctransfer (Was: [PATCH 0/8] i2c: img-scb: fixes to support
 i2c on pistachio)
Date: Mon, 7 Sep 2015 23:13:07 +0200
Message-ID: <20150907231307.726ba236@endymion.delvare>
References: <1437997641-32575-1-git-send-email-sifan.naeem@imgtec.com>
	<20150731111252.GL1522@katana>
	<CAAEAJfCW9cEMDZwta5Q6VVEZfzxTDZ50Fx=YeW6bPMnrtKNcbw@mail.gmail.com>
	<20150907135037.GA4986@katana>
	<CAAEAJfBj+qdv58gzOnqMrmN0486Enzbn3G1L0KhMctMkEkXfTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAEAJfBj+qdv58gzOnqMrmN0486Enzbn3G1L0KhMctMkEkXfTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 7 Sep 2015 11:22:23 -0300, Ezequiel Garcia wrote:
> On 7 September 2015 at 10:50, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> >
> >> > That sounds like good testing \o/ If you are happy with i2ctransfer,
> >> > then please consider adding Tested-by tags to the i2ctransfer patches,
> >> > so Jean gets a more cosy feeling to include them to i2ctools.
> >> >
> >>
> >> Definitely! i2ctransfer was a HUGE help while developing this driver,
> >> specially when preparing involved transfers to test repeated starts.
> >
> > Glad to hear that! I also discovered and fixed a corner case in repeated
> > start handling recently in the i2c-rcar driver thanks to i2ctransfer.
> >
> >> Any chance it gets merged in its current state? I think it'll be useful, even
> >> if the usage cli API is still a moving target.
> >
> > I don't think it is anymore TBH. Not more than any other tool.
> >
> > Waiving to Jean \o_ :)
> 
> OK, let me wave as well \\O//

Review in progress, will continue tomorrow.

-- 
Jean Delvare
SUSE L3 Support
