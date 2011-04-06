From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RFC][PATCH] Enable async suspend/resume of i2c devices
Date: Wed, 6 Apr 2011 06:23:35 +0100
Message-ID: <20110406052335.GA25578@sirena.org.uk>
References: <BANLkTik7i0VQpJb+enUd9c4-XvZQ1S57fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BANLkTik7i0VQpJb+enUd9c4-XvZQ1S57fQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 04, 2011 at 08:47:01PM -0700, Sonny Rao wrote:
> This improves our resume time when we have devices on an i2c bus
> that are slow to resume.  In particular we have a light sensor that
> adds about 50ms of resume time on one device. We have to enable it
> both on the i2c master and i2c client side and then we get fully async
> suspend/resume.  I suspect we'll see nice gains on systems with more
> i2c devices and will test that out soon.
> 
> Signed-off-by: Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

It'd probably help if the patch explained why this is safe - my
immediate question is why if it's safe to just unconditionally enable
async suspend for all I2C clients and adaptors it's not safe to do so
for all devices of all types?
