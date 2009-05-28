From: Joakim Tjernlund <joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused	by read
 i2c_msg
Date: Thu, 28 May 2009 20:43:24 +0200
Message-ID: <OF7FD989BC.A9165CFB-ONC12575C4.006693BB-C12575C4.0066D974@transmode.se>
References: <4A124202.4010201@doredevelopment.dk> <d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com> <20090526213351.GG23114@fluff.org.uk> <20090528171726.GE3112@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090528171726.GE3112-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>, Esben Haabendal <esbenhaabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote on 28/05/2009 19:17:26:
>
> > > Any blockers to get this accepted?
> >
> > It would be nice to get an ack from someone who can actually test
> > the driver before getting this merged.
>
> I wanted to test it, but it does not apply due to line breaks (check
> @@-line). Also, I don't really have the time to dig into the topic, so I
> would only test it and give a tested-by-tag if it doesn't break anything
> here. I think Joakim would be a good candidate for an acked-by .

It sure looks OK, even at a closer look :)
Acked-by:  Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
