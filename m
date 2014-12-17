From: arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org (Arnaud Ebalard)
Subject: Re: [PATCHv2 2/8] dt-bindings: use isil prefix for Intersil in I2C trivial-devices.txt
Date: Wed, 17 Dec 2014 22:59:07 +0100
Message-ID: <87d27i545w.fsf@natisbad.org>
References: <cover.1418763328.git.arno@natisbad.org>
	<86079cdf7325f6d83e0270d32ff66bcc3e6a34bb.1418763328.git.arno@natisbad.org>
	<20141217064610.GA1018@katana>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141217064610.GA1018@katana> (Wolfram Sang's message of "Wed,
	17 Dec 2014 07:46:11 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Darshana Padmadas <darshanapadmadas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> writes:

> On Tue, Dec 16, 2014 at 10:19:53PM +0100, Arnaud Ebalard wrote:
>> 
>> This patch fixes I2C trivial-devices.txt DT documentation file to
>> reference isil (NASDAQ symbol and the most used prefix inside the
>> kernel) for Intersil.
>> 
>> It reverts 7c75c1d5e72b ("dt-bindings: Document deprecated device
>> vendor name to fix related warning").
>> 
>> Signed-off-by: Arnaud Ebalard <arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org>
>
> Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>
> Should I take it or does it go via another tree?

No one has objected yet and MAINTAINERS file tells its under your
jurisdiction, so I guess you can take ;-)

Cheers,

a+
