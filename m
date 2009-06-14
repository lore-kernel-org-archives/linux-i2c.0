From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] Make stu300 driver depend on MACH_U300
Date: Mon, 15 Jun 2009 00:20:21 +0100
Message-ID: <20090614232021.GL20446@fluff.org.uk>
References: <1245018618-19238-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1245018618-19238-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org
Cc: ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 15, 2009 at 12:30:18AM +0200, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org wrote:
> From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> 
> This makes the stu300 driver for the ST Micro ST DDC I2C bus
> driver depend on MACH_U300, new platforms reusing this I2C
> driver will need to add in a similar dependency.
> 
> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

applied, thanks

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
