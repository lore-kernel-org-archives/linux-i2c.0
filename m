From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: Waiting until probe of i2c driver is done
Date: Tue, 22 Nov 2011 14:37:00 +0000
Message-ID: <20111122143700.GE6624@sirena.org.uk>
References: <CAH9NwWdLH32zMqzr8qsEb-HaW9sBAGHxHiBVdpTdhGsnjzwQZg@mail.gmail.com>
 <CAH9NwWfev2DWQpNj=4Hb55DOK-_i=U24uB=aawszakeAGPC6qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAH9NwWfev2DWQpNj=4Hb55DOK-_i=U24uB=aawszakeAGPC6qw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 22, 2011 at 02:09:02PM +0100, Christian Gmeiner wrote:

> I found a solution, but it feels more like a hack :)
> I am using the setup callback of the pca953x driver to register
> all needed platform devices. Is there a better way?

Not at present, Linux currently doesn't have a good way to handle probe
ordering.
