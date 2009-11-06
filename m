From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: at24 driver - a possible problem
Date: Fri, 6 Nov 2009 13:58:51 -0700
Message-ID: <200911061258.52179.david-b@pacbell.net>
References: <533f29860911050810w4d939b39x2ad11c189f13c977@mail.gmail.com> <20091106124905.GA3980@pengutronix.de> <533f29860911060457m70a1adfcr2dd11f0785748014@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <533f29860911060457m70a1adfcr2dd11f0785748014-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aleksandar Ivanov <ivanov.aleks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 06 November 2009, Aleksandar Ivanov wrote:
> So I added the O_SYNC flag to the open() call. (The man says: O_SYNC
> - The file is opened for synchronous I/O. Any write()s on the
> resulting file descriptor will block the calling process until the
> data has been physically written to the underlying hardware.)
> But obviously this didn't fix the issue.
> 
> Correct me if I'm wrong but I would expect from a synchronous write()
> call to NOT finish before the data has been "phisically written".
> And in this case of course the read operation wouldn't need a waiting loop.
> What do you think?

Makes sense to me.  Another bug to fix.  :)
