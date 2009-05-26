From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused
	by read i2c_msg
Date: Tue, 26 May 2009 22:33:51 +0100
Message-ID: <20090526213351.GG23114@fluff.org.uk>
References: <4A124202.4010201@doredevelopment.dk> <d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d2b9ea600905260430i72290901p9266de4cade049c1-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Esben Haabendal <esbenhaabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, May 26, 2009 at 01:30:21PM +0200, Esben Haabendal wrote:
> On Tue, May 19, 2009 at 7:22 AM, Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org> wrote:
> > This fixes MAL (arbitration lost) bug caused by illegal use of
> > RSTA (repeated START) after STOP condition generated after last byte
> > of reads. With this patch, it is possible to do an i2c_transfer() with
> > additional i2c_msg's following the I2C_M_RD messages.
> >
> > It still needs to be resolved if it is possible to fix this issue
> > by removing the STOP condition after reads in a robust way.
> >
> > Signed-off-by: Esben Haabendal <eha-SIcX2qgNSybd/EuGEV170n9LOBIZ5rWg@public.gmane.org>
> > ---
> > ?drivers/i2c/busses/i2c-mpc.c | ? ?9 +++++++--
> > ?1 files changed, 7 insertions(+), 2 deletions(-)
> 
> Any blockers to get this accepted?

It would be nice to get an ack from someone who can actually test
the driver before getting this merged.
 
> /Esben
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
