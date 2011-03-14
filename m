From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 00/13]  V3 Split i2c-designware.c to support PCI
	drivers.
Date: Mon, 14 Mar 2011 23:43:37 +0000
Message-ID: <20110314234337.GN15795@trinity.fluff.org>
References: <1299961407-26852-1-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1299961407-26852-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Mar 12, 2011 at 12:23:14PM -0800, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> This patch set reworks i2c-designware.c to enable supporting multiple
> instances of the driver in the system and adds support for Designware
> I2C IP cores behind PCI devices.
> 
> The patch set has been refactored to hopefully make it easier to
> review.
> 
> TODO:
> Ben disliked the module names, they haven't changed yet waiting for
> feedback on the list.

Right, merged into next-i2c pending any further feedback.

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
