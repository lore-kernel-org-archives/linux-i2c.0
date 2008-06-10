From: Uli Luckas <u.luckas@road.de>
Subject: Re: Frame buffers and early i2c
Date: Tue, 10 Jun 2008 11:31:19 +0200
Message-ID: <200806101131.19763.u.luckas@road.de>
References: <200806091647.42757.u.luckas@road.de> <200806092359.36080.u.luckas@road.de> <20080610082527.0e6d643a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758697AbYFJJbc@vger.kernel.org>
In-Reply-To: <20080610082527.0e6d643a@hyperion.delvare>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, adaplas@gmail.com, Linux I2C <i2c@lm-sensors.org>, Ryan Mallon <ryan@bluewatersys.com>, David Brownell <david-b@pacbell.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Eric Miao <eric.y.miao@gmail.com>
List-Id: linux-i2c@vger.kernel.org

On Tuesday, 10. June 2008, Jean Delvare wrote:
> Hi Uli,
>
> On Mon, 9 Jun 2008 23:59:35 +0200, Uli Luckas wrote:
> > On Monday 09 June 2008, Jean Delvare wrote:
> > > Why don't you ask on the i2c mailing list? Cc added.
> >
> > I wanted to get i2c developers plus frame buffer and other i2c client
> > developers involved. Crossposting to more then 2 lists seemed wrong.
>
> So you prefer to post to one random list than the two lists where your
> target audience is? Interesting approach. If you really don't want to
> post to two lists at once, just send two separate posts?
>
And have two seperate threads of communication??? lfml is where they all are 
and avery maintainer has different preferences. Anyway, I got your point and 
will come to the i2c list in the future if you prefere.

> > I'll change the pxa i2c driver to subsys_initcall and try if that works
> > when I get back to my desk tomorrow.
>
> I expect it to work, as apparently other platforms are doing exactly
> that already.
>
Just changing the initcall to subsys really did the trick. I thought, this was 
the first thing I tried and I thought it crashed my device. But obviousely I 
had some other problem.
If Russell gives his Ack, could this be pushed upstream through i2c?

regards,
Uli



Initialize the pxa i2c bus during subsystem initialization to make it
available during driver initialization (e.g. display powerup for pxafb).

Signed-off-by: Uli Luckas <u.luckas@road.de>
---
 drivers/i2c/busses/i2c-pxa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index eb69fba..78c0fc4 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1134,5 +1134,5 @@ static void __exit i2c_adap_pxa_exit(void)
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:pxa2xx-i2c");
 
-module_init(i2c_adap_pxa_init);
+subsys_initcall(i2c_adap_pxa_init);
 module_exit(i2c_adap_pxa_exit);
-- 

------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 64 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing directors: Hans-Peter Constien, Hubertus von Streit
