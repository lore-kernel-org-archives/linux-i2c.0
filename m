From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Questions about i2c_transfer() usage in timer context...
Date: Mon, 20 Feb 2012 15:13:01 +0100
Message-ID: <20120220151301.6ca4db1f@endymion.delvare>
References: <4F424440.300@peak-system.com>
	<20120220141112.1e633beb@endymion.delvare>
	<CADkCAusvXZC5Ju2oNbBgi6aZO2E9upoDPbtFqTbrbBhd8eCu8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CADkCAusvXZC5Ju2oNbBgi6aZO2E9upoDPbtFqTbrbBhd8eCu8A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>
Cc: Stephane Grosjean <s.grosjean-g4cQ8AsIbFbL9ATBNaCtXw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Bill,

On Mon, 20 Feb 2012 07:46:07 -0600, Bill Gatliff wrote:
> On Feb 20, 2012 7:11 AM, "Jean Delvare" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> > On Mon, 20 Feb 2012 14:01:52 +0100, Stephane Grosjean wrote:
> > > I'm facing a deadlock regarding a timer callback...
> >
> > Depends on the underlying I2C adapter driver. One of the sleep causes
> > is indeed the acquisition of the mutex in i2c_transfer(). However the
> > function then calls a driver specific callback function
> > (adap->algo->master_xfer) which may or may not sleep too depending on
> > the implementation.
> 
> Indeed. A fair number of the i2c transfer functions I have encountered call
> schedule_work() or equivalent, and/or wait_for_completion().

Or even plain msleep().

> The low-level transfer function implementations are entirely
> platform-dependent, and often lean heavily on the assumption that they
> aren't called in atomic contexts. So in addition to driving architecture
> decisions in your code which calls them, they can also have implications
> for real-time performance.
> 
> None of the above is a complaint, mind you. Just observations. :)

I certainly hope you wouldn't dare to complain without also submitting
a proposal and a patch set addressing any issue you have ;)

-- 
Jean Delvare
