From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused
	by read i2c_msg
Date: Thu, 3 Dec 2009 15:29:16 +0000
Message-ID: <20091203152916.GC23152@trinity.fluff.org>
References: <4A124202.4010201@doredevelopment.dk> <d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com> <20090526213351.GG23114@fluff.org.uk> <4B17D4C5.3070100@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B17D4C5.3070100-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Esben Haabendal <esbenhaabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 03, 2009 at 04:09:57PM +0100, Michael Lawnick wrote:
> Ben Dooks said the following:
> > On Tue, May 26, 2009 at 01:30:21PM +0200, Esben Haabendal wrote:
> >> On Tue, May 19, 2009 at 7:22 AM, Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org> wrote:
> >> > This fixes MAL (arbitration lost) bug caused by illegal use of
> >> > RSTA (repeated START) after STOP condition generated after last byte
> >> > of reads. With this patch, it is possible to do an i2c_transfer() with
> >> > additional i2c_msg's following the I2C_M_RD messages.
> >> >
> >> > It still needs to be resolved if it is possible to fix this issue
> >> > by removing the STOP condition after reads in a robust way.
> >> >
> >> > Signed-off-by: Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>
> >> > ---
> >> > ?drivers/i2c/busses/i2c-mpc.c | ? ?9 +++++++--
> >> > ?1 files changed, 7 insertions(+), 2 deletions(-)
> >> 
> >> Any blockers to get this accepted?
> > 
> > It would be nice to get an ack from someone who can actually test
> > the driver before getting this merged.
> >  
> What is the state of this patch?
> Shouldn't we attack the problem on a more general way by inventing a
> Flag I2C_M_RESTART (or better I2C_M_NO_RESTART for backward compatibility)?
> This way the client driver is able to decide what it needs. If we do the
> choice within adapter, chance is about 50% to be wrong.

The documentation for 'struct i2c_msg' already says the STOP should only
be generated for the last message of the transfer. If STOP is being
generated for a message that isn't the last in the transfer than this
is incorrect behaviour.

Unless otherwise indicated, I'll put the patch in the series that I'll
send to Linus early next week.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
