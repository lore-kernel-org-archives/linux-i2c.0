From: Uli Luckas <u.luckas@road.de>
Subject: Re: [i2c] Frame buffers and early i2c
Date: Tue, 10 Jun 2008 13:47:30 +0200
Message-ID: <200806101347.31003.u.luckas@road.de>
References: <200806091647.42757.u.luckas@road.de> <200806101131.19763.u.luckas@road.de> <20080610100249.GA30539@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754350AbYFJLrn@vger.kernel.org>
In-Reply-To: <20080610100249.GA30539@fluff.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: i2c@lm-sensors.org
Cc: Ben Dooks <ben@fluff.org>, David Brownell <david-b@pacbell.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, adaplas@gmail.com
List-Id: linux-i2c@vger.kernel.org


On Tuesday, 10. June 2008, Ben Dooks wrote:
> BTW, if people do have these sort of dependencies, then modules
> are another way of sorting out the load order, unless you have
> the module autoload enabled.
>
True. But my original post stated:
> In order to use the frame buffer console I have i2c and pxafb compiled in
This is one example where waiting for user space to be up and running is not 
an option.

regards,
Uli

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
