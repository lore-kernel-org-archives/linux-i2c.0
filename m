From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 1/1] ST DDC I2C U300 bus driver v3
Date: Sun, 14 Jun 2009 14:05:44 +0100
Message-ID: <20090614130544.GH20446@fluff.org.uk>
References: <1244922694-22026-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1244922694-22026-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org
Cc: ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

I've applied this, however one minor point is that it is turning
up in Kconfig entries where it probably shouldn't be. Please send
a patch to add a 'depends on' line to the Kconfig.

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
