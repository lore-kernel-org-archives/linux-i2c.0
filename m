From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] I2C: Add driver for Cavium OCTEON I2C ports.
Date: Wed, 3 Feb 2010 02:24:04 +0000
Message-ID: <20100203022404.GB24325@fluff.org.uk>
References: <1264711627-24304-1-git-send-email-ddaney@caviumnetworks.com>
 <20100128234113.GC13143@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100128234113.GC13143-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, rade.bozic.ext-OYasijW0DpE@public.gmane.org, Michael Lawnick <michael.lawnick.ext-OYasijW0DpE@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 29, 2010 at 12:41:13AM +0100, Ralf Baechle wrote:
> On Thu, Jan 28, 2010 at 12:47:07PM -0800, David Daney wrote:
> 
> Thanks, I've replaced the queue patch with this one.

I'd rather avoid a cross-tree merge if possible. Is there anything
stopping it being added to my next-i2c tree?
 
>   Ralf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
