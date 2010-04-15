From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/4] hmc6352: Add driver for the HMC6352 compass
Date: Thu, 15 Apr 2010 08:57:16 -0700
Message-ID: <1271347036.1726.57.camel@Joe-Laptop.home>
References: <20100414124913.23181.75903.stgit@localhost.localdomain>
	 <20100414125136.23181.16788.stgit@localhost.localdomain>
	 <4BC5C7A8.1040807@cam.ac.uk> <20100414153234.22765666@lxorguk.ukuu.org.uk>
	 <4BC5D681.20707@jic23.retrosnub.co.uk>
	 <20100414161904.713eef78@lxorguk.ukuu.org.uk>
	 <1271280993.1833.36.camel@Joe-Laptop.home>
	 <20100415131153.0e383ef3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100415131153.0e383ef3-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Kalhan Trisal <kalhan.trisal-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2010-04-15 at 13:11 +0100, Alan Cox wrote:
> > Argument alignment
> Makes it take more space

Makes it look more like most kernel code.

> > Make chars static
> Not sure I see the point (compiler generates good code anyway)

Internal consistency.  2 use areas had it, 1 didn't.
