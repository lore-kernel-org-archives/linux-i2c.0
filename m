From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] TSL2550 driver bugfix
Date: Mon, 13 Jul 2009 21:17:22 +0200
Message-ID: <20090713211722.6197da6e@hyperion.delvare>
References: <4A4A2FBC.1060804@valueteam.com>
	<4A4A4036.3000408@cam.ac.uk>
	<4A4B1A71.20101@valueteam.com>
	<20090711202030.52ffbddb@hyperion.delvare>
	<20090712105237.01e11954@hyperion.delvare>
	<4A5AE89A.8000000@valueteam.com>
	<20090713104454.5b932c3d@hyperion.delvare>
	<4A5B011F.8030507@valueteam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A5B011F.8030507-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Michele De Candia (VT)" <michele.decandia-EZxuzQJkuwwybS5Ee8rs3A@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, giometti-k2GhghHVRtY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 13 Jul 2009 11:40:47 +0200, Michele De Candia (VT) wrote:
> >> If you are in accord with this, I can pass you a new patch.
> >
> > Yes I agree, please send an updated patch and I'll apply it.
> >
> > In the meantime I've improved the performance of the i2c-taos-evm
> > driver I'm using for the TSL5220, I'll post it later today, once I am
> > fully done with testing. I'm not sure if there are other users of this
> > driver though.
> >
> > Thanks,
> >   
> You can find the patch in attachment. Maybe I'll submit you more patches 
> about this driver but they are not ready yet (extended mode support and 
> spurious values filtering).

Patch applied, thanks.

-- 
Jean Delvare
