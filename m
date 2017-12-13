From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [RFC 2/5] i3c: Add core I3C infrastructure
Date: Wed, 13 Dec 2017 17:51:55 +0100
Message-ID: <20171213165155.GA6003@kroah.com>
References: <1501518290-5723-1-git-send-email-boris.brezillon@free-electrons.com>
 <1501518290-5723-3-git-send-email-boris.brezillon@free-electrons.com>
 <20170801014021.GA20004@kroah.com>
 <20170801124801.38bbc431@bbrezillon>
 <20170801175133.GA30520@kroah.com>
 <20170801233001.4b08834f@bbrezillon>
 <20170802021327.GB23033@kroah.com>
 <20171213172043.24e4d4bc@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171213172043.24e4d4bc@bbrezillon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Przemyslaw Sroka <psroka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Arkadiusz Golec <agolec-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alan Douglas <adouglas-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Bartosz Folta <bfolta-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Damian Kos <dkos-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alicja Jurasik-Urbaniak <alicja-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Jan Kotas <jank-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Cyprian Wronka <cwronka-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak@co>
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 13, 2017 at 05:20:43PM +0100, Boris Brezillon wrote:
> Hi Greg,
> 
> On Tue, 1 Aug 2017 19:13:27 -0700
> Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> 
> > > > > Unless you see a good reason to not use a R/W lock, I'd like to keep it
> > > > > this way because master IPs are likely to implement advanced queuing
> > > > > mechanism (allows one to queue new transfers even if the master is
> > > > > already busy processing other requests), and serializing things at the
> > > > > framework level will just prevent us from using this kind of
> > > > > optimization.    
> > > > 
> > > > Unless you can prove otherwise, using a rw lock is almost always worse
> > > > than just a mutex.  
> > > 
> > > Is it still true when it's taken in non-exclusive mode most of the
> > > time, and the time you spend in the critical section is non-negligible?
> > > 
> > > I won't pretend I know better than you do what is preferable, it's just
> > > that the RW lock seemed appropriate to me for the situation I tried to
> > > described here.  
> > 
> > Again, measure it.  If you can't measure it, then don't use it.  Use a
> > simple lock instead.  Seriously, don't make it more complex until you
> > really have to.  It sounds like you didn't measure it at all, which
> > isn't good, please do so.
> > 
> 
> I'm resurrecting this thread because I finally had the time to implement
> message queuing in Cadence I3C master driver. So I did a test with 2
> I3C devices on the bus, and their drivers sending as much SDR messages
> as they can in 10s. Here are the results:
> 
>           |    mutex    |    rwsem    |
> ---------------------------------------
> dev1      |    19087    |    29532    |
> dev2      |    19341    |    29118    |
> =======================================
> total     |    38428    |    58650    |
> msg/sec	  |    ~3843    |    ~5865    |
> 
> 
> The results I'm obtaining here are not so surprising since all normal
> transfers are taking the lock in read mode, so there's no contention.
> I didn't measure the impact on performances when there's one
> maintenance operation taking the lock in write mode and several normal
> transfers waiting for this lock, but really, maintenance operations are
> infrequent, and that's not where performance matters in our use case.
> 
> I also did the same test with only one device doing transfers on the
> bus, and this time the mutex wins, but there's not a huge difference.
> 
>           |    mutex    |    rwsem    |
> ---------------------------------------
> total     |    67116    |    66561    |
> msg/sec	  |    ~6712    |    ~6656    |
> 
> Let me know if you want more information on the test procedure.

Nice, thanks for testing, so it is a real win here, good!

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
