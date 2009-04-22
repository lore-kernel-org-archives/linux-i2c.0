From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Wed, 22 Apr 2009 09:40:16 +0200
Message-ID: <20090422094016.4aa0be99@hyperion.delvare>
References: <49ED6AD3.2060808@gmx.de>
	<49ED6F03.5050107@grandegger.com>
	<49ED9132.9050806@gmx.de>
	<20090421115936.28656d09@hyperion.delvare>
	<49EDD423.3050302@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49EDD423.3050302-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Sang, Wolfram" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 21 Apr 2009 16:11:47 +0200, Michael Lawnick wrote:
> I took a look into the code of Rodolfo Giometti and it seemed to be in a
> way I would have done it, if I wouldn't have been too late. In my
> current working I assume this code as a basis.
> 
> Nevertheless my mailed patch has *nothing* to do with multiplexing.
> It works on the problem that i2c-mpc has 0 as default class and so there
> is no way to instantiate a new-style client that is not mentioned in DTS.

If you didn't want to handle warm-plug then that wouldn't be a problem,
because you would be able to put all the chip information in the DTS.
But you want warm-plug. And warm-plug needs multiplexing support. So
your problem is very much related to multiplexing.

Now I'll ignore you until I am done with the prerequisites to accept
Rodolfo's patches, and with Rodolfo's patches themselves. Discussing
your problems when there's nothing I can do about them at the time
being, is just a waste of everybody's time.

-- 
Jean Delvare
