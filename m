From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c-s3c2410: Remove unconditional 1ms delay on each
 transfer
Date: Fri, 2 Apr 2010 14:13:46 +0100
Message-ID: <20100402131346.GA28023@rakim.wolfsonmicro.main>
References: <1270211946-25103-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <p2q1b68c6791004020600g283db571gacd0f8b7e4ddaf6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <p2q1b68c6791004020600g283db571gacd0f8b7e4ddaf6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jassi brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 02, 2010 at 10:00:52PM +0900, jassi brar wrote:
> On Fri, Apr 2, 2010 at 9:39 PM, Mark Brown

> > + =A0 =A0 =A0 /* first, try busy waiting briefly */
> > + =A0 =A0 =A0 spins =3D 0;
>           ^^^^^^^^^^^^ ?

Gnargh, this is bit rot from my initial version which didn't have the
fallback for the multi-master case (I don't actually have any hardware
that can trigger that).  As you can see from the fact that I was able t=
o
test this successfully most transfers report idle on the first check
anyway.

Thanks.
