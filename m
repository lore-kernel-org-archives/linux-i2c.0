From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] i2c: Driver to expose PowerNV platform i2c busses
Date: Fri, 14 Nov 2014 16:17:19 +1100
Message-ID: <1415942239.666.37.camel@kernel.crashing.org>
References: <20141110060424.9407.2498.stgit@localhost.localdomain>
	 <20141113075817.GA1288@katana> <1415876169.666.2.camel@kernel.crashing.org>
	 <20141113131014.GA8025@katana>
	 <1415912020.666.17.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415912020.666.17.camel-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2014-11-14 at 07:53 +1100, Benjamin Herrenschmidt wrote:
> > > > > +       adapter->dev.parent = &pdev->dev;
> > > > > +       adapter->dev.of_node = of_node_get(pdev->dev.of_node);
> > > > > +       pname = of_get_property(pdev->dev.of_node, "port-name", NULL);
> > > > 
> > > > I have never seen this binding before, it looks fishy. Where is it documented?
> > > 
> > > We made it up, like pretty every SoC vendor out there. What's fishy
> > > about it ? It's a very good way to get fixed i2c port names on the
> > > system, the firmware defines them.
> > 
> > But the SoC vendors prefix it with their company name and add
> > documentation for the binding.
> 
> Why do we need to prefix arbitrary props for a very specific device ?
> When adding things to an existing more/less generic device it makes some
> sense but here I don't see much point. I can whip up a "binding"
> document for this adapter and make "port-name" be part of it if you
> want :) In fact a better name for the property might be "bus-id"...

Note: We've slipped in a last minute update to the FW which isn't
deployed yet to turn that into ibm,port-name and change the compatible
match to the more generic "ibm,opal-i2c" since the underlying HW
implementation doesn't have to be P8 (and in fact we'll soon also expose
the i2c bus off the Centaur memory buffer chips that goes to the DIMMs).

This is the only parts of the "binding" linux cares about. The actual
DT representation for that device is a bit more complete, there's a
parent node for the i2c master engine and a node per port, but clients
like Linux only care about the ports. The clock frequencies are in
standard properties but here too, only the FW use them for its own
internal use, this is an abstract FW API (server world ....)

Cheers,
Ben.
